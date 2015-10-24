@store
SET ECHO OFF
SET LONG 1000000
SET LONGCHUNKSIZE 1000000
SET LINESIZE 152
SET PAGESIZE 1000
SET SERVEROUT ON
SET TRIM ON
SET TERMOUT OFF
SET TRIMSPOOL ON
SET FEEDBACK OFF
SET VERIFY OFF
SET HEAD OFF

CLEAR BREAK
CLEAR COLUMN
COL v_dbid1 new_value v_dbid
COL v_inst_id1 new_value v_inst_id
COL V_BEGIN_ID1 new_value V_BEGIN_ID
COL v_BEGIN_TIME1 noprint new_value v_BEGIN_TIME
COL V_END_ID1 new_value V_END_ID
COL v_END_TIME1 noprint new_value v_END_TIME
col snap_id for 999999 righ

SELECT 'DBID/INSTID		:', dbid v_dbid1,'/',instance_number v_inst_id1   FROM v$database,v$instance;
SELECT 'Database/Instance	:', NAME,'/',instance_name   FROM v$database,v$instance;


SET TERMOUT ON

select 'Snap id:	',max(snap_id)-1 V_BEGIN_ID1,' to ',max(snap_id) V_END_ID1  from dba_hist_snapshot  where trunc(STARTUP_TIME)=(select trunc(STARTUP_TIME) from v$instance);
select 'Begin Intervel:		' beginin,to_char(begin_interval_time,'DD-MM-YY HH24:MI:SS') from dba_hist_snapshot where snap_id=&v_begin_id and INSTANCE_NUMBER=&v_inst_id;
select 'End Intervel:		' endin,to_char(end_interval_time,'DD-MM-YY HH24:MI:SS') from dba_hist_snapshot where snap_id=&v_end_id and INSTANCE_NUMBER=&v_inst_id;

WITH MOD AS
     (SELECT ROWNUM r, output
        FROM TABLE (DBMS_WORKLOAD_REPOSITORY.awr_report_text (&v_dbid,
                                                              &v_inst_id,
                                                              &v_begin_id,
                                                              &v_end_id
                                                             )
                   ))
SELECT   output
    FROM MOD,
         (SELECT r
            FROM MOD
           WHERE output LIKE 'Top %Time%') mod1
   WHERE MOD.r BETWEEN mod1.r AND mod1.r + 15
   AND output not like '%DB/Inst%'
ORDER BY MOD.r;
@restore
