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

