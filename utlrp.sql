Rem
Rem utlrp.sql
Rem
Rem  Copyright (c) Oracle Corporation 1998. All Rights Reserved.
Rem
Rem    NAME
Rem      utlrp.sql - UTiLity script Recompile invalid Pl/sql modules
Rem
Rem    DESCRIPTION
Rem
Rem     This is a fairly general script that can be used at any time to
Rem     recompile all existing invalid PL/SQL modules in a database.
Rem
Rem     If run as one of the last steps during migration/upgrade/downgrade
Rem     (see the README notes for your current release and the Oracle
Rem     Migration book), this script  will validate all PL/SQL modules
Rem     (procedures, functions, packages, triggers, types, views) during
Rem     the migration step itself.
Rem
Rem     Although invalid PL/SQL modules get automatically recompiled on use,
Rem     it is useful to run this script ahead of time (e.g. as one of the last
Rem     steps in your migration), since this will either eliminate or
Rem     minimize subsequent latencies caused due to on-demand automatic
Rem     recompilation at runtime.
Rem
Rem     Oracle highly recommends running this script towards the end of
Rem     of any migration/upgrade/downgrade.
Rem
Rem   NOTES
Rem
Rem     * Must be connected as internal to run this.
Rem
Rem     * The scripts expects the following packages to have been created with
Rem       VALID status.
Rem         STANDARD      (standard.sql)
Rem         DBMS_STANDARD (dbmsstdx.sql)
Rem
Rem     * There should be no other DDL on the database while running
Rem       the script. Not following this recommendation may lead to
Rem       deadlocks.
Rem
Rem   MODIFIED   (MM/DD/YY)
Rem    ncramesh    08/04/98 - change for sqlplus
Rem    usundara    06/03/98 - merge from 8.0.5
Rem    usundara    04/29/98 - creation (split from utlirp.sql).
Rem                           Mark Ramacher (mramache) was the original
Rem                           author of this script.
Rem

Rem ===========================================================================
Rem BEGIN utlrp.sql
Rem ===========================================================================

--
--
-- *********************************************************************
-- NOTE: Package STANDARD and DBMS_STANDARD must be valid before running
-- this part.  If these are not valid, run standard.sql and
-- dbms_standard.sql to recreate and validate STANDARD and DBMS_STANDARD;
-- then run this portion.
-- *********************************************************************
-- The following anonymous block will try to validate all views, functions,
-- procedures, packages, triggers, and ADTs.  It is meant to be used after 
-- performing any operation that will invalidate PL/SQL related items (views
-- are included since they can depend on PL/SQL functions).
--
-- This must be run as the user SYS, and there should be no other DDL on
-- the database while running the script.  Not following this recommendation
-- may lead to deadlocks.
--
--   The anonymous block is idempotent, it can be run as many times as needed.
-- It is also robust, in that it will continue on to the next item in the list
-- if a compilation fails for one reason or another.
--
--   The basic function of this anonymous block is to move the types listed
-- above from statuses 4, 5 and 6 to statuses 1, 2, or 3.  If a compile of
-- an object fails for some reason (not because there are compilation errors,
-- but because there was a server error such as a deadlock), then this object
-- will be left in status 4, 5, or 6.  To monitor progress of the block,
-- you can watch the number returned from the following query as it
-- decreases...
--
--  select count(*) from obj$ where status in (4,5,6) and
--    type# in (4, 7, 8, 9, 11, 12, 13, 14); 

DECLARE
 obj_number number := 0;

 cursor C1 is select o.obj#, 
           'ALTER ' || decode (o.type#,
                               4, 'VIEW ',
                               7, 'PROCEDURE ',
                               8, 'FUNCTION ',
                               9, 'PACKAGE ',
                               11, 'PACKAGE ',
                               12, 'TRIGGER ',
                               13, 'TYPE ',
                               14, 'TYPE ',
                               ' ') ||
            u.name || '.' || o.name || ' COMPILE ' ||
                       decode (o.type#,
                               9, 'SPECIFICATION',
                               11, 'BODY',
                               13, 'SPECIFICATION',
                               14, 'BODY',
                               ' ')
           from obj$ o, user$ u
           where o.obj# > obj_number and 
           u.user# = o.owner# and o.remoteowner is NULL and
           o.status in (4,5,6) and o.type# in (4, 7, 8, 9, 11, 12, 13, 14)
           order by o.obj#;

  DDL_CURSOR integer;
  ddl_statement varchar2(200);
  iterations number;
  loop_count number;
  my_err     number;
  validate   number;
BEGIN
 loop_count := 0;
 -- To make sure we eventually stop, pick a max number of iterations
 select count(*) into iterations from obj$ where remoteowner is NULL and
           status in (4,5,6) and type# in (4, 7, 8, 9, 11, 12, 13, 14); 

 DDL_CURSOR := dbms_sql.open_cursor;
 OPEN C1;

 LOOP

   BEGIN
     FETCH C1 INTO obj_number, ddl_statement;
     EXIT WHEN C1%NOTFOUND OR loop_count > iterations;
   EXCEPTION
    WHEN OTHERS THEN
      my_err := SQLCODE;
      IF my_err = -1555 THEN -- snapshot too old, re-execute fetch query
       CLOSE C1;
       -- Here is why C1 orders by obj#.  When we restart the query, we 
       -- will only find object with obj# greater than the last one tried.
       -- This keeps us from re-trying objects that failed.
       OPEN  C1;
       GOTO continue;
      ELSE
       RAISE;
      END IF;
   END;

   -- Check to see if already validated as a result of earlier compiles
   select count(*) into validate from obj$ where obj# = obj_number and
    status in (4,5,6);

   IF validate = 1 THEN
     BEGIN
       -- Issue the Alter Statement  (Parse implicitly executes DDLs)
       dbms_sql.parse(DDL_CURSOR, ddl_statement, dbms_sql.native);
     EXCEPTION
       WHEN OTHERS THEN
        null; -- ignore, and proceed.
     END;
   END IF;

 <<continue>>
   loop_count := loop_count + 1;
 END LOOP;
 dbms_sql.close_cursor(DDL_CURSOR);
 CLOSE C1;
END;
/

Rem ===========================================================================
Rem END utlrp.sql
Rem ===========================================================================
