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
WHERE sido = '대전광역시';
GROUP BY GB;


--도시발전지수가 높은 순으로 나열
--도시발전지수 = 버거킹 갯수 + kfc 개수 + 맥도날드 개수) / 롯데리아 개수
--순위 / 시도 / 시군구 / 도시발전지수 (소수점 첫번째 자리까지(둘쨰자리에서 반올림)
--1 / 서울 특별시 / 서초구 / 7.5
--2 / 서울 특별시 / 강남구 / 7.2

--해당 시도, 시군구별 프렌차이즈별 건수가 표현
SELECT ROWNUM rn, sido,sigungu, 도시발전지수
FROM
(SELECT a.sido, a.sigungu, ROUND( a.cnt/b.cnt,1 )as 도시발전지수
FROM 
    (SELECT sido, sigungu, COUNT(*) cnt
    FROM fastfood
    WHERE gb in ('버거킹','KFC', '맥도날드')
    GROUP BY sido,sigungu) a,
    
    (SELECT sido, sigungu, COUNT(*) cnt
    FROM fastfood
    WHERE gb in '롯데리아'
    GROUP BY sido,sigungu) b

WHERE a.sido = b.sido
AND a.sigungu = b.sigungu)
ORDER BY 도시발전지수 DESC;


SELECT *
FROM TAX
ORDER BY sal desc;

