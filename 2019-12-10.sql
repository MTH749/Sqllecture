--���� ���� Ȱ��ȭ / ��Ȱ��ȭ
--ALTER TABLE ���̺�� ENABLE OR DISABLE ���� ���Ǹ�;

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME  = 'DEPT_TEST';

ALTER TABLE  dept_test DISABLE CONSTRAINT sys_c007141;


SELECT *
FROM dept_test;

--dept_test ���̺��� deptno �÷��� ���뵵�� PRIMATY KEY �������� ��Ȱ��ȭ �Ͽ�
--������ �μ���ȣ�� ���� �����и� �Է��� �� �ִ�.
INSERT INTO dept_test VALUES (99,'ddit','daejeon');
INSERT INTO dept_test VALUES (99,'DDIT','����');

--dept_tset ���̺��� PRIMARY KEY �������� Ȱ��ȭ
--�̹� ������ ������ INSERT ������ ���� ���� �μ���ȣ�� ���� �����Ͱ�
--���� �ϱ� ������ PRIMARY KEY ���� ������ Ȱ��ȭ �� �� ����.
--Ȱ��ȭ �Ϸ��� �ߺ������и� �����ؾ� �Ѵ�
ALTER TABLE  dept_test ENABLE CONSTRAINT sys_c007141;

--�μ���ȣ�� �ߺ��Ǵ� �����͸� ��ȸ �Ͽ�
--�ش� �����Ϳ� ���� ������ PRIMARY KEY ���������� Ȱ��ȭ �� �� �ִ�
SELECT deptno, COUNT(*)
FROM dept_test
GROUP BY deptno
HAVING COUNT (*) >= 2;

--table_name, constraint_name , column_name
--position ���� (ASC)
SELECT *
FROM user_constraints
WHERE table_name = 'BUYER';

SELECT *
FROM user_cons_columns;

--���̺� ���� ����(�ּ�) VIEW
SELECT *
FROM USER_TAB_COMMENTS;

--���̺� �ּ�
--COMMENT ON TABLE ���̺�� IS '�ּ�';
COMMENT ON TABLE dept IS '�μ�';

--�÷��ּ�
--COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�';
COMMENT ON COLUMN dept.deptno IS '�μ���ȣ';
COMMENT ON COLUMN dept.dname IS '�μ���';
COMMENT ON COLUMN dept.loc IS '�μ���ġ ����';

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'DEPT';

--comment1
--CUSTOMER','PRODUCT', 'CYCLE', 'DAILY' ���̺�� �÷��� �ּ� ������ ��ȸ�ϴ� ������ �ۼ��϶�
SELECT c.TABLE_NAME, c.TABLE_TYPE,c.COMMENTS TAB_COMMENT ,m.COLUMN_NAME ,m.COMMENTS COL_COMMENT
FROM user_tab_comments c,user_col_comments m
WHERE c.table_name = m.table_name
AND c.table_name IN ('CUSTOMER','PRODUCT', 'CYCLE', 'DAILY'); --���̺� �̸��� ����Ŭ������ ��ҹ��ڷ� ������

--VIEW : QUERY�̴� (O)
--���̺�ó���� �����Ͱ� ���������� �����ϴ� ���� �ƴϴ�.
--���� �����ͼ� = QUERY
--VIEW�� ���̺��̴� (x)

--VIEW ����
--CREATE OR REPLACE VIEW �� �̸� [(�÷���Ī1 , �÷���Ī 2....)} AS
--SUBQUERY

--emp ���̺��� sal, comm �÷��� ������ ������ 6�� �÷��� ��ȸ�� �Ǵ� VIEW��  V_EMP �̸����� ����
--VIEW�� ���� �Ϸ��� system �������� ������ ��������� �Ѵ�
CREATE OR REPLACE VIEW V_EMP AS
SELECT empno,ename,job ,mgr ,hiredate, deptno
FROM emp;

-- VIEW�� ���� ������ ��ȸ
SELECT *
FROM v_emp;

--INLINE VIEW
SELECT *
FROM (SELECT empno, ename, job, mgr, hiredate, deptno
        FROM emp);
        
 --emp ���̺��� �����ϸ� view�� ������ ������
 --KING�� �μ���ȣ�� ���� 10��
 --emp ���̺��� KING �μ���ȣ �����͸� 30������ ����
 --v_emp ���̺��� KING�� �μ���ȣ�� ����
 UPDATE emp SET deptno = 30
 WHERE ename = 'KING';

--���ε� VIEW �� ����
CREATE OR REPLACE VIEW v_emp_dept AS
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;


-- emp ���̺��� KING ������ ����
DELETE emp
WHERE ename = 'KING';
rollback;

SELECT *
FROM emp;

--emp ���̺��� KING ������ ������ V_emp_dept view ��ȸ ��� Ȯ��
SELECT *
FROM v_emp_dept;

--INLINE VIEW
SELECT *
FROM   (SELECT emp.empno, emp.ename, dept.deptno, dept.dname
        FROM   emp, dept
        WHERE  emp.deptno=dept.deptno);
        
--VIEW ����
--v_emp ����
DROP VIEW v_emp_dept;

--�μ��� ������ �޿� �հ�
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
--����Ŭ ��ü�� �ߺ����� �ʴ� ���� ���� �������ִ� ��ü
--CREATE SEQUENCE �������� [�ɼ�... ] 

CREATE SEQUENCE seq_board; 

--������ ����� : ��������.nextval
SELECT seq_board.nextval
FROM dual;

SELECT seq_board.currval
FROM dual;

--������ ����� : ��������.nextval
--������ = ����
SELECT TO_CHAR (sysdate, 'YYYYMMDD') || '-'|| seq_board.nextval
FROM dual;

--emp ���̺� empno �÷����� PRIMARY KEY ���� ���� : pk_emp;
--dept ���̺� deptno �÷����� PRIMARY KEY ���� ���� : pk_dept;
--emp ���̺��� empno �÷��� dpet ���̺��� deptno �÷��� �����ϵ���
--FOREIGN KEY ���� �߰� : fk_dept_deptno
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT dept PRIMARY KEY (deptno);
ALTER TABLE emp ADD CONSTRAINT fk_dept_deptno FOREIGN KEY (deptno) REFERENCES dept(deptno);

-- emp_test ���̺� ����
DROP TABLE emp_test;

--emp ���̺��� �̿��Ͽ� emp_test ���̺� ����
CREATE TABLE emp_test AS
SELECT *
FROM emp;

SELECT rowid, rownum, emp.*
FROM emp;

--emp_test ���̺��� �ε����� ���� ����
--���ϴ� �����͸� ã�� ���ؼ��� ���̺��� �����͸� ��� �о���� �Ѵ�
EXPLAIN PLAN FOR
SELECT *
FROM emp_test
WHERE empno = 7369;

SELECT *
FROM table (dbms_xplan.display);

--�ε����� ������� ���� ���
 --�����ȹ�� ���� 7369�� ����� ���� ���� ������ ��ȸ�ϱ� ����
 --���̺��� ��� ������(14��)�� �о ������ ����� 7369�� �����͸� �����Ͽ�
 --����ڿ��� ��ȯ
 --13���� �����ʹ� ���ʿ��ϰ� ��ȸ�� ����
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

--�ε����� ����� ���
--�����ȹ�� ���� �м��� �ϸ�
--empno�� 7369�� ������ index�� ���� �ſ� ������ �ε����� ����
--���� ����Ǿ� �ִ� rowid ���� ���ؼ� table�� ������ �Ѵ�
--table���� ���� �����ʹ� 7369��� ������ �Ѱ˳� ��ȸ�� �ϰ�
--������ 13�ǿ� ���ؼ��� ���� �ʰ� ó��

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
 
   2 - access("EMPNO"=7369) --���ʹ� �ɷ����� ��, �������� �����ҋ� �� 
   
   