--별칭 : 테이블 컬럼을 다른 이름으로 지칭
-- [AS] 별칭 명
--SELECT empno [AS] eno
--FROM emp e

--SYNONYM (동의어)
--오라클 객체를 다른 이름으로 부를 수 있도록 하는것
--만약에 emp테이블을 e라고 하는 synonym(동의어)로 생성을 하면
--다음과 같이 SQL을 작성 할 수 있다
--SELECT *
--FROM e;

SELECT *
FROM hr.employees;

--synonym 생성
--CREATE [public] SYNONYM synonym_name for object;

--계정에 SYNONYM 생성 권한을 부여
GRANT CREATE SYNONYM TO mth;  

--emp 테이블을 사용하여 synonym e로 생성
CREATE SYNONYM e for emp;

--emp라는 테이블 명 대신에 e 락고 하는 시노님을 사용하여 쿼리를 작성 할 수 있따.

SELECT *
FROM emp;

SELECT *
FROM e;

--mth 계정의 fastfood 테이블을 hr 계정에서도 볼 수 있도록 테이블 조회 권한을 부여
GRANT SELECT ON fastfood TO hr;

--용어 정리
--DML 
--    SELECT / INSERT / UPDATE / DELETE / INSERT ALL / MERGE
--TCL 
--    COMMIT / ROLLBACK / {SAVEPOINT}
--
--DDL
--    CREATE 객체
--    ALTER
--    DROP
--    
--DCL
--    GRANT / REVOKE

--동일한 SQL 개념에 따르면....

SELECT /* 201911_205  */ * FROM emp;
SELECT /* 201911_205  */ * FROM EMP;
SELEct /* 201911_205  */ * FROM EMP;

SELEct /* 201911_205  */ * FROM EMP WHERE  empno =7369;
SELEct /* 201911_205  */ * FROM EMP WHERE  empno =7499;
SELEct /* 201911_205  */ * FROM EMP WHERE  empno = :empno;

--mulitple insert

--emp 테이블의 empno,ename 컬럼으로 emp_test, emp_test2 테이블을 생성
--(CATS, 데이터도 같이 복사

CREATE TABLE emp_test AS
SELECT empno, ename
FROM emp;

CREATE TABLE emp_test2 AS
SELECT empno, ename
FROM emp;

SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;

--ubconditional insert
--여러 테이블에 데이터를 동시 입력
--brown, cony 데이터를 emp_test, emp_test2 테이블에 동시에 입력
INSERT ALL 
    INTO emp_test
    INTO emp_test2
SELECT 9999,'brown' FROM DUAL UNION ALL    
SELECT 9998,'cony' FROM DUAL;

SELECT *
FROM emp_test
WHERE empno > 9000

UNION ALL

SELECT *
FROM emp_test2
WHERE empno > 9000;    

--테이블별 입력되는 데이터의 컬럼을 제어 가능

INSERT ALL 
    INTO emp_test (empno, ename) VALUES (eno, enm)
    INTO emp_test2 (empno) VALUES (eno)
SELECT 9999 eno,'brown' enm FROM DUAL UNION ALL    
SELECT 9998,'cony' FROM DUAL;    
    
--CONDITIONAL INSERT
--조건에 따라 테이블에 데이터를 입력
/*
    CASE
         WHER 조건 THEN --- //자바의 경우 IF
         WHER 조건 THEN ---              ELSE IF 
         ELSE --                         ELSE
*/

INSERT ALL
    WHEN eno > 9000 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)
    WHEN eno > 9500 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)    
    ELSE    
        INTO emp_test2 (empno) VALUES (eno)
SELECT 9999 eno,'brown' enm FROM DUAL UNION ALL    
SELECT 8998,'cony' FROM DUAL;   

rollback;

SELECT *
FROM emp_test
WHERE empno > 9000

UNION ALL

SELECT *
FROM emp_test2
WHERE empno > 8000;



INSERT FIRST
    WHEN eno > 9000 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)
    WHEN eno > 9500 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)    
    ELSE    
        INTO emp_test2 (empno) VALUES (eno)
SELECT 9999 eno,'brown' enm FROM DUAL UNION ALL    
SELECT 8998,'cony' FROM DUAL;   

rollback;