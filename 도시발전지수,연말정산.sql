-- 1. tax ���̺��� �̿� �õ�/�ñ����� �δ� �������� �Ű�� ���ϱ�
--2.�Ű���� ���� ������ ��ŷ �ο��ϱ�

--��ŷ(1) �õ�(2) �ñ���(3) �δ翬������Ű��(4)
--���� Ư���� ���ʱ� 7000

SELECT year.sido,year.sigungu,year.sal,year.people,year.�δ翬������Ű��,city.sido,city.sigungu,city.���ù�������
FROM
(SELECT ROWNUM ��ŷ,c.*
FROM
(SELECT a.sido, a.sigungu, ROUND( a.cnt/b.cnt,1 )as ���ù�������
FROM 
    (SELECT sido, sigungu, COUNT(*) cnt
    FROM fastfood
    WHERE gb in ('����ŷ','KFC','�Ƶ�����')
    GROUP BY sido,sigungu) a,
    
    (SELECT sido, sigungu, COUNT(*) cnt
    FROM fastfood
    WHERE gb in '�Ե�����'
    GROUP BY sido,sigungu) b

WHERE a.sido = b.sido
AND a.sigungu = b.sigungu) c
ORDER BY ���ù������� desc) city,


(SELECT ROWNUM ��ŷ,sido,sigungu,sal,people,�δ翬������Ű��
FROM
    (SELECT sido, sigungu, sal, people, ROUND (sal/people,1) �δ翬������Ű��
    FROM tax
    ORDER BY �δ翬������Ű�� desc)) year
    
WHERE city.��ŷ = year.��ŷ(+)
ORDER BY city.��ŷ;


--���ù������� �õ� , �ñ����� �������� ���ӱݾ��� �õ�, �ñ����� ���� �������� ����
--���� ������ tax ���̺��� id �÷������� ����

SELECT year.id ,year.sido,year.sigungu,year.sal,year.people
FROM

(SELECT a.sido, a.sigungu, ROUND( a.cnt/b.cnt,1 )as ���ù�������
FROM 
    (SELECT sido, sigungu, COUNT(*) cnt
    FROM fastfood
    WHERE gb in ('����ŷ','KFC','�Ƶ�����')
    GROUP BY sido,sigungu) a,
    
    (SELECT sido, sigungu, COUNT(*) cnt
    FROM fastfood
    WHERE gb in '�Ե�����'
    GROUP BY sido,sigungu) b

WHERE a.sido = b.sido
AND a.sigungu = b.sigungu) city,


    (SELECT ROWNUM rn, id, sido, sigungu, sal, people, ROUND (sal/people,1) �δ翬������Ű��
    FROM tax
    ORDER BY �δ翬������Ű�� desc) year
WHERE city.sido (+)= year.sido
AND city.sigungu (+) = year.sigungu
ORDER BY year.id;



SELECT *
FROM tax;