--FOR LOOP에서 명시적 커서 사용하기
--부서테이블의 모든 행의 부서이름, 위치, 지역 정보를 출력 (cursor)를 이용
SET SERVEROUTPUT ON;
DECLARE
    --커서 선언
    CURSOR dept_cursor IS
        SELECT dname, loc
        FROM dept
        ORDER BY deptno;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
   FOR record_row IN dept_cursor LOOP
        DBMS_OUTPUT.PUT_LINE (record_row.dname || ',' || record_row.loc);
   END LOOP;
    
END;
/

--커세어 인자가 들어가는 경우
DECLARE
    --커서 선언
    CURSOR dept_cursor (p_deptno dept.deptno%TYPE) IS
        SELECT dname, loc
        FROM dept
        WHERE deptno = p_deptno
        ORDER BY deptno;
        
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
   FOR record_row IN dept_cursor(10) LOOP
        DBMS_OUTPUT.PUT_LINE (record_row.dname || ',' || record_row.loc);
   END LOOP;
    
END;
/

--FOR LOOP 인라인 커서
--FOR LOOP 구문에서 커서를 직접 선언
DECLARE
    --커서 선언        
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
   FOR record_row IN (SELECT dname, loc
        FROM dept) LOOP
        DBMS_OUTPUT.PUT_LINE (record_row.dname || ',' || record_row.loc);
   END LOOP;
    
END;
/

CREATE OR REPLACE PROCEDURE  AVGDT IS
    TYPE dt_tab IS TABLE OF dt%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dt_tab dt_tab;
    v_sum NUMBER :=0;
    
BEGIN 
    SELECT *
    BULK COLLECT INTO v_dt_tab
    FROM dt
    ORDER BY dt;
    
    FOR i IN 1..(v_dt_tab.count -1) LOOP
    v_sum := v_sum + v_dt_tab(i+1).dt - v_dt_tab(i).dt;
    END LOOP;   
    DBMS_OUTPUT.PUT_LINE (v_sum /( v_dt_tab.count-1));
END;
/
exec avgdt;

--pro3
--1.rownum
--2.분석함수
--3.
SELECT avg(sum_avg) avg_dt
FROM
(SELECT LEAD(dt) OVER (ORDER BY dt) -dt sum_avg
FROM dt);

SELECT *
FROM dt
ORDER by dt;

SELECT (max(dt) -min(dt)) / (count(*)-1) avg_sum
FROM dt;

SELECT *
FROM cycle;

--1, 100, 2, 1 --> 1, 100, 20191202, 1
--             --> 1, 100, 20191209, 1
               --> 1, 100, 20191216, 1
               --> 1, 100, 20191223, 1
               --> 1, 100, 20191230, 1
SELECT *
FROM daily;

--pro4
CREATE OR REPLACE PROCEDURE CREATE_DAILY_SALES
(v_yyyymm IN VARCHAR2) IS
    TYPE cal_row_type IS RECORD(
    dt VARCHAR2(8),
    day NUMBER);
    TYPE cal_tab Is TABLE OF cal_row_type INDEX BY BINARY_INTEGER;
    v_cal_tab cal_tab;
BEGIN
    --생성하기 전에 해당 년월에 해당하는 일실적 데이터를 삭제한다
    DELETE daily
    WHERE dt LIKE  v_yyyymm || '%';
    
    --달력정보를 table 변수에 저장한다
    --반복적인 sql 실행을 방지하기 위해 한번만 실행해서 변수에 저장
    
    SELECT TO_CHAR (TO_DATE(v_yyyymm, 'yyyymm')+ (LEVEL -1), 'YYYYMMDD')  dt,
       TO_CHAR (TO_DATE(v_yyyymm, 'yyyymm')+ (LEVEL -1) , 'D') day
    BULK COLLECT INTO v_cal_tab   
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(v_yyyymm, 'yyyymm')),'DD');
    -- 애음주기 정보를 읽는다
    FOR daily IN (SELECT * FROM cycle)LOOP
        --12월 일자달력 : cycle row 건수 만큼 반복
        FOR i IN 1.. v_cal_tab.count LOOP 
            IF daily.day = v_cal_tab(i).day THEN
                --cid, pid, 일자, 수량
                INSERT INTO daily VALUES
                (daily.cid,daily.pid, v_cal_tab(i).dt,daily.cnt);
              END IF;  
        END LOOP;
        DBMS_OUTPUT.PUT_LINE (daily.cid || ' , ' || daily.day );
    END LOOP;
    
    COMMIT;
END;
/

exec CREATE_DAILY_SALES('201912');

SELECT cycle.cid, cycle.pid, cal.dt, cycle.cnt
FROM CYCLE,
     (SELECT TO_CHAR (TO_DATE(:v_yyyymm, 'yyyymm')+ (LEVEL -1), 'YYYYMMDD')  dt,
       TO_CHAR (TO_DATE(:v_yyyymm, 'yyyymm')+ (LEVEL -1) , 'D') day 
      FROM dual
      CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:v_yyyymm, 'yyyymm')),'DD')) cal
WHERE cycle.day = cal.day;      
