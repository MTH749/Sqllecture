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
 --특정 테이블의 ROW 정보를 담을 수 있는 참조타입
 --TYPE : 테이블명. 테이블 컬럼명%TYPE
 --ROWTYPE : 테이블명%ROWTYPE
 
 SET SERVEROUTPUT ON;
 DECLARE
    --dept 테이블의 row 정보를 담을 수 있는 ROWTYPE 변수 선언
    dept_row dept%ROWTYPE;
BEGIN
    SELECT *
    INTO dept_row
    FROM dept
    WHERE DEPTNO = 10;
    
    DBMS_OUTPUT.PUT_LINE(dept_row.dname || ', '|| dept_row.loc);
END;
/
--RECORD TYPE : 개발자가 컬럼을 직접 선언하여 개발에 필요한 TYPE을 생성
--TYPE 타입이름 IS RECORD(
--              컬럼1 컬럼1TYPE ,
--              컬럼2 컬럼2TYPE
--                               );
DECLARE
    --부서이름, LOC 정보를 저장할 수 있는 RECORD TYPE 선언
    TYPE dept_row IS RECORD (
         dname dept.dname%TYPE,
         loc dept.loc%TYPE);
    --TYPE 선언이 완료, TYPE을 갖고 변수를 생성
    --PL/SQL 변수 생성 : 변수이름 변수TYPE dname dept.dname%TYPE;
    dept_row_data dept_row;
BEGIN
    SELECT dname, loc
    INTO dept_row_data
    FROM dept
    WHERE deptno= 10;
   
   DBMS_OUTPUT.PUT_LINE(dept_row_data.dname || ', ' || dept_row_data.loc); 
END;
/


-- TABLE TYPE : 여러개의 ROWTYPE을 저장할 수 있는 TYPE
-- col -> row -- > table
-- TYPE 테이블타입명 IT TABLE OF ROWTYPE/ RECORD INDEX BY 인덱스 타입(BINARY_INTEGER)
-- java와 다르게 PL/SQL 에서는 Array 역활을 하는 TABLE TYPE의 인덱스를
-- 숫자 뿐만 아니라, 문자열 형태도 가능하다
-- 그렇기 때문에 index에 대한 타입을 명시힌다
-- 일반 적으로 Array(List) 형태인 경우라면 INDEX BY BINARY_INTEGER를 주로 사용한다.
-- arr(1).name = 'brown'
-- arr('person').name = 'brown'

--dept 테이블의 row를 여러건 저장할 수 있는 dept_tab TABLE TYPE 선언하여
--SELECT * FROM dept;의 결과 (여러건)를 변수에 담는다.
DECLARE
    TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dept dept_tab;
    
BEGIN
    --한 ROW의 값을 변수에 저장 : INTO 
    --복수 ROW이 값을 변수에 저장 : BULK COLLECT INTO
    SELECT *
    BULK COLLECT INTO v_dept
    FROM dept
    ORDER BY deptno;
    
    FOR i  IN 1.. v_dept.count LOOP
    -- index 소괄호 자바는 대괄호
        DBMS_OUTPUT.PUT_LINE (v_dept(i).deptno || '  ' || v_dept(i).dname || '  ' ||  v_dept(i).loc);
    END LOOP;
    
END;
/

--로직 제어 IF
-- IF condition THEN 
--     statement
-- ELSIF condition THEN
--     statement
-- ELSE
--     statement
-- END IF;

-- PL/ SQL 실습

-- 변수 p(NUMBER)에  2라는 값을 할당하고
-- IF 구문을 통해 p의 값이 1,2, 그밖의 값일때 텍스트 출력

DECLARE
    p NUMBER := 2; --변수선언과 할당을 한문장에서 진행
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
--FOR 인덱스 변수 IN [REVERSE] START.. END LOOP
-- 반목문 실행
-- END LOOP;
-- 0~5 까지 루프 변수를 이용하여 반복문 실행

DECLARE
    
BEGIN
    FOR i IN 0.. 5 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
    
END;
/

-- 1~10 : 55
-- 1~10까지의 합을 LOOP를 이용하여 계산, 결과를  s_val 이라는 변수에 담아
-- DBMS_OUTPUT.PUT_LINE 함수를 통해 화면에 출력
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
-- 0부터 5까지 WHILE 문을 이용하여 출력
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

-- CURSOR : SQL을 개발자가 제어할 수 있는 객체
-- 묵시적 : 개발자가 별도의 커서명을 기술하지 않은 형태, ORACLE에서 자동으로
--          OPEN, 실행, FETCH, CLOSE를 관리한다
-- 명시적 : 개발자가 이름을 붙인 커서. 개발자가 직접 제어하며
--         선언,OPEN, FETCH, CLOSE 단계가 존재
-- CURSOR 커서이름 IS -- 커서 선언
--     QUERY
-- OPEN 커서이름; --커서 OPEN
-- FETCH 커서이름 INTO 변수1, 변수2.... -- 커서 FETCH(행 인출)
-- CLOSE 커서이름; --커서 CLOSE

-- 부서테이블의 모든 행의 부서이름, 위치 지역 정보를 출력
DECLARE
    --커서 선언
    CURSOR dept_cursor IS
        SELECT dname, loc
        FROM dept;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    -- 커서 오픈
    OPEN dept_cursor;
    FETCH dept_cursor INTO v_dname , v_loc;
    CLOSE dept_cursor;
    
    DBMS_OUTPUT.PUT_LINE(v_dname || ' , ' || v_loc );
END;
/

DECLARE
    --커서 선언
    CURSOR dept_cursor IS
        SELECT dname, loc
        FROM dept
        ORDER BY deptno;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    -- 커서 오픈
    OPEN dept_cursor;

    LOOP
        FETCH dept_cursor INTO v_dname , v_loc;
        --종료 조건 = FETCH할 데이터가 없을떄 종료
        EXIT WHEN dept_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_dname || ' , ' || v_loc );
    END LOOP;    
    CLOSE dept_cursor;
    
END;
/




