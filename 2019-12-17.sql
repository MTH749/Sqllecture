--WITH
--WITH 블록 이름 AS(
    --서브쿼리
    --)
--SELECT *
--FROM 블록이름

--해당 부서의 급여 평균이 전체 직원의 급여 평균보다 높은 부서에 한해 조회
SELECT deptno,avg(sal) avg_sal
FROM emp
GROUP BY deptno
HAVING avg(sal) > (SELECT avg(sal) FROM emp);

--WITH 절을 사용하여 위의 쿼리를 작성
WITH dept_sal_avg AS (
     SELECT deptno,avg(sal) avg_sal
     FROM emp
     GROUP BY deptno),
     emp_sal_avg AS (
     SELECT avg(sal) avg_sal FROM emp)     
SELECT *
FROM dept_sal_avg
WHERE avg_sal > (SELECT avg_sal FROM emp_sal_avg);

WITH test AS(
        SELECT 1, 'TEST' FROM DUAL UNION ALL
        SELECT 2, 'TEST' FROM DUAL UNION ALL
        SELECT 3, 'TEST' FROM DUAL)
        SELECT *
        FROM test;

--계층쿼리
--달력만들기
--CONNECT BY LEVEL <=N
--테이블의 ROW 건수를 N만큼 반복한다
--CONNECT BY LEVEL 절을 사용한 쿼리에서는
--SELECT 절에서 LEVEL 이라는 특수 컬럼을 사용할 수 있다.
--계층을 표현하는 특수컬름으로 1부터 증가하며 ROWNUM과 유사하나
--추후 배우게될 START WHIT, CONNECT BY 절에서 다른 점을 배우게 된다.

--2019.11월 기준
-- 일자 + 정수 = 정수만큼의 미래의 일자
--2019.11 -- > 해당 년월의 날짜가 몇일까지 존재하는가??
-- 1-일 2- 월
SELECT TO_DATE(:yyymm, 'YYYYMM' ) + (LEVEL -1)
FROM DUAL
CONNECT BY LEVEL <=30;

-- 7개의 행에 대한 공통적인 행으로 GROUP BY 
SELECT /*일요일이면 날짜,/*활요일이면 날짜,..../*토요일이면 날짜*/
    iw,
    MAX(DECODE (d, 1,dt))sun, MAX(DECODE (d, 2,dt))mon,MAX(DECODE (d, 3,dt))tue,
    MAX(DECODE (d, 4,dt))wed,MAX(DECODE (d, 5,dt))thu,MAX(DECODE (d, 6,dt))fri,
    MAX(DECODE (d, 7,dt)) sat
FROM 
(SELECT TO_DATE(:yyyymm, 'YYYYMM' ) + (LEVEL -1) dt, --20191130
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM' ) + (LEVEL -1), 'D' )d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM' ) + (LEVEL -1 ), 'iw' )iw --20191230
FROM DUAL 
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM' )),'DD'))
GROUP BY iw
ORDER BY iw;

------------------
--DECODE를 이용해 행을 컬럼으로 
SELECT iw,
        MAX(DECODE (d, 1,dt))sun, MAX(DECODE (d, 2,dt))mon,MAX(DECODE (d, 3,dt))tue,
        MAX(DECODE (d, 4,dt))wed,MAX(DECODE (d, 5,dt))thu,MAX(DECODE (d, 6,dt))fri,
        MAX(DECODE (d, 7,dt))sat
FROM 
(SELECT TO_DATE(:yyyymm, 'YYYYMM' ) + (LEVEL -1) dt, --20191130
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM' ) + (LEVEL -1), 'D')d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM' ) + (LEVEL), 'iw')iw
FROM DUAL 
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM' )),'DD'))
GROUP BY iw
ORDER BY sat;

SELECT iw,
        MIN(DECODE (d, 1,dt))sun, MIN(DECODE (d, 2,dt))mon, MIN(DECODE (d, 3,dt))tue,
        MIN(DECODE (d, 4,dt))wed, MIN(DECODE (d, 5,dt))thu, MIN(DECODE (d, 6,dt))fri,
        MIN(DECODE (d, 7,dt))sat

FROM 
(SELECT TO_DATE(:yyyymm, 'YYYYMM' ) + (LEVEL -1) dt, --20191130
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM' ) + (LEVEL -1), 'D')d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM' ) + (LEVEL), 'iw') iw
        
FROM DUAL 
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM' )),'DD'))
GROUP BY iw
ORDER BY sat;

SELECT *
FROM SALES;

SELECT
        NVL(MIN(DECODE (mm, '01',SALES_SUM)),0) JAN,
        NVL(MIN(DECODE (mm, '02',SALES_SUM)),0) FEB,
        NVL(MIN(DECODE (mm, '03',SALES_SUM)),0) MAR,
        NVL(MIN(DECODE (mm, '04',SALES_SUM)),0) APR,
        NVL(MIN(DECODE (mm, '05',SALES_SUM)),0) MAY,
        NVL(MIN(DECODE (mm, '06',SALES_SUM)),0) JUN   
FROM        
(SELECT TO_CHAR(DT,'MM')mm ,SUM(SALES)SALES_SUM
FROM SALES
GROUP BY TO_CHAR(DT,'MM'));


SELECT dt,sum(sales)
FROM sales
GROUP BY dt;

SELECT TO_CHAR(dt,'mm')mm,sum(sales)
FROM sales
GROUP BY TO_CHAR(dt,'mm');

