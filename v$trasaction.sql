col USERNAME for a20
col PROGRAM for a20
col COMMAND for a20
select
   sid ,
   sql_id ,
   substr(s.username,1,18) username,
   substr(s.program,1,15) program,
   decode(s.command,
     0,'No Command',
     1,'Create Table',
     2,'Insert',
     3,'Select',
     6,'Update',
     7,'Delete',
     9,'Create Index',
     15,'Alter Table',
     21,'Create View',
     23,'Validate Index',
     35,'Alter Database',
     39,'Create Tablespace',
     41,'Drop Tablespace',
     40,'Alter Tablespace',
     53,'Drop User',
     62,'Analyze Table',
     63,'Analyze Index',
     s.command||': Other') command
from
   v$session     s,
   v$process     p,
   v$transaction t,
   v$rollstat    r,
   v$rollname    n
where s.paddr = p.addr
and s.taddr = t.addr (+)
and t.xidusn = r.usn (+)
and r.usn = n.usn (+)
and COMMAND not in (0,3)
order by 2;
