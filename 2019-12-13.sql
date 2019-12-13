SELECT *
FROM emp_test;



--MERGE
-- 만약 empno가 동일한 데이터가 존재하면
-- ename update : ename || '_merge'
-- 만약 empno가 동일한 데이터가 존재하지 않을 경우
--emp 테이블의 empno, ename, emp_test 데이터로 INSERT
--emp 테이블에는 14건의 데이터가 존재
--emp_test 테이블에는 사번이 7788보다 작은 7명의 데이터가 존재
--emp 테이블을 이용하여 emp_test 테이블을 머지하게 되면
--emp 테이블에만 존재하는 (사번이 7788보다 크거나 같은 7명이 emp_test로 INSERT
--emp,emp_test에 사원번호가 동일하게 존재하는 7명의 데이터는
--(사번이 7788보다 작은 직원) ename 컬럼으로 ename || '_modify'로 업데이트 한다

/*
MERGE INTO 테이블 명
USING 머지대상 테이블 |VIEW|SUBQUERY
ON 테이블 명과 머지대상의 연결 관계
WHEN MATCHED THEN 
        UPDATE
WHEN NOT MATCHED THEN
        INSERT
*/    
MERGE INTO emp_test a
USING emp b
ON (a.empno = b.empno)
WHEN MATCHED THEN
        UPDATE SET ename = ename || '_mod'
WHEN NOT MATCHED THEN
        INSERT VALUES (b.empno, b.ename);

-- emp_test 테이블에 사번이 9999인 데이터가 존재하면
-- ename 을 ' brown' 으로 update
--존재하지 않을 경우 empno, ename, VALUES (9999,'brown') 으로 insert
-- 위의 시나리오를 MERGE 구문을 활용하여 한번의 sql로 구현

MERGE INTO emp_test a
USING dual
ON (a.empno = :empno)
WHEN MATCHED THEN
    UPDATE SET ename = :ename || '_mod'
WHEN NOT MATCHED THEN
    INSERT VALUES (:empno, :ename);

SELECT *
FROM emp_test
WHERE empno = 9999;

--만약 MERGE 구문이 없다면
-- 1.empno가 9999인 데이터가 존재하는지 확인
-- 2-1. 1번 사항에서 데이터가 존재하면 UPDATE
-- 2-2 1번 사항에서 데이터가 존재하지 않으면 INSERT

--GROUP AD0
--부서별 급혀 합
SELECT deptno, sum (sal)
FROM emp
GROUP BY deptno

UNION ALL
SELECT null, SUM(sal)
FROM emp;

--조인 방식
--emp 테이블의 14건에 데이터를 28건으로 생성
-- 구분자 (1-14, 2-14) 기준으로 GROUP BY
-- 구분자 1: 부서번호 기준으로
-- 구분자 2 : 전체 14row
SELECT DECODE (b.rn, 1, emp.deptno,2,null) deptno,
           sum( emp.sal)
FROM emp,  (SELECT ROWNUM rn          
            FROM dept            
            WHERE ROWNUM <=2)b 
GROUP BY DECODE (b.rn, 1, emp.deptno,2,null)
ORDER BY DECODE (b.rn, 1, emp.deptno,2,null);

--REPORT GROUP BY
--ROLLUP
--GROUP BY ROLLUP (col1....)
--ROLLUP 절에 기술된 컬름을 오른쪽에서 부터 지원 결과로
--SUB GROUP BY을 생성하여 여러개의 GROUP BY 절을 하나의 SQL예써 실행 되도록 한다
GROUP BY ROLLUP (job, deptno)
--GROUP BY job,deptno
--GROUP BY job
--GROUP BY --> 전체 행을 대상으로 GROUP BY

--emp 테이블을 이용하여 부서번호별, 전체 직원별 급여 합을 구하는 쿼리를 
--ROLLUP 기능을 이용하여 작성

SELECT deptno,sum(sal) sal
FROM EMP
GROUP BY ROLLUP(deptno);

--emp 테이블을 이용하여 job, deptno 별 sal + comm 합계
--                    job 별 sal + comm 합계
--                    전체직원의 sal + comm 합계
--ROLLUP을 활용하여 작성


--ROLLUP은 컬럼 순서가 조회결과에 영향을 미친다
SELECT job,deptno,SUM(sal + NVL(comm,0)) sal_sum
FROM emp
GROUP BY ROLLUP(job,deptno);
--GROUP BY job , deptno
--GROUP BY job 
--GROUP BY --> 전체 ROW 대상

GROUP BY ROLLUP(deptno,job);
--GROUP BY deptno, job
--GROUP BY deptno 
--GROUP BY --> 전체 ROW 대상

--GROUP AD1
SELECT NVL(job,'총계') job,deptno, SUM(sal + NVL(comm,0)) sal_sum
FROM emp
GROUP BY ROLLUP(job,deptno);

SELECT DECODE(GROUPING(job),1,'총계', job) job,deptno, SUM(sal + NVL(comm,0)) sal_sum
FROM emp
GROUP BY ROLLUP(job,deptno);

--GROUP AD2
SELECT DECODE(GROUPING(job),1,'총계', job) job,DECODE(GROUPING(deptno),1,'소계',deptno)deptno, SUM(sal + NVL(comm,0)) sal_sum
FROM emp
GROUP BY ROLLUP(job,deptno);

--GROUP AD2_1
--case
SELECT DECODE(GROUPING(job),1,'총계', job) job,
        CASE
            WHEN deptno IS NULL AND JOB IS NULL THEN '계'
            WHEN deptno IS NULL AND JOB IS NOT NULL THEN '소계'
            ELSE TO_CHAR(deptno)
        END deptno, 
            SUM(sal + NVL(comm,0)) sal_sum
FROM emp
GROUP BY ROLLUP(job,deptno);

--decode
SELECT DECODE(GROUPING(job),1,'총계', job) job,DECODE(GROUPING(deptno),1,
       DECODE(GROUPING(job),1,'계','소계'), deptno) deptno, SUM(sal + NVL(comm,0)) sal_sum
FROM emp
GROUP BY ROLLUP(job,deptno);

--GROUP BY AD3
SELECT deptno,job,sum(sal + NVL(comm,0)) sal_sum
FROM emp
GROUP BY ROLLUP(deptno,job);

--UNION ALL로 치환
SELECT deptno, job, sum(sal + nvl(comm,0)) sal_sum
FROM emp
GROUP BY deptno,job

UNION ALL

SELECT deptno,null, sum(sal + nvl(comm,0)) sal_sum
FROM emp
GROUP BY deptno

UNION ALL

SELECT null, null ,sum(sal + nvl(comm,0)) sal_sum
FROM emp;

--GROUP BY AD4
SELECT dname,job, sum(sal + nvl(comm,0)) sal_sum
FROM emp , dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname,job);

--INLINE
SELECT DEPT.DNAME,a.job,a.sal_sum
FROM    
     (SELECT deptno,job,sum(sal + nvl(comm,0)) sal_sum
      FROM emp
      GROUP BY ROLLUP(deptno,job)) a,dept
 WHERE dept.deptno (+) = a.deptno;    

--GROUP BY AD5
SELECT DECODE(GROUPING(dname),1,'총합',dname) dname,job, sum(sal + nvl(comm,0)) sal_sum
FROM emp , dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname,job);
