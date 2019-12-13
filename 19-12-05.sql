--sub4
                     
SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);                     
--sub5              
SELECT *
FROM product
WHERE pid NOT IN (SELECT pid
                  FROM cycle
                  where cid =1);

--sub6
--cid = 2�� ���� �����ϴ� ��ǰ�� cid - 1�� ���� �����ϴ� ��ǰ�� ���������� ��ȸ

SELECT *
FROM cycle
WHERE cid=1 
AND pid IN   (SELECT pid
              FROM cycle
              WHERE cid = 2);
 --sub7             
SELECT c.cid, t.cnm , c.pid, p.pnm, c.day, c. cnt
FROM cycle c, customer t, product p
WHERE c.cid = 1
AND c.cid = t. cid
AND c.pid = p.pid
AND c.pid IN  (SELECT pid
              FROM cycle  
              WHERE cid = 2);
        
              

--�Ŵ����� �����ϴ� ���� ���� ��ȸ
--sub8
SELECT *
FROM emp e
WHERE EXISTS (SELECT '1'
              FROM emp m
              WHERE m.empno = e.mgr);

--sub9             
SELECT *
FROM product
WHERE EXISTS (SELECT 'x'
            FROM cycle
            WHERE cid = 1
            AND cycle.pid = product.pid);
            

--sub10
SELECT *
FROM product
WHERE NOT EXISTS (SELECT 'x'
                  FROM cycle
                  WHERE cid = 1
                  AND cycle.pid = product.pid);

--���տ���
--UNION : ������, �� ������ �ߺ����� �����Ѵ�
--��� ������ SALESMAN�� ������ ������ȣ , ���� �̸� ��ȸ
--���Ʒ� ������� �����ϱ� ������ ������ ������ �ϰ� �� ���
--�ߺ��Ǵ� �����ʹ� �ѹ��� ǥ���Ѵ�.

SELECT empno,ename
FROM emp
WHERE job = 'SALESMAN'
UNION
SELECT empno,ename
FROM emp
WHERE job = 'SALESMAN';

--���� �ٸ� ������ ������

SELECT empno,ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno,ename
FROM emp
WHERE job = 'CLERK';

--UNION ALL
--������ ����� �ߺ� ���Ÿ� ���� �ʴ´�
--���Ʒ� ��� ���� �ٿ� �ֱ⸸ �Ѵ�

SELECT empno,ename
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno,ename
FROM emp
WHERE job = 'SALESMAN';

--���տ���� ���ռ��� �÷��� ���� �ؾ��Ѵ�
--�÷��� ������ �ٸ���� ������ ���� �ִ� �漮���� ������ �����ش�
SELECT empno,ename,''
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno,ename,job
FROM emp
WHERE job = 'SALESMAN';

--INTERSECT : ������
--�����հ� �������� �����͸� ��ȸ

SELECT empno, ename
FROM emp
WHERE job in ('SALESMAN', 'CLERK')

INTERSECT

SELECT empno, ename
FROM emp
WHERE job in ('SALESMAN');

--MINUS
--������ : ��, �Ʒ� ������ �������� �� ���տ��� ������ ������ ��ȸ
--�������� ��� ������, �����հ� �ٸ��� ������ ���� ���� ������ ��� ���տ� ������ �ش�.


SELECT empno, ename
FROM emp
WHERE job in ('SALESMAN', 'CLERK')

MINUS

SELECT empno, ename
FROM emp
WHERE job in ('SALESMAN');

--*�� ��ȸ�� ORDER BY name�� �ν����� ���ϴ� ����

SELECT empno, ename
FROM
(SELECT empno, ename
FROM emp
WHERE job in ('SALESMAN', 'CLERK')
ORDER BY job)

UNION ALL

SELECT empno, ename
FROM emp
WHERE job in ('SALESMAN')
ORDER BY ename;

--DML
--INSERT : ���̺� ���ο� �����͸� �Է�
SELECT *
FROM dept;

DELETE dept
WHERE deptno =99;
COMMIT;

--INSERT �� �÷��� ������ ���
--������ �÷��� ���� �Է��� ���� ������ ������ ����Ѵ�
--INSERT INTO ���̺�� (�÷�1, �÷�2....)
--            VALUES (��1, ��2....)

--dept ���̺� 99�� �μ���ȣ, ddit ������, daejeon �������� ���� ������ �Է�
INSERT INTO dept (deptno, dname, loc)
            VALUES (99, 'ddit', 'DAEJEON');
ROLLBACK;            
SELECT *
FROM dept;

--�÷��� ����� ��� ���̺��� �÷� ���� ������ �ٸ��� �����ص� ����� ����
--dept ���̺��� �÷� ���� : deptno,dname,location
INSERT INTO dept (loc, deptno, dname)
            VALUES ('DAEHEON', 99, 'ddit');
SELECT *
FROM dept;


--�÷��� ������� �ʴ� ��� : ���̺��� �÷� ���� ������ ���� ���� ����Ѵ�
INSERT INTO dept VALUES (99, 'ddit','daejeon');

--��¥ �� �Է��ϱ�
--1.SYSDATE
--2.����ڷ� ���� ���� ���ڿ��� DATE Ÿ������ �����Ͽ� �Է�

INSERT INTO emp VALUES (9998,'sally' ,'SALESMAN',NULL, SYSDATE, 500, NULL, NULL);

INSERT INTO emp VALUES (9997,'james' ,'CLERK',NULL, TO_DATE ('20191202','YYYYMMDD'), 500, NULL, NULL);

--�������� �����͸� �ѹ��� �Է�
--SELECT ����� ���̺� �Է��� �� �ִ�
INSERT INTO emp
SELECT 9998,'sally' ,'SALESMAN',NULL, SYSDATE, 500, NULL, NULL
FROM dual

UNION ALL

SELECT 9997,'james' ,'CLERK',NULL, TO_DATE ('20191202','YYYYMMDD'), 500, NULL, NULL
FROM dual;

select *
from emp;

rollback;