--날짜관련 함수
--round, trunc
--(MONTHS_BETWEEN) ADD MONTHS, NEXT_DAY
--LAST_DAY : 해당날짜가 속한 월의 마지막 일자(DATE)

--월 :  1, 3, 5, 6, 7, 8, 9, 11 : 31일
--   : 2 - 융년 여부에 28,29일
--   : 4, 6, 7, 11 : 30일
SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM dual;


--fn3
--해당 날짜의 마지막날짜로 이동
--일자필드만 추출
--DATE --> 문자열 TO_CHAR( LAST_DAT(TO_DATE ('201912','YYYYMM')))

SELECT  YYYYYMM param,
        TO_CHAR( LAST_DAT(TO_DATE (:YYYYMM,'YYYYMM')), 'DD') dt  
FROM dual;

--SYSDATE를 YYYY/MM/DD 포맷의 문자열로 변경 (DATE -> CHAR)

SELECT  TO_CHAR(SYSDATE ,'YYYY-MM-DD') TODAY

FROM  dual;

--'2019/11/26' 문자열 - DATE
-- 문자열 : TO_CHAR(SYSDATE, 'YYYY/MM/DD')
SELECT TO_CHAR(SYSDATE ,'YYYY-MM-DD') TODAY,
       TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'YYYY/MM/DD')
FROM dual;

--YYYY-MM-DD HH24:MI:SS 문자열로 변경
SELECT TO_CHAR(SYSDATE ,'YYYY-MM-DD') TODAY,
       TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'YYYY/MM/DD') SECOND,
       TO_CHAR(TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'YYYY/MM/DD') , 'YYYY-MM-DD HH24:MI:SS') YMD
FROM dual;


--EMPNO    NOT NULL NUMBER(4)    
--ENAME             VARCHAR2(10) 
--JOB               VARCHAR2(9)  
--MGR               NUMBER(4)    
--HIREDATE          DATE         
--SAL               NUMBER(7,2)  
--COMM              NUMBER(7,2)  
--DEPTNO            NUMBER(2)    

desc emp;

--empno가 7369인 직원 정보 조회하기
--실행 단계 보는법
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

-- 실행계획 보는법
SELECT *
FROM TABLE(dbms_xplan.display);

--Plan hash value: 3956160932
-- 
----------------------------------------------------------------------------
--| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
--|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
--|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
----------------------------------------------------------------------------
-- 
--Predicate Information (identified by operation id):
-----------------------------------------------------
-- 
--   1 - filter("EMPNO"=7369)

--자식로드가 있으면 자식부터 읽는다


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR( empno) = 7300 +  69;

SELECT *
FROM TABLE(dbms_xplan.display);


SELECT 7300 + 69
FROM dual;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7300 + 69;-- 69 > 숫자로 변경

SELECT *
FROM TABLE(dbms_xplan.display);

--

SELECT *
FROM emp
WHERE hiredate > = TO_DATE('1981/06/01', 'YYYY/MM/DD');
--DATE타입의 묵시적 형변환은 사용을 권하지 않음
--YY ->19
--RR -->50 / 19,20
SELECT *
FROM emp
WHERE hiredate > = TO_DATE('1981/06/01','YYYY/MM/DD'); 
--WHERE hiredate >= 81/06/01;

SELECT TO_DATE('50/05/05','RR/MM/DD') aa,
       TO_DATE('49/05/05','RR/MM/DD') bb,
       TO_DATE('50/05/05','YY/MM/DD') cc,
       TO_DATE('49/05/05','YY/MM/DD') dd
 
FROM dual;

--숫자 --> 문자열
-- 문자열 --> 숫자
--숫자 : 1000000 --> 1,000,000.00(한국 기준)
--숫자 : 1000000 --> 1.000.000,00(독일 기준)
-- 날짜 포맷 : YYYY DD NN HH24 MI SS
-- 숫자 포맷 : 숫자표현 : 9, 자리맞춤을 위한 0표시 : 0 , 화폐 단위 : L
--                     1000 자리 구분 : ,
--                        소수점 : .
--숫자 -> 문자열 TO_CHAR(숫자,'포맷')
--숫자 포맷이 길어질경우 숫자 자리수를 충분히 표현
SELECT empno, ename, sal, TO_CHAR(sal, 'L09,999') fm_sal 
FROM emp;

SELECT TO_CHAR( 100000000000, '999,999,999,999,999') num
FROM dual;

--NULL 처리 함수 : NVL, NVL2, NULLIF, COALESCE

--NVL(expr1, expr2) :함수 인자 2개
--expr1이 NULL이면 expr2를 반환
--expr1이 NULL이 아니면 expr1을 반환

SELECT empno, ename, comm, NVL(comm, -1) NVL_comm
FROM emp;
--NVL2(expr1, expr2,expr3)
--expr1 IS NOT NULL expr2 리턴
--expr1 IS NULL expr3 리턴

SELECT empno, ename, comm, NVL2(comm,  1000,-500) NVL_comm,
       NVL2(comm, comm,-500) SAME_NVL_comm -- NVL과 동일한 결과
FROM emp;

--NULLIF (expr1, expr2)
--expr1 = exp2 NULL을 리턴
--expr1 != expr2 exrp1을 리턴
--comm이 NULL일떄 comm +500 : NULL
--  NULLIF(NULL,NULL)  : NULL
--comm이 NULL이 아닐때 comm +500 : comm 500
--  NULL(comm,comm +500) : comm
SELECT empno, ename, comm, NULLIF(comm, comm + 500) NULLIF_comm
FROM emp;

--COALESCE (expr1, expr2, expr3......)
--인자중에 첫번쨰로 등장하는 NULL이 아닌 exprN을 리턴
--expr1 IS NOT NULL : expr1을 리턴
--expr1 IS NULL COADLESCE(expr2,expr3.....)

SELECT empno, ename, comm, sal, COALESCE(comm, sal) coal_sal
FROM emp;

--null fn4
SELECT empno, ename, mgr, NVL(mgr, 9999) mgr_N,
       NVL2(mgr, mgr, 9999) MGR_N_1,
       COALESCE(mgr, 9999)MGR_N_2
FROM emp;

--null fn5

SELECT userid, usernm, reg_dt, NVL(reg_dt, sysdate) N_REG_DT
FROM users
WHERE userid NOT IN LIKE ('brown');

--condition
--case
--emp. job 컬럼을 기준으로
-- 'SALESMAN' 이면 sal * 1.05를 적용한 값 리턴
--'MANAGER' 이면 sal * 1.10을 적용한 값 리턴
--'PRESIDENT' 이면 sal * 1.20을 적용한 값 리턴
--empno, ename, sal, 요율 적용한 급여 AS bonus
--위 3가지 직군이 아닐경우 
SELECT empno, ename, job, sal,
       CASE
            WHEN job = 'SALESMAN' THEN sal *1.05
            WHEN job = 'MANAGER' THEN sal *1.05
            WHEN job = 'PRESIDENT' THEN sal *1.05
            ELSE sal
       END bonus,
       comm,
        --NULL 처리 함수 사용하지 않고 CASE 절을 이용하여
        --comm이 NULL일 경우 -10을 리턴하도록 구성
        CASE
            WHEN comm IS NULL THEN -10
            ELSE comm
            END case_null
FROM emp;       

--DECODE
SELECT empno, ename, job, sal,
        DECODE( job, 'SALESMAN',  sal *1.05,
                     'MANAGER',   sal *1.10,
                     'PRESIDENT', sal * 1.20) bonus
 FROM emp;
 
 
 