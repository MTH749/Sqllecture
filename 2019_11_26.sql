--��¥���� �Լ�
--round, trunc
--(MONTHS_BETWEEN) ADD MONTHS, NEXT_DAY
--LAST_DAY : �ش糯¥�� ���� ���� ������ ����(DATE)

--�� :  1, 3, 5, 6, 7, 8, 9, 11 : 31��
--   : 2 - ���� ���ο� 28,29��
--   : 4, 6, 7, 11 : 30��
SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM dual;


--fn3
--�ش� ��¥�� ��������¥�� �̵�
--�����ʵ常 ����
--DATE --> ���ڿ� TO_CHAR( LAST_DAT(TO_DATE ('201912','YYYYMM')))

SELECT  YYYYYMM param,
        TO_CHAR( LAST_DAT(TO_DATE (:YYYYMM,'YYYYMM')), 'DD') dt  
FROM dual;

--SYSDATE�� YYYY/MM/DD ������ ���ڿ��� ���� (DATE -> CHAR)

SELECT  TO_CHAR(SYSDATE ,'YYYY-MM-DD') TODAY

FROM  dual;

--'2019/11/26' ���ڿ� - DATE
-- ���ڿ� : TO_CHAR(SYSDATE, 'YYYY/MM/DD')
SELECT TO_CHAR(SYSDATE ,'YYYY-MM-DD') TODAY,
       TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'YYYY/MM/DD')
FROM dual;

--YYYY-MM-DD HH24:MI:SS ���ڿ��� ����
SELECT TO_CHAR(SYSDATE ,'YYYY-MM-DD') TODAY,
       TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'YYYY/MM/DD') SECOND,
       TO_CHAR(TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'YYYY/MM/DD') , 'YYYY-MM-DD HH24:MI:SS') YMD
FROM dual;


--EMPNO    NOT NULL NUMBER(4)    
--ENAME             VARCHAR2(10) 
--JOB               VARCHAR2(9)  
--MGR               NUMBER(4)    
--HIREDATE          DATE         
--SAL               NUMBER(7,2)  
--COMM              NUMBER(7,2)  
--DEPTNO            NUMBER(2)    

desc emp;

--empno�� 7369�� ���� ���� ��ȸ�ϱ�
--���� �ܰ� ���¹�
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

-- �����ȹ ���¹�
SELECT *
FROM TABLE(dbms_xplan.display);

--Plan hash value: 3956160932
-- 
----------------------------------------------------------------------------
--| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
--|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
--|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
----------------------------------------------------------------------------
-- 
--Predicate Information (identified by operation id):
-----------------------------------------------------
-- 
--   1 - filter("EMPNO"=7369)

--�ڽķε尡 ������ �ڽĺ��� �д´�


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR( empno) = 7300 +  69;

SELECT *
FROM TABLE(dbms_xplan.display);


SELECT 7300 + 69
FROM dual;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7300 + 69;-- 69 > ���ڷ� ����

SELECT *
FROM TABLE(dbms_xplan.display);

--

SELECT *
FROM emp
WHERE hiredate > = TO_DATE('1981/06/01', 'YYYY/MM/DD');
--DATEŸ���� ������ ����ȯ�� ����� ������ ����
--YY ->19
--RR -->50 / 19,20
SELECT *
FROM emp
WHERE hiredate > = TO_DATE('1981/06/01','YYYY/MM/DD'); 
--WHERE hiredate >= 81/06/01;

SELECT TO_DATE('50/05/05','RR/MM/DD') aa,
       TO_DATE('49/05/05','RR/MM/DD') bb,
       TO_DATE('50/05/05','YY/MM/DD') cc,
       TO_DATE('49/05/05','YY/MM/DD') dd
 
FROM dual;

--���� --> ���ڿ�
-- ���ڿ� --> ����
--���� : 1000000 --> 1,000,000.00(�ѱ� ����)
--���� : 1000000 --> 1.000.000,00(���� ����)
-- ��¥ ���� : YYYY DD NN HH24 MI SS
-- ���� ���� : ����ǥ�� : 9, �ڸ������� ���� 0ǥ�� : 0 , ȭ�� ���� : L
--                     1000 �ڸ� ���� : ,
--                        �Ҽ��� : .
--���� -> ���ڿ� TO_CHAR(����,'����')
--���� ������ �������� ���� �ڸ����� ����� ǥ��
SELECT empno, ename, sal, TO_CHAR(sal, 'L09,999') fm_sal 
FROM emp;

SELECT TO_CHAR( 100000000000, '999,999,999,999,999') num
FROM dual;

--NULL ó�� �Լ� : NVL, NVL2, NULLIF, COALESCE

--NVL(expr1, expr2) :�Լ� ���� 2��
--expr1�� NULL�̸� expr2�� ��ȯ
--expr1�� NULL�� �ƴϸ� expr1�� ��ȯ

SELECT empno, ename, comm, NVL(comm, -1) NVL_comm
FROM emp;
--NVL2(expr1, expr2,expr3)
--expr1 IS NOT NULL expr2 ����
--expr1 IS NULL expr3 ����

SELECT empno, ename, comm, NVL2(comm,  1000,-500) NVL_comm,
       NVL2(comm, comm,-500) SAME_NVL_comm -- NVL�� ������ ���
FROM emp;

--NULLIF (expr1, expr2)
--expr1 = exp2 NULL�� ����
--expr1 != expr2 exrp1�� ����
--comm�� NULL�ϋ� comm +500 : NULL
--  NULLIF(NULL,NULL)  : NULL
--comm�� NULL�� �ƴҶ� comm +500 : comm 500
--  NULL(comm,comm +500) : comm
SELECT empno, ename, comm, NULLIF(comm, comm + 500) NULLIF_comm
FROM emp;

--COALESCE (expr1, expr2, expr3......)
--�����߿� ù������ �����ϴ� NULL�� �ƴ� exprN�� ����
--expr1 IS NOT NULL : expr1�� ����
--expr1 IS NULL COADLESCE(expr2,expr3.....)

SELECT empno, ename, comm, sal, COALESCE(comm, sal) coal_sal
FROM emp;

--null fn4
SELECT empno, ename, mgr, NVL(mgr, 9999) mgr_N,
       NVL2(mgr, mgr, 9999) MGR_N_1,
       COALESCE(mgr, 9999)MGR_N_2
FROM emp;

--null fn5

SELECT userid, usernm, reg_dt, NVL(reg_dt, sysdate) N_REG_DT
FROM users
WHERE userid NOT IN LIKE ('brown');

--condition
--case
--emp. job �÷��� ��������
-- 'SALESMAN' �̸� sal * 1.05�� ������ �� ����
--'MANAGER' �̸� sal * 1.10�� ������ �� ����
--'PRESIDENT' �̸� sal * 1.20�� ������ �� ����
--empno, ename, sal, ���� ������ �޿� AS bonus
--�� 3���� ������ �ƴҰ�� 
SELECT empno, ename, job, sal,
       CASE
            WHEN job = 'SALESMAN' THEN sal *1.05
            WHEN job = 'MANAGER' THEN sal *1.05
            WHEN job = 'PRESIDENT' THEN sal *1.05
            ELSE sal
       END bonus,
       comm,
        --NULL ó�� �Լ� ������� �ʰ� CASE ���� �̿��Ͽ�
        --comm�� NULL�� ��� -10�� �����ϵ��� ����
        CASE
            WHEN comm IS NULL THEN -10
            ELSE comm
            END case_null
FROM emp;       

--DECODE
SELECT empno, ename, job, sal,
        DECODE( job, 'SALESMAN',  sal *1.05,
                     'MANAGER',   sal *1.10,
                     'PRESIDENT', sal * 1.20) bonus
 FROM emp;
 
 
 