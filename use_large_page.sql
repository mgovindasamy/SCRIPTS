col ORIGINATED for a40
col MESSAGE_TEXT for a140
WITH alrt
     AS (  SELECT  ORIGINATING_TIMESTAMP,
                  HOST_ID,
                  HOST_ADDRESS,
                  DETAILED_LOCATION,
                  MODULE_ID,
                  CLIENT_ID,
                  PROCESS_ID,
                  USER_ID,
                  MESSAGE_ID,
                  MESSAGE_GROUP,
                  MESSAGE_TEXT,
                  PROBLEM_KEY,
                  FILENAME
             FROM V$DIAG_ALERT_EXT,v$instance i
            WHERE TRIM (COMPONENT_ID) = 'rdbms'
                  AND ORIGINATING_TIMESTAMP between FROM_TZ(to_timestamp (to_char(STARTUP_TIME,'DD-MON-RR HH.MI.SS')),'-4:00') - INTERVAL '0 00:05:00.0' DAY TO SECOND (1)
				  and   FROM_TZ(to_timestamp (to_char(STARTUP_TIME,'DD-MON-RR HH.MI.SS')),'-4:00') + INTERVAL '0 00:05:00.0' DAY TO SECOND (1)
         ORDER BY ORIGINATING_TIMESTAMP desc)
  SELECT                                              --ORIGINATING_TIMESTAMP,
        --TO_CHAR (ORIGINATING_TIMESTAMP, 'Dy Mon dd hh24:mi:ss yyyy')
		ORIGINATING_TIMESTAMP
         ORIGINATED,
         listagg (MESSAGE_TEXT) WITHIN GROUP (ORDER BY ORIGINATING_TIMESTAMP)
            MESSAGE_TEXT
    FROM alrt
   WHERE filename = (SELECT VALUE || '/log.xml'
                       FROM v$diag_info
                      WHERE name = 'Diag Alert')
   and upper(MESSAGE_TEXT) like '%LARGE%PAGE%'
   --and rownum <500
GROUP BY ORIGINATING_TIMESTAMP
ORDER BY ORIGINATING_TIMESTAMP asc;
