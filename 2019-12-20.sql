--hash join
SELECT *
FROM dept, emp
WHERE dept.dptno = emp.deptno;

--detp ���� �д� ����
--join �÷��� hash �Լ��� ������ �ش� hash �Լ��� �ش��ϴ� bucket�� �����͸� �ִ´�
--10 --->> aabbaa

--emp ���̺� ���� ���� ������ �����ϰ� ����
--10 -->> ccc1122 (haschvalue)

SELECT *
FROM dept, emp
WHERE emp.deptno BETWEEN dept.deptno AND 99;

--10 --> AAAAA
--20 --> AAAAB

--��ü���� ó��
SELECT count(*) 
FROM emp;

--�����ȣ, ����̸�,�μ���ȣ,�޿�,�μ����� ��ü �޿���

SELECT empno, ename, deptno, sal,
       SUM(sal) OVER (ORDER BY sal
       ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_SUM,  --���� ó������ ���������
       
       --�ٷ� �������̶� ����������� �޿���
       SUM(sal) OVER(ORDER BY sal ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) c_sum2 
FROM emp
ORDER BY sal;

SELECT empno, ename, deptno, sal,
       SUM(sal) OVER(PARTITION BY deptno ORDER BY sal,empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum
FROM emp;

--ROWS vs RANGE ���� Ȯ���ϱ�

SELECT empno, ename, deptno, sal,
        SUM (sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING) rows_sum,
        SUM (sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING) range_sum,
        SUM (sal) OVER (ORDER BY sal) range_sum

FROM emp;


-- PL/SQL
-- PL/SQL �⺻ ����
-- DECLARE : �����, ������ ����
-- BEGIN   : PL/SQL�� ������ ���� �κ�
-- EXCEPTION :���� ó�� ��

-- DBMS.OUTPUT.PUT_LINE �Լ��� ����ϴ� ����� ȭ�鿡 �����ֵ��� Ȱ��ȭ
SET SERVEROUTPUT ON; 
DECLARE -- �����
     -- jva : Ÿ�� ������;
     -- pl/sql : ������ Ÿ��;
--     v_dname varchar2(14);
--     v_loc varchar2(13);
        --���̺� �÷��� ���Ǹ� �����Ͽ� ������ Ÿ���� �����Ѵ�
        v_dname dept.dname %TYPE;
        v_loc dept.loc %TYPE;
BEGIN 
    --DEPT ���̺��� 10�� �μ��� �μ��̸�,LOC ������ ��ȸ
    SELECT dname, loc
    INTO v_dname, v_loc
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_dname || v_loc); 
END;
/ 
--PL/SQL ����� ����

--10�� �μ��� �μ��̸�, ��ġ������ ��ȸ�ؼ� ������ ���
--������ DBMS_OUTPUT.PUT_LINE�Լ��� �̿��Ͽ� console�� ���
CREATE OR REPLACE PROCEDURE printdept IS 
--�����(�ɼ�
    dname dept.dname %TYPE;
    loc dept.loc %TYPE;
--�����
BEGIN
    SELECT dname, loc
    INTO dname,loc
    FROM dept
    WHERE deptno =10;
--����ó��(�ɼ�)
    DBMS_OUTPUT.PUT_LINE(dname || ' ' || loc);
END;
/

exec printdept;

CREATE OR REPLACE PROCEDURE printdept  
--(�Ķ���͸� IN/OUT Ÿ��)
--P_�Ķ�����̸�
(p_deptno IN dept.deptno%TYPE)
IS
--�����(�ɼ�
    dname dept.dname %TYPE;
    loc dept.loc %TYPE;
--�����

BEGIN
    SELECT dname, loc
    INTO dname,loc
    FROM dept
    WHERE deptno = p_deptno;
--����ó��(�ɼ�)
    DBMS_OUTPUT.PUT_LINE(dname || ' ' || loc);
END;
/

exec PRINTDEPT(40);

CREATE OR REPLACE PROCEDURE printtemp
(p_empno IN emp.empno%TYPE)
IS 
    ename varchar2(10);
    dname varchar2(14);
    
BEGIN
    SELECT ename,dname
    INTO ename,dname
    FROM emp,dept
    WHERE emp.deptno = dept.deptno
    AND emp.empno = p_empno;
    DBMS_OUTPUT.PUT_LINE( ename || ' ' || dname);
END;
/

exec printtemp(7788);

CREATE OR REPLACE PROCEDURE registdept_test
(p_deptno IN dept.deptno%type,
 p_dname IN dept.dname%type,
 p_loc IN dept.loc%type)
 
IS
    deptno number(2);
    dname varchar2(14);
    loc   varchar2(13);
BEGIN
    INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
    commit;
    
    DBMS_OUTPUT.PUT_LINE (deptno || ' ' || dname || ' ' || loc);
 
 END;
 /

exec registdept_test (99,'ddit' ,'daejeon');

SELECT *
FROM dept_test;

DELETE dept_test
WHERE deptno = 99;