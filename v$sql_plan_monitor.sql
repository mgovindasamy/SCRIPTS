Prompt
Prompt For a EXECUTING statement, Enter below details for plan monitor!
Prompt

ACCEPT SID PROMPT 'Enter sid :'
ACCEPT SQL_ID PROMPT 'Enter SQL_ID :'
ACCEPT SQL_EXEC_ID PROMPT 'Enter SQL_EXEC_ID :'

exec :SID := '&sid' ;
exec :SQL_ID := '&SQL_ID' ;
exec :SQL_EXEC_ID := '&SQL_EXEC_ID' ;


col ID for 9999
col Operation for a60  
col "Object Name" for a32 
col "# Rows" for 999999999
col "BYTES" for 99999999999
col "COST" for 99999999999
col "PStart" for a8
col "PStop" for a8
SELECT     ROWNUM "ID", status,
              SUBSTR (LPAD (' ', 2 * (plan_depth - 1)) || plan_operation,
                      1,
                      20
                     )
           || DECODE (plan_options, NULL, '', ' (' || plan_options || ')')
                                                                  "Operation",
           SUBSTR (plan_object_name, 1, 30) "Object Name",
           plan_cardinality "E-Rows", output_rows "A-Rows", plan_bytes BYTES,
           plan_cost COST, plan_partition_start "PStart",
           plan_partition_stop "PStop"
      FROM (SELECT *
              FROM v$sql_plan_monitor
             WHERE SID = :SID AND sql_id = :sql_id
                   AND sql_exec_id = :sql_exec_id) a
START WITH plan_line_id = 0
CONNECT BY PRIOR plan_line_id = plan_parent_id
       AND PRIOR NVL (sql_plan_hash_value, 0) = NVL (sql_plan_hash_value, 0)
  ORDER BY plan_line_id, plan_position;
