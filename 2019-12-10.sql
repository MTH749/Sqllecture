--제약 조건 활성화 / 비활성화
--ALTER TABLE 테이블명 ENABLE OR DISABLE 제약 조건명;

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME  = 'DEPT_TEST';

ALTER TABLE  dept_test DISABLE CONSTRAINT sys_c007141;


SELECT *
FROM dept_test;

--dept_test 테이블의 deptno 컬럼에 적용도니 PRIMATY KEY 제약조건 비활성화 하여
--동일한 부서번호를 갖는 데이털르 입력할 수 있다.
INSERT INTO dept_test VALUES (99,'ddit','daejeon');
INSERT INTO dept_test VALUES (99,'DDIT','대전');

--dept_tset 테이블의 PRIMARY KEY 제약조건 활성화
--이미 위에서 실행한 INSERT 구문에 의해 같은 부서번호를 갖는 데이터가
--존재 하기 떄문에 PRIMARY KEY 제약 조건을 활성화 할 수 없다.
--활성화 하려면 중복데이털르 삭제해야 한다
ALTER TABLE  dept_test ENABLE CONSTRAINT sys_c007141;

--부서번호가 중복되는 데이터만 조회 하여
--해당 데이터에 대해 수정후 PRIMARY KEY 제약조건을 활성화 할 수 있다
SELECT deptno, COUNT(*)
FROM dept_test
GROUP BY deptno
HAVING COUNT (*) >= 2;

--table_name, constraint_name , column_name
--position 정렬 (ASC)
SELECT *
FROM user_constraints
WHERE table_name = 'BUYER';

SELECT *
FROM user_cons_columns;

--테이블에 대한 설명(주석) VIEW
SELECT *
FROM USER_TAB_COMMENTS;

--테이블 주석
--COMMENT ON TABLE 테이블명 IS '주석';
COMMENT ON TABLE dept IS '부서';

--컬럼주석
--COMMENT ON COLUMN 테이블명.컬럼명 IS '주석';
COMMENT ON COLUMN dept.deptno IS '부서번호';
COMMENT ON COLUMN dept.dname IS '부서명';
COMMENT ON COLUMN dept.loc IS '부서위치 지역';

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'DEPT';

--comment1
--CUSTOMER','PRODUCT', 'CYCLE', 'DAILY' 테이블과 컬럼의 주석 정보를 조회하는 쿼리를 작성하라
SELECT c.TABLE_NAME, c.TABLE_TYPE,c.COMMENTS TAB_COMMENT ,m.COLUMN_NAME ,m.COMMENTS COL_COMMENT
FROM user_tab_comments c,user_col_comments m
WHERE c.table_name = m.table_name
AND c.table_name IN ('CUSTOMER','PRODUCT', 'CYCLE', 'DAILY'); --테이블 이름은 오라클에서는 대소문자로 관리함

--VIEW : QUERY이다 (O)
--테이블처러머 데이터가 물리적으로 존재하는 것이 아니다.
--논리적 데이터셋 = QUERY
--VIEW는 테이블이다 (x)

--VIEW 생성
--CREATE OR REPLACE VIEW 뷰 이름 [(컬럼별칭1 , 컬럼별칭 2....)} AS
--SUBQUERY

--emp 테이블에서 sal, comm 컬럼을 제외한 나머지 6개 컬럼만 조회가 되는 VIEW를  V_EMP 이름으로 생성
--VIEW를 생성 하려면 system 계정에서 권한을 생성해줘야 한다
CREATE OR REPLACE VIEW V_EMP AS
SELECT empno,ename,job ,mgr ,hiredate, deptno
FROM emp;

-- VIEW를 통해 데이터 조회
SELECT *
FROM v_emp;

--INLINE VIEW
SELECT *
FROM (SELECT empno, ename, job, mgr, hiredate, deptno
        FROM emp);
        
 --emp 테이블을 수정하면 view에 영향이 있을까
 --KING의 부서번호가 현재 10번
 --emp 테이블의 KING 부서번호 데이터를 30번으로 수정
 --v_emp 테이블에서 KING의 부서번호를 관찰
 UPDATE emp SET deptno = 30
 WHERE ename = 'KING';

--조인된 VIEW 도 가능
CREATE OR REPLACE VIEW v_emp_dept AS
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;


-- emp 테이블에서 KING 데이터 삭제
DELETE emp
WHERE ename = 'KING';
rollback;

SELECT *
FROM emp;

--emp 테이블에서 KING 데이터 삭제후 V_emp_dept view 조회 결과 확인
SELECT *
FROM v_emp_dept;

--INLINE VIEW
SELECT *
FROM   (SELECT emp.empno, emp.ename, dept.deptno, dept.dname
        FROM   emp, dept
        WHERE  emp.deptno=dept.deptno);
        
--VIEW 삭제
--v_emp 삭제
DROP VIEW v_emp_dept;

--부서별 직원의 급여 합계
CREATE OR REPLACE VIEW v_emp_sal AS
SELECT deptno, SUM (sal) sum_sal
FROM emp
GROUP BY deptno;

SELECT *
FROM v_emp_sal
WHERE dpetno = 20;

--INLINE VIEW
SELECT *
FROM   (SELECT deptno, SUM (sal) sum_sal
        FROM emp
        GROUP BY deptno)
        WHERE deptno = 20;

--SEQUENCE
--오라클 객체로 중복되지 않는 정수 값을 리턴해주는 객체
--CREATE SEQUENCE 시퀀스명 [옵션... ] 

CREATE SEQUENCE seq_board; 

--시퀀스 사용방법 : 시퀀스명.nextval
SELECT seq_board.nextval
FROM dual;

SELECT seq_board.currval
FROM dual;

--시퀀스 사용방법 : 시퀀스명.nextval
--연월일 = 순번
SELECT TO_CHAR (sysdate, 'YYYYMMDD') || '-'|| seq_board.nextval
FROM dual;

--emp 테이블 empno 컬럼으로 PRIMARY KEY 제약 생성 : pk_emp;
--dept 테이블 deptno 컬럼으로 PRIMARY KEY 제약 생성 : pk_dept;
--emp 테이블의 empno 컬럼이 dpet 테이블의 deptno 컬럼을 차조하도록
--FOREIGN KEY 제약 추가 : fk_dept_deptno
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT dept PRIMARY KEY (deptno);
ALTER TABLE emp ADD CONSTRAINT fk_dept_deptno FOREIGN KEY (deptno) REFERENCES dept(deptno);

-- emp_test 테이블 삭제
DROP TABLE emp_test;

--emp 테이블을 이용하여 emp_test 테이블 생성
CREATE TABLE emp_test AS
SELECT *
FROM emp;

SELECT rowid, rownum, emp.*
FROM emp;

--emp_test 테이블에는 인덱스가 없는 상태
--원하는 데이터를 찾기 위해서는 테이블의 데이터를 모두 읽어봐야 한다
EXPLAIN PLAN FOR
SELECT *
FROM emp_test
WHERE empno = 7369;

SELECT *
FROM table (dbms_xplan.display);

--인덱스를 사용하지 않은 경우
 --실행계획을 통해 7369인 사번을 갖는 직원 정보를 조회하기 위해
 --테이블의 모든 데이터(14건)을 읽어본 다음에 사번이 7369인 데이터만 선택하여
 --사용자에게 반환
 --13건의 데이터는 불필요하게 조회후 버림
 Plan hash value: 3124080142
------------------------------------------------------------------------------
| Id  | Operation         | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |          |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP_TEST |     1 |    87 |     3   (0)| 00:00:01 |
------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)
 
Note
-----


   - dynamic sampling used for this statement (level=2)
 EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

--인덱스를 사용한 경우
--실행계획을 통해 분석을 하면
--empno가 7369인 직원을 index를 통해 매우 빠르게 인덱스에 접근
--같이 저장되어 있는 rowid 값을 통해서 table에 접근을 한다
--table에서 읽은 데이터는 7369사번 데이터 한검나 조회를 하고
--나머지 13건에 대해서는 읽지 않고 처리

SELECT *
FROM table (dbms_xplan.display);  
Plan hash value: 2949544139
 
--------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    38 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    38 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7369) --필터는 걸러내고 씀, 엑세스는 접근할떄 씀 
   
   