--OUTER 1

--ORACLE
SELECT TO_CHAR(a.BUY_DATE, 'YY/MM/DD') BUY_DATE, a.BUY_PROD,  b.PROD_ID PROD_ID, b.PROD_NAME, a.BUY_QTY
FROM buyprod a , prod b
WHERE a.BUY_PROD(+) = b.prod_id
AND a.BUY_DATE(+) = '20050125'
ORDER BY a.buy_date;

--ANSI 
SELECT TO_CHAR(a.BUY_DATE, 'YY/MM/DD') BUY_DATE, a.BUY_PROD,  b.PROD_ID PROD_ID, b.PROD_NAME, a.BUY_QTY
FROM buyprod a RIGHT JOIN prod b
        ON (a.BUY_PROD(+) = b.prod_id)
AND a.BUY_DATE = '20050125'
ORDER BY a.buy_date;



--OUTER 2

--ORRACLE
SELECT nvl(TO_CHAR(a.BUY_DATE, 'YY/MM/DD'),'05/01/25') BUY_DATE, a.BUY_PROD,  b.PROD_ID PROD_ID, b.PROD_NAME, a.BUY_QTY
FROM buyprod a , prod b
WHERE a.BUY_PROD(+) = b.prod_id
AND a.BUY_DATE(+) = '20050125'
ORDER BY a.buy_date;

--ANSI
SELECT nvl(TO_CHAR(a.BUY_DATE, 'YY/MM/DD'),'05/01/25') BUY_DATE, a.BUY_PROD,  b.PROD_ID PROD_ID, b.PROD_NAME, a.BUY_QTY
FROM buyprod a RIGHT JOIN prod b
ON (a.BUY_PROD(+) = b.prod_id)
AND a.BUY_DATE(+) = '20050125'
ORDER BY a.buy_date;

--outer 3

SELECT nvl(TO_CHAR(a.BUY_DATE, 'YY/MM/DD'),'05/01/25') BUY_DATE, a.BUY_PROD,
        b.PROD_ID PROD_ID, b.PROD_NAME, nvl(a.BUY_QTY,0) BYY_QTY
FROM buyprod a , prod b
WHERE a.BUY_PROD(+) = b.prod_id
AND a.BUY_DATE(+) = '20050125'
ORDER BY a.buy_date;

--outer 4

SELECT p.PID, p.PNM ,nvl(c.cid,1) cid, nvl(c. day,0) day, nvl(c.CNT, 0)cnt
FROM cycle c, product p
WHERE c.cid (+) = 1
AND c.pid(+) = p.pid
ORDER BY PID;

--outer 5
SELECT a.pid , a.pnm , a.cid, customer.cnm , a.day, a.cnt
FROM
        (SELECT product.PID, product.PNM , nvl(cycle.cid,1) cid, nvl(cycle. day,0) day, nvl(cycle.CNT, 0)cnt
        FROM cycle , product
        WHERE cycle.cid(+) = 1
        AND cycle.pid (+) = product.pid ) a, customer
WHERE a.cid = customer.cid;


SELECT *
FROM customer  , product ;

SELECT *
FROM fastfood
WHERE sido = '����������';
GROUP BY GB;


--���ù��������� ���� ������ ����
--���ù������� = ����ŷ ���� + kfc ���� + �Ƶ����� ����) / �Ե����� ����
--���� / �õ� / �ñ��� / ���ù������� (�Ҽ��� ù��° �ڸ�����(�Ѥ��ڸ����� �ݿø�)
--1 / ���� Ư���� / ���ʱ� / 7.5
--2 / ���� Ư���� / ������ / 7.2

--�ش� �õ�, �ñ����� ��������� �Ǽ��� ǥ��
SELECT ROWNUM rn, sido,sigungu, ���ù�������
FROM
(SELECT a.sido, a.sigungu, ROUND( a.cnt/b.cnt,1 )as ���ù�������
FROM 
    (SELECT sido, sigungu, COUNT(*) cnt
    FROM fastfood
    WHERE gb in ('����ŷ','KFC', '�Ƶ�����')
    GROUP BY sido,sigungu) a,
    
    (SELECT sido, sigungu, COUNT(*) cnt
    FROM fastfood
    WHERE gb in '�Ե�����'
    GROUP BY sido,sigungu) b

WHERE a.sido = b.sido
AND a.sigungu = b.sigungu)
ORDER BY ���ù������� DESC;


SELECT *
FROM TAX
ORDER BY sal desc;

