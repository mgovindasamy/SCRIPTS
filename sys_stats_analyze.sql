/* Formatted on 03/14/2014 10:32:07 PM (QP5 v5.163.1008.3004) */
/* Formatted on 03/14/2014 10:35:25 PM (QP5 v5.163.1008.3004) */
WITH fixed
     AS (SELECT TO_CHAR (MAX (last_analyzed), 'YYYY-MM-DD')
                   fixed_last_analyzed,
                COUNT (*) fixed_objects
           FROM dba_tab_statistics
          WHERE object_type = 'FIXED TABLE'),
     dict
     AS (SELECT TO_CHAR (MAX (last_analyzed), 'YYYY-MM-DD')
                   dictionary_last_analyzed,
                COUNT (*) dictionary_objects
           FROM dba_tab_statistics
          WHERE owner IN ('SYS', 'SYSTEM'))
SELECT    SYS_CONTEXT ('USERENV', 'db_name')
       || '|'
       || SYS_CONTEXT ('USERENV', 'SERVER_HOST')
       || '|'
       || fixed_last_analyzed
       || '|'
       || fixed_objects
       || '|'
       || dictionary_last_analyzed
       || '|'
       || dictionary_objects
  FROM fixed, dict;
