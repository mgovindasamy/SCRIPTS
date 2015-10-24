--
--Sql statement reference
--
--Create a default Flashback Data Archive named fla1 that uses up to 10 G of tablespace tbs1, whose data will be retained for one year:
CREATE FLASHBACK ARCHIVE DEFAULT fla1 TABLESPACE tbs1 QUOTA 10G RETENTION 1 YEAR;

--Create a Flashback Data Archive named fla2 that uses tablespace tbs2, whose data will be retained for two years:
CREATE FLASHBACK ARCHIVE fla2 TABLESPACE tbs2 RETENTION 2 YEAR;

--Make Flashback Data Archive fla1 the default Flashback Data Archive:
ALTER FLASHBACK ARCHIVE fla1 SET DEFAULT;

--To Flashback Data Archive fla1, add up to 5 G of tablespace tbs3:
ALTER FLASHBACK ARCHIVE fla1 ADD TABLESPACE tbs3 QUOTA 5G;

--To Flashback Data Archive fla1, add as much of tablespace tbs4 as needed:
ALTER FLASHBACK ARCHIVE fla1 ADD TABLESPACE tbs4;

--Change the maximum space that Flashback Data Archive fla1 can use in tablespace tbs3 to 20 G:
ALTER FLASHBACK ARCHIVE fla1 MODIFY TABLESPACE tbs3 QUOTA 20G;

--Allow Flashback Data Archive fla1 to use as much of tablespace tbs1 as needed:
ALTER FLASHBACK ARCHIVE fla1 MODIFY TABLESPACE tbs1;

--Change the retention time for Flashback Data Archive fla1 to two years:
ALTER FLASHBACK ARCHIVE fla1 MODIFY RETENTION 2 YEAR;

--Remove tablespace tbs2 from Flashback Data Archive fla1:
ALTER FLASHBACK ARCHIVE fla1 REMOVE TABLESPACE tbs2;

--Purge all historical data from Flashback Data Archive fla1:
ALTER FLASHBACK ARCHIVE fla1 PURGE ALL;

--Purge all historical data older than one day from Flashback Data Archive fla1:
ALTER FLASHBACK ARCHIVE fla1
PURGE BEFORE TIMESTAMP (SYSTIMESTAMP - INTERVAL '1' DAY);

--Purge all historical data older than SCN 728969 from Flashback Data Archive fla1:
ALTER FLASHBACK ARCHIVE fla1 PURGE BEFORE SCN 728969;

--Remove Flashback Data Archive fla1 and all its historical data, but not its tablespaces:
DROP FLASHBACK ARCHIVE fla1;

--Create table employee and store the historical data in the default Flashback Data Archive:
CREATE TABLE employee (EMPNO NUMBER(4) NOT NULL, ENAME VARCHAR2(10)) FLASHBACK ARCHIVE;

--Create table employee and store the historical data in the Flashback Data Archive fla1:
CREATE TABLE employee (EMPNO NUMBER(4) NOT NULL, ENAME VARCHAR2(10)) FLASHBACK ARCHIVE fla1;

--Enable flashback archiving for the table employee and store the historical data in the default Flashback Data Archive:
ALTER TABLE employee FLASHBACK ARCHIVE;

--Enable flashback archiving for the table employee and store the historical data in the Flashback Data Archive fla1:
ALTER TABLE employee FLASHBACK ARCHIVE fla1;

--Disable flashback archiving for the table employee:
ALTER TABLE employee NO FLASHBACK ARCHIVE;
