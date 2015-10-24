prompt =========================================================================================
prompt ++ MESSAGES IN BUFFER QUEUE ++
prompt =========================================================================================
col QUEUE format a50 wrap
col "Message Count" format 9999999999999999 heading 'Current Number of|Outstanding|Messages|in Queue'
col "Spilled Msgs" format 9999999999999999 heading 'Current Number of|Spilled|Messages|in Queue'
col "TOtal Messages" format 9999999999999999 heading 'Cumulative |Number| of Messages|in Queue'
col "Total Spilled Msgs" format 9999999999999999 heading 'Cumulative Number|of Spilled|Messages|in Queue'
col "Expired_Msgs" heading 'Current Number of|Expired|Messages|in Queue'


SELECT queue_schema||'.'||queue_name Queue, startup_time, num_msgs "Message Count", spill_msgs "Spilled Msgs", 
cnum_msgs "Total Messages", cspill_msgs "Total Spilled Msgs", expired_msgs  FROM  gv$buffered_queues;

prompt ============================================================================================
prompt ++ CAPTURE STATISTICS ++
prompt =========================================================================================
COLUMN PROCESS_NAME HEADING "Capture|Process|Number" FORMAT A7
COLUMN CAPTURE_NAME HEADING 'Capture|Name' FORMAT A10
COLUMN SID HEADING 'Session|ID' FORMAT 99999999999999
COLUMN SERIAL# HEADING 'Session|Serial|Number' 
COLUMN STATE HEADING 'State' FORMAT A17
column STATE_CHANGED_TIME HEADING 'Last|State Change|Time'
COLUMN TOTAL_MESSAGES_CAPTURED HEADING 'Redo Entries|Scanned'  
COLUMN TOTAL_MESSAGES_ENQUEUED HEADING 'Total|LCRs|Enqueued'  
COLUMN TOTAL_MESSAGES_CREATED HEADING 'Total|Messages|Created'  

COLUMN LATENCY_SECONDS HEADING 'Latency|Seconds' FORMAT 9999999999999999
COLUMN CREATE_TIME HEADING 'Event Creation|Time' FORMAT A19
COLUMN ENQUEUE_TIME HEADING 'Last|Enqueue |Time' FORMAT A19
COLUMN ENQUEUE_MESSAGE_NUMBER HEADING 'Last Queued|Message Number' FORMAT 9999999999999999
COLUMN ENQUEUE_MESSAGE_CREATE_TIME HEADING 'Last Queued|Message|Create Time'FORMAT A19
COLUMN CAPTURE_MESSAGE_CREATE_TIME HEADING 'Last Redo|Message|Create Time' FORMAT A19
COLUMN CAPTURE_MESSAGE_NUMBER HEADING 'Last Redo|Message Number' FORMAT 9999999999999999
COLUMN AVAILABLE_MESSAGE_CREATE_TIME HEADING 'Available|Message|Create Time' FORMAT A19
COLUMN AVAILABLE_MESSAGE_NUMBER HEADING 'Available|Message Number' FORMAT 9999999999999999
COLUMN STARTUP_TIME HEADING 'Startup Timestamp' FORMAT A19

COLUMN MSG_STATE HEADING 'Message State' FORMAT A13
COLUMN CONSUMER_NAME HEADING 'Consumer' FORMAT A30

COLUMN PROPAGATION_NAME HEADING 'Propagation' FORMAT A8
COLUMN START_DATE HEADING 'Start Date'
COLUMN PROPAGATION_WINDOW HEADING 'Duration' FORMAT 99999
COLUMN NEXT_TIME HEADING 'Next|Time' FORMAT A8
COLUMN LATENCY HEADING 'Latency|Seconds' FORMAT 99999999


-- ALTER session set nls_date_format='HH24:MI:SS MM/DD/YY';

SELECT SUBSTR(s.PROGRAM,INSTR(S.PROGRAM,'(')+1,4) PROCESS_NAME,
       c.CAPTURE_NAME,
       C.STARTUP_TIME,
       c.SID,
       c.SERIAL#,
       c.STATE,
       c.state_changed_time,
       c.TOTAL_MESSAGES_CAPTURED,
       c.TOTAL_MESSAGES_ENQUEUED, total_messages_created
  FROM gV$STREAMS_CAPTURE c, gV$SESSION s
  WHERE c.SID = s.SID AND
        c.SERIAL# = s.SERIAL#;

SELECT capture_name, 
   SYSDATE "Current Time",
   capture_time "Capture Process TS",
   capture_message_number,
   capture_message_create_time ,
   enqueue_time ,
   enqueue_message_number,
   enqueue_message_create_time ,
   available_message_number,
   available_message_create_time    
FROM gV$STREAMS_CAPTURE;

COLUMN processed_scn HEADING 'Logminer Last|Processed Message' FORMAT 9999999999999999
COLUMN AVAILABLE_MESSAGE_NUMBER HEADING 'Last Message|Written to Redo' FORMAT 9999999999999999
SELECT c.capture_name, l.processed_scn, c.available_message_number
FROM gV$LOGMNR_SESSION l, gv$STREAMS_CAPTURE c
WHERE c.logminer_id = l.session_id;

COLUMN CAPTURE_NAME HEADING 'Capture|Name' FORMAT A15
COLUMN TOTAL_PREFILTER_DISCARDED HEADING 'Prefilter|Events|Discarded' FORMAT 9999999999999999
COLUMN TOTAL_PREFILTER_KEPT HEADING 'Prefilter|Events|Kept' FORMAT 9999999999999999
COLUMN TOTAL_PREFILTER_EVALUATIONS HEADING 'Prefilter|Evaluations' FORMAT 9999999999999999
COLUMN UNDECIDED HEADING 'Undecided|After|Prefilter' FORMAT 9999999999999999
COLUMN TOTAL_FULL_EVALUATIONS HEADING 'Full|Evaluations' FORMAT 9999999999999999

SELECT CAPTURE_NAME,
       TOTAL_PREFILTER_DISCARDED,
       TOTAL_PREFILTER_KEPT,
       TOTAL_PREFILTER_EVALUATIONS,
       (TOTAL_PREFILTER_EVALUATIONS - 
         (TOTAL_PREFILTER_KEPT + TOTAL_PREFILTER_DISCARDED)) UNDECIDED,
       TOTAL_FULL_EVALUATIONS
  FROM gV$STREAMS_CAPTURE;

column elapsed_capture HEADING 'Elapsed Time|Capture|(centisecs)'
column elapsed_rule HEADING 'Elapsed Time|Rule Evaluation|(centisecs)'
column elapsed_enqueue HEADING 'Elapsed Time|Enqueuing Messages|(centisecs)'
column elapsed_lcr HEADING 'Elapsed Time|LCR Creation|(centisecs)'
column elapsed_redo HEADING 'Elapsed Time|Redo Wait|(centisecs)'
column elapsed_Pause HEADING 'Elapsed Time|Paused|(centisecs)'

SELECT CAPTURE_NAME, ELAPSED_CAPTURE_TIME elapsed_capture,  
       elapsed_rule_time elapsed_rule,        
       ELAPSED_ENQUEUE_TIME 
       elapsed_enqueue, 
       ELAPSED_LCR_TIME elapsed_lcr,
       ELAPSED_REDO_WAIT_TIME elapsed_redo, 
       ELAPSED_PAUSE_TIME elapsed_pause,       
       total_messages_created,    total_messages_enqueued,     total_full_evaluations 
  from gv$streams_capture;


prompt
prompt ++ LOGMINER STATISTICS ++
prompt ++ (pageouts imply logminer spill) ++
COLUMN CAPTURE_NAME HEADING 'Capture|Name' FORMAT A32
COLUMN NAME HEADING 'Statistic' FORMAT A32
COLUMN VALUE HEADING 'Value' FORMAT 9999999999999999

select c.capture_name, name, value from gv$streams_capture c, gv$logmnr_stats l
 where c.logminer_id = l.session_id 
   and name in ('bytes paged out', 'microsecs spent in pageout', 
                'bytes of redo processed', 'bytes checkpointed',
                'seconds spent in checkpoint',
                'resume from low memory',
                'DDL txns mined', 'CTAS txns mined' ,'rolled back txns mined',
                'DDL txns delivered', 'DML txns delivered','CTAS txns delivered',
                'recursive txns delivered');  

prompt
prompt ++ BUFFERED PUBLISHERS ++
select * from gv$buffered_publishers;

prompt ============================================================================================
prompt
prompt ++ OPEN STREAMS CAPTURE TRANSACTIONS ++
prompt
prompt +**   Count    **+
select streams_name, count(*) "Open Transactions",sum(cumulative_message_count) "Total LCRs" from gv$streams_transaction where streams_type='CAPTURE' group by streams_name;
prompt
prompt +**   Detail    **+
select * from gv$streams_transaction where streams_type='CAPTURE' order by streams_name,first_message_number;

prompt =========================================================================================
prompt
prompt ++ PROPAGATION STATISTICS (SCHEDULE FOR EACH PROPAGATION) ++
prompt =========================================================================================
prompt
COLUMN PROPAGATION_NAME Heading 'Propagation|Name' format a17 wrap
COLUMN START_DATE HEADING 'Start Date'
COLUMN PROPAGATION_WINDOW HEADING 'Duration|in Seconds' FORMAT 9999999999999999
COLUMN NEXT_TIME HEADING 'Next|Time' FORMAT A8
COLUMN LATENCY HEADING 'Latency|in Seconds' FORMAT 9999999999999999
COLUMN SCHEDULE_DISABLED HEADING 'Status' FORMAT A8
COLUMN PROCESS_NAME HEADING 'Process' FORMAT A8
COLUMN FAILURES HEADING 'Number of|Failures' FORMAT 99
COLUMN LAST_ERROR_MSG HEADING 'Error Message' FORMAT A50 
COLUMN TOTAL_BYTES HEADING 'Total Bytes|Propagated' FORMAT 9999999999999999
COLUMN CURRENT_START_DATE HEADING 'Current|Start' FORMAT A17
COLUMN LAST_RUN_DATE HEADING 'Last|Run' FORMAT A17
COLUMN NEXT_RUN_DATE HEADING 'Next|Run' FORMAT A17
COLUMN LAST_ERROR_DATE HEADING 'Last|Error' FORMAT A17
column message_delivery_mode HEADING 'Message|Delivery|Mode'
column queue_to_queue HEADING 'Q-2-Q'

SELECT p.propagation_name,TO_CHAR(s.START_DATE, 'HH24:MI:SS MM/DD/YY') START_DATE,
       s.PROPAGATION_WINDOW, 
       s.NEXT_TIME, 
       s.LATENCY,
       DECODE(s.SCHEDULE_DISABLED,
                'Y', 'Disabled',
                'N', 'Enabled') SCHEDULE_DISABLED,
       s.PROCESS_NAME, s.total_bytes,
       s.FAILURES,
       s.message_delivery_mode,
       p.queue_to_queue,
       s.LAST_ERROR_MSG      
  FROM DBA_QUEUE_SCHEDULES s, DBA_PROPAGATION p
    WHERE   p.DESTINATION_DBLINK = 
        NVL(REGEXP_SUBSTR(s.destination, '[^@]+', 1, 2), s.destination)
  AND s.SCHEMA = p.SOURCE_QUEUE_OWNER
  AND s.QNAME = p.SOURCE_QUEUE_NAME order by message_delivery_mode, propagation_name;

SELECT p.propagation_name, message_delivery_mode, TO_CHAR(s.LAST_RUN_DATE, 'HH24:MI:SS MM/DD/YY') LAST_RUN_DATE,
   TO_CHAR(s.CURRENT_START_DATE, 'HH24:MI:SS MM/DD/YY') CURRENT_START_DATE, 
   TO_CHAR(s.NEXT_RUN_DATE, 'HH24:MI:SS MM/DD/YY') NEXT_RUN_DATE, 
   TO_CHAR(s.LAST_ERROR_DATE, 'HH24:MI:SS MM/DD/YY') LAST_ERROR_DATE
  FROM DBA_QUEUE_SCHEDULES s, DBA_PROPAGATION p
    WHERE   p.DESTINATION_DBLINK = 
        NVL(REGEXP_SUBSTR(s.destination, '[^@]+', 1, 2), s.destination)
  AND s.SCHEMA = p.SOURCE_QUEUE_OWNER
  AND s.QNAME = p.SOURCE_QUEUE_NAME order by message_delivery_mode, propagation_name;

prompt
prompt ++ EVENTS AND BYTES PROPAGATED FOR EACH PROPAGATION++
prompt
COLUMN Elapsed_propagation_TIME HEADING 'Elapsed |Propagation Time|(Seconds)' FORMAT 9999999999999999
COLUMN TOTAL_NUMBER HEADING 'Total |Events|Propagated' FORMAT 9999999999999999
COLUMN TOTAL_BYTES HEADING 'Total Bytes|Propagated' FORMAT 9999999999999999
COLUMN SCHEDULE_STATUS HEADING 'Schedule|Status'
column elapsed_dequeue_time HEADING 'Elapsed|Dequeue Time|(Seconds)'
column elapsed_pickle_time HEADING 'Total Time|(Seconds)'
column total_time HEADING 'Elapsed|Pickle Time|(Seconds)'
column high_water_mark HEADING 'High|Water|Mark'
column acknowledgement HEADING 'Target |Ack'


SELECT p.propagation_name,q.message_delivery_mode, DECODE(p.STATUS,
                'DISABLED', 'Disabled',
                'ENABLED', 'Enabled') SCHEDULE_STATUS,
  q.instance,
  q.total_number TOTAL_NUMBER, q.TOTAL_BYTES ,
  q.elapsed_dequeue_time/100 elapsed_dequeue_time, q.elapsed_pickle_time/100 elapsed_pickle_time,
  q.total_time/100 total_time
  FROM  DBA_PROPAGATION p, dba_queue_schedules q
      WHERE   p.DESTINATION_DBLINK = 
        NVL(REGEXP_SUBSTR(q.destination, '[^@]+', 1, 2), q.destination)
  AND q.SCHEMA = p.SOURCE_QUEUE_OWNER
  AND q.QNAME = p.SOURCE_QUEUE_NAME 
  order by q.message_delivery_mode, p.propagation_name;



prompt ++ PROPAGATION SENDER STATISTICS ++
prompt
col queue_id HEADING 'Queue ID'
col queue_schema HEADING 'Source|Queue|Owner'
col queue_name HEADING 'Source|Queue|Name'
col dst_queue_schema HEADING 'Destination|Queue|Owner'
col dst_queue_name HEADING 'Destination|Queue|Name'
col dblink Heading 'Destination|Database|Link'
col total_msgs HEADING 'Total|Messages'
col max_num_per_win HEADING 'Max Msgs|per|Window'
col max_size HEADING 'Max|Size'
col src_queue_schema HEADING 'Source|Queue|Owner'
col src_queue_name HEADING 'Source|Queue|Name'
column elapsed_dequeue_time HEADING 'Elapsed|Dequeue Time|(CentiSecs)'
column elapsed_pickle_time HEADING 'Total Time|(CentiSecs)'
column total_time HEADING 'Elapsed|Pickle Time|(CentiSecs)'


SELECT * from v$propagation_sender;


prompt
prompt ++ PROPAGATION RECEIVER STATISTICS++
prompt

column src_queue_name HEADING 'Source|Queue|Name'
column src_dbname HEADING 'Source|Database|Name'
column startup_time HEADING 'Startup|Time'
column elapsed_unpickle_time HEADING 'Elapsed|Unpickle Time|(CentiSeconds'
column elapsed_rule_time HEADING 'Elapsed|Rule Time|(CentiSeconds)'
column elapsed_enqueue_time HEADING 'Elapsed|Enqueue Time|(CentiSeconds)'

SELECT * from gv$propagation_receiver;

prompt
prompt ++ BUFFERED SUBSCRIBERS ++

select * from gv$buffered_subscribers;

prompt ============================================================================================
prompt
prompt ++  APPLY STATISTICS  ++
prompt
prompt ============================================================================================



prompt
prompt ++ APPLY Reader Statistics ++
col oldest_scn_num HEADING 'Oldest|SCN'
col apply_name HEADING 'Apply Name'
col apply_captured HEADING 'Captured or|User-Enqueued LCRs'
col process_name HEADING 'Process'
col state HEADING 'STATE'
col total_messages_dequeued HEADING 'Total Messages|Dequeued'
col total_messages_spilled Heading 'Total Messages|Spilled'
col sga_used HEADING 'SGA Used'
col oldest_transaction_id HEADING 'Oldest|Transaction'

SELECT ap.APPLY_NAME,
       DECODE(ap.APPLY_CAPTURED,
                'YES','Captured LCRS',
                'NO','User-Enqueued','UNKNOWN') APPLY_CAPTURED,
       SUBSTR(s.PROGRAM,INSTR(S.PROGRAM,'(')+1,4) PROCESS_NAME,
       r.STATE,
       r.TOTAL_MESSAGES_DEQUEUED,
       r.TOTAL_MESSAGES_SPILLED,
       r.SGA_USED, 
       oldest_scn_num,
       oldest_xidusn||'.'||oldest_xidslt||'.'||oldest_xidsqn 
             oldest_transaction_id
       FROM gV$STREAMS_APPLY_READER r, gV$SESSION s, DBA_APPLY ap
       WHERE r.SID = s.SID AND
             r.SERIAL# = s.SERIAL# AND
             r.APPLY_NAME = ap.APPLY_NAME;

col creation HEADING 'Dequeued Message|Creation|Timestamp'
col last_dequeue HEADING 'Dequeue |Timestamp'
col dequeued_message_number HEADING 'Last |Dequeued Message|Number'
col last_browse_num HEADING 'Last|Browsed Message|Number'
col latency HEADING 'Apply Reader|Latency|(Seconds)'

SELECT APPLY_NAME,
       (DEQUEUE_TIME-DEQUEUED_MESSAGE_CREATE_TIME)*86400 LATENCY,
     TO_CHAR(DEQUEUED_MESSAGE_CREATE_TIME,'HH24:MI:SS MM/DD') CREATION,
     TO_CHAR(DEQUEUE_TIME,'HH24:MI:SS MM/DD') LAST_DEQUEUE, 
     DEQUEUED_MESSAGE_NUMBER,
     last_browse_num
  FROM gV$STREAMS_APPLY_READER;

col elapsed_dequeue HEADING 'Elapsed Time|Dequeue|(centisecs)'
col elapsed_schedule HEADING 'Elapsed Time|Schedule|(centisecs)'
col elapsed_spill HEADING 'Elapsed Time|Spill|(centisecs)'
col elapsed_idle HEADING 'Elapsed Time|Idle|(centisecs)'

Select APPLY_NAME, total_messages_dequeued, total_messages_spilled,         Elapsed_dequeue_time Elapsed_dequeue, 
        elapsed_schedule_time elapsed_schedule, 
        elapsed_spill_time elapsed_spill
  from gv$STREAMS_APPLY_READER;

prompt ============================================================================================
prompt
prompt ++ APPLY SPILLED TRANSACTIONS ++

col APPLY_NAME	Head 'Apply Name'
col txn_id   HEAD 'Transaction|ID'
col  FIRST_SCN	Head 'SCN of First| Message in Txn'
col  MESSAGE_COUNT  Head 'Count of |Messages in Txn'
col  FIRST_MESSAGE_CREATE_TIME	Head 'First Message|Creation Time'
col  SPILL_CREATION_TIME  Head ' Spill |Creation Time'

select Apply_name, 
       xidusn||'.'||xidslt||'.'||xidsqn txn_id,
       first_scn, 
       first_message_create_time, 
       message_count, 
       spill_creation_time   
    from dba_apply_SPILL_TXN;


prompt ============================================================================================
prompt
prompt ++ APPLY Coordinator Statistics ++
col apply_name HEADING 'Apply Name' format a22 wrap
col process HEADING 'Process' format a7
col RECEIVED HEADING 'Total|Txns|Received' 
col ASSIGNED HEADING 'Total|Txns|Assigned' 
col APPLIED HEADING 'Total|Txns|Applied' 
col ERRORS HEADING 'Total|Txns|w/ Error' 
col total_ignored HEADING 'Total|Txns|Ignored' 
col total_rollbacks HEADING 'Total|Txns|Rollback' 
col WAIT_DEPS HEADING 'Total|Txns|Wait_Deps' 
col WAIT_COMMITS HEADING 'Total|Txns|Wait_Commits' 
col STATE HEADING 'State' format a10 word

SELECT ap.APPLY_NAME,
       SUBSTR(s.PROGRAM,INSTR(S.PROGRAM,'(')+1,4) PROCESS,
       c.STATE,
       c.TOTAL_RECEIVED RECEIVED,
       c.TOTAL_ASSIGNED ASSIGNED,
       c.TOTAL_APPLIED APPLIED,
       c.TOTAL_ERRORS ERRORS,
       c.total_ignored,
       c.total_rollbacks,
       c.TOTAL_WAIT_DEPS WAIT_DEPS, c.TOTAL_WAIT_COMMITS WAIT_COMMITS
       FROM gV$STREAMS_APPLY_COORDINATOR  c, gV$SESSION s, DBA_APPLY ap
       WHERE c.SID = s.SID AND
             c.SERIAL# = s.SERIAL# AND
             c.APPLY_NAME = ap.APPLY_NAME;

col lwm_msg_ts HEADING 'LWM Message|Creation|Timestamp'
col lwm_msg_nbr HEADING 'LWM Message|SCN'
col lwm_updated HEADING 'LWM Updated|Timestamp'
col hwm_msg_ts HEADING 'HWM Message|Creation|Timestamp'
col hwm_msg_nbr HEADING 'HWM Message|SCN'
col hwm_updated HEADING 'HWM Updated|Timestamp'


SELECT APPLY_NAME,
     LWM_MESSAGE_CREATE_TIME LWM_MSG_TS ,
     LWM_MESSAGE_NUMBER LWM_MSG_NBR ,
     LWM_TIME LWM_UPDATED,
     HWM_MESSAGE_CREATE_TIME HWM_MSG_TS,
     HWM_MESSAGE_NUMBER HWM_MSG_NBR ,
     HWM_TIME HWM_UPDATED
  FROM gV$STREAMS_APPLY_COORDINATOR;

SELECT APPLY_NAME,      TOTAL_RECEIVED,TOTAL_ASSIGNED,TOTAL_APPLIED,
     STARTUP_TIME,
     ELAPSED_SCHEDULE_TIME elapsed_schedule, 
     ELAPSED_IDLE_TIME  elapsed_idle
from gv$streams_apply_coordinator;
     
prompt ============================================================================================
prompt
prompt  ++ APPLY Server Statistics ++
col SRVR format 9999
col ASSIGNED format 9999999999999999 Heading 'Total|Transactions|Assigned'
col MSG_APPLIED heading 'Total|Messages|Applied' FORMAT 9999999999999999
col MESSAGE_SEQUENCE FORMAT 9999999999999999
col applied_message_create_time HEADING 'Applied Message|Creation|Timestamp'
col applied_message_number HEADING 'Last Applied|Message|SCN'
col lwm_updated HEADING 'Applied|Timestamp'
col message_sequence HEADING 'Message|Sequence'
col elapsed_apply_time HEADING 'Elapsed|Apply|Time (cs)'
col elapsed_dequeue_time HEADING 'Elapsed|Dequeue|Time (cs)'
col apply_time Heading 'Apply Time'

SELECT ap.APPLY_NAME,
       SUBSTR(s.PROGRAM,INSTR(S.PROGRAM,'(')+1,4) PROCESS_NAME,
       a.server_id SRVR,
       a.STATE,
       a.TOTAL_ASSIGNED ASSIGNED,
       a.TOTAL_MESSAGES_APPLIED msg_APPLIED,
       a.APPLIED_MESSAGE_NUMBER, 
       a.APPLIED_MESSAGE_CREATE_TIME ,
       a.MESSAGE_SEQUENCE, a.elapsed_dequeue_time, a.elapsed_apply_time, a.apply_time
       FROM gV$STREAMS_APPLY_SERVER a, gV$SESSION s, DBA_APPLY ap
       WHERE a.SID = s.SID AND
             a.SERIAL# = s.SERIAL# AND
             a.APPLY_NAME = ap.APPLY_NAME order by a.apply_name, a.server_id;


Col apply_name Heading 'Apply Name' FORMAT A30
Col server_id Heading 'Apply Server Number' FORMAT 99999999
Col sqltext Heading 'Current SQL' FORMAT A64

select a.inst_id, a.apply_name,  a.server_id, q.sql_text sqltext
  from gv$streams_apply_server a, gv$sqltext q, gv$session s
 where a.sid = s.sid and s.sql_hash_value = q.hash_value 
   and s.sql_address = q.address and s.sql_id = q.sql_id 
 order by a.apply_name, a.server_id, q.piece;

Col apply_name Heading 'Apply Name' FORMAT A30
Col server_id Heading 'Apply Server Number' FORMAT 99999999
Col event Heading 'Wait Event' FORMAT A64
Col secs Heading 'Seconds Waiting' FORMAT 9999999999999999

select a.inst_id, a.apply_name, a.server_id, w.event, w.seconds_in_wait secs
  from gv$streams_apply_server a, gv$session_wait w 
 where a.sid = w.sid order by a.apply_name, a.server_id;

Col apply_name Heading 'Apply Name' FORMAT A30
Col server_id Heading 'Apply Server Number' FORMAT 99999999
Col event Heading 'Wait Event' FORMAT 99999999
Col total_waits Heading 'Total Waits' FORMAT 9999999999999999
Col total_timeouts Heading 'Total Timeouts' FORMAT 9999999999999999
Col time_waited Heading 'Time Waited' FORMAT 9999999999999999
Col average_wait Heading 'Average Wait' FORMAT 9999999999999999
Col max_wait Heading 'Maximum Wait' FORMAT 9999999999999999

select a.inst_id, a.apply_name, a.server_id, e.event, e.total_waits, e.total_timeouts,
       e.time_waited, e.average_wait, e.max_wait 
  from gv$streams_apply_server a, gv$session_event e
 where a.sid = e.sid order by a.apply_name, a.server_id,e.time_waited desc;


col current_txn format a15 wrap
col dependent_txn format a15 wrap

select APPLY_NAME, server_id SRVR,
xidusn||'.'||xidslt||'.'||xidsqn CURRENT_TXN,
commitscn,
dep_xidusn||'.'||dep_xidslt||'.'||dep_xidsqn DEPENDENT_TXN,
dep_commitscn
from  gv$streams_apply_server order by apply_name,server_id;


prompt  ++  APPLY PROGRESS ++
col oldest_message_number HEADING 'Oldest|Message|SCN'
col apply_time HEADING 'Apply|Timestamp'
select * from dba_apply_progress;

prompt ============================================================================================
prompt
prompt ++ OPEN STREAMS APPLY TRANSACTIONS ++
prompt
prompt +**   Count    **+
select streams_name, count(*) "Open Transactions",sum(cumulative_message_count) "Total LCRs" from gv$streams_transaction where streams_type='APPLY' group by streams_name;

prompt
prompt +**   Detail    **+
select * from gv$streams_transaction where streams_type='APPLY' order by streams_name,first_message_number;
prompt

prompt ================================================================================
prompt ++ STREAMS Process Wait Analysis ++ 
prompt ================================================================================

prompt
set lines 180
set numf 9999999999999
set pages 9999
set verify OFF

COL BUSY FORMAT A4
COL PERCENTAGE FORMAT 999D9
COL event wrapped

-- This variable controls how many minutes in the past to analyze
DEFINE minutes_to_analyze = 30

prompt  Analysis of last &minutes_to_analyze minutes of Streams processes
prompt

PROMPT Note:  When computing the busiest component, be sure to subtract the percentage where BUSY = 'NO'
PROMPT Note:  'no rows selected' means that the process was performing no busy work, or that no such process exists on the system.
PROMPT Note:  A null Wait Event implies running - either on the cpu or waiting for cpu

prompt
prompt ++ LOGMINER READER PROCESSES ++

COL LOGMINER_READER_NAME FORMAT A30 WRAP
BREAK ON LOGMINER_READER_NAME;
COMPUTE SUM LABEL 'TOTAL' OF PERCENTAGE ON LOGMINER_READER_NAME;
SELECT c.capture_name || ' - reader' as logminer_reader_name, 
       ash_capture.event_count, ash_total.total_count, 
       ash_capture.event_count*100/ash_total.total_count percentage, 
       'YES' busy,
       ash_capture.event
FROM (SELECT SESSION_ID,
             SESSION_SERIAL#,
             EVENT,
             COUNT(sample_time) AS EVENT_COUNT
       FROM  v$active_session_history
       WHERE sample_time > sysdate - &minutes_to_analyze/24/60
       GROUP BY session_id, session_serial#, event) ash_capture,
     (SELECT COUNT(DISTINCT sample_time) AS TOTAL_COUNT
       FROM  v$active_session_history
       WHERE sample_time > sysdate - &minutes_to_analyze/24/60) ash_total,
     v$logmnr_process lp, v$streams_capture c
WHERE lp.SID = ash_capture.SESSION_ID 
  AND lp.serial# = ash_capture.SESSION_SERIAL#
  AND lp.role = 'reader' and lp.session_id = c.logminer_id
ORDER BY logminer_reader_name, percentage;

prompt
prompt ++ LOGMINER PREPARER PROCESSES ++

COL LOGMINER_PREPARER_NAME FORMAT A30 WRAP
BREAK ON LOGMINER_PREPARER_NAME;
COMPUTE SUM LABEL 'TOTAL' OF PERCENTAGE ON LOGMINER_PREPARER_NAME;
SELECT c.capture_name || ' - preparer' || lp.spid as logminer_preparer_name, 
       ash_capture.event_count, ash_total.total_count, 
       ash_capture.event_count*100/ash_total.total_count percentage, 
       'YES' busy,
       ash_capture.event
FROM (SELECT SESSION_ID,
             SESSION_SERIAL#,
             EVENT,
             COUNT(sample_time) AS EVENT_COUNT
       FROM  v$active_session_history
       WHERE sample_time > sysdate - &minutes_to_analyze/24/60
       GROUP BY session_id, session_serial#, event) ash_capture,
     (SELECT COUNT(DISTINCT sample_time) AS TOTAL_COUNT
       FROM  v$active_session_history
       WHERE sample_time > sysdate - &minutes_to_analyze/24/60) ash_total,
     v$logmnr_process lp, v$streams_capture c
WHERE lp.SID = ash_capture.SESSION_ID 
  AND lp.serial# = ash_capture.SESSION_SERIAL#
  AND lp.role = 'preparer' and lp.session_id = c.logminer_id
ORDER BY logminer_preparer_name, percentage;

prompt
prompt ++ LOGMINER BUILDER PROCESSES ++

COL LOGMINER_BUILDER_NAME FORMAT A30 WRAP
BREAK ON LOGMINER_BUILDER_NAME;
COMPUTE SUM LABEL 'TOTAL' OF PERCENTAGE ON LOGMINER_BUILDER_NAME;
SELECT c.capture_name || ' - builder' as logminer_builder_name, 
       ash_capture.event_count, ash_total.total_count, 
       ash_capture.event_count*100/ash_total.total_count percentage, 
       'YES' busy,
       ash_capture.event
FROM (SELECT SESSION_ID,
             SESSION_SERIAL#,
             EVENT,
             COUNT(sample_time) AS EVENT_COUNT
       FROM  v$active_session_history
       WHERE sample_time > sysdate - &minutes_to_analyze/24/60
       GROUP BY session_id, session_serial#, event) ash_capture,
     (SELECT COUNT(DISTINCT sample_time) AS TOTAL_COUNT
       FROM  v$active_session_history
       WHERE sample_time > sysdate - &minutes_to_analyze/24/60) ash_total,
     v$logmnr_process lp, v$streams_capture c
WHERE lp.SID = ash_capture.SESSION_ID 
  AND lp.serial# = ash_capture.SESSION_SERIAL#
  AND lp.role = 'builder' and lp.session_id = c.logminer_id
ORDER BY logminer_builder_name, percentage;


prompt
prompt ++ CAPTURE PROCESSES ++

COL CAPTURE_NAME FORMAT A30 WRAP
BREAK ON CAPTURE_NAME;
COMPUTE SUM LABEL 'TOTAL' OF PERCENTAGE ON CAPTURE_NAME;
SELECT c.capture_name, 
       ash_capture.event_count, ash_total.total_count, 
       ash_capture.event_count*100/ash_total.total_count percentage, 
       DECODE(ash_capture.event, 
              'Streams capture: waiting for subscribers to catch up', 'NO',
              'Streams capture: resolve low memory condition', 'NO',
              'Streams capture: waiting for archive log', 'NO',
              'YES') busy,
       ash_capture.event
FROM (SELECT SESSION_ID,
             SESSION_SERIAL#,
             EVENT,
             COUNT(sample_time) AS EVENT_COUNT
       FROM  v$active_session_history
       WHERE sample_time > sysdate - &minutes_to_analyze/24/60
       GROUP BY session_id, session_serial#, event) ash_capture,
     (SELECT COUNT(DISTINCT sample_time) AS TOTAL_COUNT
       FROM  v$active_session_history
       WHERE sample_time > sysdate - &minutes_to_analyze/24/60) ash_total,
     v$streams_capture c
WHERE c.SID = ash_capture.SESSION_ID and c.serial# = ash_capture.SESSION_SERIAL#
ORDER BY capture_name, percentage;


/*
prompt
prompt ++ PROPAGATION SENDER PROCESSES ++

COL PROPAGATION_NAME FORMAT A30 WRAP
BREAK ON PROPAGATION_NAME;
COMPUTE SUM LABEL 'TOTAL' OF PERCENTAGE ON PROPAGATION_NAME;
SELECT ('"'||vps.queue_schema||'"."'||vps.queue_name||
          '"=>'||vps.dblink) as propagation_name,
       ash.event_count, ash_total.total_count, 
       ash.event_count*100/ash_total.total_count percentage, 
       DECODE(ash.event, 
              'SQL*Net more data to dblink', 'NO',
              'SQL*Net message from dblink', 'NO',
              'YES') busy,
       ash.event
FROM (SELECT SESSION_ID,
             SESSION_SERIAL#,
             EVENT,
             COUNT(sample_time) AS EVENT_COUNT
       FROM  v$active_session_history
       WHERE sample_time > sysdate - &minutes_to_analyze/24/60
       GROUP BY session_id, session_serial#, event) ash,
     (SELECT COUNT(DISTINCT sample_time) AS TOTAL_COUNT
       FROM  v$active_session_history
       WHERE sample_time > sysdate - &minutes_to_analyze/24/60) ash_total,
     v$propagation_sender vps, x$kwqps xps
WHERE xps.kwqpssid = ash.SESSION_ID and xps.kwqpsser = ash.SESSION_SERIAL#
  AND xps.kwqpsqid = vps.queue_id and vps.dblink = xps.KWQPSDBN
ORDER BY propagation_name, percentage;



prompt
prompt ++ PROPAGATION RECEIVER PROCESSES ++

COL PROPAGATION_RECEIVER_NAME FORMAT A30 WRAP
BREAK ON PROPAGATION_RECEIVER_NAME;
COMPUTE SUM LABEL 'TOTAL' OF PERCENTAGE ON PROPAGATION_RECEIVER_NAME;
SELECT ('"'||vpr.src_queue_schema||'"."'||vpr.src_queue_name||
          '@' || vpr.src_dbname|| '"=>'||global_name) 
          as propagation_receiver_name,
       ash.event_count, ash_total.total_count, 
       ash.event_count*100/ash_total.total_count percentage, 
       DECODE(ash.event, 
              'Streams AQ: enqueue blocked on low memory', 'NO',
              'Streams AQ: enqueue blocked due to flow control', 'NO',
              'YES') busy,
       ash.event
FROM (SELECT SESSION_ID,
             SESSION_SERIAL#,
             EVENT,
             COUNT(sample_time) AS EVENT_COUNT
       FROM  v$active_session_history
       WHERE sample_time > sysdate - &minutes_to_analyze/24/60
       GROUP BY session_id, session_serial#, event) ash,
     (SELECT COUNT(DISTINCT sample_time) AS TOTAL_COUNT
       FROM  v$active_session_history
       WHERE sample_time > sysdate - &minutes_to_analyze/24/60) ash_total,
     v$propagation_receiver vpr, x$kwqpd xpd, global_name
WHERE xpd.kwqpdsid = ash.SESSION_ID and xpd.kwqpdser = ash.SESSION_SERIAL#
  AND xpd.kwqpdsqn = vpr.src_queue_name 
  AND xpd.kwqpdsqs = vpr.src_queue_schema and xpd.kwqpddbn = vpr.src_dbname
ORDER BY propagation_receiver_name, percentage;
*/


prompt
prompt ++ APPLY READER PROCESSES ++

COL APPLY_READER_NAME FORMAT A30 WRAP
BREAK ON APPLY_READER_NAME;
COMPUTE SUM LABEL 'TOTAL' OF PERCENTAGE ON APPLY_READER_NAME;
SELECT a.apply_name as apply_reader_name,
       ash.event_count, ash_total.total_count, 
       ash.event_count*100/ash_total.total_count percentage, 
       DECODE(ash.event, 
              'rdbms ipc message', 'NO',
              'YES') busy,
       ash.event
FROM (SELECT SESSION_ID,
             SESSION_SERIAL#,
             EVENT,
             COUNT(sample_time) AS EVENT_COUNT
       FROM  v$active_session_history
       WHERE sample_time > sysdate - &minutes_to_analyze/24/60
       GROUP BY session_id, session_serial#, event) ash,
     (SELECT COUNT(DISTINCT sample_time) AS TOTAL_COUNT
       FROM  v$active_session_history
       WHERE sample_time > sysdate - &minutes_to_analyze/24/60) ash_total,
     v$streams_apply_reader a
WHERE a.sid = ash.SESSION_ID and a.serial# = ash.SESSION_SERIAL#
ORDER BY apply_reader_name, percentage;



prompt
prompt ++ APPLY COORDINATOR PROCESSES ++

COL APPLY_COORDINATOR_NAME FORMAT A30 WRAP
BREAK ON APPLY_COORDINATOR_NAME;
COMPUTE SUM LABEL 'TOTAL' OF PERCENTAGE ON APPLY_COORDINATOR_NAME;
SELECT a.apply_name as apply_coordinator_name,
       ash.event_count, ash_total.total_count, 
       ash.event_count*100/ash_total.total_count percentage, 
       'YES' busy,
       ash.event
FROM (SELECT SESSION_ID,
             SESSION_SERIAL#,
             EVENT,
             COUNT(sample_time) AS EVENT_COUNT
       FROM  v$active_session_history
       WHERE sample_time > sysdate - &minutes_to_analyze/24/60
       GROUP BY session_id, session_serial#, event) ash,
     (SELECT COUNT(DISTINCT sample_time) AS TOTAL_COUNT
       FROM  v$active_session_history
       WHERE sample_time > sysdate - &minutes_to_analyze/24/60) ash_total,
     v$streams_apply_coordinator a
WHERE a.sid = ash.SESSION_ID and a.serial# = ash.SESSION_SERIAL#
ORDER BY apply_coordinator_name, percentage;



prompt
prompt ++ APPLY SERVER PROCESSES ++

COL APPLY_SERVER_NAME FORMAT A30 WRAP
BREAK ON APPLY_SERVER_NAME;
COMPUTE SUM LABEL 'TOTAL' OF PERCENTAGE ON APPLY_SERVER_NAME;
SELECT a.apply_name || ' - ' || a.server_id as apply_server_name,
       ash.event_count, ash_total.total_count, 
       ash.event_count*100/ash_total.total_count percentage, 
       'YES' busy,
       ash.event
FROM (SELECT SESSION_ID,
             SESSION_SERIAL#,
             EVENT,
             COUNT(sample_time) AS EVENT_COUNT
       FROM  v$active_session_history
       WHERE sample_time > sysdate - &minutes_to_analyze/24/60
       GROUP BY session_id, session_serial#, event) ash,
     (SELECT COUNT(DISTINCT sample_time) AS TOTAL_COUNT
       FROM  v$active_session_history
       WHERE sample_time > sysdate - &minutes_to_analyze/24/60) ash_total,
     v$streams_apply_server a
WHERE a.sid = ash.SESSION_ID and a.serial# = ash.SESSION_SERIAL#
ORDER BY apply_server_name, percentage;
