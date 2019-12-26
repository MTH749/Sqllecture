--EXCEPTION
--���� �߻��� ���α׷��� �����Ű�� �ʰ�
--�ش� ���ܿ� ���� �ٸ� ������ ���� ��ų �� �ְ� �� ó���Ѵ�.

--���ܰ� �߻��ߴµ� ����ó���� ���� ��� : pl/sql ����� ������ �԰� ����ȴ�
--�������� SELECT ����� �����ϴ� ��Ȳ���� ��Į�� ������ ���� �ִ� ��Ȳ

--emp ���̺��� ��� �̸��� ��ȸ
SET SERVEROUTPUT ON;
DECLARE
    --��� �̸��� ������ �� �ִ� ����
    v_ename emp.ename%TYPE;
BEGIN
    --14���� select ����� ������ SQL --> ��Į�� ������ ������ �Ұ��ϴ�
    SELECT ename
    INTO v_ename
    FROM emp;
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('�������� select ����� ����');
    WHEN OTHERS THEN
        dbms_output.put_line('WHEN OTHERS');
END;
/

--��������� ����

-- ����Ŭ���� ������ ������ ���� �ǿܿ��� �����ڰ� �ش� ����Ʈ���� �����Ͻ� ��������
-- ������ ���ܸ� ����, ����� �� �ֵ�.
-- ���� ��� SELECT ����� ���� ��Ȳ���� ����Ŭ������ NO_DATA_FOUND ���ܸ� ������
-- �ش� ���ܸ� ��� NO_EMP��� �����ڰ� ������ ���ܷ� ������ �Ͽ� ���ܸ� ���� �� �ִ�.

DECLARE
    -- emp ���̺� ��ȸ ����� ������ ����� ����� ���� ����
    -- ���ܸ� EXEPTION;
    no_emp EXCEPTION;
    v_ename emp.ename%TYPE;
BEGIN
    -- NO_ DATA_FOUND
    BEGIN
        SELECT ename
        INTO V_ename
        FROM emp
        WHERE empno = 7000;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE no_emp; -- java throw new No_EmpException()
    END;
EXCEPTION
    WHEN no_emp THEN
    dbms_output.put_line('NO_EMP');
END;
/

--����� �Է¹޾Ƽ� �ش� ������ �̸��� �����ϴ� �Լ�
-- getEmpEname(7369) --> SMITH

CREATE OR REPLACE FUNCTION getEmpName (p_empno emp.empno%TYPE)
RETURN VARCHAR2 IS
--�����
    v_ename emp. ename%TYPE;
BEGIN
    SELECT ename
    INTO v_ename
    FROM emp
    WHERE empno = p_empno;
    
    RETURN v_ename;
    
END;
/

SELECT getempname (7369)
FROM dual;

SELECT getempname (empno)
FROM emp;

CREATE OR REPLACE FUNCTION getdeptname (p_deptno dept.deptno%TYPE)
RETURN VARCHAR2 IS
    v_dname DEPT.DNAME%TYPE;
BEGIN
    SELECT dname
    INTO v_dname
    FROM dept
    WHERE deptno = p_deptno;
    
    RETURN v_dname;

END;
/

--cache : 20
--������ ������ :
--deptno (�ߺ� �߻�����) : �������� ���� ���ϴ�
--empno (�ߺ��� ����) : �������� ����

--emp ���̺��� �����Ͱ� 100������ ���
--100�� �߿��� deptno�� ������ 4�� (4~10)

SELECT getdeptname (10) 
FROM dual;

SELECT getdeptname (deptno) dname, --4���� 
       getEmpName (empno) ename   --row ����ŭ �����Ͱ� ����
FROM emp;

--------------------------------------------------
CREATE OR REPLACE FUNCTION indent (p_lv NUMBER, p_dname VARCHAR2)
RETURN VARCHAR2 IS
    v_dname VARCHAR2(200);
BEGIN
    SELECT LPAD (' ', (p_lv -1) *4, ' ' ) || p_dname
    INTO v_dname
    FROM dual;
    
    RETURN v_dname;
END;
/

SELECT deptcd, LPAD (' ',(level -1) * 4, ' ' ) || deptnm deptnm
FROM dept_h
START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT deptcd, indent (level, deptnm )deptnm
FROM dept_h
START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;
-----------------------------------------

SELECT *
FROM users;

-- users ���̺��� ��й�ȣ �÷��� ������ ������ ��
--������ ����ϴ� ��й�ȣ �÷� �̷��� �����ϱ� ���� ���̺�
CREATE TABLE users_history(
    userid VARCHAR2 (20),
    pass VARCHAR2 (100),
    mod_dt date
);

CREATE OR REPLACE TRIGGER make_history
    --timing
    BEFORE UPDATE ON USERS
    FOR EACH ROW -- ��Ʈ����, ���� ������ ���� ������ �����Ѵ�
    -- ���� ������ ���� : OLD
    -- ���� ������ ���� : NEW
    
    BEGIN
        --users ���̺��� pass �÷��� ������ �� trigger ����
        IF :OLD.pass !=:NEW.pass THEN
            INSERT INTO users_history
                VALUES (:OLD.userid , :OLD.pass, sysdate);
        END IF;
        -- �ٸ� �÷��� ���ؼ��� �����Ѵ�
    END;
/
drop trigger make_history;
--USERS ���̺��� PASS �÷��� ���� ���� ��
--TRIGGER�� ���ؼ� users_histoy ���̺� �̷��� �����Ǵ��� Ȯ��
SELECT *
FROM users_history;

UPDATE USERS SET pass = '1234'
WHERE userid = 'brown';

SELECT *
FROM users_history;

--INSERT USERS_HISTORY....
--UPDATE USERS....