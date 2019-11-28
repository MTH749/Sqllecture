--GROUP FUNCTION
--특정 컬림이나, 표현을 기준으로 여러행의 값을 한행의 결과로 생성
--COUNT-건수, SUM- 합계, AVG -평균, MAX-최대값, MIN -최소값
--전체 직원을 대상으로 (14건의 ->1건)

DESC emp;
SELECT  MAX(sal) max_sal, -- 가장 높은 급여
        MIN(sal) min_sal,-- 가장 낮은 급여
        ROUND(AVG(sal), 2) avg_sal, -- 급여 평균
        SUM(sal) sum_sal, --전 직원의 급여 합계
        COUNT(sal) count_sal, -- 급여 건수null이 아닌 값이면 1건
        COUNT(mgr) count_mgr, -- 직원 관리자 건수(KING의 경우 MRG이 없다)
        COUNT(*) count_row-- 특정 컬럼의 건수가 아니라 행의개수를 알고 싶을떄 (NULL 포함)
FROM emp;

--부서별 그룹함수 적용
SELECT  deptno,
        MAX(sal) max_sal, -- 부서에서 가장 높은급여
        MIN(sal) min_sal,-- 부서에서 가장 낮은 급여
        ROUND(AVG(sal), 2) avg_sal, -- 부서 급여 평균
        SUM(sal) sum_sal, --부서 직원의 급여 합계
        COUNT(sal) count_sal, -- 부서dml 급여 건수null이 아닌 값이면 1건
        COUNT(mgr) count_mgr, -- 부서 직원 관리자 건수(KING의 경우 MRG이 없다)
        COUNT(*) count_row-- 부서의 조직원 수
FROM emp
GROUP BY deptno;

--부서별 + 이름별
SELECT  deptno, ename,
        MAX(sal) max_sal, -- 부서에서 가장 높은급여
        MIN(sal) min_sal,-- 부서에서 가장 낮은 급여
        ROUND(AVG(sal), 2) avg_sal, -- 부서 급여 평균
        SUM(sal) sum_sal, --부서 직원의 급여 합계
        COUNT(sal) count_sal, -- 부서dml 급여 건수null이 아닌 값이면 1건
        COUNT(mgr) count_mgr, -- 부서 직원 관리자 건수(KING의 경우 MRG이 없다)
        COUNT(*) count_row-- 부서의 조직원 수
FROM emp
GROUP BY deptno, ename;

--SELECT 절에는 GROUP BY 절에 표현된 컬럼 이외의 컬럼이 올 수 없다
--논리적으로 성립이 되지 않음(여려명의 직원 정보로 한건의 데이터로 그루핑)
--단 예외적으로 상수값ㄷ르은 SELECT 절에 표현이 가능

SELECT  deptno, 1,'문자열',sysdate,
        MAX(sal) max_sal, -- 부서에서 가장 높은급여
        MIN(sal) min_sal,-- 부서에서 가장 낮은 급여
        ROUND(AVG(sal), 2) avg_sal, -- 부서 급여 평균
        SUM(sal) sum_sal, --부서 직원의 급여 합계
        COUNT(sal) count_sal, -- 부서dml 급여 건수null이 아닌 값이면 1건
        COUNT(mgr) count_mgr, -- 부서 직원 관리자 건수(KING의 경우 MRG이 없다)
        COUNT(*) count_row-- 부서의 조직원 수
FROM emp
GROUP BY deptno;

--그룹함수에서는 NULL 컬럼은 계산에서 제외된다
--emp테이블에서 comm 컬럼이 null이 아닌 데이터는 4건이 존재, 9건은 null
SELECT COUNT (comm)count_comm, --NULL이 아닌값의 개수
        sum(comm) sum_comm, --NULL값을 제외, 300+ 500+ 1400 + 0 = 2200
        SUM(sal) sum_sal, -- 급여 합
        SUM(sal + comm) tot_sal_sum, -- 급여에서 coomm의 NULL에 포함된 행이 제외됨 
        SUM(sal + NVL (comm, 0)) tot_sal_sum -- 급여에서 commm의 NULL의 행도 포함된 합
FROM emp;

--WHERE 절에는 GROUP 함수를 표현할 수 없다
----부서별 최대 급여 구하기
--1.부서별 최대급여 구하기
--2.부서별 최대급여 값이 3000이 넘는 행만 구하기

--deptno, 최대급여
SELECT deptno, MAX(sal) m_sal
FROM emp
WHERE MAX(sal) > 3000 -- ORA-00934 오류 WHERE 절에는 GROUP 함수가 올 수 없다
GROUP BY deptno;

--HAVING 사용
SELECT deptno, MAX(sal) m_sal
FROM emp
GROUP BY deptno
HAVING MAX(sal) >= 3000;

--grp1

SELECT MAX(sal) max_sal,
        MIN(sal) min_sal,
        TRUNC( AVG (sal)*100, 2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mrg,
        COUNT(empno) count_all
 FROM emp;       

--grp2

SELECT DEPTNO, MAX(sal) max_sal,
        MIN(sal) min_sal,
        TRUNC(AVG (sal)*100,2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mrg,
        COUNT(empno) count_all
 FROM emp
 GROUP BY DEPTNO;

--grp3

SELECT DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH',30, 'SALES') DNAME,
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        TRUNC(AVG (sal)*100,2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mrg,
        COUNT(empno) count_all

 FROM emp
 GROUP BY DEPTNO
 ORDER BY DEPTNO;
 
 --grp4
 
 SELECT TO_CHAR(hiredate,'YYYYMM') hire_YYYMM, -- 1980/12/17 --> 198012
        COUNT (*) CNT 
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYYMM');
-- inLine 사용
 SELECT hire_yyyymm, COUNT (*) CNT
 FROM
     (SELECT TO_CHAR(hiredate,'YYYYMM') hire_yyyymm -- 1980/12/17 --> 198012        
     FROM emp)
GROUP BY hire_yyyymm;

--grp5
-- inLine 사용
SELECT hire_yyyy, COUNT (*) CNT
FROM
     (SELECT TO_CHAR(hiredate,'YYYY') hire_yyyy -- 1980년대로        
     FROM emp)
GROUP BY hire_yyyy;
--
 SELECT TO_CHAR(hiredate,'YYYY') hire_YYYY, --1980년대로
        COUNT (*) CNT 
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY');

--grp6
--전체 직원수 구하기(emp)

SELECT count(*), COUNT(empno), COUNT(mgr) 
FROM emp;

-- 전체 부서수 구하기(dept
SELECT count(*), COUNT(deptno), COUNT(loc) 
FROM dept;

--직원이 속한 부서의 개수
SELECT COUNT(COUNT (*)) CNT
FROM emp
GROUP BY deptno;

--inLine 활용
SELECT COUNT (*) CNT
FROM
(SELECT COUNT(deptno)
FROM emp
GROUP BY deptno);

--distinct 활용
SELECT COUNT (DISTINCT deptno) CNT
FROM emp;

--JOIN
--1.테이블의 구조변경( 컬럼 추가)
--2.추가된 컬럼에 값을 UPDATE
--ename 컬럼을 emp 테이블에 추가
DESC emp;
DESC dept;
-- 컬럼추가( dname, VARCHA2(14)
ALTER TABLE emp ADD (dname VARCHAR2(14));

SELECT *
FROM emp;

UPDATE emp SET dname = CASE
                            WHEN deptno = 10 THEN 'ACCOUNTING'--특정 행 업데이트는 WHERE 활용
                            WHEN deptno = 20 THEN 'RESEARCH'
                            WHEN deptno = 30 THEN 'SALES'
                            END;
 
 COMMIT;
 
 
 SELECT empno, ename, deptno, dname
 FROM emp;
 
 -- SALES -- > MARKET SALES
 -- 총 6건의 데이터 변경이 필요하다
 --값의 중복이 있는 형태(반 정규형)
-- UPDATE emp set dname = 'MARKET SALES'
-- WHERE dname = 'SALES';


