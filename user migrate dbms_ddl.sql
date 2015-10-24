UNDEF Username
accept Username  prompt 'Enter Role name:'
SET LINESIZE 132 PAGESIZE 0 FEEDBACK off VERIFY off TRIMSPOOL on LONG 1000000
COLUMN Extracted_DDL FORMAT A100 WORD_WRAP
execute DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'STORAGE',false);
execute DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'PRETTY',true);
execute DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'SQLTERMINATOR',true);
select (case 
        when ((select count(*)
               from   dba_users
               where  username = '&&Username') > 0)
        then  dbms_metadata.get_ddl ('USER', '&&Username') 
        else  to_clob ('   -- Note: User not found!')
        end ) Extracted_DDL from dual
UNION ALL
select (case 
        when ((select count(*)
               from   dba_ts_quotas
               where  username = '&&Username') > 0)
        then  dbms_metadata.get_granted_ddl( 'TABLESPACE_QUOTA', '&&Username') 
        else  to_clob ('   -- Note: No TS Quotas found!')
        end ) from dual
UNION ALL
select (case 
        when ((select count(*)
               from   dba_role_privs
               where  grantee = '&&Username') > 0)
        then  dbms_metadata.get_granted_ddl ('ROLE_GRANT', '&&Username') 
        else  to_clob ('   -- Note: No granted Roles found!')
        end ) from dual
UNION ALL
select (case 
        when ((select count(*)
               from   dba_sys_privs
               where  grantee = '&&Username') > 0)
        then  dbms_metadata.get_granted_ddl ('SYSTEM_GRANT', '&&Username') 
        else  to_clob ('   -- Note: No System Privileges found!')
        end ) from dual
UNION ALL
select (case 
        when ((select count(*)
               from   dba_tab_privs
               where  grantee = '&&Username') > 0)
        then  dbms_metadata.get_granted_ddl ('OBJECT_GRANT', '&&Username') 
        else  to_clob ('   -- Note: No Object Privileges found!')
        end ) from dual
/

