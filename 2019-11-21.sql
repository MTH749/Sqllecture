-- col IN (value1, value2...)
-- col�� ���� IN ������ �ȿ� ������ ���߿� ���Ե� �� ������ ����

--RDMS - ���հ���
-- 1. ���տ��� ������ ����
-- (1,5,7), (5,1,7)

-- 2.���տ��� �ߺ��� ����
-- {1,1,5,7}, {5,1,7}

SELECT *
FROM emp
WHERE deptno IN (10,20); -- emp ���̺��� ������ �Ҽ� �μ��� 10�� �̰ų� 20����
                         -- ���� ������ ��ȸ
                         
--�̰ų� --> OR(�Ǵ�)
--�̰� --> AND(�׸���)

--IN --> OR
--BETWEEN AND --> AND + �����

SELECT *
FROM emp
WHERE deptno = 10 OR detpno = 20;

SELECT *
FROM users;
--WHERE 2
SELECT userid ���̵�, usernm �̸�, ALIAS ���� 
FROM users
WHERE userid IN ('brown', 'cony', 'sally');

--LIKE ������ : ���ڿ� ��Ī ����
-- % : �������� (���ڰ� ���� ���� �ִ�)
--_ : �ϳ��� ����

--emp ���̺��� ��� �̸���(ename)�� s�� �����ϴ� ��� ������ ��ȸ
SELECT *
FROM emp
WHERE ename LIKE 'S%';

-- SMITH
-- SCOTT
-- �ι���, ������, �ټ���° ���ڴ� � ���ڵ� �� �� �ִ�
SELECT *
FROM emp
WHERE ename LIKE 'S__T_';
WHERE ename LIKE 'S__T_'; -- ex)'STE','STTT', 'STESTS' ��ȸ ����

--WHERE4
SELECT *
FROM member;

SELECT MEM_ID, MEM_NAME
FROM member
WHERE MEM_NAME LIKE '��%';

SELECT MEM_ID, MEM_NAME
FROM member
WHERE MEM_NAME LIKE '��__';

--�÷� ���� NULL�� ������ã��
-- emp ���̺� ���� MGR �÷��� NULL �����Ͱ� ����
SELECT *
FROM emp;

SELECT *
FROM emp
WHERE MGR IS NULL; -- MGR �÷� ���� NULL�� ��� ������ȸ
WHERE MGR = NULL; -- MGR �÷� ���� NULL�� ��� ������ȸ (��ȸ���� ����

-- WHERE 6

SELECT *
FROM emp
WHERE comm IS NOT NULL;

-- AND : ������ ���ÿ� ����
-- OR  : ������ �Ѱ��� �����ϸ� ����

-- emp ���̺��� mgr�� 7698 ��� �̰�(AND) �޿���(sal) ���� ū��� ��ȸ
SELECT *
FROM emp
WHERE MGR = 7698
AND sal > 1000;

--emp ���̺��� mgr�� 7698 �̰ų� �޿��� 1000���� ū ���
SELECT *
FROM emp
WHERE MGR = 7698
OR sal > 1000;

--emp ���̺��� ������ ����� 7698, 7839�� �ƴ� ���� ������ȸ + king ��ȸ
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839)
OR mgr is NULL;

DESC emp;
-
--where 7
SELECT *
FROM emp
WHERE job LIKE 'SALESMAN'
AND hiredate >= TO_DATE ('19810601','YYYYMMDD');