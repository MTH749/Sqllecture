SELECT *
FROM EMP    
WHERE empno = :empno;   

SELECT *
FROM DEPT
WHERE deptno = :deptno;

SELECT *
FROM EMP,DEPT
WHERE EMP.deptno = DEPT.deptno
AND EMP.deptno = :deptno
AND EMp.deptno LIKE : deptno || '%';

SELECT *
FROM EMP
WHERE sal BETWEEN : st_sal AND :ed_sal
AND deptno = :deptno;

SELECT *
FROM EMP,DEPT
WHERE EMP.deptno = DEPT.deptno
AND EMP.deptno = :deptno
AND DEPT.loc = :loc;

CREATE INDEX idx_dt_nuni01 ON emp (empno,deptno);
CREATE INDEX idx_dt_nuni01 ON dept (deptno,loc);
CREATE INDEX idx_dt_nuni01 ON emp (sal);