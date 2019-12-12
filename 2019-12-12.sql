--��Ī : ���̺� �÷��� �ٸ� �̸����� ��Ī
-- [AS] ��Ī ��
--SELECT empno [AS] eno
--FROM emp e

--SYNONYM (���Ǿ�)
--����Ŭ ��ü�� �ٸ� �̸����� �θ� �� �ֵ��� �ϴ°�
--���࿡ emp���̺��� e��� �ϴ� synonym(���Ǿ�)�� ������ �ϸ�
--������ ���� SQL�� �ۼ� �� �� �ִ�
--SELECT *
--FROM e;

SELECT *
FROM hr.employees;

--synonym ����
--CREATE [public] SYNONYM synonym_name for object;

--������ SYNONYM ���� ������ �ο�
GRANT CREATE SYNONYM TO mth;  

--emp ���̺��� ����Ͽ� synonym e�� ����
CREATE SYNONYM e for emp;

--emp��� ���̺� �� ��ſ� e ���� �ϴ� �ó���� ����Ͽ� ������ �ۼ� �� �� �ֵ�.

SELECT *
FROM emp;

SELECT *
FROM e;

--mth ������ fastfood ���̺��� hr ���������� �� �� �ֵ��� ���̺� ��ȸ ������ �ο�
GRANT SELECT ON fastfood TO hr;

--��� ����
--DML 
--    SELECT / INSERT / UPDATE / DELETE / INSERT ALL / MERGE
--TCL 
--    COMMIT / ROLLBACK / {SAVEPOINT}
--
--DDL
--    CREATE ��ü
--    ALTER
--    DROP
--    
--DCL
--    GRANT / REVOKE

--������ SQL ���信 ������....

SELECT /* 201911_205  */ * FROM emp;
SELECT /* 201911_205  */ * FROM EMP;
SELEct /* 201911_205  */ * FROM EMP;

SELEct /* 201911_205  */ * FROM EMP WHERE  empno =7369;
SELEct /* 201911_205  */ * FROM EMP WHERE  empno =7499;
SELEct /* 201911_205  */ * FROM EMP WHERE  empno = :empno;

--mulitple insert

--emp ���̺��� empno,ename �÷����� emp_test, emp_test2 ���̺��� ����
--(CATS, �����͵� ���� ����

CREATE TABLE emp_test AS
SELECT empno, ename
FROM emp;

CREATE TABLE emp_test2 AS
SELECT empno, ename
FROM emp;

SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;

--ubconditional insert
--���� ���̺� �����͸� ���� �Է�
--brown, cony �����͸� emp_test, emp_test2 ���̺� ���ÿ� �Է�
INSERT ALL 
    INTO emp_test
    INTO emp_test2
SELECT 9999,'brown' FROM DUAL UNION ALL    
SELECT 9998,'cony' FROM DUAL;

SELECT *
FROM emp_test
WHERE empno > 9000

UNION ALL

SELECT *
FROM emp_test2
WHERE empno > 9000;    

--���̺� �ԷµǴ� �������� �÷��� ���� ����

INSERT ALL 
    INTO emp_test (empno, ename) VALUES (eno, enm)
    INTO emp_test2 (empno) VALUES (eno)
SELECT 9999 eno,'brown' enm FROM DUAL UNION ALL    
SELECT 9998,'cony' FROM DUAL;    
    
--CONDITIONAL INSERT
--���ǿ� ���� ���̺� �����͸� �Է�
/*
    CASE
         WHER ���� THEN --- //�ڹ��� ��� IF
         WHER ���� THEN ---              ELSE IF 
         ELSE --                         ELSE
*/

INSERT ALL
    WHEN eno > 9000 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)
    WHEN eno > 9500 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)    
    ELSE    
        INTO emp_test2 (empno) VALUES (eno)
SELECT 9999 eno,'brown' enm FROM DUAL UNION ALL    
SELECT 8998,'cony' FROM DUAL;   

rollback;

SELECT *
FROM emp_test
WHERE empno > 9000

UNION ALL

SELECT *
FROM emp_test2
WHERE empno > 8000;



INSERT FIRST
    WHEN eno > 9000 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)
    WHEN eno > 9500 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)    
    ELSE    
        INTO emp_test2 (empno) VALUES (eno)
SELECT 9999 eno,'brown' enm FROM DUAL UNION ALL    
SELECT 8998,'cony' FROM DUAL;   

rollback;