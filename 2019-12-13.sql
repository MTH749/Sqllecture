SELECT *
FROM emp_test;



--MERGE
-- ���� empno�� ������ �����Ͱ� �����ϸ�
-- ename update : ename || '_merge'
-- ���� empno�� ������ �����Ͱ� �������� ���� ���
--emp ���̺��� empno, ename, emp_test �����ͷ� INSERT
--emp ���̺��� 14���� �����Ͱ� ����
--emp_test ���̺��� ����� 7788���� ���� 7���� �����Ͱ� ����
--emp ���̺��� �̿��Ͽ� emp_test ���̺��� �����ϰ� �Ǹ�
--emp ���̺��� �����ϴ� (����� 7788���� ũ�ų� ���� 7���� emp_test�� INSERT
--emp,emp_test�� �����ȣ�� �����ϰ� �����ϴ� 7���� �����ʹ�
--(����� 7788���� ���� ����) ename �÷����� ename || '_modify'�� ������Ʈ �Ѵ�

/*
MERGE INTO ���̺� ��
USING ������� ���̺� |VIEW|SUBQUERY
ON ���̺� ��� ��������� ���� ����
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

-- emp_test ���̺� ����� 9999�� �����Ͱ� �����ϸ�
-- ename �� ' brown' ���� update
--�������� ���� ��� empno, ename, VALUES (9999,'brown') ���� insert
-- ���� �ó������� MERGE ������ Ȱ���Ͽ� �ѹ��� sql�� ����

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

--���� MERGE ������ ���ٸ�
-- 1.empno�� 9999�� �����Ͱ� �����ϴ��� Ȯ��
-- 2-1. 1�� ���׿��� �����Ͱ� �����ϸ� UPDATE
-- 2-2 1�� ���׿��� �����Ͱ� �������� ������ INSERT

--GROUP AD0
--�μ��� ���� ��
SELECT deptno, sum (sal)
FROM emp
GROUP BY deptno

UNION ALL
SELECT null, SUM(sal)
FROM emp;

--���� ���
--emp ���̺��� 14�ǿ� �����͸� 28������ ����
-- ������ (1-14, 2-14) �������� GROUP BY
-- ������ 1: �μ���ȣ ��������
-- ������ 2 : ��ü 14row
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
--ROLLUP ���� ����� �ø��� �����ʿ��� ���� ���� �����
--SUB GROUP BY�� �����Ͽ� �������� GROUP BY ���� �ϳ��� SQL���� ���� �ǵ��� �Ѵ�
GROUP BY ROLLUP (job, deptno)
--GROUP BY job,deptno
--GROUP BY job
--GROUP BY --> ��ü ���� ������� GROUP BY

--emp ���̺��� �̿��Ͽ� �μ���ȣ��, ��ü ������ �޿� ���� ���ϴ� ������ 
--ROLLUP ����� �̿��Ͽ� �ۼ�

SELECT deptno,sum(sal) sal
FROM EMP
GROUP BY ROLLUP(deptno);

--emp ���̺��� �̿��Ͽ� job, deptno �� sal + comm �հ�
--                    job �� sal + comm �հ�
--                    ��ü������ sal + comm �հ�
--ROLLUP�� Ȱ���Ͽ� �ۼ�


--ROLLUP�� �÷� ������ ��ȸ����� ������ ��ģ��
SELECT job,deptno,SUM(sal + NVL(comm,0)) sal_sum
FROM emp
GROUP BY ROLLUP(job,deptno);
--GROUP BY job , deptno
--GROUP BY job 
--GROUP BY --> ��ü ROW ���

GROUP BY ROLLUP(deptno,job);
--GROUP BY deptno, job
--GROUP BY deptno 
--GROUP BY --> ��ü ROW ���

--GROUP AD1
SELECT NVL(job,'�Ѱ�') job,deptno, SUM(sal + NVL(comm,0)) sal_sum
FROM emp
GROUP BY ROLLUP(job,deptno);

SELECT DECODE(GROUPING(job),1,'�Ѱ�', job) job,deptno, SUM(sal + NVL(comm,0)) sal_sum
FROM emp
GROUP BY ROLLUP(job,deptno);

--GROUP AD2
SELECT DECODE(GROUPING(job),1,'�Ѱ�', job) job,DECODE(GROUPING(deptno),1,'�Ұ�',deptno)deptno, SUM(sal + NVL(comm,0)) sal_sum
FROM emp
GROUP BY ROLLUP(job,deptno);

--GROUP AD2_1
--case
SELECT DECODE(GROUPING(job),1,'�Ѱ�', job) job,
        CASE
            WHEN deptno IS NULL AND JOB IS NULL THEN '��'
            WHEN deptno IS NULL AND JOB IS NOT NULL THEN '�Ұ�'
            ELSE TO_CHAR(deptno)
        END deptno, 
            SUM(sal + NVL(comm,0)) sal_sum
FROM emp
GROUP BY ROLLUP(job,deptno);

--decode
SELECT DECODE(GROUPING(job),1,'�Ѱ�', job) job,DECODE(GROUPING(deptno),1,
       DECODE(GROUPING(job),1,'��','�Ұ�'), deptno) deptno, SUM(sal + NVL(comm,0)) sal_sum
FROM emp
GROUP BY ROLLUP(job,deptno);

--GROUP BY AD3
SELECT deptno,job,sum(sal + NVL(comm,0)) sal_sum
FROM emp
GROUP BY ROLLUP(deptno,job);

--UNION ALL�� ġȯ
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
SELECT DECODE(GROUPING(dname),1,'����',dname) dname,job, sum(sal + nvl(comm,0)) sal_sum
FROM emp , dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname,job);
