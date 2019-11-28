SELECT *
FROM DBA_DATA_FILES;

--table space ���� (�������)
  CREATE TABLESPACE TS_DBSQL
   DATAFILE 'D:\B_UTIL\4.ORACLE\APP\ORACLE\ORADATA\XE\DBSQL.DBF' 
   SIZE 100M 
   AUTOEXTEND ON;


--����� �߰�
create user MTH identified by java
default tablespace TS_DBSQL
temporary tablespace temp
quota unlimited on TS_DBSQL
quota 0m on system;


--����, ��������
GRANT CONNECT, RESOURCE TO MTH;



alter user MTH identified by java;

select *
from dba_users;

alter user MTH account unlock;