--WITH
--WITH ��� �̸� AS(
    --��������
    --)
--SELECT *
--FROM ����̸�

--�ش� �μ��� �޿� ����� ��ü ������ �޿� ��պ��� ���� �μ��� ���� ��ȸ
SELECT deptno,avg(sal) avg_sal
FROM emp
GROUP BY deptno
HAVING avg(sal) > (SELECT avg(sal) FROM emp);

--WITH ���� ����Ͽ� ���� ������ �ۼ�
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

--��������
--�޷¸����
--CONNECT BY LEVEL <=N
--���̺��� ROW �Ǽ��� N��ŭ �ݺ��Ѵ�
--CONNECT BY LEVEL ���� ����� ����������
--SELECT ������ LEVEL �̶�� Ư�� �÷��� ����� �� �ִ�.
--������ ǥ���ϴ� Ư���ø����� 1���� �����ϸ� ROWNUM�� �����ϳ�
--���� ���Ե� START WHIT, CONNECT BY ������ �ٸ� ���� ���� �ȴ�.

--2019.11�� ����
-- ���� + ���� = ������ŭ�� �̷��� ����
--2019.11 -- > �ش� ����� ��¥�� ���ϱ��� �����ϴ°�??
-- 1-�� 2- ��
SELECT TO_DATE(:yyymm, 'YYYYMM' ) + (LEVEL -1)
FROM DUAL
CONNECT BY LEVEL <=30;

-- 7���� �࿡ ���� �������� ������ GROUP BY 
SELECT /*�Ͽ����̸� ��¥,/*Ȱ�����̸� ��¥,..../*������̸� ��¥*/
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
--DECODE�� �̿��� ���� �÷����� 
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

