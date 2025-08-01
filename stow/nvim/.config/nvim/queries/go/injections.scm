;; extends

; sql

([
  (interpreted_string_literal_content)
  (raw_string_literal_content)
 ] @injection.content
 (#contains? @injection.content "-- sql" "--sql"
                  "GROUP BY" "HAVING" "INSERT INTO"
                  "UPDATE SET" "LEFT JOIN" "group by" "having" "insert into"
                  "update set" "left join")
 (#set! injection.language "sql"))

; json

(const_spec
  name: (identifier)
  value: (expression_list
	   (raw_string_literal
	     (raw_string_literal_content) @injection.content
             (#lua-match? @injection.content "^[\n|\t| ]*\{.*\}[\n|\t| ]*$")
             (#set! injection.language "json"))))

(short_var_declaration
    left: (expression_list (identifier))
    right: (expression_list
             (raw_string_literal
               (raw_string_literal_content) @injection.content
               (#lua-match? @injection.content "^[\n|\t| ]*\{.*\}[\n|\t| ]*$")
               (#set! injection.language "json"))))

(var_spec
  name: (identifier)
  value: (expression_list
           (raw_string_literal
             (raw_string_literal_content) @injection.content
             (#lua-match? @injection.content "^[\n|\t| ]*\{.*\}[\n|\t| ]*$")
             (#set! injection.language "json"))))
