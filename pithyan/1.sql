alter session set tracefile_identifier='SQL_MERGE_TABLE2';

exec dbms_monitor.session_trace_enable(37,21453,waits=>true,binds=>true);


MERGE
   INTO  TDEST tgt
   USING TSOURCE src
   ON  ( src.KEYVAL = tgt.KEYVAL )
WHEN MATCHED
THEN
   UPDATE
   SET   tgt.VAL1 = src.VAL1
   ,     tgt.VAL2 = src.VAL2
   ,     tgt.VAL3 = src.VAL3
WHEN NOT MATCHED
THEN
   INSERT ( tgt.KEYVAL
          , tgt.VAL1
          , tgt.VAL2
          , tgt.VAL3 )
   VALUES ( src.KEYVAL
          , src.VAL1
          , src.VAL2
          , src.VAL3 );
		  
rollback;