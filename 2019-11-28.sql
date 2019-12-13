--emp ���̺�, dept ���Ը� ����

-- ������ ����
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno


-- �ٸ� �� ������ ��� (!=) 
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno
AND emp.deptno =10;


SELECT *
FROM TABLE (DBMS_XPLAN.DISPLAY);

SELECT ename,deptno
FROM emp;

SELECT deptno, dname
FROM dept;

-- natural join : ���� ���̺� ���� Ÿ��, ���� �̸��� �÷����� 
--                ���� ���� ���� ��� ����

desc emp;
desc dept;
--ANSI SQL ����
SELECT deptno, emp.empno, ename
FROM emp  NATURAL JOIN dept;

--��Ī �߰�
SELECT deptno, a.empno, ename
FROM emp a NATURAL JOIN dept;


ALTER TABLE emp DROP COLUMN dname;

-- ORACLE ����
SELECT emp.deptno, emp.empno, ename
FROM emp,dept
WHERE emp.deptno = dept.deptno;

--JOIN USING
--join �Ϸ��� �ϴ� ���̺� ������ �̸��� �÷��� �ΰ� �̻��϶�
-- join �÷��� �ϳ��� ����ϰ� ���� ��

--ANSI SQL

SELECT *
FROM emp JOIN dept USING (deptno);

--ORACLE SQL
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI JOIN with ON
--���� �ϰ��� �ϴ� ���̺��� �÷� �̸��� �ٸ���
--�����ڰ� ���� ������ ���� ������ ��

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--ORACLE
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : ���� ���̺� ���� 
--EMP ���̺� ���� �Ҹ��� ���� : ������ ������ ���� ��ȸ
SELECT *
FROM emp;

-- ������ ������ ������ ��ȸ
-- ���� �̸�, ������ �̸�

--ANSI SQL
SELECT e.ename, m. ename
FROM emp e join emp m ON(e.mgr = m.empno );

--ORACLE
SELECT e.ename, m.ename --3��
FROM emp e, emp m -- �ؼ����� 1��
WHERE e.mgr = m.empno; --2��

--���� �̸�, ������ ����� �̸�, ������ ������� ����� �̸�

SELECT .a*
FROM
(SELECT e.ename, m.ename
FROM emp e , emp m 
WHERE e.mgr = m.empno) a;

SELECT e.ename, m.ename, t.ename
FROM emp e, emp m, emp t
WHERE e.mgr = m.empno
AND m.mgr = t.empno; 

 -- ���� �̸�, ������ �������� �̸�, ������ �������� �������� �̸�, ������ �������� �������� �������� �̸�.
 
 SELECT e.ename, m.ename, t.ename, r.ename
FROM emp e, emp m, emp t, emp r
WHERE e.mgr = m.empno
AND m.mgr = t.empno 
AND t.mgr = r.empno;

--�������̺��� ANSI JOIN�� �̿��� JOIN
SELECT e.ename, m.ename, t.ename, r.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno)
    JOIN emp t ON (m.mgr = t.empno)
    JOIN emp r ON (t.mgr = r.empno);
    
--������ �̸��� �ش� ������ �������� �̸��� ��ȸ �Ѵ�
-- �� ������ ����� 7369~ 7698�� ������

SELECT e.ename, m.ename
FROM emp e, emp m
WHERE e.empno = m.empno
AND e.empno BETWEEN 7369 AND 7698;

SELECT empno, ename
FROM emp;

--ANSI
SELECT e.ename, m.ename
FROM emp e join emp m ON (e.mgr = m.empno)
WHERE e.empno BETWEEN 7369 AND 7698;

--NON-EQUI JOIN : ���� ������ = (equal)�� �ƴ� JOIN
-- !=, BETWEEN AND

SELECT *
FROM salgrade;

SELECT empno, ename, sal --�޿� grade
FROM emp;

SELECT empno, ename, sal, grade
FROM emp, salgrade
WHERE emp.sal BETWEEN  salgrade.losal AND salgrade.hisal;

SELECT empno, ename, sal, grade
FROM emp JOIN salgrade ON emp.sal BETWEEn losal AND hisal; 

--join0
--ORACLE
SELECT EMPNO, ENAME, d.DEPTNO, DNAME
FROM emp e, dept d
WHERE e.DEPTNO = d.DEPTNO
ORDER BY e.deptno;

--ANSI
SELECT EMPNO, ENAME, dept.DEPTNO, DNAME
FROM emp JOIN dept ON (emp.DEPTNO = dept.DEPTNO)
ORDER BY emp.deptno;


--join 1
--ORACLE
SELECT EMPNO, ENAME, d.DEPTNO, DNAME
FROM emp e, dept d
WHERE e.DEPTNO IN (10,30)
AND e.DEPTNO = d.DEPTNO;

--ANSI
SELECT EMPNO, ENAME, dept.DEPTNO, DNAME
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.DEPTNO IN (10,30);



--join 2

--ORACLE
SELECT EMPNO, ENAME, SAL, emp.DEPTNO, DNAME
FROM emp ,dept
WHERE emp. sal >2500
AND emp.DEPTNO = dept.DEPTNO
ORDER BY emp.sal desc;

--ANSI
SELECT EMPNO, ENAME,SAL, dept.DEPTNO, DNAME
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.sal > 2500
ORDER BY emp.sal desc;

--join3
--ORACLE
SELECT EMPNO, ENAME, SAL, e.DEPTNO, DNAME
FROM emp e ,dept d
WHERE e. sal >2500
AND e.empno >7600
AND e.DEPTNO = d.DEPTNO;

--ANSI
SELECT EMPNO, ENAME, SAL, dept.DEPTNO, DNAME
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
and emp.empno >7600
AND emp.sal > 2500;

--join4

--ORACLE
SELECT EMPNO, ENAME, SAL, e.DEPTNO, DNAME
FROM emp e ,dept d
WHERE e. sal >2500
AND e.empno >7600
AND d.dname = 'RESEARCH'
AND e.DEPTNO = d.DEPTNO

ORDER BY e.ename;

--ANSI
SELECT EMPNO, ENAME, SAL, dept.DEPTNO, DNAME
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
and emp.empno >7600
AND emp.sal > 2500
AND dept.dname = 'RESEARCH'
ORDER BY emp.ename;

