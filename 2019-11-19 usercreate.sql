SELECT *
FROM DBA_DATA_FILES;

--table space 생성 (저장공간)
  CREATE TABLESPACE TS_DBSQL
   DATAFILE 'D:\B_UTIL\4.ORACLE\APP\ORACLE\ORADATA\XE\DBSQL.DBF' 
   SIZE 100M 
   AUTOEXTEND ON;


--사용자 추가
create user MTH identified by java
default tablespace TS_DBSQL
temporary tablespace temp
quota unlimited on TS_DBSQL
quota 0m on system;


--접속, 생성권한
GRANT CONNECT, RESOURCE TO MTH;



alter user MTH identified by java;

select *
from dba_users;

alter user MTH account unlock;