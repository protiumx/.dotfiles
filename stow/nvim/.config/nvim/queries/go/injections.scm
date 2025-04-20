;; extends

; neovim nightly 0.10
([
  (interpreted_string_literal_content)
  (raw_string_literal_content)
  ] @injection.content
 (#match? @injection.content "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
(#set! injection.language "sql"))

; a general query injection
([
   (interpreted_string_literal_content)
   (raw_string_literal_content)
 ] @sql
 (#match? @sql "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
 )

; ----------------------------------------------------------------
; fallback keyword and comment based injection

([
  (interpreted_string_literal_content)
  (raw_string_literal_content)
 ] @sql
 (#contains? @sql "-- sql" "--sql" "ADD CONSTRAINT" "ALTER TABLE" "ALTER COLUMN"
                  "DATABASE" "FOREIGN KEY" "GROUP BY" "HAVING" "CREATE INDEX" "INSERT INTO"
                  "NOT NULL" "PRIMARY KEY" "UPDATE SET" "TRUNCATE TABLE" "LEFT JOIN" "add constraint" "alter table" "alter column" "database" "foreign key" "group by" "having" "create index" "insert into"
                  "not null" "primary key" "update set" "truncate table" "left join")
 )

; nvim 0.10
([
  (interpreted_string_literal_content)
  (raw_string_literal_content)
 ] @injection.content
 (#contains? @injection.content "-- sql" "--sql" "ADD CONSTRAINT" "ALTER TABLE" "ALTER COLUMN"
                  "DATABASE" "FOREIGN KEY" "GROUP BY" "HAVING" "CREATE INDEX" "INSERT INTO"
                  "NOT NULL" "PRIMARY KEY" "UPDATE SET" "TRUNCATE TABLE" "LEFT JOIN" "add constraint" "alter table" "alter column" "database" "foreign key" "group by" "having" "create index" "insert into"
                  "not null" "primary key" "update set" "truncate table" "left join")
 (#set! injection.language "sql"))


; should I use a more exhaustive list of keywords?
;  "ADD" "ADD CONSTRAINT" "ALL" "ALTER" "AND" "ASC" "COLUMN" "CONSTRAINT" "CREATE" "DATABASE" "DELETE" "DESC" "DISTINCT" "DROP" "EXISTS" "FOREIGN KEY" "FROM" "JOIN" "GROUP BY" "HAVING" "IN" "INDEX" "INSERT INTO" "LIKE" "LIMIT" "NOT" "NOT NULL" "OR" "ORDER BY" "PRIMARY KEY" "SELECT" "SET" "TABLE" "TRUNCATE TABLE" "UNION" "UNIQUE" "UPDATE" "VALUES" "WHERE"

; json

((const_spec
  name: (identifier) @_const
  value: (expression_list (raw_string_literal) @json))
 (#lua-match? @_const ".*[J|j]son.*"))

; jsonStr := `{"foo": "bar"}`

((short_var_declaration
    left: (expression_list
            (identifier) @_var)
    right: (expression_list
             (raw_string_literal) @json))
  (#lua-match? @_var ".*[J|j]son.*")
  (#offset! @json 0 1 0 -1))

; nvim 0.10

(const_spec
  name: (identifier)
  value: (expression_list
	   (raw_string_literal
	     (raw_string_literal_content) @injection.content
             (#lua-match? @injection.content "^[\n|\t| ]*\{.*\}[\n|\t| ]*$")
             (#set! injection.language "json")
	    )
   ))

(short_var_declaration
    left: (expression_list (identifier))
    right: (expression_list
             (raw_string_literal
               (raw_string_literal_content) @injection.content
               (#lua-match? @injection.content "^[\n|\t| ]*\{.*\}[\n|\t| ]*$")
               (#set! injection.language "json"))
               )
    )

(var_spec
  name: (identifier)
  value: (expression_list
           (raw_string_literal
             (raw_string_literal_content) @injection.content
             (#lua-match? @injection.content "^[\n|\t| ]*\{.*\}[\n|\t| ]*$")
             (#set! injection.language "json")
             )
   ))
