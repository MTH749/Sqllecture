--OUTER join : 조인 연결에 실패 하더라도 기준이 되는 테이블의 데이터는
--나오도록 하는 join
-- LEFT OUTER JOIN : 테이블 1 LEFT OUTER JOIN 테이블2
--테이블 1과 테이블 2를 조인할떄 조인에 실패하더라도 테이블 1쪽의 테이이터는
--조회가 되도록 한다
--조인에 실패한 행에서 테이블2의 컬럼값은 존재하지 않으므로 NULL로 표시된다.

--ORACLE outer join syntax
--일반 조인과 차이점은 컬렴명에 (+)표시
--(+)표시 : 데이터가 존재하지 않는데 나와야 하는 테이블의 컬럼
--직원 LEFT OUTER JOIN 매니저
-- ON ( 직원.매니저 번호 = 매니저.직원 번호
--ORAcLE OUTER
--WHERE 직원.매니저번호 = 매니저.직원번호(+) -- 매니저쪽 데이터가 존재하지 않음

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
--아우터 조인이 적용되어야 하는 모든 컬럼에 (+)가 붙어야 된다
--ANSI SQL ON 절에 기술한 형태
SELECT e.empno,e.ename, m.empno,m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;
        
-- ANSI
SELECT e.empno,e.ename,e.deptno, m.empno,m.ename , m.deptno
FROM emp e LEFT OUTER JOIN emp m
            ON (e.mgr = m.empno)
WHERE m.deptno = '10';     --where 절에서 부서번호 10번인것을 걸러냄

--매니저 부서번호 제한
--ORACLE
--> OUTER JOIN이 적용되지 않은 상황
SELECT e.empno,e.ename, m.empno,m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;

--emp 테이블에는 14명의 직원이 있고 14명은 10,20,30부서 중에 한 부서에 속한다
-- 하지만 dept 테이블에는 10,20,30,40번 부서가 존재

--부서번호, 부서명, 해당부서에 속한 직원수가 나오도록 쿼리를 작성
--dept : deptno, danme
--inline : deptno, cnt(직원의 수)
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
            
--FULL OUTER : LEFT OUTER + RIGHT OUTER - 중복데이터 한건만 남기기 

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
