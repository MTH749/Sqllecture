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
SELECT empno, ename, sal, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.sal >2500 AND emp.empno > 7600
ORDER BY emp.sal desc;

--ANSI
SELECT EMPNO, ENAME, SAL, DEPT.DEPTNO, DNAME
FROM EMP JOIN DEPT ON (EMP.DEPTNO = DEPT.DEPTNO)
WHERE emp.sal > 2500 AND emp.empno >7600
ORDER BY emp.sal desc;


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

--실습 join1

SELECT l.LPROD_GU, l.LPROD_NM, p.prod_id, p.prod_name
FROM lprod l, prod p
WHERE p.prod_lgu = l.lprod_gu
ORDER BY p.prod_lgu, p.prod_name;

--실습 join2
SELECT BUYER_ID, BUYER_NAME, PROD_ID, PROD_NAME
FROM buyer, prod
WHERE buyer_id = prod_buyer
ORDER BY buyer_id, prod_name;

SELECT m.MEM_ID,m. MEM_NAME, p.PROD_NAME, c.CART_QTY
FROM member m, cart c, prod p
WHERE m.mem_id = c.cart_member
AND p.prod_id = c.cart_prod;


--join4
SELECT c.cid CID,c.cnm CNM, d.pid PID, day, d.cnt CNT
FROM customer c, cycle d
WHERE c.cid = d.cid
and cnm in ('brown','sally');

--join5
SELECT c.cid CID,c.cnm CNM,e.pnm, d.pid PID, day, d.cnt CNT
FROM customer c, cycle d, product e
WHERE c.cid = d.cid
AND d.pid = e.pid
and cnm in ('brown','sally');

--join6
SELECT c.CID , CNM, pnm, d.PID, SUM (CNT)
FROM customer c, cycle d, product e
WHERE c.cid = d.cid
AND d.pid = e.pid
GROUP BY c.CID, CNM,pnm,d.pid
ORDER BY cid;

SELECT cnm,pnm,a.*
FROM
(SELECT cid, pid,sum(cnt)
    FROM cycle
        GROUP BY cid,pid) a, customer,product
WHERE a.cid = customer.cid
AND a.pid = product.pid;


        
--join7
SELECT c.pid, pnm,
sum(cnt) cnt
FROM cycle c, product d
WHERE c.pid = d.pid
GROUP BY c.pid, pnm;

