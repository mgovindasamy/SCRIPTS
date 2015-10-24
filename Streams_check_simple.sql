SET LINE 190 PAGES 124

 
prompt ###########################################
prompt ++ DBA_CAPTURE
prompt ###########################################
PROMPT
COL DESTINATION_DBLINK FOR A20
COL ERROR_MESSAGE FOR A60
SELECT CAPTURE_NAME,STATUS,STATUS_CHANGE_TIME FROM DBA_CAPTURE;

prompt ###########################################
prompt ++ DBA_PROPAGATION
prompt ###########################################
PROMPT

SELECT PROPAGATION_NAME,SOURCE_QUEUE_NAME,STATUS,DESTINATION_DBLINK,ERROR_MESSAGE FROM DBA_PROPAGATION;

prompt ###########################################
prompt ++ DBA_APPLY
prompt ###########################################
PROMPT
SELECT APPLY_NAME,STATUS FROM DBA_APPLY;


prompt ###########################################
prompt ++ To see the latency:
prompt ###########################################
PROMPT

COLUMN APPLY_PROC FORMAT A30
COLUMN LAT_SEC FORMAT 999999999
COLUMN 'Message Creation' FORMAT A17
COLUMN 'Apply Time' FORMAT A17
COLUMN MSG_NO FORMAT 9999999999999999
SELECT INST_ID,SID,SERIAL#,APPLY_NAME APPLY_PROC,
TO_CHAR(HWM_MESSAGE_CREATE_TIME,'HH24:MI:SS DD/MM/YY')
"Message Creation",
TO_CHAR(HWM_TIME,'HH24:MI:SS DD/MM/YY') "Apply Time",
HWM_MESSAGE_NUMBER MSG_NO,
(HWM_TIME-HWM_MESSAGE_CREATE_TIME)*86400 LAT_SEC
FROM gV$STREAMS_APPLY_COORDINATOR;


prompt ###########################################
prompt ++ To see the apply errors:
prompt ###########################################
PROMPT

select count(1) from dba_apply_error;


prompt ###########################################
prompt ++ To see the queue size:
prompt ###########################################
PROMPT

select queue_name, num_msgs, spill_msgs from v$buffered_queues;
