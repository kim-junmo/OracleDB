-- �н��� ��������
-- �����ڸ� ��������
CREATE USER sqldb IDENTIFIED BY 1234
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP;
    
-- ���Ѻο�. connect : ����(����), resource : �ڿ�����, dba : �����ͺ��̽� ��������
-- GRANT ���� 1,����2, ����3 TO sqldb
GRANT connect, resource, dba TO sqldb; --dba ������ ���ȶ����� �ο��� ������ �ʴ´�.

-- �������� �� ���� �ο��۾� : ������ �������� �����ؼ� ����� �����ؾ� �Ѵ�. (sys, system)
-- ������ ���� (sys, system) ����(����) ����
CREATE USER sqldb IDENTIFIED BY 1234
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP;

GRANT CONNECT, RESOURCE, dba TO sqlDB;

-- ���������� ���Ѻο��۾��� ����Ǿ��� ���, SQLDB�������� ����
-- �н��� ������ �غ��۾�
-- 1������ 6������ ���������� ���� ����� �����Ѵ�.

--1)
CREATE TABLE userTBL -- ȸ�� ���̺�
( userID  	CHAR(8) NOT NULL PRIMARY KEY, -- ����� ���̵�(PK)
  userName  	NVARCHAR2(10) NOT NULL, -- �̸�
  birthYear 	NUMBER(4) NOT NULL,  -- ����⵵
  addr	  	NCHAR(2) NOT NULL, -- ����(���,����,�泲 ������ 2���ڸ��Է�)
  mobile1	CHAR(3), -- �޴����� ����(010, 011, 016, 017, 018, 019 ��)
  mobile2	CHAR(8), -- �޴����� ������ ��ȭ��ȣ(����������)
  height    	NUMBER(3),  -- Ű
  mDate    	DATE  -- ȸ�� ������
);

--2)
CREATE TABLE buyTBL -- ȸ�� ���� ���̺�
(  idNum 	NUMBER(8) NOT NULL PRIMARY KEY, -- ����(PK)
   userID  	CHAR(8) NOT NULL, -- ���̵�(FK)
   prodName 	NCHAR(6) NOT NULL, --  ��ǰ��
   groupName 	NCHAR(4)  , -- �з�
   price     	NUMBER(8)  NOT NULL, -- �ܰ�
   amount    	NUMBER(3)  NOT NULL, -- ����
   FOREIGN KEY (userID) REFERENCES userTBL(userID)
);

--3)
INSERT INTO userTBL VALUES('LSG', '�̽±�', 1987, '����', '011', '11111111', 182, '2008-8-8');
INSERT INTO userTBL VALUES('KBS', '�����', 1979, '�泲', '011', '22222222', 173, '2012-4-4');
INSERT INTO userTBL VALUES('KKH', '���ȣ', 1971, '����', '019', '33333333', 177, '2007-7-7');
INSERT INTO userTBL VALUES('JYP', '������', 1950, '���', '011', '44444444', 166, '2009-4-4');
INSERT INTO userTBL VALUES('SSK', '���ð�', 1979, '����', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO userTBL VALUES('LJB', '�����', 1963, '����', '016', '66666666', 182, '2009-9-9');
INSERT INTO userTBL VALUES('YJS', '������', 1969, '�泲', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO userTBL VALUES('EJW', '������', 1972, '���', '011', '88888888', 174, '2014-3-3');
INSERT INTO userTBL VALUES('JKW', '������', 1965, '���', '018', '99999999', 172, '2010-10-10');
INSERT INTO userTBL VALUES('BBK', '�ٺ�Ŵ', 1973, '����', '010', '00000000', 176, '2013-5-5');

--4)
CREATE SEQUENCE idSEQ; -- ������ȣ �Է��� ���ؼ� ������ ����

--5)
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '�ȭ', NULL   , 30,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '��Ʈ��', '����', 1000, 1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'JYP', '�����', '����', 200,  1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�����', '����', 200,  5);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', 'û����', '�Ƿ�', 50,   3);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�޸�', '����', 80,  10);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'SSK', 'å'    , '����', 15,   5);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', 'å'    , '����', 15,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', 'û����', '�Ƿ�', 50,   1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�ȭ', NULL   , 30,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', 'å'    , '����', 15,   1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�ȭ', NULL   , 30,   2);

--6)
COMMIT;

--SELECT �� : ���̺� ����Ǿ� �ִ� ������ Ȯ��. ��ȸ ��ɾ�
SELECT * FROM usertbl;
SELECT * FROM buytbl;

--Ư���� ������ �����͸� ��ȸ(SELECT ~ FROM ~ WHRER)

/*
����
SELECT �÷���, �÷��� 2 FROM ���̺�� WHERE ���ǽ�;
*/

--���� ���� : �̸��� ���ȣ�� �����͸� ��ȸ�϶�.
SELECT * FROM USERTBL WHERE USERNAME = '���ȣ';

SELECT * FROM USERTBL WHERE USERNAME = '������';

--���ǳ��� : 1970�� �̻� ����� �ϰ�, Ű�� 182CM �̻��� �����͸� ��ȸ�϶�.
SELECT * FROM USERTBL WHERE birthyear >= 1970 AND height >= 182;

--���ǳ��� : 1970�� �̻� ����� �ϰų�, Ű�� 182CM �̻��� �����͸� ��ȸ�϶�.
SELECT * FROM USERTBL WHERE BIRTHYEAR >= 1970 OR HEIGHT >= 182;

--���ǳ��� : Ű�� 180�̻��̸鼭 183������ �����͸� ��ȸ�϶�
SELECT * FROM USERTBL WHERE HEIGHT >=180 AND HEIGHT <=183;

--���� ������ ����.
SELECT * FROM USERTBL WHERE HEIGHT BETWEEN 180 AND 183;

--���ǳ��� : �ּҰ� �泲�̰ų� ���� �Ǵ� ��� �����͸� ��ȸ�϶�.
SELECT * FROM USERTBL WHERE ADDR = '�泲' OR ADDR = '����' OR ADDR = '���';

--���� ���ϱ���
SELECT * FROM USERTBL WHERE ADDR IN ('�泲', '����', '���');

--���ڵ����� �÷��� ��쿡�� ��Ģ������ �����ϴ�.
SELECT * FROM buytbl;

--�ֹ��ݾ��� ����Ͻÿ�
--��ǥ�� ������ �������� ������ �����͸� ���� ������ ���� ���� ����.
SELECT idnum, USERID, PRODNAME, GROUPNAME, PRICE, AMOUNT, PRICE * AMOUNT AS TOT_PRICE FROM BUYTBL;

SELECT idnum, USERID, PRODNAME, GROUPNAME, PRICE, AMOUNT, PRICE * 1.1 FROM BUYTBL;

-- LIKE ���� ��Ī
--���ǳ��� : �̸� �� ���� "��" ���� �����͸� ����϶�. ���ϵ� ī�� ���� % : ���̰� 0�� �̻��� ���ڿ�.
SELECT * FROM USERTBL WHERE USERNAME LIKE '��%';


--���� ���� : ������ ������ ��ü�̸��� 3�����̸鼭, �������� ������ �����͸� ��ȸ�϶� / ���ϵ�ī�幮�� _ : ���̰� 1���� �ǹ�
SELECT * FROM USERTBL WHERE USERNAME LIKE '_����';
SELECT * FROM USERTBL WHERE USERNAME LIKE '��__';

--LIKE ���� ���漳���� ��.
-- ���� ����Ŭ / å : ����Ŭ SQL�� PL/SQL�� �ٷ�� ��� / https://thebook.io/006696/0063/

--���� ���� : ��� ���̺��� �޿��� 5000�� �Ѵ� �����ȣ�� ������� ��ȸ.
SELECT  employee_id, emp_name FROM  employees WHERE   salary > 5000;

-- order by : ����, 
-- asc : �������� ��� �۾��� ������ �� ���� �������� �۾��ؾ� �Ѵ�.
    SELECT  employee_id, emp_name
      FROM  employees
     WHERE  salary > 5000
     ORDER  BY employee_id; -- order by employee_id asc
     
-- desc : ��������
    SELECT  employee_id, emp_name
      FROM  employees
     WHERE  salary > 5000
     ORDER  BY employee_id desc; -- order by employee_id desc
     
-- ���� ���� : �޿��� 5000�̻��̰�  job_id�� ��IT_PROG���� ����� ��ȸ�Ѵ�
    SELECT  employee_id, emp_name
      FROM  employees
     WHERE  salary >= 5000
       AND  job_id = 'IT_PROG'
     ORDER  BY employee_id;
     
--�����ʹ� ��ҹ��ڸ� �����Ѵ�.
--��ҹ��� �����ϱ� ������ �Ʒ� ���ô� ����� ������ �ʴ´�. 
--��ɾ�� ��ҹ��ڸ� �������� ������, �����ʹ� �����Ѵ�.
    SELECT  employee_id, emp_name
      FROM  employees
     WHERE  salary >= 5000
       AND  job_id = 'it_prog'
     ORDER  BY employee_id;
     
--USERTBL ���̺��� ��������� ������������ �����϶�.
SELECT * FROM USERTBL ORDER BY BIRTHYEAR ASC;

--���ǳ��� : USERTBL���� Ű�� ��������, �̸��� ������������ �����϶�.
-- Ű�� ������ ��쿡�� �̸��� ������������ ������ �ȴ�.
SELECT * FROM USERTBL ORDER BY HEIGHT DESC, USERNAME ASC;

--���ǳ��� : USERTBL���� �ּҸ� ������������ �����϶�.
SELECT * FROM USERTBL ORDER BY ADDR ASC;

SELECT ADDR FROM USERTBL ORDER BY ADDR ASC;

--���ǳ��� : �ߺ��� �����͸� 1���� ����� �������� �����ϴ� ��� : DISTINCT
SELECT DISTINCT ADDR FROM USERTBL ORDER BY ADDR ASC;

-- USERNAME �÷��� ADDR�÷��� ���ÿ� �����Ǵ� �����Ͱ� ����� DISTINCT ȿ���� ���´�.
SELECT DISTINCT USERNAME, ADDR FROM USERTBL ORDER BY ADDR ASC;

--���� 2�� �����ͺ��̽��� �����ϴ� ��ü ���캸�� https://thebook.io/006696/0025/
/*
01. �����ͺ��̽� ��ü�� ����
 - �����ͺ��̽� ��ü�� �����ͺ��̽� ���� �����ϴ� ������ ���� ������ ���Ѵ�.
02. ���̺�
*/
--���̺� ����
/*
���̺� ����
���̺��� CREATE ������ ������ �� �ִµ�, �⺻ ������ ������ ����.

    CREATE TABLE [��Ű��.]���̺��( --��Ű�� : SQLDB
        �÷�1 �÷�1_������Ÿ�� [NULL, NOT NULL],
        �÷�2 �÷�2_������Ÿ�� [NULL, NOT NULL],
    ...
    )[TABLESPACE ���̺����̽���];
*/

-- CREATE TABLE [SQLDB.]���̺�� : [SQLDB.] ���ӵ� �����̸� ��������
-- ���ڿ� ������Ÿ�� : char, varchar2, ncahr, nvarchar2
CREATE TABLE ex2_1 (
    column1 char(10),
    column2 varchar2(10),
    column3 nvarchar2(10),
    column4 number
);
--������ ����
insert into ex2_1(column1, column2) values('abc', 'abc');

--������ Ÿ�� ����
--�÷��� ������������ ũ�⸦ Ȯ��, char(10�� varchar2(10)�� ������
--CHAR : ���̰� ������ ������. �ִ� 2000BYTE���� ��������. ��> �ֹι�ȣ : 14�ڸ� 123456-1234567 CHAR(14)
--VARCHAR2 : ���̰� �������� ������, �ִ� 4000BYTE���� ����, ��> ���̵� 8~15�� �̳�. VARCHAR2(15)

--length(column1) : �÷��� �������� ����
select column1, length(column1), column2, length(column2) from ex2_1

CREATE TABLE ex2_2 (
    COLUMN1 VARCHAR2(3),
    COLUMN2 VARCHAR2(3 BYTE),
    COLUMN3 VARCHAR2(3 CHAR) --����, �ѱ� ������� 3���ڰ� ��.
    //ũ��� ������� �ѱ� �Ǵ� ���� 3������ �Է¸���
);

--����Ŭ �����ͺ��̽� �ý���
/*
    ������, ����, Ư������ : 1BYTE�� ������ �ȴ�.
    �ѱ� : 3BYTE�� ������ �Ǿ� �ִ�.
    �ѱ��� ��� ����Ŭ ��ġ ȯ�濡 ���� ������̱� ������ Ȯ���� �ʿ��ϸ� 2BYTE�� ���� �ִ�.
*/
-- �Լ� : LENGTHB() : ����Ʈ ���̸� ���ϴ� ���� / �Ű������� �����Ǵ� �������� ����Ʈ ������ Ȯ��.
SELECT LENGTHB('A'), LENGTHB('1'), LENGTHB('*'), LENGTHB('��') FROM DUAL; --1,1,1,3
SELECT LENGTHB('�����') FROM DUAL --9BYTE

--������ ����. �������ڿ� �����ʹ� ��ҹ��� ����. 'ABC' , 'abc'�� �ٸ� ���ڿ� �����ͷ� �ν��� �ȴ�.
--INSERT INTO ���̺��(COLUMN1,COLUMN2,COLUMN3) VALUES(��1, ��2, ��3)
INSERT INTO ex2_2(COLUMN1,COLUMN2,COLUMN3) VALUES('abc', 'abc', 'abc');

-- ������ ��ȸ
SELECT COLUMN1, LENGTHB(COLUMN1), LENGTHB(COLUMN1), LENGTHB(COLUMN3) FROM ex2_2;

--�ѱ۵����� �Է� �õ� �����߻�
--ORA-12899: value too large for column "SQLDB"."EX2_2"."COLUMN1" (actual: 9, maximum: 3)
insert into ex2_2(COLUMN1,COLUMN2,COLUMN3) values('ȫ�浿','ȫ�浿','ȫ�浿');

-- ���� : COLUMN3�÷��� VARCHAR2(3 CHAR)�̹Ƿ�, �ѱ� 3�� ���ڸ� ������ ���� ����
insert into ex2_2(COLUMN3) values('ȫ�浿');

-- ������ ��ȸ
SELECT COLUMN1, LENGTHB(COLUMN1), LENGTHB(COLUMN1), LENGTHB(COLUMN3) FROM ex2_2;

--���� ������ Ÿ�� : NUMBER [(PS, [S])]
--��� ���������� NUMBER ������Ÿ������ ��ȯ�Ǿ� ������ �ȴ�.
CREATE TABLE EX2_3 (
    COL_INT INTEGER,
    COL_DEC DECIMAL,
    COL_NUM NUMBER
);

-- user_tab_cols��� �ý��� �� : ���̺��� �÷������� Ȯ���� �� ����ϴ� �뵵
SELECT column_id, column_name, data_type, data_length
FROM user_tab_cols
WHERE table_name = 'EX2_3' --���̺���� �����ͷ� ����� ��� �빮�ڷ� �Է��ؾ� �Ѵ�.
ORDER BY column_id;

--��¥�� ������ Ÿ�� :DATE - �ʴ������� ����, TIMESTAMP - �и�������������� �����Ѵ�.
CREATE TABLE EX2_5 (
    COL_DATE        DATE,
    COL_TIMESTAMP   TIMESTAMP
);

--��¥ �Լ� : SYSDATE, SYSTIMESTAMP

--�����ͻ���
INSERT INTO EX2_5(COL_DATE, COL_TIMESTAMP) VALUES(SYSDATE, SYSTIMESTAMP);

--������ ��ȸ, ��µǴ� ��¥ ������ ���� : 
--���� - ȯ�漳�� - �����ͺ��̽� - NLS-��¥���ĺ��� YYYY-MM-DD HH24:MI:SS
SELECT * FROM EX2_5;

--�ó����� : 
/*
���̺�� : USERINFO
�÷��� : �̸�(U_NAME)VARCHAR2 50, �ּ�(U-ADDR)VARCHAR2 100, ����ó(U-TEL) VARCHAR2 20, ����U-(AGE)NUMBER, �����(U-REG) DATE
*/
CREATE TABLE USERINFO (
    U_NAME  VARCHAR2(50),
    U_ADDR  VARCHAR2(100),
    U_TEL   VARCHAR2(20),
    U_AGE   NUMBER,
    U_REG   DATE
);

--�����ͻ���
INSERT INTO USERINFO(U_NAME, U_ADDR, U_TEL, U_AGE, U_REG) VALUES('ȫ�浿', '����Ư���� �����', '01011111111', '210', SYSDATE);

--������ Ȯ��
SELECT * FROM USERINFO;

-- LOB ������ Ÿ��
--LOB�� ��Large OBject���� ���ڷ� ��뷮 �����͸� ������ �� �ִ� ������ Ÿ���̴�
/*
- ������ ��뷮 �����ʹ� CLOB�� NCLOB, / 4000BYTE���� ū ���ڿ������� �����Ҷ� ����Ѵ�.
- ������ �׷���, �̹���, ������ ���� �����ʹ� BLOB�� ����Ѵ�. 
- BFILE�� ���� ���� ������ �ƴ� �����ͺ��̽� �ܺο� �ִ� ���Ͽ� ���� ��������(�ش� ������ ����Ű�� ������)�� �����ϸ�, 
���� ������ ������ ���� ���� �б⸸ �����ϴ�.
*/

CREATE TABLE SAMPLE_1
(
    COL1    VARCHAR2(50),
    COL2    CLOB -- ����, ORDER BY ��������.
);

--�����ͻ���
INSERT INTO SAMPLE_1(COL1, COL2) VALUES('���޷�', '�۾�Ȱ�� ��������, �ѹݵ��� �ַ� ����');
INSERT INTO SAMPLE_1(COL1, COL2) VALUES('������', '��Ǫ�������� �Ĺ��� ��ö�� ��� ���� �ǿ�� ������ �� ����');
INSERT INTO SAMPLE_1(COL1, COL2) VALUES('����ȭ', '�ֶ��ٽĹ� ��ȯ�ڹ��� ����ȭ���� ���ػ���Ǯ');

--��������ȸ
SELECT * FROM SAMPLE_1

--����: ORDER BY COL2
SELECT * FROM SAMPLE_1 ORDER BY COL1 ASC;

--����: ORDER BY COL2 ������ �߻��ȴ�. COL2�÷��� CLOB ������Ÿ���̹Ƿ� ���ı���� �����ȵ�.
SELECT * FROM SAMPLE_1 ORDER BY COL2 ASC;

--NULL
--NULL�� ������ �������� �ǹ��ϸ� ���̺��� ������ �� �÷� �Ӽ��� ����Ѵ�. 
--����Ʈ ���� NULL�̹Ƿ� ������ �������� ������ �ش� �÷��� NULL�� ����ϰ� �ȴ�. 

--NULL ��� : �÷��� �����͸� �Է��ص� �ǰ�, �Է��� ���� �ʾƵ� �ȴ�.
--NOT NULL ��� : �÷��� �����͸� �ݵ�� �Է��ؾ� �Ѵٴ� �ǹ�. 

CREATE TABLE SAMPLE_2 (
    COL1 NUMBER, --COL1 NUMER NULL�� �����ϴ�. NULL�� ��� --INSERT������ ������ �����ϴ�.
    COL2 VARCHAR2(50) NOT NULL --INSERT�� ����� ���� ������ �Ұ����ϴ�.
);

--������ �Է� ���� �߻�: ORA-01400: cannot insert NULL into ("SQLDB"."SAMPLE_2"."COL2")
INSERT INTO SAMPLE_2(COL1) VALUES(1);--COL2�÷��� NOT NULL�̹Ƿ� ������ �Ұ����ϴ�. �����߻�

INSERT INTO SAMPLE_2(COL2) VALUES('�׽�Ʈ'); --COL1�÷��� NULL ����̱� ������ ������ �����ϴ�.

INSERT INTO SAMPLE_2(COL1, COL2) VALUES(1, '�׽�Ʈ2');

--��������ȸ
SELECT * FROM SAMPLE_2;

--���ǻ��� DBMS ������ ���� NULLó���� ���ݾ� �ٸ� �� �־�, �ǹ����� �����ͺ��̽��� ���� NULL ������ Ȯ���� ��.

/****************************��������****************************/
/*
�� NOT NULL
�÷��� ������Ÿ�� NOT NULL
���� NULL���� �����ߵ���, �÷��� ������ �� NOT NULL ���������� ����ϸ� �ش� �÷����� �ݵ�� �����͸� �Է��ؾ� �Ѵ�. 
�� �ݵ�� ���� ��� �־�� �ϴ� �÷����� NOT NULL ���������� ����� ����Ѵ�.
*/

CREATE TABLE EX2_6(
    COL_NULL        VARCHAR2(10),
    COL_NOT_NULL    VARCHAR2(10) NOT NULL --����Ŭ������ �ڵ����� SYS_C007042 �������ǰ�ü�̸��� �����Ͽ� NOT NULL�� ����
);

--������ ���Խ� �÷����� ���� �� ��쿡�� ��� �÷����� �Է��Ѵٴ� �ǹ�
--INSERT INTO EX2_6(�÷���.......)
INSERT INTO EX2_6 VALUES('AA', ''); --'': ''�ȿ� �����Ͱ� ������ NULL�� �ǹ̷� �ؼ�(����Ŭ������ ����� �ȴ�)
INSERT INTO EX2_6 VALUES('AA', NULL); --NULL�� ������ ���� ���� �ǹ��̴�. ANSI-SQLǥ��
--�� 2�� ������ NULL������ ���� ������ �߻��Ǿ���. ORA-01400: cannot insert NULL into ("SQLDB"."EX2_6"."COL_NOT_NULL")

--1���� 2���� ������ ������ �����̴�.
INSERT INTO EX2_6 VALUES('AA', 'BB'); --1��
INSERT INTO EX2_6(COL_NULL, COL_NOT_NULL) VALUES('AA', 'BB'); --2��

--user_constraints �ý��� �� : ���̺��� �������� ������ Ȯ���ϴ� �뵵.
SELECT constraint_name, constraint_type, table_name, search_condition
FROM user_constraints
WHERE table_name = 'EX2_6';

/*
�� UNIQUE
UNIQUE ���������� �� �״�� �ش� �÷��� ���� ���� �����ؾ� �Ѵٴ� �ǹ̴�. �� �ߺ� ���� ������� �ʴ´�.

    �÷��� ������Ÿ�� UNIQUE
    Ȥ��
    CONSTRAINTS �������Ǹ� UNIQUE(�÷���, ...)
    
    Ư¡ : UNIQUE 
*/

CREATE TABLE SAMPLE_3 (
    U_NAME  VARCHAR(50)      NOT NULL,
    SSN     CHAR(14)        UNIQUE NOT NULL --����Ŭ������ SYS_C007045 �������� ��ü�̸����� SSM�÷��� UNIQUE���������� ����
);
--������ �Է�
INSERT INTO SAMPLE_3 VALUES('�����', '123456-1234567');

--ORA-00001: unique constraint (SQLDB.SYS_C007045) violated
--������ �ֹε�Ϲ�ȣ�� �����Ͽ�, UNIQUE�������� �����߻�
INSERT INTO SAMPLE_3 VALUES('�����', '123456-1234567');

--���������� ������ ������ 1)�÷����� ���� 2)���̺� ���������̶�� ����� �ִ�.

--�÷��������� : �÷��� ������ �� ����
CREATE TABLE EX2_7 (
    COL_UNIQUE_NULL  VARCHAR2(10)    UNIQUE, -- ����Ŭ������ UNIQUE���������̸��� �ڵ�����
    COL_UNIQUE_NNULL VARCHAR2(10)    UNIQUE NOT NULL,
    COL_UNIQUE       VARCHAR2(10)
);

--���̺� �������� : ���̺��� �÷��� ��� �����ϰ� �� �� �������κп� ����.
    /*
    CREATE TABLE EX2_7 (
    COL_UNIQUE_NULL  VARCHAR2(10)
    COL_UNIQUE_NNULL VARCHAR2(10)
    COL_UNIQUE       VARCHAR2(10),
    CONSTRAINT ���������̸�(EX. UNIQUE_NM1) UNIQUE(�÷��� COL_UNIQUE)
    );
    */
    
    --�����÷� ������ UNIQUE���������� ����, EX2_7���̺��� UNIQUE���������� 3���� ����Ǿ� �ִ�
        CREATE TABLE EX2_7 (
    COL_UNIQUE_NULL  VARCHAR2(10) UNIQUE, --�÷��������� NULL ���, ����Ŭ������ UNIQUE���������̸��� �ڵ�����
    COL_UNIQUE_NNULL VARCHAR2(10) UNIQUE NOT NULL, --�÷����� ����
    COL_UNIQUE       VARCHAR2(10),
    CONSTRAINT UNIQUE_NM1 UNIQUE(COL_UNIQUE) --���̺� �������� 
);

--���漳�� : �������� ��ɾ ����ϸ�, �������ǰ�ü�̸��� ����Ŭ������ �ڵ����� ����
--�������ǰ�ü�̸��� �������� �����ϰ� ������, ������ ������ �����Ѵ�.
-- ��> CONSTRAINT UNIQUE_NM1 UNIQUE

--������ �Է�
insert into Ex2_7 VALUES('AA', 'AA', 'AA'); --ù��° ����

insert into Ex2_7 VALUES('AA', 'AA', 'AA'); --�ι�° ����
--ORA-00001: unique constraint (SQLDB.SYS_C007047) violated �����߻�

insert into Ex2_7 VALUES('', 'BB', 'BB'); --����° ����, insert into Ex2_7 VALUES(NULL, 'BB', 'BB');�� �ǹ̰� �����ϴ�.

SELECT * FROM EX2_7;

--����° ���࿡�� NULL�� �����ص�, �� NULL�� ����� �����ϴ�, ��� UNIQUE �񱳴�󿡼� NULL�� �ߺ���󿡼� ���ܵȴ�.
--�ٸ� �����ͺ��̽������� NULL�� �� 1���� ����ϴ� ��쵵 �ִ�. ��>MS-SQL�����ͺ��̽�
insert into Ex2_7 VALUES('', 'CC', 'CC'); --�׹�° ���� 

SELECT * FROM EX2_7;

insert into Ex2_7 VALUES('', 'CC', 'CC'); --�ټ���° ���� 
--ORA-00001: unique constraint (SQLDB.SYS_C007048) violated

commit;

--���̺� �÷��� 2���̻� ������ UNIQUE�������� �����ϱ�, (�����÷��� ������� UNIQUE�������� ����)
--���̺� �������� ������ ����ؾ� �����÷��� UNIQUE ���������� ������ �̤� �ִ�.

--�����÷� ������ UNIQUE ���������� ���� ��. �� ���̺� UNIQUE���� ������ 2�� ����
--��1> �߸� ���ظ� �ϰ� ���� ��
CREATE TABLE SAMPLE_4 (
    COL1 NUMBER UNIQUE,
    COL2 VARCHAR2(10) UNIQUE,
    COL3 VARCHAR2(10),
    COL4 VARCHAR2(10)
);

--��2> �ùٸ��� �����ϰ� ���� ��, ���̺� ������������ �ؾ� �Ѵ�.
CREATE TABLE SAMPLE_5 (
    COL1 NUMBER,
    COL2 VARCHAR2(10),
    COL3 VARCHAR2(10),
    COL4 VARCHAR2(10),
    UNIQUE (COL_1, COL_2);
);

--�����ͻ���
INSERT INTO SAMPLE_5(COL1, COL2)_5 CALUES(1, 'A'); --ù��° ����
INSERT INTO SAMPLE_5 (COL1, COL2)_5 CALUES(1, 'B'); --�ι�° ����

SELECT * FROM SAMPLE_5;

INSERT INTO SAMPLE_5 CALUES(1, 'A'); --����° ����


/*
�� �⺻Ű
�⺻ŰPrimary key��� �ϰ� ���� �״�� ��Primary key����� �Ѵ�. 
���� ���̺� Ű�� �����ߴٶ�� �� ��, �̴� �⺻Ű�� �ǹ��Ѵ�. 

Ư¡ : ���̺� �� 1���� �⺻Ű�� ������ �� �ִ�.
�⺻Ű�� UNIQUE�� NOT NULL �Ӽ��� ���ÿ� ���� ���������̴�

�����÷��� �⺻Ű�� �����ϸ� ����Ű��� �ϸ� - �÷������������� ���� �� ������ ���̺� �����������ε� ���� �� �ִ�.
�����÷��� �⺻Ű�� �����ϸ� ����Ű��� �Ѵ�. - ���̺� ���� �������� ������ ��

    �÷��� ������Ÿ�� PRIMARY KEY
    Ȥ��
    CONSTRAINTS �������Ǹ� PRIMARY KEY(�÷���, ...)
*/

-- �����÷��� �⺻Ű ���� : ����Ű
CREATE TABLE EX2_8 (
    COL1    VARCHAR2(10) PRIMARY KEY, -- UNIQUE�� NOT NULLƯ¡
    COL2    VARCHAR2(10)
);

--������ �Է�
--����Ŭ INSERT��
INSERT INTO EX2_8 VALUES('','AA'); --ORA-01400: cannot insert NULL into ("SQLDB"."EX2_8"."COL1")
--ANSI-SQL INSERT��
INSERT INTO EX2_8 VALUES(NULL,'AA'); --ORA-01400: cannot insert NULL into ("SQLDB"."EX2_8"."COL1")

INSERT INTO EX2_8 VALUES('AA','AA');
INSERT INTO EX2_8 VALUES('AA','AA'); --ORA-00001: unique constraint (SQLDB.SYS_C007052) violated


--����Ű ���̺� ����
--��1 > �߸� ���ظ� �ϰ� ���� ��
--���� �߻�. ������ �⺻Ű�� ���̺�� �� 1���� ������ �� �ִ�. �׷��� �Ʒ��� 2���� �����ϰ� �־� ������ �߻��Ͽ���. 
CREATE TABLE SAMPLE_6 (
    COL1 NUMBER PRIMARY KEY,
    COL2 VARCHAR2(10) PRIMARY KEY,
    COL3 VARCHAR2(10),
    COL4 VARCHAR2(10)
); --"table can have only one primary key"

--��2> �ùٸ��� �����ϰ� ���� ��, ���̺� ������������ �ؾ� �Ѵ�.
-- PRIMARY KEY �������ǰ�ü�̸��� ����Ŭ ������ �ڵ����� ������ ���ش�.
--�׷��� �������ǰ�ü�̸��� ���������� ����¡��ɱ����� ����� �� ��쿡�� 
--�������ǰ�ü�̸��� �������� ������ �־�� �Ѵ�. (�߿�)
CREATE TABLE SAMPLE_7 (
    COL1 NUMBER,
    COL2 VARCHAR2(10),
    COL3 VARCHAR2(10),
    COL4 VARCHAR2(10),
    CONSTRAINT PK_SAMPLE_7_COL1_COL2 PRIMARY KEY (COL1, COL2)
);
--���� ���̺� PRIMARY KEY(���ձ�)�������� COL1, COL2 �÷��� ���ÿ� �����ϴ� �����ʹ� �ߺ��� �� ����.
--�������� �÷��� �ϳ��� �⺻Ű�� ����� ��� �ִ� �÷� ���� 32������ �����ϴ�.

/*
�� �ܷ�Ű �Ǵ� ����Ű, Foreign key��� ��.
�ܷ�ŰForeign key�� ���̺� ���� ���� ������ ���Ἲ�� ���� ���������̴�.

    CONSTRAINT �ܷ�Ű�� FOREIGN KEY(�÷���, ...)
    REFERENCES ���� ���̺�(���� ���̺� �÷���, ...)
*/

--�μ����̺�
CREATE TABLE DEPT (
    D_CODE      NUMBER          PRIMARY KEY, --�� �÷��� �����޴� ������ PRIMARY KEY OR UNIQUE ������ �Ǿ� �־�� �Ѵ�.
    D_NAME      VARCHAR2(20)    NOT NULL
);

--������̺�. ����Ű�� �����Ǵ� ���̺�, ������̺��� D_CODE�÷��� �μ����̺��� D_CODE�÷��� ������ Ÿ���� �����ؾ� �Ѵ�.
CREATE TABLE EMP (
    E_ID    NUMBER          PRIMARY KEY,
    E_NAME  VARCHAR2(20)    NOT NULL,
    D_CODE  NUMBER REFERENCES DEPT(D_CODE) --�÷���������
);

--������̺�
CREATE TABLE EMP (
    E_ID    NUMBER          PRIMARY KEY,
    E_NAME  VARCHAR2(20)    NOT NULL,
    D_CODE  NUMBER,
    FOREIGN KEY(D_CODE) REFERENCES DEPT(D_CODE) --���̺��������
);

--���̺� ���� ��ɾ� : ����Ű�� ������ ���̺� ������ ������ �����Ѵ�.
DROP TABLE EMP; --�����ϴ� ���̺��� ���� ���� �ؾ� �Ѵ�. 
DROP TABLE DEPT; --���� ���ϴ� ���̺��� ���߿� ���� �ؾ� �ȴ�.

--���̺� ����Ű ������ ����� ���� Ȯ���ϱ�
--���� - DATE MODELER - ������ ���� 
--������ ������������ ������ �� [] ��Ŭ�� ���� - �� ������ ��

--������ �Է�
--�μ����̺�
INSERT INTO DEPT VALUES(1, '�ѹ���');
INSERT INTO DEPT VALUES(2, '���ߺ�');
INSERT INTO DEPT VALUES(3, '������');
INSERT INTO DEPT VALUES(4, 'ȫ����');

SELECT * FROM DEPT

--������̺�
INSERT INTO EMP VALUES(1001, '�����', 1);
INSERT INTO EMP VALUES(1002, '�����', 3);
INSERT INTO EMP VALUES(1003, 'Ȳ����', 2);
INSERT INTO EMP VALUES(1004, '�̰���', 4);

INSERT INTO EMP VALUES(1005, 'Ȳ��ȫ', 7);
--ORA-02291: integrity constraint (SQLDB.SYS_C007071) violated - parent key not found

/*
����Ű �������
�ܷ�Ű�� ���� ��������� ������ ����.
�ݵ�� �����ϴ� ���̺��� ���� �����Ǿ�� �ϸ�, ����Ű�� ���� ���̺��� �⺻Ű�� ������� �־�� �Ѵ�.
�ܷ�Ű�� ����� �� �ִ� �÷� ������ �ִ� 32����.
���� �÷��� �ܷ�Ű�� �������, �����ϴ� �÷��� �ܷ�Ű �÷��� ������ ������ ���ƾ� �Ѵ�.
*/

/*
�ý��� ���� ���忡���� ���� ��â�⿡�� �ܷ�Ű�� �������� �ʴ´�. 
���� �߿��� ���÷� �����͸� �Է��ϰ� �����ϴ� ��찡 ����ѵ�, 
�ܷ�Ű�� �����ϸ� ���� ��� ������ ���� ����̴�. 
�׷��� ���� �� �׽�Ʈ �Ⱓ�� ���� ��� ���� �ý����� ����ȭ�� ���� �ܷ�Ű�� ������ ���� ����.
*/

/*
CHECK
���������� �˾ƺ� ������������ CHECK�� �ִ�. 
�÷��� �ԷµǴ� �����͸� üũ�� Ư�� ���ǿ� �´� �����͸� 
�Է� �ް� �׷��� ������ ������ ��� ����.

    CONSTRAINT üũ�� CHECK(üũ����)
*/

CREATE TABLE EX2_9 (
    NUM1    NUMBER 
    CONSTRAINTS CHECK1 CHECK(NUM1 BETWEEN 1 AND 9), 
    --NUM1 �÷��� ���� ������ 1~9������ �Է°���
    GENDER VARCHAR2(10)
    CONSTRAINTS CHECK2 CHECK(GENDER IN ('MALE', 'FEMALE')) 
    --GENDER�÷��� ���ڵ����� 'MALE', 'FEMALE'���ڵ����͸� �Է°���
);

--������ �Է�
INSERT INTO EX2_9 VALUES(10, 'MALE'); --���� 10������ ������ �߻�
--ORA-02290: check constraint (SQLDB.CHECK1) violated

INSERT INTO EX2_9 VALUES(5, 'FEMALE');

SELECT * FROM EX2_9

COMMIT; --Ŀ���� ���� ������, �����͸� �Է��� ���� ���� �ӽû��¿� �ִ�, �׷��� ���������� �Է��� �����͸� �ݿ��ҷ��� Ŀ���� �ؾ��Ѵ�.

--DEFAULT(�⺻��) : ���������� �ƴ����� �÷��Ӽ� ��ɾ�
CREATE TABLE EX2_10 (
    COL1    VARCHAR2(10)   NOT NULL,
    COL2    VARCHAR2(10)   NULL,
    CREATE_DATE DATE DEFAULT SYSDATE
);

--�������Է�
--CREATE_DATE �� �÷��� �Է½� �����ϰ� �Ǹ� ������ ���Խ� DEFAULT SYSDATE �۵��ȴ�. ��ǻ���� ��¥�� �ð��� �о�ͼ� ���Եȴ�.
INSERT INTO EX2_10(COL1, COL2) VALUES('AA', 'BB'); 

-- CREATE_DATE �÷��� ������ �Է�
INSERT INTO EX2_10 VALUES('AA', 'BB', '2024-04-04'); --'2024-04-04' ���ڿ� �����Ͱ� ��¥�����ͷ� ����ȯ�� �Ǿ� ����ȴ�.

--������ ��ȸ
SELECT * FROM EX2_10;


--�ǽ�
/*
CREATE TABLE DEPT_CONST (
    ��_�̸�             VARCHAR2(40),
    �ڷ���              VARCHAR2(30),
    ����               NUMBER,
    ����_����           VARCHAR2(30),
    ����_����_�̸�         VARCHAR2(30)
);

CREATE TABLE EMP_CONST (
    ��_�̸�           VARCHAR2(30),
    �ڷ���            VARCHAR2(30),
    ����              NUMBER,
    ����_����          VARCHAR2(30),
    ����_����_�̸�      VARCHAR2(30)
);

DROP TABLE DEPT_CONST;
DROP TABLE EMP_CONST;

--������ �Է�
INSERT INTO DEPT_CONST VALUES('DEPTNO', '������ ����', 2, 'PRIMARY KEY', 'DEPTCONST_DEPTNO_PK');
INSERT INTO DEPT_CONST VALUES('DNAME', '������ ���ڿ�', 14, 'UNIQUE', 'DEPTCONST_DNAME_UNQ');
INSERT INTO DEPT_CONST VALUES('LOC', '������ ���ڿ�', 13, 'NOT NULL', 'DEPTCONST_LOC_NN');
*/

--�μ����̺�
CREATE TABLE DEPT_CONST (
    DEPTNO  NUMBER(2)       CONSTRAINT DEPTCONST_DEPTNO_PK PRIMARY KEY,
    DNAME   VARCHAR2(14)    CONSTRAINT DEPTCONST_DNAME_UNQ UNIQUE,
    LOC     VARCHAR2(13)    CONSTRAINT DEPTCONST_LOC_NN    NOT NULL
);

--������̺�
CREATE TABLE EMP_CONST (
    EMPNO       NUMBER(2)       CONSTRAINT     EMPCONST_EMPNO_PK   PRIMARY KEY,
    ENAME       VARCHAR2(10)    CONSTRAINT     EMPCONST_ENAME_NN   NOT NULL,
    JOB         VARCHAR2(9),
    TEL         VARCHAR2(20)    CONSTRAINT     EMPCONST_TEL_UNQ    UNIQUE,
    HIREDATE    DATE,
    SAL         NUMBER(7,2)     CONSTRAINT     EMPCONST_SAL_CHK    CHECK(SAL BETWEEN 1000 AND 9999),
    COMM        NUMBER(7,2),
    DEPTNO      NUMBER(2)       CONSTRAINT     EMPCONST_DEPTNI_FK  REFERENCES DEPT_CONST(DEPTNO)
);
    

COMMIT;

--���̺� ����
/*
DROP TABLE [��Ű��.]���̺�� [CASCADE CONSTRAINTS]
CASCADE CONSTRAINTS�� ���̸� ������ ���̺��� �⺻Ű�� UNIQUE Ű�� �����ϴ� ���� ���Ἲ �������ǵ� �ڵ����� �����ȴ�.
*/

DROP TABLE DEPT_CONST; -- EMP_CONST���̺�� ���� ������ �ް� �ִ� ���̺��̱� ������ ������ �ȵȴ�.

-- ���� ���� �߿�.
DROP TABLE EMP_CONST;
DROP TABLE DEPT_CONST;

--[CASCADE CONSTRAINTS] ���
DROP TABLE DEPT_CONST CASCADE CONSTRAINTS; --EMP_CONST���̺��� ����ġ ���������� �ڵ�����


--���̺� ����.
--���̺� ��Ŭ�� �� ���氡����.
--������ �����ߴ� �÷��� ������ Ÿ���� �����ϰų� ����, ���ο� �÷��� �־�� �ϴ� ��찡 �߻�

DROP TABLE EX2_10;

CREATE TABLE EX2_10 (
    COL1 VARCHAR2(10)    NOT NULL,
    COL2 VARCHAR2(10)    NULL,
    CREATE_DATE DATE DEFAULT SYSDATE
);

/*
�� �÷��� ����: COL1 �÷� �̸��� COL11���� ����
    ALTER TABLE [��Ű��.]���̺�� RENAME COLUMN �������÷��� TO �������÷���;
*/

ALTER TABLE EX2_10
RENAME COLUMN COL1 TO COL11;

--�÷����� Ȯ��
DESC EX2_10; --���̺� �÷� ������ Ȯ���� �� ����

/*
�� �÷� Ÿ�� ����: col2 �÷��� VARCHAR2(10)���� VARCHAR2(30)���� ����
    ALTER TABLE [��Ű��.]���̺�� MODIFY �÷��� ������Ÿ��;
*/
ALTER TABLE EX2_10
MODIFY COL2 VARCHAR2(30);

--�÷� Ȯ��
DESC EX2_10;

/*
�� �÷� �߰�: col3 NUMBER Ÿ������ �ű� ����
    ALTER TABLE [��Ű��.]���̺�� ADD �÷��� ������Ÿ��;
*/

ALTER TABLE EX2_10
ADD COL3 NUMBER;

--�÷� Ȯ��
DESC EX2_10;

/*
�� �÷� ����: col3 �÷��� ����
    ALTER TABLE [��Ű��.]���̺�� DROP COLUMN �÷���;
*/

ALTER TABLE EX2_10
DROP COLUMN COL3;

--�÷�Ȯ��
DESC EX2_10;

/*
�� �������� �߰�: col11�� �⺻Ű �߰�
    ALTER TABLE [��Ű��.]���̺�� ADD CONSTRAINTS �������Ǹ� PRIMARY KEY (�÷���, ..);
*/
ALTER TABLE EX2_10
ADD CONSTRAINTS PK_EX2_10 PRIMARY KEY(COL11);

/*
�� �������� ����: col11���� �⺻Ű ����
    ALTER TABLE [��Ű��.]���̺�� DROP CONSTRAINTS �������Ǹ�;
*/
ALTER TABLE EX2_10
DROP CONSTRAINTS PK_EX2_10;


DESC EX2_10;

/*
DDL - DATE DEFINITION LANGUAGE
CREATE TABLE : ����
ALTER TABLE : ����
DROP TABLE : ����

DML - DATE MANIPULATION LANGUAGE
SELECT, INSERT, UPDATE, DELETE, MERGE

DCL
GRANT, DENY
*/

/*
���̺� ����
������Ʈ�� �ϴ� ���� ������ �ִ� ���̺��� �����ؼ� ����� ��찡 �߻��Ѵ�. 
���� ���, ����ϰ� �ִ� ���� ���̺��� ���̺��� ������ ���� �����Ѵٸ� 
�̸� ������ ����� �׽�Ʈ�غ��ų�, ���̺� ������ ��ü�� ��������� ����� ���� ���� �ִ�.
    CREATE TABLE [��Ű��.]���̺�� AS
    SELECT �÷�1, �÷�2, ...
    FROM ������ ���̺��;
    
    �⺻Ű�� ���簡 �ȵȴ�, �׷��� �ٸ� ���������� ����ȴ�.
*/

SELECT * FROM EX2_9;

--���� : SELECT * FROM EX2_9 ������ �����͸� EX2_9_1���̺��� �����Ͽ� �����ϰڴ�.
CREATE TABLE EX2_9_1
AS
SELECT * FROM EX2_9;

--Ȯ��
SELECT * FROM EX2_9_1;

--�ó����� : ������̺� �� �μ��ڵ尡 50���� �����͸� �����ϴ� ���̺��� �����϶�. EMP_DEPART

CREATE TABLE EMP_DEPARTMENT_ID_50
AS
SELECT employee_id, EMP_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, SALARY, MANAGER_ID, DEPARTMENT_ID 
FROM EMPLOYEES 
WHERE DEPARTMENT_ID = 50;

--Ȯ��
SELECT * FROM EMP_DEPARTMENT_ID_50;

--�ó����� : ��������Ϳ��� �޿��� 5000�̻��� �����͸� EMP_SALARY_5000 ���̺� ������ �����϶�.
--�÷����� �����ȣ, ����̸�, �޿�, Ŀ�̼�, �μ��ڵ� ���

CREATE TABLE EMP_SALARY_5000
AS
SELECT employee_id, EMP_NAME, SALARY, COMMISSION_PCT, DEPARTMENT_ID 
FROM EMPLOYEES
WHERE SALARY >= 5000;
--Ȯ��
SELECT * FROM EMP_SALARY_5000;

--������ �Է�
--�����ȣ�� 201���� ���� �� ����. 
--�⺻Ű�� ���簡 �ȵǾ �����ȣ 201�� �ߺ������� �����ϰ� �ȴ�.
INSERT INTO EMP_SALARY_5000 VALUES(201, 'DDK ALI', 20000, NULL, 20);

SELECT * FROM EMP_SALARY_5000 ORDER BY EMPLOYEE_ID;













































