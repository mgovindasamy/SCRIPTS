
iordxp11> select max(TEMP_SPACE_ALLOCATED) from v$active_Session_history where sql_id in  ('7nnq1akzzxsk0','byhv959nvxtrj','gty79z83v1gak');

AX(TEMP_SPACE_ALLOCATED)
------------------------
              1.0914E+10

 row selected.

iordxp11> select max(TEMP_SPACE_ALLOCATED),sql_id from v$active_Session_history where sql_id in  ('7nnq1akzzxsk0','byhv959nvxtrj','gty79z83v1gak');
elect max(TEMP_SPACE_ALLOCATED),sql_id from v$active_Session_history where sql_id in  ('7nnq1akzzxsk0','byhv959nvxtrj','gty79z83v1gak')
                                *
RROR at line 1:
RA-00937: not a single-group group function


iordxp11> select max(TEMP_SPACE_ALLOCATED),sql_id from v$active_Session_history where sql_id in  ('7nnq1akzzxsk0','byhv959nvxtrj','gty79z83v1gak') group by sql_id;

AX(TEMP_SPACE_ALLOCATED) SQL_ID
------------------------ -------------
              9655287808 byhv959nvxtrj
              1.0914E+10 gty79z83v1gak
              6858735616 7nnq1akzzxsk0

 rows selected.

iordxp11> select max(TEMP_SPACE_ALLOCATED)/1024/1024/1024,sql_id from v$active_Session_history where sql_id in  ('7nnq1akzzxsk0','byhv959nvxtrj','gty79z83v1gak') group by sql_id;

AX(TEMP_SPACE_ALLOCATED)/1024/1024/1024 SQL_ID
--------------------------------------- -------------
                              8.9921875 byhv959nvxtrj
                             10.1640625 gty79z83v1gak
                             6.38769531 7nnq1akzzxsk0

 rows selected.

iordxp11> select max(TEMP_SPACE_ALLOCATED)/1024/1024/1024,sql_id from v$active_Session_history where sql_id in  ('7nnq1akzzxsk0','byhv959nvxtrj','gty79z83v1gak') group by sql_id;

select max(SAMPLE_ID),sql_id from v$active_Session_history where sql_id in  ('7nnq1akzzxsk0','byhv959nvxtrj','gty79z83v1gak') group by sql_id;

select max(TEMP_SPACE_ALLOCATED), SAMPLE_ID from 
(select sum(TEMP_SPACE_ALLOCATED)/1024/1024/1024 TEMP_SPACE_ALLOCATED,sql_id,SAMPLE_ID from gv$active_Session_history where sql_id in  ('7nnq1akzzxsk0','byhv959nvxtrj','gty79z83v1gak') 
group by sql_id,SAMPLE_ID
order by TEMP_SPACE_ALLOCATED desc
) where TEMP_SPACE_ALLOCATED >100 and rownum<100
group by SAMPLE_ID
order by TEMP_SPACE_ALLOCATED;


66551144

select max(TEMP_SPACE_ALLOCATED), SAMPLE_ID from 
(select sum(TEMP_SPACE_ALLOCATED)/1024/1024/1024 TEMP_SPACE_ALLOCATED,sql_id,SAMPLE_ID from gv$active_Session_history where sql_id in  ('7nnq1akzzxsk0','byhv959nvxtrj','gty79z83v1gak') 
group by sql_id,SAMPLE_ID
order by TEMP_SPACE_ALLOCATED desc
) where TEMP_SPACE_ALLOCATED >100 and rownum<100
group by SAMPLE_ID
order by TEMP_SPACE_ALLOCATED;
