SELECT dept_h.*, LEVEL, LPAD(' ',(LEVEL -1) *3) || deptnm nm
FROM dept_h
START WITH deptcd = 'dept0' --시작점은 deptcd = 'dept0' --> XX회사(최상위 조직)
CONNECT BY PRIOR deptcd = p_deptcd; -- PRIOR = 이미 읽은 데이터


/*
    dept0 xx회사
        dept0_00 디자인부
             dept0_00_0 디자인팀
        dept0_01 정보기획부
             dept0_01_0 기획팀
                dept0_00_0_0 기획파트
        dept0_02 정보시스템부
                deptdept0_02_0  개발 1팀
                deptdept0_02_1  개발 2팀
                */
   
 SELECT LPAD('XX회사',15,'*'),
        LPAD('XX회사',15)
 FROM dual;

--h_2
SELECT deptcd,LPAD(' ',(LEVEL-1) *4) || deptnm deptnm,p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT *
FROM dept_h;
--h_3
--디자인팀(dept0_00_0)을 기준으로 상향식 계층쿼리 작성
--자기 부서의 부모 부서와 연결을 한다
SELECT deptcd,LPAD(' ',(LEVEL-1) *4) || deptnm deptnm,p_deptcd
FROM dept_h
START WITH deptcd ='dept0_00_0'
CONNECT BY PRIOR p_deptcd =deptcd; --PRIOR는 뒤에 붙일 수 있다 (CONNECT BY 절에 속하지 않음 ex p_deptcd = PRIOR deptcd
                                   -- 1번이 아닌 여러번 올 수 있다.ex p_deptcd = PRIOR deptcd AND col = PRIOR col2
                                   --WHERE 절과 다를게 없음
--조인 조건은 한컬럼에만 적용 가능한가?
SELECT *
FROM  tab_a, tab_b
WHERE tab_a.a = tab_b.a
AND   tab_a.a = tab_a.a;

--h_4
SELECT LPAD(' ', 4* (LEVEL-1))|| S_ID S_ID, value
FROM H_sum
START WITH S_ID = 0
CONNECT BY PRIOR s_id = ps_id;

--h_5
SELECT LPAD(' ', 4* (LEVEL-1))|| ORG_CD ORG_CD , NO_EMP
FROM no_emp
START WITH ORG_CD = 'XX회사'
CONNECT BY PRIOR ORG_CD = PARENT_ORG_CD;

SELECT *
FROM NO_EMP;

--pruning branch (가지치기)
--계층 쿼리의 실행순서
--FROM --> START WUTH ~ CONNECT BY --> WHERE
--조건을 CONNECT BY 절에 기술한 경우
-- . 조건에 따라 다음 ROW 로 연결이 안되고 종료
--  조건을 WHERE 절에 기술한 경우
--. START WITH ~ CONNECT BY 절에 의해 계층형으로 나온 결과에
--  WHERE 절에 기술한 결과 값에 해당하는 데이터만 표현

--최상위 노드에서 하향식으로 탐색
--CONNECT BY 절에 deptnm != '정보기획부'조건을 기술한 경우
SELECT *
FROM DEPT_H
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = P_DEPTCD AND DEPTNM != '정보기획부';


--WHERE 절에 deptnm != '정보기획부'조건을 기술한 경우
-- 계층 쿼리를 실행하고 나서 최종 결과에 WHERE 절 조건을 적용
SELECT *
FROM DEPT_H
WHERE DEPTNM != '정보기획부'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = P_DEPTCD;


-- 계층 쿼리에서 사용 가능한 특수 함수
-- CONNECT_BY_ROOT(col) 가장 최상위 row의 col 정보값 조회
SELECT deptcd, LPAD(' ', 4*(LEVEL-1)) || deptnm,
        CONNECT_BY_ROOT(deptnm) c_root
FROM DEPT_H
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = P_DEPTCD;

--SYS_CONNECT_BY_PATH (col,구분자) : 최상위 row에서 현재 row 까지
--col값을 구분자로 연결해준 문자열 (EX : XX 회사- 디자인부디자인팀
SELECT deptcd, LPAD(' ', 4*(LEVEL-1)) || deptnm,
        CONNECT_BY_ROOT(deptnm) c_root,
        LTRIM(SYS_CONNECT_BY_PATH(deptnm,'-'),'-') sys_path 
FROM DEPT_H
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = P_DEPTCD;

--CONNECT_BY_ISLEAF : 해당 ROW가 마지막 노드인지(leaf Node)
--leaf node :1, node : 0
SELECT deptcd, LPAD(' ', 4*(LEVEL-1)) || deptnm,
        CONNECT_BY_ROOT(deptnm) c_root,
        LTRIM(SYS_CONNECT_BY_PATH(deptnm,'-'),'-') sys_path ,
        
        CONNECT_BY_ISLEAF isleaf
FROM DEPT_H
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = P_DEPTCD;

---h_6
SELECT SEQ, LPAD (' ', 4*(LEVEL-1)) || TITLE TITLE  
FROM board_test
START WITH PARENT_SEQ is null
CONNECT BY PRIOR seq = PARENT_SEQ ;

-----h_7
SELECT SEQ, LPAD (' ', 4*(LEVEL-1)) || TITLE TITLE  
FROM board_test
START WITH PARENT_SEQ is null
CONNECT BY PRIOR seq = PARENT_SEQ
ORDER BY seq desc;
-----h_8
SELECT SEQ, LPAD (' ', 4*(LEVEL-1)) || TITLE TITLE  
FROM board_test
START WITH PARENT_SEQ is null
CONNECT BY PRIOR seq = PARENT_SEQ
ORDER SIBLINGS BY seq desc;

-----hr9
SELECT SEQ,TITLE
FROM
(SELECT SEQ, CONNECT_BY_ROOT(seq), LPAD (' ', 4*(LEVEL-1)) || TITLE TITLE  
FROM BOARD_TEST 
START WITH PARENT_SEQ is null
CONNECT BY PRIOR seq = PARENT_SEQ
order by  CONNECT_BY_ROOT(seq)desc ,seq asc);

