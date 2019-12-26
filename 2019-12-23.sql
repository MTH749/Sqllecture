 SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE UPDATEdept_test
(p_deptno IN dept.deptno%type,
 p_dname IN dept.dname%type,
 p_loc IN dept.loc%type)
 
 IS
 


BEGIN

UPDATE dept_test SET dname = p_dname, loc = p_loc
WHERE deptno = p_deptno;
commit;

     DBMS_OUTPUT.PUT_LINE (p_deptno || ' ' ||p_dname || ' ' || p_loc);
 END;
 /
 
 exec UPDATEdept_test (99, 'ddit_m', 'daejeon');
 
 desc dept;
 
 SELECT *
 FROM dept_test;
 
 --ROWTYPE
 --Ư�� ���̺��� ROW ������ ���� �� �ִ� ����Ÿ��
 --TYPE : ���̺���. ���̺� �÷���%TYPE
 --ROWTYPE : ���̺���%ROWTYPE
 
 SET SERVEROUTPUT ON;
 DECLARE
    --dept ���̺��� row ������ ���� �� �ִ� ROWTYPE ���� ����
    dept_row dept%ROWTYPE;
BEGIN
    SELECT *
    INTO dept_row
    FROM dept
    WHERE DEPTNO = 10;
    
    DBMS_OUTPUT.PUT_LINE(dept_row.dname || ', '|| dept_row.loc);
END;
/
--RECORD TYPE : �����ڰ� �÷��� ���� �����Ͽ� ���߿� �ʿ��� TYPE�� ����
--TYPE Ÿ���̸� IS RECORD(
--              �÷�1 �÷�1TYPE ,
--              �÷�2 �÷�2TYPE
--                               );
DECLARE
    --�μ��̸�, LOC ������ ������ �� �ִ� RECORD TYPE ����
    TYPE dept_row IS RECORD (
         dname dept.dname%TYPE,
         loc dept.loc%TYPE);
    --TYPE ������ �Ϸ�, TYPE�� ���� ������ ����
    --PL/SQL ���� ���� : �����̸� ����TYPE dname dept.dname%TYPE;
    dept_row_data dept_row;
BEGIN
    SELECT dname, loc
    INTO dept_row_data
    FROM dept
    WHERE deptno= 10;
   
   DBMS_OUTPUT.PUT_LINE(dept_row_data.dname || ', ' || dept_row_data.loc); 
END;
/


-- TABLE TYPE : �������� ROWTYPE�� ������ �� �ִ� TYPE
-- col -> row -- > table
-- TYPE ���̺�Ÿ�Ը� IT TABLE OF ROWTYPE/ RECORD INDEX BY �ε��� Ÿ��(BINARY_INTEGER)
-- java�� �ٸ��� PL/SQL ������ Array ��Ȱ�� �ϴ� TABLE TYPE�� �ε�����
-- ���� �Ӹ� �ƴ϶�, ���ڿ� ���µ� �����ϴ�
-- �׷��� ������ index�� ���� Ÿ���� ��������
-- �Ϲ� ������ Array(List) ������ ����� INDEX BY BINARY_INTEGER�� �ַ� ����Ѵ�.
-- arr(1).name = 'brown'
-- arr('person').name = 'brown'

--dept ���̺��� row�� ������ ������ �� �ִ� dept_tab TABLE TYPE �����Ͽ�
--SELECT * FROM dept;�� ��� (������)�� ������ ��´�.
DECLARE
    TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dept dept_tab;
    
BEGIN
    --�� ROW�� ���� ������ ���� : INTO 
    --���� ROW�� ���� ������ ���� : BULK COLLECT INTO
    SELECT *
    BULK COLLECT INTO v_dept
    FROM dept
    ORDER BY deptno;
    
    FOR i  IN 1.. v_dept.count LOOP
    -- index �Ұ�ȣ �ڹٴ� ���ȣ
        DBMS_OUTPUT.PUT_LINE (v_dept(i).deptno || '  ' || v_dept(i).dname || '  ' ||  v_dept(i).loc);
    END LOOP;
    
END;
/

--���� ���� IF
-- IF condition THEN 
--     statement
-- ELSIF condition THEN
--     statement
-- ELSE
--     statement
-- END IF;

-- PL/ SQL �ǽ�

-- ���� p(NUMBER)��  2��� ���� �Ҵ��ϰ�
-- IF ������ ���� p�� ���� 1,2, �׹��� ���϶� �ؽ�Ʈ ���

DECLARE
    p NUMBER := 2; --��������� �Ҵ��� �ѹ��忡�� ����
BEGIN
    --p:= 2;
    IF p =1 THEN
        dbms_output.put_LINE ('p = 1');
    ELSIF p = 2 THEN
        dbms_output.put_LINE ('p = 2');
    ELSE 
        dbms_output.put_LINE (p);
    END IF;    
END;
/

-- FOR LOOP
--FOR �ε��� ���� IN [REVERSE] START.. END LOOP
-- �ݸ� ����
-- END LOOP;
-- 0~5 ���� ���� ������ �̿��Ͽ� �ݺ��� ����

DECLARE
    
BEGIN
    FOR i IN 0.. 5 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
    
END;
/

-- 1~10 : 55
-- 1~10������ ���� LOOP�� �̿��Ͽ� ���, �����  s_val �̶�� ������ ���
-- DBMS_OUTPUT.PUT_LINE �Լ��� ���� ȭ�鿡 ���
DECLARE
    s_val number := 0;
BEGIN
    FOR i IN 1..10 LOOP
        s_val := s_val +i;
    END LOOP;
      DBMS_OUTPUT.PUT_LINE ( s_val );
END;
/

--while loop
--WHILE condition LOOP
-- staement
-- END LOOP;
-- 0���� 5���� WHILE ���� �̿��Ͽ� ���
DECLARE
    i NUMBER := 0;
BEGIN
    WHILE i <= 5 LOOP 
        DBMS_OUTPUT.PUT_LINE (i);
        i := i + 1;
    END LOOP;  
END;
/
--LOOP
--LOOP
--  statement;
--  EXIT [when condition];
-- END LOOP:

DECLARE
    i NUMBER := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE (i);
        EXIT WHEN i >= 5;    
        i := i + 1;
    END LOOP;  
END;
/

-- CURSOR : SQL�� �����ڰ� ������ �� �ִ� ��ü
-- ������ : �����ڰ� ������ Ŀ������ ������� ���� ����, ORACLE���� �ڵ�����
--          OPEN, ����, FETCH, CLOSE�� �����Ѵ�
-- ������ : �����ڰ� �̸��� ���� Ŀ��. �����ڰ� ���� �����ϸ�
--         ����,OPEN, FETCH, CLOSE �ܰ谡 ����
-- CURSOR Ŀ���̸� IS -- Ŀ�� ����
--     QUERY
-- OPEN Ŀ���̸�; --Ŀ�� OPEN
-- FETCH Ŀ���̸� INTO ����1, ����2.... -- Ŀ�� FETCH(�� ����)
-- CLOSE Ŀ���̸�; --Ŀ�� CLOSE

-- �μ����̺��� ��� ���� �μ��̸�, ��ġ ���� ������ ���
DECLARE
    --Ŀ�� ����
    CURSOR dept_cursor IS
        SELECT dname, loc
        FROM dept;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    -- Ŀ�� ����
    OPEN dept_cursor;
    FETCH dept_cursor INTO v_dname , v_loc;
    CLOSE dept_cursor;
    
    DBMS_OUTPUT.PUT_LINE(v_dname || ' , ' || v_loc );
END;
/

<<<<<<< HEAD
--�μ����̺��� ��� ���� �μ��̸�, ��ġ, ���� ������ ��� (cursor)�� �̿�
=======
>>>>>>> master
DECLARE
    --Ŀ�� ����
    CURSOR dept_cursor IS
        SELECT dname, loc
        FROM dept
        ORDER BY deptno;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    -- Ŀ�� ����
    OPEN dept_cursor;

    LOOP
        FETCH dept_cursor INTO v_dname , v_loc;
        --���� ���� = FETCH�� �����Ͱ� ������ ����
        EXIT WHEN dept_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_dname || ' , ' || v_loc );
    END LOOP;    
    CLOSE dept_cursor;
    
END;
/



