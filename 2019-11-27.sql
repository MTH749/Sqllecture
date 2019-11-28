--GROUP FUNCTION
--Ư�� �ø��̳�, ǥ���� �������� �������� ���� ������ ����� ����
--COUNT-�Ǽ�, SUM- �հ�, AVG -���, MAX-�ִ밪, MIN -�ּҰ�
--��ü ������ ������� (14���� ->1��)

DESC emp;
SELECT  MAX(sal) max_sal, -- ���� ���� �޿�
        MIN(sal) min_sal,-- ���� ���� �޿�
        ROUND(AVG(sal), 2) avg_sal, -- �޿� ���
        SUM(sal) sum_sal, --�� ������ �޿� �հ�
        COUNT(sal) count_sal, -- �޿� �Ǽ�null�� �ƴ� ���̸� 1��
        COUNT(mgr) count_mgr, -- ���� ������ �Ǽ�(KING�� ��� MRG�� ����)
        COUNT(*) count_row-- Ư�� �÷��� �Ǽ��� �ƴ϶� ���ǰ����� �˰� ������ (NULL ����)
FROM emp;

--�μ��� �׷��Լ� ����
SELECT  deptno,
        MAX(sal) max_sal, -- �μ����� ���� �����޿�
        MIN(sal) min_sal,-- �μ����� ���� ���� �޿�
        ROUND(AVG(sal), 2) avg_sal, -- �μ� �޿� ���
        SUM(sal) sum_sal, --�μ� ������ �޿� �հ�
        COUNT(sal) count_sal, -- �μ�dml �޿� �Ǽ�null�� �ƴ� ���̸� 1��
        COUNT(mgr) count_mgr, -- �μ� ���� ������ �Ǽ�(KING�� ��� MRG�� ����)
        COUNT(*) count_row-- �μ��� ������ ��
FROM emp
GROUP BY deptno;

--�μ��� + �̸���
SELECT  deptno, ename,
        MAX(sal) max_sal, -- �μ����� ���� �����޿�
        MIN(sal) min_sal,-- �μ����� ���� ���� �޿�
        ROUND(AVG(sal), 2) avg_sal, -- �μ� �޿� ���
        SUM(sal) sum_sal, --�μ� ������ �޿� �հ�
        COUNT(sal) count_sal, -- �μ�dml �޿� �Ǽ�null�� �ƴ� ���̸� 1��
        COUNT(mgr) count_mgr, -- �μ� ���� ������ �Ǽ�(KING�� ��� MRG�� ����)
        COUNT(*) count_row-- �μ��� ������ ��
FROM emp
GROUP BY deptno, ename;

--SELECT ������ GROUP BY ���� ǥ���� �÷� �̿��� �÷��� �� �� ����
--�������� ������ ���� ����(�������� ���� ������ �Ѱ��� �����ͷ� �׷���)
--�� ���������� ����������� SELECT ���� ǥ���� ����

SELECT  deptno, 1,'���ڿ�',sysdate,
        MAX(sal) max_sal, -- �μ����� ���� �����޿�
        MIN(sal) min_sal,-- �μ����� ���� ���� �޿�
        ROUND(AVG(sal), 2) avg_sal, -- �μ� �޿� ���
        SUM(sal) sum_sal, --�μ� ������ �޿� �հ�
        COUNT(sal) count_sal, -- �μ�dml �޿� �Ǽ�null�� �ƴ� ���̸� 1��
        COUNT(mgr) count_mgr, -- �μ� ���� ������ �Ǽ�(KING�� ��� MRG�� ����)
        COUNT(*) count_row-- �μ��� ������ ��
FROM emp
GROUP BY deptno;

--�׷��Լ������� NULL �÷��� ��꿡�� ���ܵȴ�
--emp���̺��� comm �÷��� null�� �ƴ� �����ʹ� 4���� ����, 9���� null
SELECT COUNT (comm)count_comm, --NULL�� �ƴѰ��� ����
        sum(comm) sum_comm, --NULL���� ����, 300+ 500+ 1400 + 0 = 2200
        SUM(sal) sum_sal, -- �޿� ��
        SUM(sal + comm) tot_sal_sum, -- �޿����� coomm�� NULL�� ���Ե� ���� ���ܵ� 
        SUM(sal + NVL (comm, 0)) tot_sal_sum -- �޿����� commm�� NULL�� �൵ ���Ե� ��
FROM emp;

--WHERE ������ GROUP �Լ��� ǥ���� �� ����
----�μ��� �ִ� �޿� ���ϱ�
--1.�μ��� �ִ�޿� ���ϱ�
--2.�μ��� �ִ�޿� ���� 3000�� �Ѵ� �ุ ���ϱ�

--deptno, �ִ�޿�
SELECT deptno, MAX(sal) m_sal
FROM emp
WHERE MAX(sal) > 3000 -- ORA-00934 ���� WHERE ������ GROUP �Լ��� �� �� ����
GROUP BY deptno;

--HAVING ���
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
-- inLine ���
 SELECT hire_yyyymm, COUNT (*) CNT
 FROM
     (SELECT TO_CHAR(hiredate,'YYYYMM') hire_yyyymm -- 1980/12/17 --> 198012        
     FROM emp)
GROUP BY hire_yyyymm;

--grp5
-- inLine ���
SELECT hire_yyyy, COUNT (*) CNT
FROM
     (SELECT TO_CHAR(hiredate,'YYYY') hire_yyyy -- 1980����        
     FROM emp)
GROUP BY hire_yyyy;
--
 SELECT TO_CHAR(hiredate,'YYYY') hire_YYYY, --1980����
        COUNT (*) CNT 
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY');

--grp6
--��ü ������ ���ϱ�(emp)

SELECT count(*), COUNT(empno), COUNT(mgr) 
FROM emp;

-- ��ü �μ��� ���ϱ�(dept
SELECT count(*), COUNT(deptno), COUNT(loc) 
FROM dept;

--������ ���� �μ��� ����
SELECT COUNT(COUNT (*)) CNT
FROM emp
GROUP BY deptno;

--inLine Ȱ��
SELECT COUNT (*) CNT
FROM
(SELECT COUNT(deptno)
FROM emp
GROUP BY deptno);

--distinct Ȱ��
SELECT COUNT (DISTINCT deptno) CNT
FROM emp;

--JOIN
--1.���̺��� ��������( �÷� �߰�)
--2.�߰��� �÷��� ���� UPDATE
--ename �÷��� emp ���̺� �߰�
DESC emp;
DESC dept;
-- �÷��߰�( dname, VARCHA2(14)
ALTER TABLE emp ADD (dname VARCHAR2(14));

SELECT *
FROM emp;

UPDATE emp SET dname = CASE
                            WHEN deptno = 10 THEN 'ACCOUNTING'--Ư�� �� ������Ʈ�� WHERE Ȱ��
                            WHEN deptno = 20 THEN 'RESEARCH'
                            WHEN deptno = 30 THEN 'SALES'
                            END;
 
 COMMIT;
 
 
 SELECT empno, ename, deptno, dname
 FROM emp;
 
 -- SALES -- > MARKET SALES
 -- �� 6���� ������ ������ �ʿ��ϴ�
 --���� �ߺ��� �ִ� ����(�� ������)
-- UPDATE emp set dname = 'MARKET SALES'
-- WHERE dname = 'SALES';


