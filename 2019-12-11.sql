--INDEX만 조회하여 사용자의 요구사항에 만족하는 데이터를 만들어 낼 수 있는 경우

SELECT rowid, emp.*
FROM emp;

SELECT empno,rowid
FROM emp
ORDER BY empno;


--emp 테이블의 모든 컬럼을 조회
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
   
   
   --emp 테이블의 empno 컬럼을 조회
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


--기존 엔덱스 제거 (pk_emp 제약조건 삭제 --> unique 제약 삭제 --> emp 인덱스 삭제

--INDEX 종류 (컬럼 중복 여부)
--UNIQUE INDEX : 인덱스 컬럼의 값이 중복될 수 없는 인덱스 (emp.empno, dpet.deptno)
--NON - UNIQUE INDEX(default) :인덱스 컬럼의 값이 중복 될 수 있는 인덱스
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

--emp 테이블에 job 컬럼으로 non -unique 인덱스 수행
--인덱스명 : idx_n_emp_02
CREATE INDEX idx_n_02 ON emp(job);

SELECT job,rowid
FROM emp
ORDER BY job;

--emp 테이블에는 인덱스가 2개 존재
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

--idx_02 인덱스
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM table(dbms_xplan.display);

--dix_n_emp_03
--emp 테이블의 job, ename 컬럼으로 non- unique 인덱스 생성

CREATE INDEX idx_n_emp03 ON emp ( job,ename);

SELECT job, ename , rowid
FROM emp
ORDER BY job, ename;

--idx_n_emp_04
--ename, job 컬럼으로 emp 테이블에 non- unique 인덱스 생성

CREATE INDEX idx_n_emp04 ON emp (ename,job);

SELECT ename, job , rowid
FROM emp
ORDER BY ename,job;


-- JOIN 쿼리에서의 인덱스
-- emp 테이블은 empno 컬럼으로 PRIMARY KEY 제약 조건이 존재
-- dept 테이블은 deptno 컬럼으로 PRIMARY KEY 제약 조건이 존재
-- emp 테이블은 PRIMARY KEY 제약을 삭제한 상태이므로 재생성
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
--순서  4 3 5 6 1 0
Predicate Information (identified by operation id):
---------------------------------------------------
 
   4 - access("EMP"."EMPNO"=7788)
   5 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")
   
DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept WHERE 1 =1;

--index 1
--deptno 컬럼으로 UINQUE INDEX
CREATE UNIQUE INDEX idx_dt_uni01 ON dept_test(deptno);    
--dname 컬럼으로 NON-UINQUE INDEX
CREATE INDEX idx_dt_nuni01 ON dept_test(dname);
--deptno , dname 컬럼으로 NON-UINQUE INDEX
CREATE INDEX idx_dt_nuni02 ON dept_test(deptno, dname);
   
--index2
--1의 내용을 삭제하는 ddl 작성
DROP INDEX idx_dt_uni01;
DROP INDEX idx_dt_nuni01;
DROP INDEX idx_dt_nuni02;

--과제1
--exerd를 참고하여 
--hr.exerd를 min 계정에 생성하는 쿼리를 작성
--KEY도 같이 작성

--과제2
--nest loop join
--hash join
--sort merge join 조사 pt나 word 등으로 작성.