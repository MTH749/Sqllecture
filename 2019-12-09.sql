---PRMARY KEY ���� : UNIQUE + NOT NUL

--UNIQUE : �ش� �÷��� ������ ���� �ߺ��� �� ����
            (EX : emp ���̺��� deptno(���)
                  dept ���̺��� deptno(�μ���ȣ)
                  �ش� �÷��� null���� �� �� �ִ�
                  NOTNULL : ������ �Է½� �ش� �÷��� ���� �ݵ�� ���;� �Ѵ�
                    
 -- �÷� ������ PRIMARY ���� ����
--����Ŭ�� �������� �̸��� ���Ƿ� ���� *(SYS-c000701)
CREATE TABLE dept_test (
 deptno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY;
 
 --PAIRWISE : ���� ����
 --����� PRIMARY KEY ���� ������ ��� �ϳ��� �÷��� ���������� ����
 --���� �÷��� �������� PRIMARY KEY �������� ���� �� �� �մ�
 --�ش� ����� ���� �ΰ��� ����ó�� �÷� ���������� ���� �� �� ����.
 --> TABLE LEVEL ���� ���ǻ���
 
 --������ ������  dept_test ���̺� ����(drop)
DROP TABLE dept_test;

--�÷������� �ƴ�, ���̺� ������ �������� ����
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),-- ������ �÷� ������ �ĸ� ������ �ʱ�
  
    --deptno,dname �÷��� ������ ������(�ߺ���) �����ͷ� �ν�
    CONSTRAINT pk_dept_test PRIMARY KEY(deptno,dname)
    );
--�μ���ȣ, �μ��̸� ���������� �ߺ� �����и� ����
--�Ʒ� �ΰ��� insert ������ �μ���ȣ�� ������
--�μ����� �ٸ��Ƿ� ���� �ٸ� �����ͷ� �ν� --> INSERT ����

INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (99, '���', '����');

SELECT *
FROM dept_test;

--�ι�° INSERT ������ Ű���� �ߺ��ǹǷ� ����
INSERT INTO dept_test VALUES ('99', '���', '����');

--NOT NULL ��������
--�ش� �÷��� NULL���� ������ ���� ������ �� ���
--dname �÷��� null ���� ������ ���ϵ��� NOT NULL ���� ���� ����
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) NOT NULL,
    loc VARCHAR2(13)
    );

--deptno �÷��� primary key ���࿡ �ɸ��� �ʰ�
--loc �÷��� nulltable �̱� ������ null ���� �Է� �� �� �ִ�
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');

--deptno �÷��� primary ���࿡ �ɸ��� �ʰ�(�ߺ��� ���� �ƴϴϱ�)
--dname �÷��� NOT NULL ���� ������ ����
INSERT INTO dept_test VALUES (99, '���', '����');

SELECT *
FROM dept_test;

--���� ������ ���̺� ���� (drop)
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    --CONSTRINT pk_dept_test PRIMARY KEY  (deptno, dname)
    --CONSTRAINT NM_dname NOT NULL (dname) : ������ �ʴ´�.
);    
--1.�÷�����
--2.�÷����� �������� �̸� ���̱�
--3.���̺� ����
--[4.���̺� ������ �������� ����]

--UNIQUE ���� ����
--�ش� �÷��� ���� �ߺ��Ǵ� ���� ����
--�� NULL ���� ���
--GLOBAL solution �� ��� ������ ���� ���� ������ �ٸ��� ������
--pk ���ຸ�ٴ� UNIQUE ������ ����ϴ� ���̸�, ������ ���� ������
--APPICATION �������� üũ �ϵ��� ���� �ϴ� ������ �ִ�


--�÷����� unique ���� ����
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) UNIQUE,
    loc VARCHAR2(13)
);

--�ΰ��� Inser ������ ���� dname�� ���� ���� �Է��ϱ� ������
--dname �÷��� ����� UNIQUE ���࿡ ���� �ι��� ������ ���������� ���� �� �� ����
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '����');

--���� ���̺� ����
drop table dept_test;

--���̺� ���� unique ���� ����
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT IDX_U_dept_test_dname UNIQUE (dname)
);

--�ΰ��� Inser ������ ���� dname�� ���� ���� �Է��ϱ� ������
--dname �÷��� ����� UNIQUE ���࿡ ���� �ι��� ������ ���������� ���� �� �� ����
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '����');

SELECT *
FROM dept_test;

--FOREIGN KEY ���� ����
--�ٸ� ���̺� �����ϴ� ���� �Է� �� �� �ֵ��� ����
--dept_test ���̺� ����
DROP TABLE dept_test;

--dept_test ���̺� ����( deptno �÷� PRIMARY KEY ����)
--dpet ���̺�� �÷��̸�, Ÿ�� �����ϰ� ����
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2 (14),
    loc VARCHAR2 (13)
);    
INSERT INTO dept_test VALUES(99,'ddit','daejeon');

DESC emp;

--empno, ename, deptno : emp_test
--empno PRIMARY KEY
--deptno dept_test.deptno FOREIGN KEY

--�÷� ���� FOREIGN KEY
CREATE TABLE emp_test (
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2 (10),
    deptno NUMBER(2) REFERENCES dept_test (deptno) );

--dept_test ���̺� �����ϴ� deptno�� ���� �Է�
INSERT INTO emp_test VALUES (9999, 'brown', 99);

--dept_test ���̺� �������� �ʴ� deptno �� ���� �Է�
INSERT INTO emp_test VALUES (9998, 'sally', 98);

--�÷� ���� FOREIGN KEY (���� ���� �� �߰�)
CREATE TABLE emp_test (
    empno NUMBER(4) PRIMARY KEY,
    --empno NUMBER(4) CONSTRAINT ���� ���� �̸� PRIMARY KEY
    ename VARCHAR2 (10),
    
    --deptno NUMBER(2) REFERENCES dept_test (deptno)
    deptno NUMBER(2),
    
    CONSTRAINT fk_dept_test FOREIGN KEY (deptno)
    REFERENCES dept_test (deptno) );
--dept_test ���̺� �����ϴ� deptno�� ���� �Է�
INSERT INTO emp_test VALUES (9999, 'brown', 99);

--dept_test ���̺� �������� �ʴ� deptno �� ���� �Է�
INSERT INTO emp_test VALUES (9998, 'sally', 98);

--�μ������� ������� ������� �ϴ� �μ���ȣ�� �����ϴ� ���� ������ ���� �Ǵ� deptno �÷��� nulló��
--EMP -> DEPT

DELETE dept_test
WHERE deptno = 99;

--FOREIGN KEY OPTION -ON DELETE CASCADE


CREATE TABLE emp_test (
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2 (10),
    deptno NUMBER(2),
    
    CONSTRAINT fk_dept_test FOREIGN KEY (deptno)
    REFERENCES dept_test (deptno) ON DELETE CASCADE );
--dept_test ���̺� �����ϴ� deptno�� ���� �Է�
INSERT INTO emp_test VALUES (9999, 'brown', 99);

--������ �Է� Ȯ��
SELECT *
FROM emp_test;
SELECT *
FROM dept;

--ON DELETE CASCADE �ɼǿ� �ٶ� dept �����͸� ������ ���
--�ش� �����͸� �����ϰ� �ִ� EMP ���̺��� ��� �����͵� ���� �ȴ�
DELETE dept_test
WHERE deptno = 99;
ROLLBACK;

--���� ���̺� ����
DROP TABLE emp_test;

--FOREIGN KEY OPTION -ON DELETE SET NULL
CREATE TABLE emp_test (
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2 (10),
    deptno NUMBER(2),
    
    CONSTRAINT fk_dept_test FOREIGN KEY (deptno)
    REFERENCES dept_test (deptno) ON DELETE SET NULL );
--dept_test ���̺� �����ϴ� deptno�� ���� �Է�
INSERT INTO emp_test VALUES (9999, 'brown', 99);
commit;
--������ �Է� Ȯ��
SELECT *
FROM emp_test;
SELECT *
FROM dept_test;

--ON DELETE CASCADE �ɼǿ� ���� dept �����͸� ������ ���
--�ش� �����͸� �����ϰ� �ִ� EMP ���̺��� ��� �����͵� ���� �ȴ�
DELETE dept_test
WHERE deptno = 99;
ROLLBACK;

--CHECK ���� ����
--�÷��� ���� ���� ������ ��
-- EX : �޿� �÷����� ���� 0���� ū ���� ������ üũ
--      ���� �÷����� ��/ �� Ȫ�� F/M ���� ������ ����

--emp_test ���̺� ����
DROP TABLE emp_test;

--emp_test ���̺� �÷�
--empno NUMBER(4)
--ename VARCHAR
--sal NUMBER(7,2) - 0���� ū ���ڸ� �Էµǵ��� ����
--emp_gb VARCHAR(2) -- ���� ���� 01 - ������, 02 - ����
desc emp;

CREATE TABLE emp_test(
        empno NUMBER(4) PRIMARY KEY,
        ename VARCHAR2(10),
        sal NUMBER (7,2) CHECK (sal > 0),
        emp_gb VARCHAR2(2) CHECK (emp_gb IN ('01', '02') ) );
--emp_test ������ �Է�      
--sal �÷� check ���� ����(sal>0)�� ���ؼ� �������� �Է� �� �� ����
INSERT INTO emp_test VALUES (9999 , 'brown' , -1 ,'01');

--check �������ǿ� ���� ���� �����Ƿ� ���� �Է� (sal , emp_gb)
INSERT INTO emp_test VALUES (9999 , 'brown' , 1000 , '01');

--emp_gb check ���ǿ� ���� (emp_gb IN ('01','02'))
INSERT INTO emp_test VALUES (9999 , 'brown' , 1000 , '03');

--emp_gb check ���ǿ� ���� (emp_gb IN ('01','02'))
INSERT INTO emp_test VALUES (9999 , 'brown' , 1000 ,'02');

--CHECK ���� ���� �������� �̸� ����
CREATE TABLE emp_test(
        empno NUMBER(4) PRIMARY KEY,
        --empno NUMBER(4) CONSTRAINT ���� ���Ǹ� PRIMAY KEY,
        
        ename VARCHAR2(10),
        
        --sal NUMBER (7,2) CHECK (sal > 0),
        sal NUMBER (7,2) CONSTRAINT C_SAL CHECK (sal > 0),
        
        --emp_gb VARCHAR2(2) CHECK (emp_gb IN ('01', '02') ) );
        emp_gb VARCHAR2(2) CONSTRAINT C_EMP_GB CHECK (emp_gb IN ('01', '02') ) );
--emp_test ������ �Է�      
--sal �÷� check ���� ����(sal>0)�� ���ؼ� �������� �Է� �� �� ����
INSERT INTO emp_test VALUES (9999 , 'brown' , -1 ,'01');

--check �������ǿ� ���� ���� �����Ƿ� ���� �Է� (sal , emp_gb)
INSERT INTO emp_test VALUES (9999 , 'brown' , 1000 , '01');

--emp_gb check ���ǿ� ���� (emp_gb IN ('01','02'))
INSERT INTO emp_test VALUES (9999 , 'brown' , 1000 , '03');

--emp_gb check ���ǿ� ���� (emp_gb IN ('01','02'))
INSERT INTO emp_test VALUES (9999 , 'brown' , 1000 ,'02');

--table level CHECK ���� ���� �������� �̸� ����
CREATE TABLE emp_test(
        empno NUMBER(4) PRIMARY KEY,   
        ename VARCHAR2(10),
        sal NUMBER (7,2),
        emp_gb VARCHAR2(2),
        CONSTRAINT nm_ename CHECK (ename IS NOT NULL),
        CONSTRAINT C_SAL CHECK (sal > 0),
        CONSTRAINT C_EMP_GB CHECK (emp_gb IN ('01', '02') )
        );

--���̺� ���� : CREATE TABLE ���̺�� ( �÷� �÷� Ÿ�� .....);
--���� ���̺��� Ȱ���ؼ� ���̺� �����ϱ�
--CREATE TABLE AS : CTAS (��Ÿ��)
--  CREATE TABLE ���̺�� [(�÷�1, �÷�2, �÷�3....)]  AS SELECT col1, col2 ......
--                        FROM �ٸ� ���̺��             
--                        WHERE ����

-- emp ���̺��� �����͸� �����ؼ� emp_test ���̺��� ����
CREATE TABLE emp_test AS
        SELECT *
        FROM emp;

emp- emp -test = ������
emp_test- emp = ������;

SELECT *
FROM emp_test;
INTERSECT
SELECT *
FROM emp;



--emp ���̺��� �����͸� �����ؼ� emp_test ���̺��� �÷����� �����Ͽ� ����
CREATE TABLE emp_test (c1 , c2 , c3 , c4 , c5 ,c6 , c7, c8) AS
        SELECT *
        FROM emp;
        
--�����ʹ� �����ϰ� ���̺��� ��ü (�÷� ����) �� �����Ͽ� ���̺� ����
CREATE TABLE emp_test AS
        SELECT *
        FROM emp
        WHERE 1=2;
        
--empno, ename, deptno �÷����� emp_test ����

CREATE TABLE emp_test  AS
        SELECT empno, ename, deptno
        FROM emp
        WHERE 1= 2;

SELECT *
FROM emp_test;

-- emp_ test ���̺� �ű� �÷� �߰�
-- hp VARCHAR2 (20) DEFAULT '010'
--ALTER TABLE ���̺�� ADD (�÷��� �÷� Ÿ�� [default value]);

ALTER TABLE emp_test ADD ( hp VARCHAR2(20) DEFAULT '010');

SELECT *
FROM emp_test;

--���� �÷� ����
--ALTER TABLE ���̺�� MODIFY ( �÷� �÷� Ÿ�� [default value]);
--hp �÷��� Ÿ���� VARHAR2(20) -> VARCHAR2(30)

ALTER TABLE  emp_test MODIFY (hp VARCHAR2(30));

--���� emp_test ���̺� �����Ͱ� ���� ������ �÷� Ÿ���� �����ϴ� ���� �����ϴ�
--hp �÷��� Ÿ���� VARHAR2(20) -> NUMBER
ALTER TABLE  emp_test MODIFY (hp NUMBER);

DESC emp_test;

--�÷��� ����
--�ش� �÷��� pk, unique, not null, check ���� ���ǽ� ����� �÷��� ���ؼ��� �ڵ������� ������ �ȴ�
--hp �÷� hp_ n
--ALTER TABLE ���̺�� RENAME COLUMN ���� �÷Ÿ� to ������ �÷���
ALTER TABLE emp_test RENAME COLUMN hp TO hp_n;

--�÷� ����
--ALTER TABLE ���̺�� DROP (�÷�);
--ALTER TABLE ���̺�� DROP COLUMN �÷�;
-- hp_n �÷� ����
ALTER TABLE emp_test DROP (hp_n);
ALTER TABLE emp_test DROP COLUMN hp_n;

--���� ���� �߰�
--ALTER TABLE ���̺� �� ADD --���̺� ���� �������� ��ũ��Ʈ
--emp _test ���̺��� empno �÷��� pk �������� �߰�

ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY (empno);

--���� ���� ����
--ALTER TABLE ���̺� �� DROP CONSTRAINT ���� ���� �̸�;
--emp_test ���̺��� PRIMARY ���� ������ pk_emp_test ���� ����
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;

--���̺� �÷�, Ÿ�� ������ ���������γ��� ����
--���̺��� �÷� ������ �����ϴ� ���� �Ұ��� �ϴ�
--empno, ename, job --> empno job, ename

ALTER TABLE emp ORDER BY EMPNO asc;

SELECT *
FROM emp;

