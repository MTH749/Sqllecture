--emp 테이블, dept 테입르 조인

-- 값은값 조인
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno


-- 다른 값 조인할 경우 (!=) 
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

-- natural join : 조인 테이블간 같은 타입, 같은 이름의 컬럼으로 
--                같은 값을 갖을 경우 조인

desc emp;
desc dept;
--ANSI SQL 문법
SELECT deptno, emp.empno, ename
FROM emp  NATURAL JOIN dept;

--별칭 추가
SELECT deptno, a.empno, ename
FROM emp a NATURAL JOIN dept;


ALTER TABLE emp DROP COLUMN dname;

-- ORACLE 문법
SELECT emp.deptno, emp.empno, ename
FROM emp,dept
WHERE emp.deptno = dept.deptno;

--JOIN USING
--join 하려고 하는 테이블간 동일한 이름의 컬럼이 두개 이상일때
-- join 컬럼을 하나만 사용하고 싶을 때

--ANSI SQL

SELECT *
FROM emp JOIN dept USING (deptno);

--ORACLE SQL
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI JOIN with ON
--조인 하고자 하는 테이블의 컬럼 이름이 다를때
--개발자가 조인 조건을 직접 제어할 때

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--ORACLE
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : 같은 테이블간 조인 
--EMP 테이블간 조일 할만한 사항 : 직원의 관리자 정보 조회
SELECT *
FROM emp;

-- 직원의 관리자 정보를 조회
-- 직원 이름, 관리자 이름

--ANSI SQL
SELECT e.ename, m. ename
FROM emp e join emp m ON(e.mgr = m.empno );

--ORACLE
SELECT e.ename, m.ename --3번
FROM emp e, emp m -- 해석순서 1번
WHERE e.mgr = m.empno; --2번

--직원 이름, 직원의 상급자 이름, 직원의 상급자의 상급자 이름

SELECT .a*
FROM
(SELECT e.ename, m.ename
FROM emp e , emp m 
WHERE e.mgr = m.empno) a;

SELECT e.ename, m.ename, t.ename
FROM emp e, emp m, emp t
WHERE e.mgr = m.empno
AND m.mgr = t.empno; 

 -- 직원 이름, 직원의 관리자의 이름, 직원의 관리자의 관리자의 이름, 직원의 관리자의 관리자의 관리자의 이름.
 
 SELECT e.ename, m.ename, t.ename, r.ename
FROM emp e, emp m, emp t, emp r
WHERE e.mgr = m.empno
AND m.mgr = t.empno 
AND t.mgr = r.empno;

--여러테이블을 ANSI JOIN을 이용한 JOIN
SELECT e.ename, m.ename, t.ename, r.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno)
    JOIN emp t ON (m.mgr = t.empno)
    JOIN emp r ON (t.mgr = r.empno);
    
--직원이 이름과 해당 직원의 관리자의 이름을 조회 한다
-- 단 직원의 사번이 7369~ 7698인 직원만

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

--NON-EQUI JOIN : 조인 조건이 = (equal)이 아닌 JOIN
-- !=, BETWEEN AND

SELECT *
FROM salgrade;

SELECT empno, ename, sal --급여 grade
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

