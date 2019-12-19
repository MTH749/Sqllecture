--사원 이름, 사원 번호, 전체직원 건수
--ana0-
SELECT a.ename, a.sal, a.deptno, b.rn sal_rank
FROM 
(SELECT ename, sal, deptno, ROWNUM j_rn
    FROM
    (SELECT ename, sal, deptno
     FROM emp
     ORDER BY deptno, sal DESC)) a,

(SELECT rn, ROWNUM j_rn
FROM
    (SELECT b.*, a.rn
    FROM 
    (SELECT ROWNUM rn
     FROM dual
     CONNECT BY level <= (SELECT COUNT(*) FROM emp)) a,
    
    (SELECT deptno, COUNT(*) cnt
     FROM emp
     GROUP BY deptno) b
    WHERE b.cnt >= a.rn
    ORDER BY b.deptno, a.rn )) b
WHERE a.j_rn = b.j_rn;

-- ana0-을 분석함수로 
SELECT ename, sal, deptno, RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) sal_rank
FROM emp;

SELECT ename, sal, deptno, RANK() OVER (PARTITION BY deptno ORDER BY sal ) rank,
                           DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal )dense_rank,
                           ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal ) row_number
FROM emp;

SELECT empno, ename , sal, deptno, 
       RANK () OVER ( ORDER BY sal desc,empno) sal_rank,
       DENSE_RANK () OVER ( ORDER BY sal desc,empno) sal_dense_rank ,    
       ROW_NUMBER () OVER ( ORDER BY sal desc,empno) sal_row_number
FROM emp;

--no_ana2
    SELECT a.empno,a.ename,a.deptno, b.cnt
     FROM
    (SELECT empno,ename,deptno
     FROM emp) a,
     
    (SELECT deptno,count(*) cnt
    FROM emp
    GROUP BY deptno)b
    WHERE a.deptno = b.deptno
    ORDER BY deptno, empno;
    
 
 --사원번호, 사원 이름, 부서번호, 부서의 직원 수
 
 SELECT empno, ename, deptno,
        COUNT (*) OVER (PARTITION BY deptno) cnt
 FROM emp;

----ana2
SELECT empno, ename, sal, deptno,
        ROUND (AVG(sal) OVER (PARTITION BY deptno),2) avg
FROM emp;

--- ana3
SELECT empno, ename, sal, deptno,
        max(sal) OVER (PARTITION BY deptno) MAX_SAL
FROM emp;

--- ana4
SELECT empno, ename, sal, deptno,
        min(sal) OVER (PARTITION BY deptno) MIN_SAL
FROM emp;

--- 분석함수 없이
SELECT a.empno, a.ename, a.sal, a.deptno, max_sal
FROM
(SELECT empno,ename, sal,deptno
FROM emp) a,

(SELECT deptno, max(sal) max_sal
FROM emp
GROUP BY deptno) b
WHERE a.deptno = b.deptno
ORDER BY deptno;

--전체사원을 대상으로 급여순위가 자신보다 한단계 낮은 사람의 급여
-- (급여가 같을경우 입사일자가 빠른 사람이 높은 순위
SELECT empno, ename,hiredate, sal,
       LEAD(sal) OVER( ORDER BY sal DESC,hiredate) lead_sal
FROM emp;
--ana5
SELECT empno, ename,hiredate, sal,
       LAG(sal) OVER( ORDER BY sal DESC,hiredate) lag_sal
FROM emp;
--ana6
SELECT empno, ename, hiredate,sal,job,
       LAG(sal) OVER(PARTITION BY job ORDER BY sal desc,hiredate) lag_sal
FROM emp;
--no_ana3
SELECT empno,ename,sal
FROM 
  (SELECT empno, ename, sal, ROWNUM j_rn
    FROM
        (SELECT empno, ename, sal
         FROM emp
         ORDER BY empno, sal DESC) a,

        (SELECT empno,sum(sal) c_sum
         FROM emp
         GROUP BY empno) a
         
         WHERE b.cum >= a.rn
         ORDER BY b.empno, a.rn ) b;
         
         
         
SELECT a.empno, a.ename, a.sal, sum(rn)
FROM 
(SELECT empno, ename, sal, ROWNUM j_rn
    FROM
    (SELECT empno, ename, sal
     FROM emp
     ORDER BY empno, sal DESC)) a,

(SELECT rn, ROWNUM j_rn
FROM
    (SELECT b.*, a.rn
    FROM 
    (SELECT ROWNUM rn
     FROM dual
     CONNECT BY level <= (SELECT sum(sal) FROM emp)) a,
    
    (SELECT empno, sum(sal) c_sum
     FROM emp
     GROUP BY empno) b
    WHERE b.c_sum >= a.rn
    ORDER BY b.empno, a.rn )) b
WHERE a.j_rn >= b.j_rn
GROUP BY a.empno, a.ename, a.sal
ORDER BY sal;

    SELECT a.empno,a.ename,a.sal, sum(b.sal)
    FROM
    (SELECT empno,ename, sal
    FROM emp)a,
    
    ((SELECT a.empno,a.sal
    FROM
    (SELECT empno,sal
    FROM emp
    ORDER BY sal) a,

    (SELECT empno,sal
    FROM emp
    ORDER BY sal) b
    WHERE a.sal <= b.sal))b
    
    WHERE a.sal = b.sal
    GROUP BY a.empno,a.ename,a.sal;

    SELECT ROWNUM rn
     FROM dual
     CONNECT BY level <= (SELECT count(*) FROM emp); 