--��Ī : ���̺� �÷��� �ٸ� �̸����� ��Ī
-- [AS] ��Ī ��
--SELECT empno [AS] eno
--FROM emp e

--SYNONYM (���Ǿ�)
--����Ŭ ��ü�� �ٸ� �̸����� �θ� �� �ֵ��� �ϴ°�
--���࿡ emp���̺��� e��� �ϴ� synonym(���Ǿ�)�� ������ �ϸ�
--������ ���� SQL�� �ۼ� �� �� �ִ�
--SELECT *
--FROM e;

SELECT *
FROM hr.employees;

--synonym ����
--CREATE [public] SYNONYM synonym_name for object;

--������ SYNONYM ���� ������ �ο�
GRANT CREATE SYNONYM TO mth;  

--emp ���̺��� ����Ͽ� synonym e�� ����
CREATE SYNONYM e for emp;

--emp��� ���̺� �� ��ſ� e ���� �ϴ� �ó���� ����Ͽ� ������ �ۼ� �� �� �ֵ�.

SELECT *
FROM emp;

SELECT *
FROM e;

--mth ������ fastfood ���̺��� hr ���������� �� �� �ֵ��� ���̺� ��ȸ ������ �ο�
GRANT SELECT ON fastfood TO hr;

