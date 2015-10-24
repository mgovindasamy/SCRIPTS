
PEWM2 PROD> select table_name,round((blocks*8),2)||' KB' "size"
from DBA_tables
where table_name = 'PNOTIF';  2    3

TABLE_NAME                     size
------------------------------ -------------------------------------------
PNOTIF                         489096 KB

PEWM2 PROD> select table_name,round((num_rows*avg_row_len/1024),2)||' KB' "size"
from dba_tables
where table_name = 'PNOTIF';
  2    3
TABLE_NAME                     size
------------------------------ -------------------------------------------
PNOTIF                         292080.77 KB


ANALYZE TABLE PEWM_BPM_ENG_PREP.PNOTIF COMPUTE STATISTICS;
*
ERROR at line 1:
ORA-01591: lock held by in-doubt distributed transaction 5.2.92371

SELECT 
LOCAL_TRAN_ID, GLOBAL_TRAN_ID, STATE, MIXED, HOST, COMMIT#
FROM
DBA_2PC_PENDING
WHERE
LOCAL _TRAN_ID = '5.2.92371';
