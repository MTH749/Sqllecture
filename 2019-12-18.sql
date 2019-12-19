SELECT dept_h.*, LEVEL, LPAD(' ',(LEVEL -1) *3) || deptnm nm
FROM dept_h
START WITH deptcd = 'dept0' --�������� deptcd = 'dept0' --> XXȸ��(�ֻ��� ����)
CONNECT BY PRIOR deptcd = p_deptcd; -- PRIOR = �̹� ���� ������


/*
    dept0 xxȸ��
        dept0_00 �����κ�
             dept0_00_0 ��������
        dept0_01 ������ȹ��
             dept0_01_0 ��ȹ��
                dept0_00_0_0 ��ȹ��Ʈ
        dept0_02 �����ý��ۺ�
                deptdept0_02_0  ���� 1��
                deptdept0_02_1  ���� 2��
                */
   
 SELECT LPAD('XXȸ��',15,'*'),
        LPAD('XXȸ��',15)
 FROM dual;

--h_2
SELECT deptcd,LPAD(' ',(LEVEL-1) *4) || deptnm deptnm,p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT *
FROM dept_h;
--h_3
--��������(dept0_00_0)�� �������� ����� �������� �ۼ�
--�ڱ� �μ��� �θ� �μ��� ������ �Ѵ�
SELECT deptcd,LPAD(' ',(LEVEL-1) *4) || deptnm deptnm,p_deptcd
FROM dept_h
START WITH deptcd ='dept0_00_0'
CONNECT BY PRIOR p_deptcd =deptcd; --PRIOR�� �ڿ� ���� �� �ִ� (CONNECT BY ���� ������ ���� ex p_deptcd = PRIOR deptcd
                                   -- 1���� �ƴ� ������ �� �� �ִ�.ex p_deptcd = PRIOR deptcd AND col = PRIOR col2
                                   --WHERE ���� �ٸ��� ����
--���� ������ ���÷����� ���� �����Ѱ�?
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
START WITH ORG_CD = 'XXȸ��'
CONNECT BY PRIOR ORG_CD = PARENT_ORG_CD;

SELECT *
FROM NO_EMP;

--pruning branch (����ġ��)
--���� ������ �������
--FROM --> START WUTH ~ CONNECT BY --> WHERE
--������ CONNECT BY ���� ����� ���
-- . ���ǿ� ���� ���� ROW �� ������ �ȵǰ� ����
--  ������ WHERE ���� ����� ���
--. START WITH ~ CONNECT BY ���� ���� ���������� ���� �����
--  WHERE ���� ����� ��� ���� �ش��ϴ� �����͸� ǥ��

--�ֻ��� ��忡�� ��������� Ž��
--CONNECT BY ���� deptnm != '������ȹ��'������ ����� ���
SELECT *
FROM DEPT_H
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = P_DEPTCD AND DEPTNM != '������ȹ��';


--WHERE ���� deptnm != '������ȹ��'������ ����� ���
-- ���� ������ �����ϰ� ���� ���� ����� WHERE �� ������ ����
SELECT *
FROM DEPT_H
WHERE DEPTNM != '������ȹ��'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = P_DEPTCD;


-- ���� �������� ��� ������ Ư�� �Լ�
-- CONNECT_BY_ROOT(col) ���� �ֻ��� row�� col ������ ��ȸ
SELECT deptcd, LPAD(' ', 4*(LEVEL-1)) || deptnm,
        CONNECT_BY_ROOT(deptnm) c_root
FROM DEPT_H
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = P_DEPTCD;

--SYS_CONNECT_BY_PATH (col,������) : �ֻ��� row���� ���� row ����
--col���� �����ڷ� �������� ���ڿ� (EX : XX ȸ��- �����κε�������
SELECT deptcd, LPAD(' ', 4*(LEVEL-1)) || deptnm,
        CONNECT_BY_ROOT(deptnm) c_root,
        LTRIM(SYS_CONNECT_BY_PATH(deptnm,'-'),'-') sys_path 
FROM DEPT_H
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = P_DEPTCD;

--CONNECT_BY_ISLEAF : �ش� ROW�� ������ �������(leaf Node)
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

