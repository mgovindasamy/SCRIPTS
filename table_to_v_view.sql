-- table_to_v_view.sql         Generate View From Table
--**Use this information and these scripts at your own risk. As a condition of using these scripts and information from this site, you agree to hold harmless both the University of Arkansas Cooperative Extension Service and Bruce Knox for any problems that they may cause or other situations that may arise from their use, and that neither the Extension Service nor I will be held liable for those consequences. The scripts and information are provided "as is" without warranty, implied or otherwise. Limitation of liability will be the amount paid to the University of Arkansas specifically for this information. (It was free:) 

SET ECHO OFF

-- This program helps you create the Oracle SQL Code for an Oracle VIEW
-- All fields are extracted retaining the original table's column names
-- Requires SELECT privileges to ALL_TAB_COLUMNS and ALL_TAB_COMMENTS
-- You may need to change all ! to $ for Host OS other than AIX

-- The generated code is not intended to be run without some manual adjustments
-- The user must review and make changes as required to select the appropriate records.
-- All DATE fields are Truncated to strip the time
-- inserts WHERE Statements for COLUMN_NAMEs ending with _EFF_DATE, _NCHG_DATE, _TERM_DATE,
-- N_CHANGE_IND and comment statements for the most likely to be used COLUMN_NAMEs for
-- additional user code

-- Change Log
-- 03/14/07 bknox Created table to table_v version from table_to_view.sql for use with Argos

SET VERIFY OFF
SET RECSEP OFF
SET LINESIZE 512
TTITLE OFF
BTITLE OFF
CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTES

!echo
!echo This program will Generate the Code Required to Create a View based upon an Existing Table

ACCEPT TABLE_FROM CHAR PROMPT ' Enter Table for Selection --(xxxxxxx)-> '

SET HEADING OFF
SET TIME OFF
SET TIMING OFF   
-- prevent time stamp at end of report
SET FEEDBACK OFF

COLUMN TABLE_FROM NEW_VALUE TABLE_FROM FORMAT A7
SELECT UPPER('&&TABLE_FROM') TABLE_FROM FROM DUAL;

COLUMN NEW_VIEW_FROM NEW_VALUE NEW_VIEW_FROM FORMAT A7
SELECT '&&TABLE_FROM' NEW_VIEW_FROM FROM DUAL;
COLUMN NEW_V_VIEW NEW_VALUE NEW_V_VIEW FORMAT A9
SELECT '&&NEW_VIEW_FROM'||'_V' NEW_V_VIEW FROM DUAL;


COLUMN COL_ID NOPRINT

!echo
!echo Creating Code for View &&NEW_V_VIEW

SET TERMOUT OFF
-- Write out file for transmission

SET PAGESIZE 0   
-- no page breaks
SET WRAP OFF
SET SPACE 0      
-- no space(s) between columns

SET TERMOUT OFF
SET ECHO OFF
SET HEADING OFF
SET TRIMSPOOL ON

-rm -f table_to_v_view.txt

SPOOL table_to_v_view.txt

SELECT '-- '||LOWER('&&TABLE_FROM')||'_v'||'_create.sql  Current Records VIEW from TABLE '||'&&TABLE_FROM' FROM DUAL;

SELECT 'CREATE OR REPLACE VIEW '|| '&&TABLE_FROM'||'_V ('
FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = UPPER('&&NEW_VIEW_FROM')
AND ROWNUM < 2;

SELECT COLUMN_NAME||',' 
FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = UPPER('&&NEW_VIEW_FROM') AND COLUMN_ID NOT IN 
(SELECT MAX(COLUMN_ID) FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = UPPER('&&NEW_VIEW_FROM'))
ORDER BY COLUMN_ID;
SELECT COLUMN_NAME 
FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = UPPER('&&NEW_VIEW_FROM') AND COLUMN_ID = 
(SELECT MAX(COLUMN_ID) FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = UPPER('&&NEW_VIEW_FROM'));

SELECT ') AS SELECT  ' FROM DUAL;

SELECT DECODE(DATA_TYPE,'DATE','TRUNC('||COLUMN_NAME||')', COLUMN_NAME)||','
FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = UPPER('&&NEW_VIEW_FROM') AND COLUMN_ID NOT IN 
(SELECT MAX(COLUMN_ID) FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = UPPER('&&NEW_VIEW_FROM'))
ORDER BY COLUMN_ID;

SELECT DECODE(DATA_TYPE,'DATE','TRUNC('||COLUMN_NAME||')', COLUMN_NAME)
FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = UPPER('&&NEW_VIEW_FROM') AND COLUMN_ID = 
(SELECT MAX(COLUMN_ID) FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = UPPER('&&NEW_VIEW_FROM'));

SELECT '  FROM '||TABLE_NAME
FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = UPPER('&&NEW_VIEW_FROM')
AND ROWNUM < 2;

-- Output WHERE
SELECT 90001 COL_ID,' WHERE '
  FROM ALL_TAB_COLUMNS
 WHERE TABLE_NAME = UPPER('&&NEW_VIEW_FROM')
   AND (COLUMN_NAME LIKE '%_EFF_DATE' OR COLUMN_NAME LIKE '%_NCHG_DATE' OR COLUMN_NAME LIKE '%_TERM_DATE')
    OR (COLUMN_NAME LIKE '%N_CHANGE_IND' AND TABLE_NAME = UPPER('&&NEW_VIEW_FROM'))
   AND ROWNUM < 2
UNION
SELECT 90001 COL_ID,'-- WHERE ' 
  FROM DUAL
 WHERE NOT EXISTS
 (SELECT 'X'   FROM ALL_TAB_COLUMNS
   WHERE TABLE_NAME = UPPER('&&NEW_VIEW_FROM')
     AND (COLUMN_NAME LIKE '%_EFF_DATE'
      OR COLUMN_NAME LIKE '%_NCHG_DATE' 
      OR COLUMN_NAME LIKE '%_TERM_DATE')
     OR  COLUMN_NAME LIKE '%N_CHANGE_IND')
UNION
-- Output Critical Date Checking Code
SELECT 90002 COL_ID,'       TRUNC('||COLUMN_NAME||') <= SYSDATE'
  FROM ALL_TAB_COLUMNS
 WHERE TABLE_NAME = UPPER('&&NEW_VIEW_FROM')
   AND COLUMN_NAME LIKE '%_EFF_DATE'
UNION
SELECT 90003 COL_ID,'   AND      ('||COLUMN_NAME||'  > TRUNC(SYSDATE) OR '||COLUMN_NAME||' IS NULL)'
  FROM ALL_TAB_COLUMNS
 WHERE TABLE_NAME = UPPER('&&NEW_VIEW_FROM')
   AND COLUMN_NAME LIKE '%_NCHG_DATE'
UNION
SELECT 90004 COL_ID,'   AND      ('||COLUMN_NAME||'  > TRUNC(SYSDATE) OR '||COLUMN_NAME||' IS NULL)'
  FROM ALL_TAB_COLUMNS
 WHERE TABLE_NAME = UPPER('&&NEW_VIEW_FROM')
   AND COLUMN_NAME LIKE '%_TERM_DATE'
ORDER BY 1;

SELECT ';' FROM DUAL;

SPOOL OFF

SET FEEDBACK ON
SET TERMOUT ON
SET ECHO ON
