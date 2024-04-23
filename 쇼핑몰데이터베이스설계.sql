CREATE TABLE USERS (
    id          varchar2(20)    CONSTRAINT  pk_users     PRIMARY KEY,     --ȸ�����̵�
    PWD         varchar2(20),                                    --ȸ�� ��й�ȣ
    NAME        varchar2(20),                                    --ȸ�� �̸�
    EMAIL       varchar2(40),                                   --ȸ�� �̸���
    ZIP_CODE    char(5),                                         --ȸ�� �����ȣ
    ADDRESS     varchar2(100),                                   --ȸ�� �ּ�
    PHONE       varchar2(20),                                    --ȸ�� ��ȭ��ȣ
    USEYN       NUMBER          DEFAULT 1,       --ȸ�� Ż�𿩺�               
    REGDATE     DATE            DEFAULT SYSDATE  --ȸ�� ������
);


CREATE TABLE PRODUCT (
    PRODNUM         NUMBER(5)       PRIMARY KEY,
    NAME            VARCHAR2(200),   
    KIND            CHAR(1)         CHECK (KIND IN (1, 2, 3, 4)), 
    PRICE1          NUMBER(7),
    PRICE2          NUMBER(7),
    PRICE3          NUMBER(7),
    CONTENT         VARCHAR2(1000),
    IMAGE           VARCHAR2(200),
    USEYN           CHAR            DEFAULT 'Y',
    REGDATE         DATE
);

CREATE TABLE ADMIN (
    ID          varchar2(20)        primary KEY,
    PWD         varchar2(20),
    NAME        varchar2(20),
    EMAIL       varchar2(40),
    PHONE       varchar2(20)
);

CREATE TABLE CART (
    CARTNUM     NUMBER(8)       PRIMARY KEY,
    ID          VARCHAR2(20)    CONSTRAINT FK_ID REFERENCES USERS(ID), 
    PRODNUM     NUMBER(5)       CONSTRAINT FK_PD REFERENCES PRODUCT(PRODNUM), 
    QUANTITY    NUMBER(5),
    RESULT      CHAR(1)         DEFAULT '1',
    INDATE      DATE  
);

CREATE TABLE ORDERS (
    ORDERNUM    NUMBER(5)       CONSTRAINT      PK_ORDER    primary KEY,
    ID          varchar2(20)    CONSTRAINT      PK_ID REFERENCES USERS(ID),
    INDATE      DATE
);

CREATE TABLE ORDER_DETAIL (
    ODNUM               NUMBER(10)       CONSTRAINT PK_OND PRIMARY KEY,
    ORDERNUM            NUMBER(10)       CONSTRAINT FK_ODN REFERENCES ORDERS(ORDERNUM),
    PRODNUM             NUMBER(5)        CONSTRAINT FK_PDM REFERENCES PRODUCT(PRODNUM),
    QUANTITY            NUMBER(5),
    RESULT              CHAR(1)          DEFAULT '1'
);

CREATE TABLE QNA (
    QSEQ        NUMBER(5)           CONSTRAINT  FK_QS    primary KEY,
    SUBJECT     varchar2(30),        
    CONTENT     varchar2(1000) ,     
    REPLY       varchar2(1000),
    ID          varchar2(20)        CONSTRAINT FK_QID REFERENCES USERS(ID), 
    REP         CHAR(1)             DEFAULT '1',
    INDATE      DATE
);


























































































