/*
��View�� �ϳ� �̻��� ���̺��̳� �ٸ� ���� �����͸� �� �� �ְ� �ϴ� �����ͺ��̽� ��ü��. 
���� �����ʹ� �並 �����ϴ� ���̺� ��� ������ ��ġ ���̺�ó�� ����� �� �ִ�. 
���� ���̺� �Ӹ� �ƴ϶� �ٸ� �並 ������ ���ο� �並 ����� ����� �� �ִ�
�����͸� ���ٴ� �ǹ̰� �����Ƿ� ���� ���Ǵ� �����͸� ��ȸ�ϴ� SELECT������ �����ȴ�.

���̺��� ���� �����͸� �����Ѵ�. �׷��� ��� �����͸� �����ϴ� ���� �ƴ� SELECT���� �ڵ带 �����Ѵ�.
�׷��� �並 ���� SELECT���� ������ �Ǿ�, �����͸� ��ȸ�ϰ� �Ǵ� ���̴�.
*/
/*
�� ����
    CREATE OR REPLACE VIEW [��Ű��.]��� AS
    SELECT ����;
    
�뵵 : 1) SELECT������ �����ϴ� �� ����, 2)���������� �߿��� �÷��� ������ �ִ� ���̺� ����� ���� ��� ��ü�Ҷ�
*/

--�� ���� �� ���� (CREATE OR REPLACE)
--���� : VW_EMPLOYEES_DEPARTMENT_ID_50 ���̸����� SELECT ������ �ڵ带 �����Ͽ� �����Ѵ�.
--SELECT ���� �� ���� �Ǵ� ���������� �߿��� �÷�(�� : SALARY �޿�)
--���ȶ����� ���� ���̺��� ����� ȿ���� �ִ�.
CREATE OR REPLACE VIEW VW_EMPLOYEES_DEPARTMENT_ID_50
AS
SELECT employee_id, EMP_NAME, HIRE_DATE, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

--�� ����(����: �Լ��� ȣ���ϴ� �ǹ�). �Ʒ�ó�� �ۼ��ϸ�, �䰡 �����ϴ� SELECT���� ������ �Ǿ� �����͸� Ȯ���� �� �ִ�.
SELECT * FROM VW_EMPLOYEES_DEPARTMENT_ID_50;

/*
�� ����
    DROP VIEW [��Ű��.]���;
*/
DROP VIEW VW_EMPLOYEES_DEPARTMENT_ID_50;

/*
06 | ������
������(Sequence)�� �ڵ� ������ ��ȯ�ϴ� �����ͺ��̽� ��ü��. 
*/

/*
? INCREMENT BY ��������: �������ڴ� 0�� �ƴ� ����. ����̸� ����, �����̸� ����. ����Ʈ ���� 1

? START WITH ���ۼ���: ���ۼ����� ����Ʈ ���� ������ ���� MINVALUE, ������ ��� MAXVALUE.

? NOMINVALUE: ����Ʈ ������ ������ �� 1, ������ ��� -(1027 -1).

? MINVALUE �ּڰ�: �ּڰ��� ���ۼ��ڿ� �۰ų� ���ƾ� �ϰ� MANVALUE���� �۾ƾ� �Ѵ�.

? NOMAXVALUE: ����Ʈ ������ ������ �� 1028-1, ������ ��� -1.

? MAXVALUE �ִ�: �ִ��� ���ۼ��ڿ� ���ų� Ŀ�� �ϰ� MINVALUE���� Ŀ�� �Ѵ�.

? NOCYCLE: ����Ʈ ������ �ִ볪 �ּڰ��� �����ϸ� ���� ����.

? CYCLE: ������ �ִ񰪿� �����ϸ� �ٽ� �ּڰ����� ����, ���Ҵ� �ּڰ��� �����ϸ� �ٽ� �ִ񰪿��� ����.

? NOCACHE: ����Ʈ�� �޸𸮿� ������ ���� �̸� �Ҵ��� ���� ������ ����Ʈ ���� 20.

? CACHE: �޸𸮿� ������ ���� �̸� �Ҵ��� ����.
*/

--������ ����
CREATE SEQUENCE MY_SEQ1
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 1000
NOCYCLE
NOCACHE;

CREATE SEQUENCE MY_SEQ2; -- �ּҰ� 1, ������ 1

--������ ��ɾ�
--NEXTVAL : ����� �� ���� ó������ �ּҰ� 1�� ��µǰ� �������� ������ 1�� ������ ���� ��µȴ�.
--CURRVAL : ���� ������ ���� Ȯ���Ҷ� ����Ѵ�. 

SELECT MY_SEQ2.NEXTVAL FROM DUAL; -- �ּҰ� 1
SELECT MY_SEQ2.NEXTVAL FROM DUAL; -- �������� �۵� +1 ����� 2

--������ �� Ȯ��
--����> ������ ó�� ����� NEXTVAL ��ɾ ������� �ʰ� �ش� ��ɾ ����ϸ� �ȵȴ�.
SELECT MY_SEQ2.CURRVAL FROM DUAL;

CREATE SEQUENCE MY_SEQ3;
SELECT MY_SEQ2.CURRVAL FROM DUAL; --�����߻�

--������ ���.
CREATE SEQUENCE MY_SEQ4;

CREATE TABLE SAMPLE_8 (
  IDX       NUMBER          PRIMARY KEY,
  NAME      VARCHAR2(20)    NOT NULL,
  REG_DATE  DATE            DEFAULT SYSDATE
);

INSERT INTO SAMPLE_8(IDX, NAME) VALUES(MY_SEQ4.NEXTVAL, '�����'); --�ʱⰪ 1

INSERT INTO SAMPLE_8(IDX, NAME) VALUES(MY_SEQ4.NEXTVAL, 'Ȳ����'); --INCREMENT_BY

INSERT INTO SAMPLE_8(IDX, NAME) VALUES(MY_SEQ4.NEXTVAL, '�����'); --INCREMENT_BY

INSERT INTO SAMPLE_8(IDX, NAME) VALUES(MY_SEQ4.NEXTVAL, '�̰���'); --INCREMENT_BY

SELECT * FROM SAMPLE_8;

CREATE SEQUENCE MY_SEQ5
MINVALUE 1000 --�ʱⰪ
INCREMENT BY 10;  --���������ε� ��밡���ϴ�.

SELECT MY_SEQ5.NEXTVAL FROM DUAL; --1000

SELECT MY_SEQ5.NEXTVAL FROM DUAL; --1010

SELECT MY_SEQ5.NEXTVAL FROM DUAL; --1020


--������ ����
CREATE SEQUENCE ��������

--������ ����
ALTER SEQUENCE ��������
INCREMENT BY 5;

ALTER SEQUENCE ��������
MAXVALUE 999999;

--START WITH �Ӽ��� �������� ���� �Ұ���

--������ ����
DROP SEQUENCE ��������;

--04 | �ε���
--�ε���Index�� ���̺� �ִ� �����͸� ���� ã�� ���� �뵵�� �����ͺ��̽� ��ü��. 
--? �ε��� ���� �÷� ������ ���� �з�: ���� �ε����� ���� �ε���
--? ���ϼ� ���ο� ���� �з�: UNIQUE �ε���, NON-UNIQUE �ε���
--? �ε��� ���� ������ ���� �з�: B-tree �ε���(�Ϲ������� ���� ���� �����), ��Ʈ�� �ε���, �Լ� ��� �ε���

--���̺� primary key ���������� �����ϸ�, �������� �ε����� �����ȴ�.
-- �⺻Ű
--1)����Ű : �÷� 1��
--2)����Ű : �÷� ������ �ϳ��� ������ ��� ����

--�ε��� ����
--    CREATE[UNIQUE] INDEX [��Ű����.]�ε�����
--    ON [��Ű����.]���̺��(�÷�1, �÷�2, ...);

--�÷� 1���� �ε��� ���� : ���� �ε���
CREATE UNIQUE INDEX ex2_10_ix01
ON ex2_10 (col11); 
--COL1�÷��� �ߺ��� �����ʹ� ������� �����鼭, 
--�˻��� �� �÷��� �����͸� �˻��� ��������� �������� �ε��� �����Ѵ�.

--��Ƽ������(Optimaizer) : select���� ����� ���� ó���� �� �� �ֵ��� �׺���̼� ���� ���.
SELECT * FROM ex2_10 WHERE COL1 = ��;

--���� �ε���, �ߺ����� �ȵ�
--�˻��� ���� �ͺ��� ������ ���ξ ����ؾ���.
CREATE INDEX EX2_10_IX2
ON EX2_10(COL11, COL2)


CREATE TABLE ȸ�� (
ȸ�����̵�, --PRIVATE KEY
�̸�,
�ֹε�Ϲ�ȣ --

CREATE UNIQUE INDEX ȸ��_INX
ON ȸ��(�ֹε�Ϲ�ȣ):

--�ε����� �⺻������ ���ĵ� ���� ���·� ������ش�.
--�׷��Ƿ� �ε����� �ʹ� ���� ����� SELECT �ܿ� INSERT, DELETE, UPDATE �� ���ɿ� ���ϰ� �ڵ�����.

--�ε����� ������ �� ����ؾ� �� ������ �����ϸ� ������ ����.

--? �Ϲ������� ���̺� ��ü �ο� ���� 15%������ �����͸� ��ȸ�� �� �ε����� �����Ѵ�
--���� 15%�� ������ ���� �ƴϸ� ���̺� �Ǽ�, ������ ���� ������ ���� �޶�����.

--? ���̺� �Ǽ��� ���ٸ�(�ڵ强 ���̺�) ���� �ε����� ���� �ʿ䰡 ����
--������ ������ ���� ���̺��̳� �ε����� Ž���ϴ� ���� ��ĵ(scan)�̶�� �ϴµ�, 
--���̺� �Ǽ��� ������ �ε����� �����ϱ⺸�� ���̺� ��ü�� ��ĵ�ϴ� ���� ������.

--? �������� ���ϼ� ������ ���ų� ������ ���� ���� ���� �÷��� �ε����� ����� ���� ����

--? NULL�� ���� ���Ե� �÷��� �ε��� �÷����� ����� ����ġ �ʴ�

--? ���� �ε����� ���� ����, �÷��� ������ �߿��ϴ�
--����, ���� ���Ǵ� �÷��� ������ �տ� �δ� ���� ����.

--? ���̺� ���� �� �ִ� �ε��� ���� ������ ������, �ʹ� ���� ����� ������ ���� ���ϰ� �߻��Ѵ�





