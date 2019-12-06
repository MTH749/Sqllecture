SELECT *
FROM dept;
-- dept ���̺� �μ���ȣ 99, �μ��� 'ddit' ��ġ�� daejeon
INSERT INTO dept VALUES (99,'ddit','Daejeon');


DESC dept;

--UPDATE : ���̺� ����� �÷��� ���� ����
--UPDATE ���̺�� SET �÷Ÿ� = �����Ϸ��� �ϴ� ��
--UPDATE ���̺�� SET �÷Ť�1 = �����Ϸ��� �ϴ� ��1, �÷���2  = �����Ϸ��� �ϴ� ��2...
--[WHERE row ��ȸ ����] --��ȸ���ǿ� �ش��ϴ� �����͸� ������Ʈ�� �ȴ�

--�μ���ȣ�� 99�� �μ��� �μ����� ���it�� ������ ���κ������� ����


UPDATE dept SET dname = '���it', loc = '���κ���'
WHERE deptno =99;


--������Ʈ���� ������Ʈ �Ϸ��� �ϴ� ���̺��� WHERE���� ����� �������� SELECT �Ͽ� ������Ʈ ��� ROW�� Ȯ���� ����

SELECT *
FROM dept
WHERE deptno = 99;

--���� QYERY�� �����ϸ� WHERE���� ROW ���� ������ ���� ������
--dept  ���̺��� ��� �࿡ ���� �μ���, ��ġ ������ �����Ѵ�
UPDATE dept SET dname = '���it', loc = '���κ���';

--SUBQUERY�� �̿��� UPDATE
--emp ���̺� �ű� ������ �Է�
--�����ȣ 9999, ��� �̸� brown, ���� : NULL


INSERT INTO emp (empno,ename) VALUES (9999,'brown');

SELECT *
FROM emp;
WHERE ename  = 'SMITH';
--�����ȣ�� 9999�� ��� �Ҽ� �μ���, �������� SMITH ����� �μ�, ������ ������Ʈ

UPDATE emp SET deptno =(SELECT deptno FROM emp WHERE ename = 'SMITH') , job =(SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno =9999;

commit;

--DELETE : ���ǿ� �ش��ϴ� ROW �� ����
--�÷��� ���� ����?? (NULL)������ �����Ϸ��� -->> UPDATE

--DELETE ���̺��
--[WHERE ����]

--UPDATE QUERY�� ���������� DELETE QUERY ���������� �ش� ���̺��� WHERE ������ �����ϰ� �Ͽ�
--SELECT�� ����, ������ ROW�� ���� Ȯ���غ���

--emp ���̺� �����ϴ� �����ȣ 9999�� ����� ����

DELETE emp
WHERE empno =9999;

SELECT *
FROM emp;
WHERE empno =9999;
commit;

--�Ŵ����� 7698�� ��� ����� ����

DELETE emp
WHERE empno IN ( SELECT empno 
                  FROM emp 
                  WHERE mgr = 7698);
--�� ������ �Ʒ��� ����
DELETE emp
WHERE mgr = 7698;


SELECT *
FROM emp
WHERE mgr = 7698;

-- DDL : TABEL ����
-- CREATE TABLE [����ڸ�.]���̺��(
--            �÷���1 �÷�Ÿ��1,
--            �÷���1 �÷�Ÿ��2, .....
--            �÷���n �÷�Ÿ��n);

DESC ranger;
--ranger_no NUMBER       : ������ ��ȣ
--ranger_rm VARCAAR2(50) : ������ �̸�
--reg_dt DATE            :������ �������
-- ���̺� ���� DDL : Data Defination Language (������ ���Ǿ�)
--DDL rollback�� ���� (�ڵ� Ŀ�� �ǹǷ� �ѹ� �� �� ����)
CREATE TABLE ranger (
    ranger_no NUMBER,
    ranger_rm VARCHAR2(50),
    reg_dt DATE);
    
DESC ranger;

--DDL ������ ROLLBACK ó���� �Ұ�
ROLLBACK;

SELECT *
FROM user_tables
WHERE table_name = 'RANGER';

--WHERE tabe_name - 'ranger';
--����Ŭ������ ��ü ������ �ҹ��ڷ� �����ϴ���
--���������δ� �빮�ڷ� �����ȴ�.

INSERT INTO ranger VALUES ( 1, 'brown', sysdate);

--�����Ͱ� ��ȸ�Ǵ� ���� Ȯ��
SELECT *
FROM ranger;

--DML ���� DDL�� �ٸ��� ROLLBACK�� �����ϴ�
ROLLBACK;

--ROLLBACK�� �߱� ������ DML ������ ��ҵȴ�.
SELECT *
FROM ranger;

--DATE Ÿ�Կ��� �ʵ� �����ϱ�
--EXTRACT (�ʵ�� FROM �÷�/ expression)
SELECT TO_CHAR (SYSDATE, 'yyyy') yyyy,
       TO_CHAR (SYSDATE, 'MM') MM,
       EXTRACT(year FROM SYSDATE) ex_yyyy,
       EXTRACT(year FROM SYSDATE) ex_mm
FROM dual;

--���̺� ������ �÷� ���� �������� ����
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2)PRIMARY KEY ,
    dname VARCHAR2(14),
    loc VARCHAR2(13));
    
--dept_test ���̺��� deptno �÷��� PRIMARY KEY ���� ������ �ֱ� ������
--deptno �� ������ �����͸� �Է��ϰų� ���� �� �� ����.

--���� �������̹Ƿ� �Է¼���
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');

--depte_test �����Ϳ� deptno�� 99���� �����Ͱ� �����Ƿ�
--primary key ���� ���ǿ� ���� �Է� �� �� ����.
--�������� ORA-00001 unique constraint ���� ����
--SYS_c007127 ���� ������ � ���� �������� �Ǵ��ϱ� ����Ƿ�
--���� ���ǿ� �̸��� �ڵ� �꿡 ���� �ٿ��ִ� ���� ���������� ���ϴ�
INSERT INTO dept_test VALUES (99, '���', '����');

--���̺� ������ �������� �̸��� �߰��Ͽ� �� ����
--primary Key : pk_���̺��
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2)CONSTRAINT pk_dept_test PRIMARY KEY ,
    dname VARCHAR2(14),
    loc VARCHAR2(13));

--INSERT ���� ����
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (99, '���', '����');
    

