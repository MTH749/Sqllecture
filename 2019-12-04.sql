--SMITH가 속한 부서 찾기

SELECT *
FROM emp
WHERE deptno = 20;

SELECT * --메인
FROM emp;
WHERE deptno IN  (SELECT deptno --서브
                  FROM emp);

--SCALAR SUBQUERY
--SELECT 절에 표현된 서브 쿼리
--한 행, 한 COLUMN을 조회해야 한다
SELECT empno,ename,deptno,  
      (SELECT dname FROM dept WHERE dept.deptno = emp.deptno) dname --SELECT 절 실행 x
FROM emp;

SELECT empno,ename,deptno,  
      (SELECT dname FROM dept) danme --SELECT 절 실행 o
FROM emp;

--INLINE VIEW
--FROM 절에 사용되는 서브 쿼리

--SUBQUERY
--WHERE에 사용되는 서브쿼리

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
--1.SMITH WARD가 속한 부서 조회
--2.1번에 나온 결과값을 이용하여 해당 부서번호에 속하는 직원 조회
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

-- SMITH 혹은 WARD 보다 급여를 적게 받는 직원 조회 (800, 1250) any 쓸 경우 ---> 1250보다 작은 사람
SELECT *
FROM emp
WHERE sal < any (SELECT sal
                 FROM emp
                 WHERE ename IN ('SMITH', 'WARD'));

--관리자 역활을 하지 않는 사원 정보 조회
--NOT IN 연산자 사용시 NULL이 데이터에 존재하지 않아야 정상동작 한다
SELECT *
FROM emp -- 사원 정보 조회 --> 관리자 역활을 하지 않는
WHERE empno NOT IN (SELECT nvl(mgr,-1) --NULL값을 존재하지 않을만한 데이터로 치환 
                    FROM emp);

SELECT *
FROM emp -- 사원 정보 조회 --> 관리자 역활을 하지 않는
WHERE empno NOT IN (SELECT mgr 
                    FROM emp
                    WHERE mgr is NOT NULL);
--pairwise (여러 컬럼의 값을 동시에 만족 해야하는 경우)
--ALLEN, CLEARK 의 매니저와 부서번호가 동시에 같은 사원 정보 조회
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
                
--비상호 연관 서브 쿼리
--메인쿼리의 컬럼을 서브쿼레이서 사용하지 않는 형태의 서브 쿼리


--비상호 연관 서브쿼리의 경우 메인쿼리에서 사용하는 테이블, 서브쿼리 조회 순서를
--성능적으로 유리한쪽으로 판단하여 순서를 결정한다 (단독적으로 실행이 가능하기 때문)
--메인쿼리의 emp 테이블을 먼저 읽을수도 있고, 서브쿼리의 emp 테이블을 먼저 읽을 수도 있다.

--비상호 연관 서브쿼리에서 서브쿼리쪽 테이블을 먼저 읽을 때는
--서브쿼리가 제공자 역활을 했다 라고 모 도서에서 표현
--비상호 연관 서브쿼리에서 서브쿼리쪽 테이블을 나중에 읽을 때는
--서브쿼리가 확인 역활을 했다 라고 모 도서에서 표현

--직원의 급여 평균보다 높은 급여를 받는 직원 정보 조회
SELECT *
FROM emp
WHERE sal > ( SELECT AVG(sal)
             FROM emp);

--상호연관 서브쿼리
--해당직원이 속한 부서의 급여평균보다 높은 급여를 받는 직원 조회

SELECT *
FROM emp m
WHERE sal > (SELECT AVG(sal) 
            FROM emp
            WHERE deptno = m. deptno);
            

--10번 부서의 급여 평균

SELECT AVG(sal)
FROM emp
WHERE deptno = 10;
             



                
                