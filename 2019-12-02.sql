--OUTER join : ���� ���ῡ ���� �ϴ��� ������ �Ǵ� ���̺��� �����ʹ�
--�������� �ϴ� join
-- LEFT OUTER JOIN : ���̺� 1 LEFT OUTER JOIN ���̺�2
--���̺� 1�� ���̺� 2�� �����ҋ� ���ο� �����ϴ��� ���̺� 1���� �������ʹ�
--��ȸ�� �ǵ��� �Ѵ�
--���ο� ������ �࿡�� ���̺�2�� �÷����� �������� �����Ƿ� NULL�� ǥ�õȴ�.

--ORACLE outer join syntax
--�Ϲ� ���ΰ� �������� �÷Ÿ� (+)ǥ��
--(+)ǥ�� : �����Ͱ� �������� �ʴµ� ���;� �ϴ� ���̺��� �÷�
--���� LEFT OUTER JOIN �Ŵ���
-- ON ( ����.�Ŵ��� ��ȣ = �Ŵ���.���� ��ȣ
--ORAcLE OUTER
--WHERE ����.�Ŵ�����ȣ = �Ŵ���.������ȣ(+) -- �Ŵ����� �����Ͱ� �������� ����

--ANSI
SELECT e.empno,e.ename, m.empno,m.ename
FROM emp e LEFT OUTER JOIN emp m
            ON (e.mgr = m.empno);
            
SELECT e.empno,e.ename, m.empno,m.ename
FROM emp e JOIN emp m
            ON (e.mgr = m.empno);

--ORACLE
SELECT e.empno,e.ename, m.empno,m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);
            

--ANSI
SELECT e.empno,e.ename,e.deptno, m.empno,m.ename , m.deptno
FROM emp e LEFT OUTER JOIN emp m
            ON (e.mgr = m.empno AND m.deptno = 10);
            
--ORACLE
--�ƿ��� ������ ����Ǿ�� �ϴ� ��� �÷��� (+)�� �پ�� �ȴ�
--ANSI SQL ON ���� ����� ����
SELECT e.empno,e.ename, m.empno,m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;
        
-- ANSI
SELECT e.empno,e.ename,e.deptno, m.empno,m.ename , m.deptno
FROM emp e LEFT OUTER JOIN emp m
            ON (e.mgr = m.empno)
WHERE m.deptno = '10';     --where ������ �μ���ȣ 10���ΰ��� �ɷ���

--�Ŵ��� �μ���ȣ ����
--ORACLE
--> OUTER JOIN�� ������� ���� ��Ȳ
SELECT e.empno,e.ename, m.empno,m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;

--emp ���̺��� 14���� ������ �ְ� 14���� 10,20,30�μ� �߿� �� �μ��� ���Ѵ�
-- ������ dept ���̺��� 10,20,30,40�� �μ��� ����

--�μ���ȣ, �μ���, �ش�μ��� ���� �������� �������� ������ �ۼ�
--dept : deptno, danme
--inline : deptno, cnt(������ ��)
--oracle(inline)
SELECT dept.deptno, dept.dname, nvl (emp_cnt.cnt, 0)
FROM dept,
(SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno) emp_cnt
WHERE dept.deptno = emp_cnt.deptno(+);

--ORACLE
SELECT d.deptno , d.dname, nvl (count(e.deptno) ,0) cnt
FROM emp e, dept d
WHERE e.deptno(+) = d.deptno
GROUP BY d.deptno,d.dname
ORDER BY DEPTNO;

--ANSI
SELECT dept.deptno, dept.dname, nvl (emp_cnt.cnt, 0)
FROM dept LEFT OUTER JOIN
                            (SELECT deptno, COUNT(*) cnt
                            FROM emp
                            GROUP BY deptno) emp_cnt
                     ON(  dept.deptno = emp_cnt.deptno);


SELECT e.empno,e.ename, m.empno,m.ename
FROM emp e LEFT OUTER JOIN emp m
            ON (e.mgr = m.empno);


SELECT e.empno,e.ename, m.empno,m.ename
FROM emp e RIGHT OUTER JOIN emp m
            ON (e.mgr = m.empno);
            
--FULL OUTER : LEFT OUTER + RIGHT OUTER - �ߺ������� �ѰǸ� ����� 

SELECT e.empno,e.ename, m.empno,m.ename
FROM emp e FULL OUTER JOIN emp m
            ON (e.mgr = m.empno);
            
--OUTER 1

--ORACLE
SELECT TO_CHAR(a.BUY_DATE, 'YY/MM/DD') BUY_DATE, a.BUY_PROD,  b.PROD_ID PROD_ID, b.PROD_NAME, a.BUY_QTY
FROM buyprod a , prod b
WHERE a.BUY_PROD(+) = b.prod_id
AND a.BUY_DATE(+) = '20050125'
ORDER BY a.buy_date;

--ANSI 
SELECT TO_CHAR(a.BUY_DATE, 'YY/MM/DD') BUY_DATE, a.BUY_PROD,  b.PROD_ID PROD_ID, b.PROD_NAME, a.BUY_QTY
FROM buyprod a RIGHT JOIN prod b
        ON (a.BUY_PROD(+) = b.prod_id)
AND a.BUY_DATE = '20050125'
ORDER BY a.buy_date;



--OUTER 2

SELECT nvl(TO_CHAR(a.BUY_DATE, 'YY/MM/DD'),'05/01/25') BUY_DATE, a.BUY_PROD,  b.PROD_ID PROD_ID, b.PROD_NAME, a.BUY_QTY
FROM buyprod a , prod b
WHERE a.BUY_PROD(+) = b.prod_id
AND a.BUY_DATE(+) = '20050125'
ORDER BY a.buy_date;

--outer 3

SELECT nvl(TO_CHAR(a.BUY_DATE, 'YY/MM/DD'),'05/01/25') BUY_DATE, a.BUY_PROD,
        b.PROD_ID PROD_ID, b.PROD_NAME, nvl(a.BUY_QTY,0) BYY_QTY
FROM buyprod a , prod b
WHERE a.BUY_PROD(+) = b.prod_id
AND a.BUY_DATE(+) = '20050125'
ORDER BY a.buy_date;

--outer 4


SELECT *
FROM buyprod;

SELECT *
FROM prod;


ORDER BY PROD_INSDATE;
