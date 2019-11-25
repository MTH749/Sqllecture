
-- DUAL ���̺� " sys ������ �ִ� ������ ��밡���� ���̺��̸�
-- �����ʹ� ���ุ �����ϸ� �÷�(dummy)�� �ϳ� ���� 'X'
SELECT *
FROM dual;

--SINGLE ROW FUNCTION : ��� �ѹ��� FRUNCTION�� ����
--1 ���� �� INPUT -> 1���� ������ OUTPUT (COLUMN)
--  'Hello, WOrld'
-- dual ���̺� ���� �ϳ��� �ุ �����Ѵ�. ����� �ϳ��� ������ ���´�
SELECT  LOWER ('Hello, World'), UPPER ('Hello, World') upper,
        INITCAP ('Hello, World') 
FROM dual;

--emp ���̺��� �� 14���� ������(����)�� ���� (14���� ��)
-- �Ʒ� ������ ����� 14���� ��

SELECT  emp. *, LOWER (' Hello, World'), UPPER ('Hello, World') upper,
        INITCAP ('Hello, World') 
FROM emp;

-- �÷��� function ����
SELECT empno, lower (ename) low_enm
FROM emp
WHERE ename = UPPER ('smith'); -- ���� �̸��� smith�� ����� ��ȸ �Ϸ��� �빮��/�ҹ���?

--���̺� �÷��������ص� ������ ����� ���� �� ������ 
-- ���̺� �÷� ���ٴ� ��������� �����ϴ� ���� �ӵ��鿡�� ����
--�ش� �÷��� �ε����� �����ϴ��� �Լ��� �����ϰ� �Ǹ� ���� �޶����� �Ǿ�
-- �ε����� Ȱ�� �� �� ���� �ȴ�.
-- ���� FBI (Function Based Index)
SELECT empno, lower (ename) low_enm
FROM emp
WHERE LOWER (ename) = 'smith'; -- ���� �̸��� smith�� ����� ��ȸ �Ϸ��� �빮��/�ҹ���?


SELECT empno, lower (ename) low_enm
FROM emp
WHERE ename = UPPER ('smith'); -- ���� �̸��� smith�� ����� ��ȸ �Ϸ��� �빮��/�ҹ���?

--HELLO
--,
--HELLO, WEORLD ( �� 3���� ���ڿ� ����� �̿�, CONCAT �Լ��� ����Ͽ� ���ڿ� ����)

SELECT CONCAT(CONCAT ('HELLO',','), 'WORLD'),
       'HELLO' || ',' || 'WORLD',
       -- �����ε����� 1����, �����ε��� ���ڿ����� �����Ѵ�
       SUBSTR ('HELLO, WORLD', 1 ,5), --SUBSTR -- SUBSTR (���ڿ� , ���� �ε���, ���� �ε���)
       --INSTR  : ���ڿ��� Ư�����ڿ��� �����ϴ���, ������ ��칮���� �ε����� ����
       INSTR ('HELLO, WORLD' , 'O') i1, -- 5, 9
        -- 'HELLO, WORLD ���ڿ��� 6��° �ε��� ���Ŀ� �����ϴ� 'O' ���ڿ��� �ε��� ����
       INSTR ('HELLO, WORLD' , 'O', 6) i2, -- ���ڿ���  Ư�� �ε��� ���ĺ��� �˻��ϵ��� �ɼ� �ɼǰ�
        -- 'HELLO, WORLD' ���ڿ��� 6��° �ε��� ���Ŀ� �����ϴ� 'O' ���ڿ��� �ε��� ����
       
        INSTR('HELLO, WORLD' , 'O', INSTR ('HELLO, WORLD' , 'O') +1) i3, -- ���ڿ���  Ư�� �ε��� ���ĺ��� �˻��ϵ��� �ɼ� �ɼǰ�
        
        --L/PAD Ư�� ���ڿ��� ���� / �����ʿ� ������ ���ڿ� ���̺��� ������ ��ŭ ���ڿ��� ä�� �ִ´�
        
        LPAD('HELLO, WORLD', 15 , '*')L1,
        LPAD('HELLO, WORLD', 15 )L2, -- DEFAULT ä�� ���ڴ� �����̴�
        RPAD('HELLO, WORLD', 15 , '*')R1,
        
        --REPLACE (����ڿ�, �˻� ���ڿ�, ������ ���ڿ�)
        --����ڿ����� �˻� ���ڿ��� ������ ���ڿ��� ġȯ
        REPLACE ('HELLO, WORLD', 'HELLO', 'hello') rep1, -- hello WORLD
        
        -- ���ڿ� �� , ���� ������ ����
        '   HELLO, WORLD   ' before_trim,
        TRIM('   HELLO, WORLD   ') after_trim,
        TRIM('H' FROM 'HELLO, WORLD') after_trim2
FROM dept;

-- ���� �����Լ�
--ROUND : �ݿø� -ROUND(����, �ݿø� �ڸ�)
--TRUNC : ���� - TRONC (����, �����ڸ�)
--MOD : ������ ���� NOD(������, ����) // MOD (5,2 ) : 1 

SELECT ROUND ( 105.54, 1) R1, -- �ݿø� ����� �Ҽ��� ���ڸ����� ��������( �Ҽ��� ��°�ڸ����� �ݿø�)
       ROUND ( 105.55, 1) R2, 
       ROUND ( 105.55, 0) R3, -- �Ҽ��� ù���� �ڸ����� �ݿø�      
       ROUND ( 105.55, -1) R4 --���� ù���� �ڸ����� �ݿø�       
FROM dual;

SELECT TRUNC ( 105.54, 1) T1, -- ���� ����� �Ҽ��� ���ڸ����� ��������( �Ҽ��� ��°�ڸ����� �ݿø�)
       TRUNC ( 105.55, 1) T2, 
       TRUNC ( 105.55, 0) T3, -- �Ҽ��� ù���� �ڸ����� ����      
       TRUNC ( 105.55, -1) T4 --���� ù���� �ڸ����� ����      
FROM dual;

--MOD(������, ����) �������� ������ ���� ������ ��
--MOD(M,2 ) �� ��� ���� : 0,1 ( 0~ ���� - 1 )
SELECT MOD (5, 2 ) M1 -- 5/2 : ���� 2, [�������� 1]
FROM dual;

--emp ���̺��� �÷��� 1000�� �������� ����� ������ ���� ��ȸ�ϴ� sql �ۼ�
--ename, sal, sal/1000�� ���� ��, sal/1000�� ���� ������

SELECT ename , sal ,TRUNC (sal/ 1000, 0) ��������, MOD (sal, 1000) ��������, 
       TRUNC (sal/ 1000, 0) * 1000 +  MOD (sal, 1000) 
FROM emp; 

--DATE : �����, �ð� , ��, ��
SELECT ename, TO_CHAR(hiredate, 'YYYY_MM_DD HH24-mi-ss') �⵵_��_�� --YYYY/MM/DD
FROM emp;

--SYSDATE : ������ ���� DATE�� �����ϴ� �����Լ�, Ư���� ���ڰ� ����
--DATE�� ���� DATE + ���� N���� ��ŭ ���Ѵ�
--�Ϸ�� 24�ð�
--DATE Ÿ�Կ� �ð��� ���� �� �� �ִ� 1�ð� = 1/24
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

-- YY,MM, DD, D(������ ���ڷ� : �Ͽ��� 1 ������ 2... ����� : 7)
-- IW( ���� 1~53), HH, MI, SS
SELECT TO_CHAR (SYSDATE, 'YYYY') YYYY, -- ���� �⵵
       TO_CHAR (SYSDATE, 'MM') MM, -- ���� ��
       TO_CHAR (SYSDATE, 'DD') DD,  -- ���� ��
       TO_CHAR (SYSDATE, 'D') D, -- ���� ���� (1~7)
       TO_CHAR (SYSDATE, 'IW') IW,  -- ���� ������ ���� ( 1~ 53)  
       --- 2019�� 12�� 31���� �������� �����°�?
       TO_CHAR (TO_DATE('20191231', 'YYYYMMDD','IW') IW       
FROM dual;

--fun2

SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD') DT_DASH,
       TO_CHAR (SYSDATE,'YYYY-MM-DD hh24-mi-ss') DT_DASH_WITH_TIME,
       TO_CHAR (SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY 
FROM dual;

--DATE Ÿ���� ROUND, TRUNC ����
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD hh24-mi-ss') now,
        --mm���� �ݿø�
       TO_CHAR(ROUND (SYSDATE,'YYYY'), 'YYYY-MM-DD hh24-mi-ss') now_YYYY,
        --DD���� �ݿø�(25�� -> 1����)
       TO_CHAR(ROUND (SYSDATE,'MM'), 'YYYY-MM-DD hh24-mi-ss') now_MM,      
       --�ð����� �ݿø�
       TO_CHAR(ROUND (SYSDATE,'DD'), 'YYYY-MM-DD hh24-mi-ss') now_DD 
FROM dual;  

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD hh24-mi-ss') now,
        --mm���� ����
       TRUNC (SYSDATE,'YYYY'), 'YYYY-DD-MM hh24-mi-ss') now-YYYY,
        --dd���� ����
       TRUNC (SYSDATE,'MM'), 'YYYY-DD-MM hh24-mi-ss') now_MM,      
        --�ð����� ����
       TRUNC (SYSDATE,'DD'), 'YYYY-DD-MM hh24-mi-ss') now_DD 
 
FROM dual;

--��¥ ���� �Լ�
--MONTHS_BETWEEN(date1, date2) : date2�� date1 ������ ���� ��
--ADD_MONTHS(date, ������ ������) : date���� Ư���������� ���ϰų� �� ��¥
--NEXT_DAY (date, weekday(1~7)) : date���� ù��° weekday ��¥
--LAST_DAY (date) : date�� ���� ���� ������ ��¥

--MONTH_BETWEEN(date1, date2)
SELECT MONTHS_BETWEEN (TO_DATE('2019-11-25', 'YYYY-MM-DD'),
                      TO_DATE('2019-03-31', 'YYYY-MM-DD')) M_bet,
                      TO_DATE('2019-11-25', 'YYYY-MM-DD') -   TO_DATE('2019-03-31', 'YYYY-MM-DD') d_m
                      
FROM dual;                   

--ADD_MONTH(date, number (+ -) )
SELECT ADD_MONTHS(TO_DATE('20191125', 'YYYYMMDD'), 5) NOW_AFTER5M,
       ADD_MONTHS(TO_DATE('20191125', 'YYYYMMDD'), - 5) NOW_BEFORE5,
       SYSDATE + 100 --100�� ���� ��¥ (������ 3 -31, 2-28/29
FROM dual;

--NEXT_DAY (date, weekday number(1~7)
SELECT NEXT_DAY(SYSDATE, 7) -- ���� ��¥ (2019/11��/25)�� ���� �����ϴ� ù��° �����