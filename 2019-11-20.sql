--Ư�� ���̺��� �÷� ��ȸ
--1.DESC ���̺��
--2.SELECT * FROM user_tab_colunm;

--prod ���̺��� �÷���ȸ

DESC prod;

VARCHAR2, CHAR --> ���ڿ�
NUMBER --> ����
CLOB --> Cjaracter LArge OBject, ���ڿ� Ÿ���� ���� ������ ���ϴ� Ÿ��
        --> �ִ������ : VARCHAR2(4000), CLOB : 4GB

DATE --> ��¥ (�Ͻ� = ��, ��, �� + �ð�, ��, ��)

--DATE Ÿ�Կ� ���� ������ �����?
'2019//11/20 09:17:20' + 1 = ?

--USERS ���̺��� ��� �÷��� ��ȸ �غ�����

SELECT * FROM USERS

--userid, usernm, reg_dt ������ �÷��� ��ȸ

SELECT userid, usernm, reg_dt FROM USERS;

--������ ���� ���ο� �÷��� ���� (reg_dt�� ���� ������ �� ���ο� ���� �÷�)
--��Ī : ���� �÷����̳� ������ ���� ������ ���� �÷��� ������ �÷��̸��� �ο�
-- col | express [AS] ��Ī��

SELECT userid, usernm, reg_dt, reg_dt+5 AS after5day From users;

--���� ���, ���ڿ� ��� (oracle = ''  java = ''. "" )
--table�� ���� ���� ���Ƿ� �÷����� ����
--���ڿ� ���� ���� (+,-,/,*)
--���ڿ� ���� ���� (+�� �������� ����) 

SELECT 10 + 5, 'DB SQL ����',
/*userid  '_modified' �����ǿ����� ���ϱ� ������ ����*/
usernm|| 'modified', reg_dt FROM users;

--NULL : ���� �𸣴� ��
--NULL�� ���� ���� ����� �׻� NULL �̴�
--DESC ���̺�� : NOT NULL�� �����Ǿ� �ִ� �÷����� ���� �ݵ�� ���� �Ѵ�

--DELETE ���ʿ��� ������ ����

SELECT * FROM users;

DELETE users
WHERE userid NOT IN ('brown', 'sally', 'cony', 'moon', 'james');
--oracle ���� �̸��� ��ҹ��ڸ� ������

rollback;

commit;

SELECT userid, usernm, reg_dt
FROM users;

--NULL ������ �����غ��� ���� moon�� reg_dt �÷��� null�� ����
UPDATE users SET reg_dt = NULL
WHERE userid = 'moon';

--users ���̺��� reg_dt �÷����� 5���� ���� ���ο� �÷��� ����
--NULL ���� ���� ������ ����� NULL�̴�
SELECT userid, usernm, reg_dt, reg_dt +5 FROM users;

--SELECT2
--1.prod ���̺��� prod_id, prod_name �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
--(�� prod_id -> id, prod_name -> name ���� �÷� ��Ī�� ����)
SELECT prod_id AS id, prod_name name FROM prod;

--2 lprod ���̺��� lprod_gu, lprod_nm �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
--(�� lprod_gu -> gu, lprod_nm -> nm ���� �÷� ��Ī�� ����

SELECT lprod_gu AS gu, lprod_nm nm FROM lprod;

--3.buyer ���̺��� buyer_id, buyer_name �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
--(�� buyer_id -> ���̾���̵�, buyer_name -> �̸� ���� �÷� ��Ī�� ����

SELECT buyer_id AS ���̾���̵�, buyer_name �̸� FROM buyer;

--���ڿ� �÷��� ���� (�÷� || �÷�, '���ڿ����' || �÷�)
--                 (CONCAT (�÷�,�÷�)

SELECT userid, usernm,
       userid|| usernm id_nm,
       CONCAT(userid, usernm) con_id_nm,
       userid || usernm || pass id_nm_pass,
       CONCAT (CONCAT(userid, usernm),pass) con_id_nm_pass
    
FROM USERS;

--����ڰ� ������ ���̺� ��� ��ȸ
SELECT table_name, 'SELECT * FROM ' || table_name ||';' QUERY, -- || �� �̿��ؼ�
       table_name, CONCAT (CONCAT('SELECT * FROM ', table_name), ':') QUERY -- CONCAT �� �̿��ؼ�
FROM user_tables;

SELECT * FROM MEMBER;

-- WHERE : ��������ġ�ϴ��ุ ��ȸ�ϱ� ���� ���
--          �࿡ ���� ��ȸ ������ �ۼ�
-- WHERE�� ������ �ش� �����͵��� ��� �࿡ ��ȸ ��ȸ
SELECT userid, usernm, alias, reg_dt
FROM users
WHERE userid = 'cony' OR userid = 'sally'


--EMP���̺��� ��ü ������ ��ȸ (��� �� (row), �� (colunm)

SELECT    *
FROM EMP;

SELECT *
FROM dept;

--�μ���ȣ(deptno)�� 20���� ũ�ų� ���� �μ����� ���ϴ� ���� ���� ��ȸ
SELECT *    
FROM emp
WHERE deptno >= 20;

--�����ȣ(empno)�� 7700���� ũ�ų� ���� ����� ������ ��ȸ
SELECT
    *
FROM emp
WHERE empno >= 7700;

--����Ի�����(hiredate)�� 1982�� 1�� 1�������� ��� ���� ��ȸ
-- ���ڿ� --> ��¥ Ÿ������ ���� TO_DATE('��¥���ڿ�','��¥���ڿ�����')
--�ѱ� ��¥ ǥ�� : ��~��~��
--�̱� ��¥ ǥ�� : ��~��~�� (01-01-2020)
SELECT empno, ename, hiredate,
        2000no, '���ڿ����' str, TO_DATE('19820101','YYYYMMDD')
FROM emp
WHERE hiredate >= TO_DATE ('1982 0101', 'YYYYMMDD');

--���� ��ȸ (BETWEEN ���۱��� AND �������)
--���۱���, ��������� ����
--����߿��� �޿�(sal)�� 1000���� ũ�ų� ����, 2000���� �۰ų� ���� ��� ������ȸ

-- BETWEEN AND �����ڴ� �ε�ȣ �����ڷ� ��ü ����
SELECT
    *
FROM emp
WHERE sal >= 1000
AND sal  <= 2000;

--where1
SELECT ename,hiredate  
FROM emp
WHERE hiredate
BETWEEN  TO_DATE('19820101','YYYYMMDD')
AND TO_DATE('19830101','YYYYMMDD');

--where2
SELECT ename,hiredate    
FROM emp
WHERE hiredate >= ('19820101')
AND hiredate <=  ('19830101');



