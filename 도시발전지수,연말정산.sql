-- 1. tax 테이블을 이용 시도/시군구별 인당 연말정산 신고액 구하기
--2.신고액이 많은 순서로 랭킹 부여하기

--랭킹(1) 시도(2) 시군구(3) 인당연말정산신고액(4)
--서울 특별시 서초구 7000

SELECT year.sido,year.sigungu,year.sal,year.people,year.인당연말정산신고액,city.sido,city.sigungu,city.도시발전지수
FROM
(SELECT ROWNUM 랭킹,c.*
FROM
(SELECT a.sido, a.sigungu, ROUND( a.cnt/b.cnt,1 )as 도시발전지수
FROM 
    (SELECT sido, sigungu, COUNT(*) cnt
    FROM fastfood
    WHERE gb in ('버거킹','KFC','맥도날드')
    GROUP BY sido,sigungu) a,
    
    (SELECT sido, sigungu, COUNT(*) cnt
    FROM fastfood
    WHERE gb in '롯데리아'
    GROUP BY sido,sigungu) b

WHERE a.sido = b.sido
AND a.sigungu = b.sigungu) c
ORDER BY 도시발전지수 desc) city,


(SELECT ROWNUM 랭킹,sido,sigungu,sal,people,인당연말정산신고액
FROM
    (SELECT sido, sigungu, sal, people, ROUND (sal/people,1) 인당연말정산신고액
    FROM tax
    ORDER BY 인당연말정산신고액 desc)) year
    
WHERE city.랭킹 = year.랭킹(+)
ORDER BY city.랭킹;


--도시발전지수 시도 , 시군구와 연말정산 납임금액의 시도, 시군구가 같은 지역끼리 조인
--정렬 순서는 tax 테이블의 id 컬럼순으로 정렬

SELECT year.id ,year.sido,year.sigungu,year.sal,year.people
FROM

(SELECT a.sido, a.sigungu, ROUND( a.cnt/b.cnt,1 )as 도시발전지수
FROM 
    (SELECT sido, sigungu, COUNT(*) cnt
    FROM fastfood
    WHERE gb in ('버거킹','KFC','맥도날드')
    GROUP BY sido,sigungu) a,
    
    (SELECT sido, sigungu, COUNT(*) cnt
    FROM fastfood
    WHERE gb in '롯데리아'
    GROUP BY sido,sigungu) b

WHERE a.sido = b.sido
AND a.sigungu = b.sigungu) city,


    (SELECT ROWNUM rn, id, sido, sigungu, sal, people, ROUND (sal/people,1) 인당연말정산신고액
    FROM tax
    ORDER BY 인당연말정산신고액 desc) year
WHERE city.sido (+)= year.sido
AND city.sigungu (+) = year.sigungu
ORDER BY year.id;



SELECT *
FROM tax;