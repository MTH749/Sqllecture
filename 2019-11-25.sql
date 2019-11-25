
-- DUAL 테이블 " sys 계정에 있는 누구나 사용가능한 테이블이며
-- 데이터는 한행만 존재하며 컬럼(dummy)도 하나 존재 'X'
SELECT *
FROM dual;

--SINGLE ROW FUNCTION : 행당 한번의 FRUNCTION이 실행
--1 개의 행 INPUT -> 1개의 행으로 OUTPUT (COLUMN)
--  'Hello, WOrld'
-- dual 테이블 에는 하나의 행만 존재한다. 결과도 하나의 행으로 나온다
SELECT  LOWER ('Hello, World'), UPPER ('Hello, World') upper,
        INITCAP ('Hello, World') 
FROM dual;

--emp 테이블에는 총 14건의 데이터(직원)가 존재 (14개의 행)
-- 아래 쿼리는 결과도 14개의 행

SELECT  emp. *, LOWER (' Hello, World'), UPPER ('Hello, World') upper,
        INITCAP ('Hello, World') 
FROM emp;

-- 컬럼에 function 적용
SELECT empno, lower (ename) low_enm
FROM emp
WHERE ename = UPPER ('smith'); -- 직원 이름이 smith인 사람을 조회 하려면 대문자/소문자?

--테이블 컬럼을가공해도 동일한 결과를 얻을 수 있지만 
-- 테이블 컬럼 보다는 상수쪽으로 가공하는 것이 속도면에서 유리
--해달 컬럼에 인덱스가 존재하더라도 함수를 적용하게 되면 값이 달라지게 되어
-- 인덱스를 활용 할 수 없게 된다.
-- 예외 FBI (Function Based Index)
SELECT empno, lower (ename) low_enm
FROM emp
WHERE LOWER (ename) = 'smith'; -- 직원 이름이 smith인 사람을 조회 하려면 대문자/소문자?


SELECT empno, lower (ename) low_enm
FROM emp
WHERE ename = UPPER ('smith'); -- 직원 이름이 smith인 사람을 조회 하려면 대문자/소문자?

--HELLO
--,
--HELLO, WEORLD ( 위 3가지 문자열 상수를 이용, CONCAT 함수를 사용하여 문자열 결합)

SELECT CONCAT(CONCAT ('HELLO',','), 'WORLD'),
       'HELLO' || ',' || 'WORLD',
       -- 시작인덱스는 1부터, 종료인덱스 문자열까지 포함한다
       SUBSTR ('HELLO, WORLD', 1 ,5), --SUBSTR -- SUBSTR (문자열 , 시작 인데스, 종료 인덱스)
       --INSTR  : 문자열에 특정문자열이 존재하는지, 존재할 경우문자의 인덱스를 리턴
       INSTR ('HELLO, WORLD' , 'O') i1, -- 5, 9
        -- 'HELLO, WORLD 문자열의 6번째 인덱스 이후에 등장하는 'O' 문자열의 인덱스 리던
       INSTR ('HELLO, WORLD' , 'O', 6) i2, -- 문자열의  특정 인덱스 이후부터 검색하도록 옵션 옵션값
        -- 'HELLO, WORLD' 문자열의 6번째 인덱스 이후에 등장하는 'O' 문자열의 인덱스 리턴
       
        INSTR('HELLO, WORLD' , 'O', INSTR ('HELLO, WORLD' , 'O') +1) i3, -- 문자열의  특정 인덱스 이후부터 검색하도록 옵션 옵션값
        
        --L/PAD 특정 문자열의 왼쪽 / 오른쪽에 설정한 문자열 길이보다 부족한 만큼 문자열을 채워 넣는다
        
        LPAD('HELLO, WORLD', 15 , '*')L1,
        LPAD('HELLO, WORLD', 15 )L2, -- DEFAULT 채움 문자는 공백이다
        RPAD('HELLO, WORLD', 15 , '*')R1,
        
        --REPLACE (대상문자열, 검색 문자열, 변경할 문자열)
        --대상문자열에서 검색 문자열을 변경할 문자열로 치환
        REPLACE ('HELLO, WORLD', 'HELLO', 'hello') rep1, -- hello WORLD
        
        -- 문자열 앞 , 뒤의 공백을 제거
        '   HELLO, WORLD   ' before_trim,
        TRIM('   HELLO, WORLD   ') after_trim,
        TRIM('H' FROM 'HELLO, WORLD') after_trim2
FROM dept;

-- 숫자 조작함수
--ROUND : 반올림 -ROUND(숫자, 반올림 자리)
--TRUNC : 절삭 - TRONC (숫자, 절삭자리)
--MOD : 나머지 연산 NOD(피제수, 제수) // MOD (5,2 ) : 1 

SELECT ROUND ( 105.54, 1) R1, -- 반올림 결과가 소수점 한자리까지 나오도록( 소수점 둘째자리에서 반올림)
       ROUND ( 105.55, 1) R2, 
       ROUND ( 105.55, 0) R3, -- 소수점 첫번쨰 자리에서 반올림      
       ROUND ( 105.55, -1) R4 --정수 첫번쨰 자리에서 반올림       
FROM dual;

SELECT TRUNC ( 105.54, 1) T1, -- 절삭 결과가 소수점 한자리까지 나오도록( 소수점 둘째자리에서 반올림)
       TRUNC ( 105.55, 1) T2, 
       TRUNC ( 105.55, 0) T3, -- 소수점 첫번쨰 자리에서 절삭      
       TRUNC ( 105.55, -1) T4 --정수 첫번쨰 자리에서 절삭      
FROM dual;

--MOD(피제수, 제수) 피제수를 제수로 나눈 나머지 값
--MOD(M,2 ) 의 결과 종류 : 0,1 ( 0~ 제수 - 1 )
SELECT MOD (5, 2 ) M1 -- 5/2 : 몫이 2, [나머지가 1]
FROM dual;

--emp 테이블의 컬럼을 1000을 나눴을때 사원별 나머지 값을 조회하는 sql 작성
--ename, sal, sal/1000을 때의 몫, sal/1000을 때의 나머지

SELECT ename , sal ,TRUNC (sal/ 1000, 0) 나눴을때, MOD (sal, 1000) 나머지값, 
       TRUNC (sal/ 1000, 0) * 1000 +  MOD (sal, 1000) 
FROM emp; 

--DATE : 년월일, 시간 , 분, 초
SELECT ename, TO_CHAR(hiredate, 'YYYY_MM_DD HH24-mi-ss') 년도_월_일 --YYYY/MM/DD
FROM emp;

--SYSDATE : 서버의 현재 DATE를 리턴하는 내장함수, 특별한 인자가 없다
--DATE의 연산 DATE + 정수 N일자 만큼 더한다
--하루는 24시간
--DATE 타입에 시간을 더할 수 도 있다 1시간 = 1/24
SELECT TO_CHAR(SYSDATE +5, 'YYYY-MM-DD hh24-mi-ss') AFTER5_DAYS,
       TO_CHAR(SYSDATE +5/24, 'YYYY-MM-DD hh24-mi-ss') AFTER5_HOURS,
       TO_CHAR(SYSDATE +5/24/60, 'YYYY-MM-DD hh24-mi-ss') AFTER5_MIN
FROM dual;

--fun 1

SELECT TO_CHAR(SYSDATE + 36, 'YYYY-MM-DD') LASTDAY,
       TO_CHAR(SYSDATE + 31, 'YYYY-MM-DD') LASTDAY_BEFORE5,
       SYSDATE NOW,
       SYSDATE -3 LASTDAY_BEROFE3  
FROM dual;

-- YY,MM, DD, D(요일을 숫자로 : 일요일 1 월요일 2... 토요일 : 7)
-- IW( 주자 1~53), HH, MI, SS
SELECT TO_CHAR (SYSDATE, 'YYYY') YYYY, -- 현재 년도
       TO_CHAR (SYSDATE, 'MM') MM, -- 현재 월
       TO_CHAR (SYSDATE, 'DD') DD,  -- 현재 일
       TO_CHAR (SYSDATE, 'D') D, -- 현재 요일 (1~7)
       TO_CHAR (SYSDATE, 'IW') IW,  -- 현재 일자의 주차 ( 1~ 53)  
       --- 2019년 12월 31일은 몇주차가 나오는가?
       TO_CHAR (TO_DATE('20191231', 'YYYYMMDD','IW') IW       
FROM dual;

--fun2

SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD') DT_DASH,
       TO_CHAR (SYSDATE,'YYYY-MM-DD hh24-mi-ss') DT_DASH_WITH_TIME,
       TO_CHAR (SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY 
FROM dual;

--DATE 타입의 ROUND, TRUNC 적용
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD hh24-mi-ss') now,
        --mm에서 반올림
       TO_CHAR(ROUND (SYSDATE,'YYYY'), 'YYYY-MM-DD hh24-mi-ss') now_YYYY,
        --DD에서 반올림(25일 -> 1개월)
       TO_CHAR(ROUND (SYSDATE,'MM'), 'YYYY-MM-DD hh24-mi-ss') now_MM,      
       --시간에서 반올림
       TO_CHAR(ROUND (SYSDATE,'DD'), 'YYYY-MM-DD hh24-mi-ss') now_DD 
FROM dual;  

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD hh24-mi-ss') now,
        --mm에서 절삭
       TRUNC (SYSDATE,'YYYY'), 'YYYY-DD-MM hh24-mi-ss') now-YYYY,
        --dd에서 절삭
       TRUNC (SYSDATE,'MM'), 'YYYY-DD-MM hh24-mi-ss') now_MM,      
        --시간에서 절삭
       TRUNC (SYSDATE,'DD'), 'YYYY-DD-MM hh24-mi-ss') now_DD 
 
FROM dual;

--날짜 조작 함수
--MONTHS_BETWEEN(date1, date2) : date2와 date1 사이의 개월 수
--ADD_MONTHS(date, 가감할 개월수) : date에서 특정개월수를 더하거나 뺀 날짜
--NEXT_DAY (date, weekday(1~7)) : date이후 첫번째 weekday 날짜
--LAST_DAY (date) : date가 속한 월의 마지막 날짜

--MONTH_BETWEEN(date1, date2)
SELECT MONTHS_BETWEEN (TO_DATE('2019-11-25', 'YYYY-MM-DD'),
                      TO_DATE('2019-03-31', 'YYYY-MM-DD')) M_bet,
                      TO_DATE('2019-11-25', 'YYYY-MM-DD') -   TO_DATE('2019-03-31', 'YYYY-MM-DD') d_m
                      
FROM dual;                   

--ADD_MONTH(date, number (+ -) )
SELECT ADD_MONTHS(TO_DATE('20191125', 'YYYYMMDD'), 5) NOW_AFTER5M,
       ADD_MONTHS(TO_DATE('20191125', 'YYYYMMDD'), - 5) NOW_BEFORE5,
       SYSDATE + 100 --100일 뒤의 날짜 (월개념 3 -31, 2-28/29
FROM dual;

--NEXT_DAY (date, weekday number(1~7)
SELECT NEXT_DAY(SYSDATE, 7) -- 오늘 날짜 (2019/11월/25)일 이후 등장하는 첫번째 토요일