-- Top SQL by Mean Exec Time
WITH hist AS (
  SELECT
    queryid::text,
    SUBSTRING(query from 1 for 1000) query,
    ROW_NUMBER () OVER (ORDER BY mean_exec_time::numeric DESC) rn,
    SUM(mean_exec_time::numeric) mean_exec_time
  FROM pg_stat_statements
  WHERE queryid IS NOT NULL
    AND query::text not like '%pg\_%'
    AND query::text not like '%g\_%'
    /* Add more filters here */
  GROUP BY
    queryid,
    SUBSTRING(query from 1 for 1000),
    mean_exec_time::numeric
),

total AS (SELECT SUM(mean_exec_time::numeric) mean_exec_time FROM hist)

SELECT
  DISTINCT h.queryid::text,
  ROUND(h.mean_exec_time::numeric,3) mean_exec_time,
  ROUND(100 * h.mean_exec_time / t.mean_exec_time, 1) percent,
  h.query
FROM hist h, total t
WHERE h.mean_exec_time >= t.mean_exec_time / 1000 AND rn <= 14
UNION ALL
SELECT
  'Others',
  ROUND(COALESCE(SUM(h.mean_exec_time), 0), 3) mean_exec_time,
  COALESCE(ROUND(100 * SUM(h.mean_exec_time) / AVG(t.mean_exec_time), 1), 0) percent,
  NULL sql_text
FROM hist h, total t
WHERE h.mean_exec_time < t.mean_exec_time / 1000 OR rn > 14
ORDER BY 3 DESC NULLS LAST;

-- Top SQL by Total Exec Time
WITH hist AS (
  SELECT
    queryid::text,
    SUBSTRING(query from 1 for 100) query,
    ROW_NUMBER () OVER (ORDER BY total_exec_time::numeric DESC) rn,
    SUM(total_exec_time::numeric) total_exec_time
  FROM pg_stat_statements
  WHERE queryid IS NOT NULL
    AND query::text not like '%pg\_%'
    AND query::text not like '%g\_%'
   /* Add more filters here */
  GROUP BY
    queryid,
    SUBSTRING(query from 1 for 100),
    total_exec_time::numeric
),

total AS ( SELECT SUM(total_exec_time::numeric) total_exec_time FROM hist)

SELECT
  DISTINCT h.queryid::text,
  ROUND(h.total_exec_time::numeric,3) total_exec_time,
  ROUND(100 * h.total_exec_time / t.total_exec_time, 1) percent,
  h.query
FROM hist h, total t
WHERE h.total_exec_time >= t.total_exec_time / 1000 AND rn <= 14
UNION ALL
SELECT
  'Others',
  ROUND(COALESCE(SUM(h.total_exec_time::numeric), 0), 3) total_exec_time,
  COALESCE(ROUND(100 * SUM(h.total_exec_time) / AVG(t.total_exec_time), 1), 0) percent,
  NULL sql_text
FROM hist h, total t
WHERE h.total_exec_time < t.total_exec_time / 1000 OR rn > 14
ORDER BY 3 DESC NULLS LAST;

-- Top SQL by Execution Count
WITH hist AS (
  SELECT
    queryid::text,
    SUBSTRING(query from 1 for 100) query,
    ROW_NUMBER () OVER (ORDER BY calls DESC) rn,
    calls
  FROM pg_stat_statements
  WHERE queryid IS NOT NULL
    AND query::text not like '%pg\_%'
    AND query::text not like '%g\_%'
    /* Add more filters here */
 GROUP BY
    queryid,
    SUBSTRING(query from 1 for 100),
    calls
),

total AS ( SELECT SUM(calls) calls FROM hist)

SELECT
  DISTINCT
  h.queryid::text,
  h.calls,
  ROUND(100 * h.calls / t.calls, 1) percent,
  h.query
FROM hist h, total t
WHERE h.calls >= t.calls / 1000 AND rn <= 14
UNION ALL
SELECT
  'Others',
  COALESCE(SUM(h.calls), 0) calls,
  COALESCE(ROUND(100 * SUM(h.calls) / AVG(t.calls), 1), 0) percent,
  NULL sql_text
FROM hist h, total t
WHERE h.calls < t.calls / 1000 OR rn > 14
ORDER BY 2 DESC NULLS LAST;

-- Tables With Missing FK Indexes
WITH y AS (
  SELECT
    pg_catalog.format('%I.%I', n1.nspname, c1.relname) AS referencing_tbl,
    pg_catalog.quote_ident(a1.attname) AS referencing_column,
    t.conname AS existing_fk_on_referencing_tbl,
    pg_catalog.format('%I.%I', n2.nspname, c2.relname) AS referenced_tbl,
    pg_catalog.quote_ident(a2.attname) AS referenced_column,
    pg_relation_size(pg_catalog.format('%I.%I', n1.nspname, c1.relname)) AS referencing_tbl_bytes,
    pg_relation_size(pg_catalog.format('%I.%I', n2.nspname, c2.relname)) AS referenced_tbl_bytes,
    pg_catalog.format($$CREATE INDEX ON %I.%I(%I);$$, n1.nspname, c1.relname, a1.attname) AS suggestion
  FROM
    pg_catalog.pg_constraint t
    JOIN pg_catalog.pg_attribute a1 ON a1.attrelid = t.conrelid
        AND a1.attnum = t.conkey[1]
    JOIN pg_catalog.pg_class c1 ON c1.oid = t.conrelid
    JOIN pg_catalog.pg_namespace n1 ON n1.oid = c1.relnamespace
    JOIN pg_catalog.pg_class c2 ON c2.oid = t.confrelid
    JOIN pg_catalog.pg_namespace n2 ON n2.oid = c2.relnamespace
    JOIN pg_catalog.pg_attribute a2 ON a2.attrelid = t.confrelid
        AND a2.attnum = t.confkey[1]
  WHERE t.contype = 'f'
    AND NOT EXISTS (
      SELECT 1 FROM pg_catalog.pg_index i
      WHERE i.indrelid = t.conrelid AND i.indkey[0] = t.conkey[1]
    )
)
SELECT
  referencing_tbl,
  referencing_column,
  existing_fk_on_referencing_tbl,
  referenced_tbl,
  referenced_column,
  pg_size_pretty(referencing_tbl_bytes) AS referencing_tbl_size,
  pg_size_pretty(referenced_tbl_bytes) AS referenced_tbl_size,
  suggestion
FROM
  y
ORDER BY
  referencing_tbl_bytes DESC,
  referenced_tbl_bytes DESC,
  referencing_tbl,
  referenced_tbl,
  referencing_column,
  referenced_column;

-- Tables sizes
SELECT
  table_name,
  pg_size_pretty(pg_total_relation_size(table_name)) AS total_size
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY pg_total_relation_size(table_name) DESC;
