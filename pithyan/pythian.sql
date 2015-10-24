--pythian
 sqlplus midhungt/a510777

 
CREATE DIRECTORY test AS '/home/oracle/midhungt/interview';

impdp midhungt/a510777 dumpfile=interview.dmp directory=test


Create user INTERVIEW identified by INTERVIEW default tablespace SLOB quota unlimited on SLOB;

imp INTERVIEW/INTERVIEW file=interview.dmp log=interview.log FULL=Y 

#########################################

    Type of business:

     We are a subscription company where people sign up to received products
    like CDs, books, magazines, etc. We always try to market new
    subscriptions to our existing client base, but because we have millions of
    customers who use the same email address, we like to send our
    promotional emails only once
	
	
	QUERY:

 

    Some assumptions will need to be made. Please list any such assumptions.

     How would you generate a list of unique email addresses with the latest name, gender
    and age for a user with that email address?

     The selection criteria limits the list to users who never subscribed to
    anything; or;
    users with inactive subscriptions; or;
    users with active subscriptions that renewed between Sep 1st and Sep
    30th of any year

    the answer should be:

    a@a.com <mailto:a@a.com> m 31 robert
    b@b.com <mailto:b@b.com> f 22 lulu
    c@c.com <mailto:c@c.com> f 08 kim
    d@d.com <mailto:d@d.com> m 22 Jay
    e@e.com <mailto:e@e.com> f 60 Will
	
#########################################
    Some assumptions will need to be made. Please list any such assumptions.
		-- assuming name of person is not uinque accross 
     How would you generate a list of unique email addresses with the latest name, gender
    and age for a user with that email address?

     The selection criteria limits the list to users who never subscribed to
    anything; or;
    users with inactive subscriptions; or;
    users with active subscriptions that renewed between Sep 1st and Sep
    30th of any year
	
USERS
subscriptions
transactions

interview@orcl> select * from users;

   USER_ID EMAIL                G        AGE NAME
---------- -------------------- - ---------- ------------------
         1 a@a.com              m         30 rob
         2 a@a.com              m         31 robert
         3 b@b.com              f         18 lucie
         4 b@b.com              f         22 lulu
         5 c@c.com              m         10 kim
         6 c@c.com              f         18 kim
         7 c@c.com              f          8 kim
         8 d@d.com              f         18 jj
         9 d@d.com              m         22 jay
        10 e@e.com              f         88 bill
        11 e@e.com              f         88 will
        12 e@e.com              f         60 will
        13 f@f.com              m         70 george
 
interview@orcl> select user_id from users u where user_id not in (select user_id from subscriptions);

   USER_ID
----------
         5
        12
         7
         4
         1
        11
         6

'<mailto:'||u.email||'>' mail,
		 
select u.email, u.gender,max(u.age) age,max(u.NAME)
--,s.SUBSCRIPTION_TYPE,s.ACTIVE_INDICATOR 
from users u, subscriptions s , transactions t
where 
( u.USER_ID=s.USER_ID and s.ACTIVE_INDICATOR='no') and (u.user_id!=s.USER_ID)
and ( s.SUBSCRIPTION_ID=t.SUBSCRIPTION_ID and ACTIVE_INDICATOR='yes' and t.ACTION='renewal' and t.TIMESTAMP between to_date('01-SEP','DD-MON') and to_date('01-SEP','DD-MON')  )
group by u.email,  u.gender
--,u.NAME,s.SUBSCRIPTION_TYPE,s.ACTIVE_INDICATOR
order by u.email;

with mod as (
select u.email, max(u.gender) gender, max(u.age) age,max(u.NAME) NAME from  users u, subscriptions s where u.user_id not in ( select s.USER_ID from subscriptions s) group by  u.email
union
select u.email, max(u.gender) gender,max(u.age) age,max(u.NAME) NAME from  users u, subscriptions s where u.user_id=s.USER_ID and s.ACTIVE_INDICATOR='no' group by  u.email 
union
select u.email, max(u.gender) gender,max(u.age) age,max(u.NAME) NAME from users u, subscriptions s , transactions t 
where u.user_id=s.user_id and s.SUBSCRIPTION_ID=t.SUBSCRIPTION_ID and ACTIVE_INDICATOR='yes' and t.ACTION='renewal' 
and to_CHAR(t.TIMESTAMP,'MON')='SEP'
group by u.email )
select  email,  max(gender), max( age) age,max( NAME) from mod group by email
order by 1;


    a@a.com <mailto:a@a.com> m 31 robert
    b@b.com <mailto:b@b.com> f 22 lulu
    c@c.com <mailto:c@c.com> f 08 kim
    d@d.com <mailto:d@d.com> m 22 Jay
    e@e.com <mailto:e@e.com> f 60 Will


with /*+ monitor */ mod as (
select u.email, u.gender, u.age, u.name, u.user_id from  users u where u.user_id not in ( select s.user_id from subscriptions s)  
union
select u.email, u.gender, u.age, u.name, u.user_id from  users u, subscriptions s where u.user_id=s.user_id and s.active_indicator='no'  
union
select u.email, u.gender, u.age, u.name, u.user_id from  users u, subscriptions s , transactions t 
		where u.user_id=s.user_id and s.subscription_id=t.subscription_id and active_indicator='yes' and t.action='renewal' 
		and to_char(t.timestamp,'mon')='sep'  )
select  * from mod  
order by USER_ID;


EMAIL                G        AGE NAME
-------------------- - ---------- --------------------
a@a.com              m         30 rob
a@a.com              m         31 robert*
b@b.com              f         18 lucie
b@b.com              f         22 lulu*
c@c.com              f          8 kim*
c@c.com              m         10 kim
c@c.com              f         18 kim
d@d.com              m         22 jay*
e@e.com              f         60 will*
e@e.com              f         88 bill
e@e.com              f         88 will

--###################
--###### final ######
--###################

with  id as (
select  u.email,max(u.user_id) user_id from  users u where u.user_id not in ( select s.user_id from subscriptions s)  group by u.email
union all
select  u.email,max(u.user_id) user_id from  users u, subscriptions s where u.user_id=s.user_id and s.active_indicator='no'  group by u.email  
union all
select  u.email,max(u.user_id) user_id from  users u, subscriptions s , transactions t 
		where u.user_id=s.user_id and s.subscription_id=t.subscription_id and active_indicator='yes' and t.action='renewal' 
		and to_char(t.timestamp,'mon')='sep'
  group by u.email ),
  fid as ( select   id.email,max(id.user_id) user_id from id group by id.email)
  select u.email,'<mailto:'||u.email||'>' mail,u.gender, u.age,initcap(u.NAME) from users u,fid where u.email=fid.email and u.user_id=fid.user_id
order by u.email;


col email for a10
col mail for a20
col gender for a10
col name for a10
with mod1 as (select *  
from users u
where
not exists (select s.user_id
from subscriptions s
where u.user_id = s.user_id) --Condition 1
or 
exists (select s.user_id
from subscriptions s
where u.user_id = s.user_id
and s.active_indicator = 'no') --Condition 2
or 
exists (select s.user_id
from subscriptions s, transactions t
where u.user_id = s.user_id
and s.subscription_id = t.subscription_id
and s.active_indicator = 'yes'
and t.action = 'renewal'
and to_char(t.timestamp, 'MON') = 'SEP')--Condition 3
), 
mod2 as (select mod1.*,RANK() OVER (PARTITION BY email ORDER BY user_id desc) rnk from mod1) --Assuming, we have to address each user with his/her first appeared name in our system
 select u.email,'<mailto:'||u.email||'>' mail,u.gender, u.age, u.name  from mod2 u where rnk=1;
 
 
--###################
--###### PL/SQL program ######
--###################


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
	
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.14       0.15          0        417      10730        9517
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        2      0.14       0.15          0        417      10730        9517


DECLARE
 type src_type is table of TSOURCE%ROWTYPE;
 src src_type;
BEGIN

   FOR src IN ( SELECT * FROM TSOURCE )
   LOOP
      UPDATE TDEST tgt
   SET   tgt.VAL1 = src.VAL1
   ,     tgt.VAL2 = src.VAL2
   ,     tgt.VAL3 = src.VAL3
      WHERE  tgt.KEYVAL = src.KEYVAL;
	--if not matching KEYVAL, then insert new one
      IF SQL%ROWCOUNT = 0 THEN
         INSERT INTO TDEST
            ( KEYVAL, VAL1, VAL2,VAL3 )
         VALUES
            ( src.KEYVAL, src.VAL1, src.VAL2,src.VAL3 );
      END IF;
   END LOOP;
END;
/

SQL     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
PL/SQL        2      0.73       0.87          0          0          0           1
select       98      0.00       0.00          0        132          0        9517
update     9518      1.97       1.92          0      19034       8761        8537
insert      981      0.20       0.20          0          8       3015         980
30950


OVERALL TOTALS FOR ALL RECURSIVE STATEMENTS

call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        4      0.00       0.00          0          0          0           0
Execute  10499      2.17       2.12          0      19042      11776        9517
Fetch       97      0.00       0.00          0        135          0        9518
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total    10600      2.18       2.13          0      19177      11776       19035



DECLARE
cursor c1 is
select keyval,val1,val2,val3 from TSOURCE;

type src_typ is table of c1%rowtype;
src_tab src_typ;

error_Count number := 0;
l_idx    number;

dup_val  EXCEPTION;
PRAGMA exception_init(dup_val , -24381);

BEGIN

  open c1;
  loop
    fetch c1 bulk collect into src_tab limit 1000;

        begin

          Forall i in 1..src_tab.count save exceptions
          insert into TDEST (keyval, val1, val2,val3)
          values(src_tab(i).keyval, src_tab(i).val1, src_tab(i).val2,src_tab(i).val3);
		  
        exception
           when dup_val  then
              error_count := sql%bulk_exceptions.count;

              for j in 1..error_count
              loop
               l_idx   := sql%bulk_exceptions(j).error_index;
                  update TDEST
                  set val1 = src_tab(l_idx).val1,val2 = src_tab(l_idx).val2,val3 = src_tab(l_idx).val3
                  where keyval = src_tab(l_idx).keyval;
              end loop;
			  
        end;
		
        exit when c1%notfound;
     end loop;
  close c1;
  --commit;
end;
/

 

 trcsess output=MERGE_TABLE.trc action=MERGE_TABLE1 orcl_ora_16569_MERGE_TABLE1.trc
 
 
 ######################
 
 sqlplus /nolog
connect perfstat/pw;
BEGIN
DBMS_SCHEDULER.CREATE_JOB (
job_name => 'snap_1',
job_type => 'STORED_PROCEDURE',
job_action => 'statspack.snap',
repeat_interval => 'FREQ=DAILY;BYHOUR=7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23;BYMINUTE=00,15,30,45',
auto_drop => FALSE,
enabled => TRUE,
comments => 'Business Window');
END;

sqlplus /nolog
connect perfstat/pw;
BEGIN
DBMS_SCHEDULER.CREATE_JOB (
job_name => 'snap_1',
job_type => 'STORED_PROCEDURE',
job_action => 'statspack.snap',
repeat_interval => 'FREQ=DAILY;BYHOUR=0,2,4,6;BYMINUTE=00',
auto_drop => FALSE,
enabled => TRUE,
comments => 'Batch Window');
END;

 
exec dbms_scheduler.create_job('myjob','plsql_block',job_action=>'begin test_interval; end;',repeat_interval => 'mytime');
exec dbms_scheduler.enable('myjob');

###############################################
--exec DBMS_SCHEDULER.DROP_SCHEDULE ( schedule_name => 'batch_window');
i'm using dbms_scheduler and defining intervals with BYHOUR to keep it simple and understandable to other DBA's

--exec DBMS_SCHEDULER.DROP_SCHEDULE ( schedule_name => 'batch_window');
BEGIN
  DBMS_SCHEDULER.CREATE_SCHEDULE ( schedule_name => 'batch_window',
  repeat_interval => 'FREQ=DAILY;BYHOUR=0,2,4,6;BYMINUTE=00;BYSECOND=00;',
  comments => 'Runs every 2hr from midnight to 7am, at stuck of hour');
END;
/

--exec DBMS_SCHEDULER.DROP_SCHEDULE ( schedule_name => 'business_window');
BEGIN
  DBMS_SCHEDULER.CREATE_SCHEDULE ( schedule_name => 'business_window',
  repeat_interval => 'FREQ=DAILY;BYHOUR=7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23;BYMINUTE=00,15,30,45;BYSECOND=00;', 
  comments => 'Runs every 15mins from 7am to midnight, at stuck of quater');
END;
/

--exec DBMS_SCHEDULER.DROP_SCHEDULE ( schedule_name => 'statspack_schedule');
BEGIN
  DBMS_SCHEDULER.CREATE_SCHEDULE ( schedule_name => 'statspack_schedule', 
  repeat_interval => 'batch_window,business_window', 
  comments => 'Schedule to capture statspack snapshots');
END;
/


BEGIN
DBMS_SCHEDULER.CREATE_JOB ( job_name => 'statspack_snapper', 
job_type => 'STORED_PROCEDURE', 
job_action => 'statspack.snap', 
enabled => TRUE, 
schedule_name => 'statspack_schedule');
END;
/

   SNAP_ID SNAP_TIME
---------- --------------------
         1 30-AUG-2015 03:02:05
         2 30-AUG-2015 03:02:47
        11 30-AUG-2015 04:15:02
        12 30-AUG-2015 04:30:02
        13 30-AUG-2015 04:45:02
        14 30-AUG-2015 05:00:02
        15 30-AUG-2015 05:15:02
        16 30-AUG-2015 05:30:02
        17 30-AUG-2015 05:45:03

###############################################
CREATE OR REPLACE
PROCEDURE print_schedule_dates(
    SCHEDULE   IN VARCHAR2,
    start_date IN TIMESTAMP WITH TIME ZONE DEFAULT dbms_scheduler.stime(
    ),
    number_of_dates IN pls_integer DEFAULT 100 )
IS
  date_after TIMESTAMP WITH TIME ZONE := start_date - interval '1' second;
  next_date  TIMESTAMP WITH TIME ZONE;
BEGIN
  FOR i IN 1 .. number_of_dates
  LOOP
    dbms_scheduler.evaluate_calendar_string (SCHEDULE, start_date, date_after, next_date);
    dbms_output.put_line(TO_CHAR(next_date, 'DY DD-MON-YYYY (DDD-IW) HH24:MI:SS TZH:TZM TZR'));
    date_after := next_date;
  END LOOP;
END;
/

exec print_schedule_dates('FREQ=DAILY;BYHOUR=7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23;BYMINUTE=00,15,30,45;BYSECOND=00;')

exec print_schedule_dates('FREQ=DAILY;BYHOUR=0,2,4,6;BYMINUTE=00;BYSECOND=00;');