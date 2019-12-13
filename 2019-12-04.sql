--SMITH�� ���� �μ� ã��

SELECT *
FROM emp
WHERE deptno = 20;

SELECT * --����
FROM emp;
WHERE deptno IN  (SELECT deptno --����
                  FROM emp);

--SCALAR SUBQUERY
--SELECT ���� ǥ���� ���� ����
--�� ��, �� COLUMN�� ��ȸ�ؾ� �Ѵ�
SELECT empno,ename,deptno,  
      (SELECT dname FROM dept WHERE dept.deptno = emp.deptno) dname --SELECT �� ���� x
FROM emp;

SELECT empno,ename,deptno,  
      (SELECT dname FROM dept) danme --SELECT �� ���� o
FROM emp;

--INLINE VIEW
--FROM ���� ���Ǵ� ���� ����

--SUBQUERY
--WHERE�� ���Ǵ� ��������

--sub1
SELECT count(*) cnt
FROM emp
WHERE sal>  (SELECT AVG(sal)            
            FROM emp);
--sub2            
SELECT *
FROM emp
WHERE sal>  (SELECT AVG(sal)            
            FROM emp);            

--sub3
--1.SMITH WARD�� ���� �μ� ��ȸ
--2.1���� ���� ������� �̿��Ͽ� �ش� �μ���ȣ�� ���ϴ� ���� ��ȸ
SELECT *
FROM emp
WHERE deptno  in (SELECT deptno 
                  FROM emp
                  WHERE ename IN ('SMITH','WARD'));
                   
SELECT deptno
FROM emp
WHERE ename IN ('SMITH','WARD');

SELECT *
FROM emp
WHERE deptno IN (20 , 30);

SELECT *
FROM emp;

-- SMITH Ȥ�� WARD ���� �޿��� ���� �޴� ���� ��ȸ (800, 1250) any �� ��� ---> 1250���� ���� ���
SELECT *
FROM emp
WHERE sal < any (SELECT sal
                 FROM emp
                 WHERE ename IN ('SMITH', 'WARD'));

--������ ��Ȱ�� ���� �ʴ� ��� ���� ��ȸ
--NOT IN ������ ���� NULL�� �����Ϳ� �������� �ʾƾ� ������ �Ѵ�
SELECT *
FROM emp -- ��� ���� ��ȸ --> ������ ��Ȱ�� ���� �ʴ�
WHERE empno NOT IN (SELECT nvl(mgr,-1) --NULL���� �������� �������� �����ͷ� ġȯ 
                    FROM emp);

SELECT *
FROM emp -- ��� ���� ��ȸ --> ������ ��Ȱ�� ���� �ʴ�
WHERE empno NOT IN (SELECT mgr 
                    FROM emp
                    WHERE mgr is NOT NULL);
--pairwise (���� �÷��� ���� ���ÿ� ���� �ؾ��ϴ� ���)
--ALLEN, CLEARK �� �Ŵ����� �μ���ȣ�� ���ÿ� ���� ��� ���� ��ȸ
--(7698,30)
--(7839,10)
--7698, 10
--7698,30
--7839,10
--7839,30
--pairwise
SELECT *
FROM emp
WHERE (mgr,deptno) IN (SELECT mgr,deptno
                FROM emp
                WHERE empno in (7499, 7782));


--nonpairwise
SELECT *
FROM emp
WHERE mgr IN (SELECT mgr
                FROM emp
                WHERE empno in (7499, 7782))
AND deptno IN
                (SELECT deptno
                FROM emp
                WHERE empno in (7499, 7782));
                
--���ȣ ���� ���� ����
--���������� �÷��� ���������̼� ������� �ʴ� ������ ���� ����


--���ȣ ���� ���������� ��� ������������ ����ϴ� ���̺�, �������� ��ȸ ������
--���������� ������������ �Ǵ��Ͽ� ������ �����Ѵ� (�ܵ������� ������ �����ϱ� ����)
--���������� emp ���̺��� ���� �������� �ְ�, ���������� emp ���̺��� ���� ���� ���� �ִ�.

--���ȣ ���� ������������ ���������� ���̺��� ���� ���� ����
--���������� ������ ��Ȱ�� �ߴ� ��� �� �������� ǥ��
--���ȣ ���� ������������ ���������� ���̺��� ���߿� ���� ����
--���������� Ȯ�� ��Ȱ�� �ߴ� ��� �� �������� ǥ��

--������ �޿� ��պ��� ���� �޿��� �޴� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE sal > ( SELECT AVG(sal)
             FROM emp);

--��ȣ���� ��������
--�ش������� ���� �μ��� �޿���պ��� ���� �޿��� �޴� ���� ��ȸ

SELECT *
FROM emp m
WHERE sal > (SELECT AVG(sal) 
            FROM emp
            WHERE deptno = m. deptno);
            

--10�� �μ��� �޿� ���

SELECT AVG(sal)
FROM emp
WHERE deptno = 10;
             



                
                