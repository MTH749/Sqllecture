--INDEX�� ��ȸ�Ͽ� ������� �䱸���׿� �����ϴ� �����͸� ����� �� �� �ִ� ���

SELECT rowid, emp.*
FROM emp;

SELECT empno,rowid
FROM emp
ORDER BY empno;


--emp ���̺��� ��� �÷��� ��ȸ
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM table (dbms_xplan.display);

Plan hash value: 2949544139
 
--------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    38 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    38 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7782)
   
   
   --emp ���̺��� empno �÷��� ��ȸ
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM table (dbms_xplan.display);

Plan hash value: 56244932
 
----------------------------------------------------------------------------
| Id  | Operation         | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |        |     1 |     4 |     0   (0)| 00:00:01 |
|*  1 |  INDEX UNIQUE SCAN| PK_EMP |     1 |     4 |     0   (0)| 00:00:01 |
----------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - access("EMPNO"=7782)


--���� ������ ���� (pk_emp �������� ���� --> unique ���� ���� --> emp �ε��� ����

--INDEX ���� (�÷� �ߺ� ����)
--UNIQUE INDEX : �ε��� �÷��� ���� �ߺ��� �� ���� �ε��� (emp.empno, dpet.deptno)
--NON - UNIQUE INDEX(default) :�ε��� �÷��� ���� �ߺ� �� �� �ִ� �ε���
--                     (emp.job)
ALTER TABLE emp DROP CONSTRAINT pk_emp;

--CREATE INDEX idx_n_emp_01 ON emp (empno); 
CREATE INDEX idx_n_emp_01 ON emp (empno); 

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM table(dbms_xplan.display);

INSERT INTO emp (empno,ename) VALUES(7782,'brown');

--emp ���̺� job �÷����� non -unique �ε��� ����
--�ε����� : idx_n_emp_02
CREATE INDEX idx_n_02 ON emp(job);

SELECT job,rowid
FROM emp
ORDER BY job;

--emp ���̺��� �ε����� 2�� ����
--1. empno
--2. job
SELECT *
FROM EMP
WHERE sal >500;

SELECT *
FROM emp
WHERE job = 'MANAGER'; 

SELECT *
FROM emp
WHERE empno = 7369;

--idx_02 �ε���
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM table(dbms_xplan.display);

--dix_n_emp_03
--emp ���̺��� job, ename �÷����� non- unique �ε��� ����

CREATE INDEX idx_n_emp03 ON emp ( job,ename);

SELECT job, ename , rowid
FROM emp
ORDER BY job, ename;

--idx_n_emp_04
--ename, job �÷����� emp ���̺� non- unique �ε��� ����

CREATE INDEX idx_n_emp04 ON emp (ename,job);

SELECT ename, job , rowid
FROM emp
ORDER BY ename,job;


-- JOIN ���������� �ε���
-- emp ���̺��� empno �÷����� PRIMARY KEY ���� ������ ����
-- dept ���̺��� deptno �÷����� PRIMARY KEY ���� ������ ����
-- emp ���̺��� PRIMARY KEY ������ ������ �����̹Ƿ� �����
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

EXPLAIN PLAN FOR
SELECT ename , dname, loc
FROM emp, dept
WHERE emp.DEPTNO = dept.DEPTNO
AND emp.empno = 7788;

SELECT *
FROM table (dbms_xplan.display);

Plan hash value: 1709332084
 
----------------------------------------------------------------------------------------------
| Id  | Operation                     | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT              |              |     1 |    33 |     2   (0)| 00:00:01 |
|   1 |  NESTED LOOPS                 |              |       |       |            |          |
|   2 |   NESTED LOOPS                |              |     1 |    33 |     2   (0)| 00:00:01 |
|   3 |    TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    13 |     1   (0)| 00:00:01 |
|*  4 |     INDEX RANGE SCAN          | IDX_N_EMP_01 |     1 |       |     0   (0)| 00:00:01 |
|*  5 |    INDEX UNIQUE SCAN          | DEPT         |     1 |       |     0   (0)| 00:00:01 |
|   6 |   TABLE ACCESS BY INDEX ROWID | DEPT         |     4 |    80 |     1   (0)| 00:00:01 |
----------------------------------------------------------------------------------------------
--����  4 3 5 6 1 0
Predicate Information (identified by operation id):
---------------------------------------------------
 
   4 - access("EMP"."EMPNO"=7788)
   5 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")
   
DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept WHERE 1 =1;

--index 1
--deptno �÷����� UINQUE INDEX
CREATE UNIQUE INDEX idx_dt_uni01 ON dept_test(deptno);    
--dname �÷����� NON-UINQUE INDEX
CREATE INDEX idx_dt_nuni01 ON dept_test(dname);
--deptno , dname �÷����� NON-UINQUE INDEX
CREATE INDEX idx_dt_nuni02 ON dept_test(deptno, dname);
   
--index2
--1�� ������ �����ϴ� ddl �ۼ�
DROP INDEX idx_dt_uni01;
DROP INDEX idx_dt_nuni01;
DROP INDEX idx_dt_nuni02;

--����1
--exerd�� �����Ͽ� 
--hr.exerd�� min ������ �����ϴ� ������ �ۼ�
--KEY�� ���� �ۼ�

--����2
--nest loop join
--hash join
--sort merge join ���� pt�� word ������ �ۼ�.