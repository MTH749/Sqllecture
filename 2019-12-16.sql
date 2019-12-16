--GROUPING SETS(col1,col2)

--������ ����� ����
--�����ڰ� GROUP BY ������ ���� ����Ѵ�
--ROLLUP�� �޸� ���⼺�� ���� �ʴ´�
--GROUPING SETS(co1,co2) = GROUPING SETS(col1,col2

--GROUP BY col1
--UNION ALL
--GROUP BY col2

--emp ���̺��� ������ job�� �޿�(sal) + �� (comm)��,
--                    deptno(�μ�)�� �޿�(sal)+ ��(comm) �� ���ϱ�

--�������(GROUP FUCTION) : 2���� SQL �ۼ� �ʿ�*UNION /UNION ALL)

SELECT job,null, sum(sal + NVL(comm,0)) sal_comm_sum
FROM emp
GROUP BY job

UNION ALL

SELECT '', deptno, sum(sal + NVL(comm,0)) sal_comm_sum
FROM emp
GROUP BY deptno;

--GROUPING SETS ������ �̿��Ͽ� ���� SQL�� ���տ����� ������� �ʰ�
--���̺��� �ѹ� �о ó��
SELECT job,deptno,sum(sal + NVL(comm,0)) sal_comm_sum
FROM emp
GROUP BY GROUPING SETS (job,deptno);

-- job, deptno�� �׷����� �� sal + comm��
--mgr�� �׷����� �� sal _+ comm ��
--GROUP BY job, deptno
--UNION ALL
--GROUP BY mgr
-- -->> GROUPING SETS ((job,deptno),mgr)

SELECT job,deptno,mgr, sum (sal +NVL(comm,0)) sal_comm_sum
FROM emp
GROUP BY GROUPING SETS((job,deptno),mgr);

--CUBE (col1, col2....)
--������ �÷��� ��� ������ �������� GROUP BY subset�� �����
--CUBE�� ������ �÷��� 2���� ��� : ������ ���� 4��
--CUBE�� ������ �÷��� 3���� ��� : ������ ���� 8��
--CUBE�� ������ �÷����� 2�� ���������� �� ����� ������ ���� ������ �ȴ� (2^n)
--�÷��� ���ݸ� �������� ������ ������ ���ϱ޼������� �þ�� ������
--���� ��������� �ʴ´�.

--job,deptno�� �̿��Ͽ� CUBE ����
SELECT job,deptno,sum(sal +NVL(comm,0)) sal_comm_sum
FROM emp
GROUP BY CUBE(job,deptno);

--job, deptno
--1,    1  --> GROUP BY job,deptno
--1,    0  --> GROUP BY job
--0,    1  --> GROUP BY job deptno
--0,    0  --> GROUP BY --emp ���̺��� ����࿡ ���� GROUP BY

--GROUP BY ����
--GROUP BY, ROLLUP, CUBE�� ���� ����ϱ�
--������ ������ �����غ��� ���� ����� ���� �� �� �ִ�.
--GROUP BY job,ROOLLUP (deptno),CUBE(mgr)

SELECT job,deptno,sum(sal +NVL(comm,0)) sal_comm_sum
FROM emp
GROUP BY job, ROLLUP(deptno),CUBE(mgr);

SELECT job,job,sum(sal)
FROM emp
GROUP BY job,job;


--sub_a1
CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD (empcnt number);

SELECT *
FROM dept_test;

SELECT *
FROM emp;

UPDATE dept_test
SET empcnt = (SELECT count(*)
              FROM emp
              WHERE emp.deptno = dept_test.deptno);


--sub_a2              
CREATE TABLE dept_test AS
SELECT *
FROM dept;

INSERT INTO dept_test VALUES(99,'it1','dajeon');
INSERT INTO dept_test VALUES(98,'it2','dajeon');

DELETE dept_test
WHERE deptno NOT IN (SELECT DEPTNO 
                     FROM emp
                     );


--sub.ad3
SELECT *
FROM emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;

UPDATE emp_test
SET sal =  sal + 200
WHERE sal < (SELECT avg(sal)
             FROM emp
             WHERE deptno =emp_test.deptno);
-- MERGE ������ �̿��� ������Ʈ

MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
       FROM emp_test
       GROUP bY deptno) b
ON  (a.deptno =b.deptno)
    
WHEN MATCHED THEN
    UPDATE SET sal = sal + 200
    WHERE  a.sal < avg_sal;
    
MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
       FROM emp_test
       GROUP bY deptno) b
ON  (a.deptno =b.deptno)  
WHEN MATCHED THEN
    UPDATE SET sal = CASE
                        WHEN a.sal <b.avg_sal THEN sal +200
                        ELSE sal
                        END;
    
       