-- 학습용 계정생성
-- 관리자만 생성가능
CREATE USER sqldb IDENTIFIED BY 1234
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP;
    
-- 권한부여. connect : 연결(접속), resource : 자원생성, dba : 데이터베이스 관리권한
-- GRANT 권한 1,권한2, 권한3 TO sqldb
GRANT connect, resource, dba TO sqldb; --dba 권한은 보안때문에 부여를 해주지 않는다.

-- 개정생성 및 권한 부여작업 : 관리자 계정으로 접속해서 명령을 실행해야 한다. (sys, system)
-- 관리자 계정 (sys, system) 접속(연결) 상태
CREATE USER sqldb IDENTIFIED BY 1234
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP;

GRANT CONNECT, RESOURCE, dba TO sqlDB;

-- 계정생성과 권한부여작업이 진행되었을 경우, SQLDB계정으로 접속
-- 학습용 데이터 준비작업
-- 1번부터 6번까지 순차적으로 블럭을 만들어 실행한다.

--1)
CREATE TABLE userTBL -- 회원 테이블
( userID  	CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  userName  	NVARCHAR2(10) NOT NULL, -- 이름
  birthYear 	NUMBER(4) NOT NULL,  -- 출생년도
  addr	  	NCHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  mobile1	CHAR(3), -- 휴대폰의 국번(010, 011, 016, 017, 018, 019 등)
  mobile2	CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈제외)
  height    	NUMBER(3),  -- 키
  mDate    	DATE  -- 회원 가입일
);

--2)
CREATE TABLE buyTBL -- 회원 구매 테이블
(  idNum 	NUMBER(8) NOT NULL PRIMARY KEY, -- 순번(PK)
   userID  	CHAR(8) NOT NULL, -- 아이디(FK)
   prodName 	NCHAR(6) NOT NULL, --  물품명
   groupName 	NCHAR(4)  , -- 분류
   price     	NUMBER(8)  NOT NULL, -- 단가
   amount    	NUMBER(3)  NOT NULL, -- 수량
   FOREIGN KEY (userID) REFERENCES userTBL(userID)
);

--3)
INSERT INTO userTBL VALUES('LSG', '이승기', 1987, '서울', '011', '11111111', 182, '2008-8-8');
INSERT INTO userTBL VALUES('KBS', '김범수', 1979, '경남', '011', '22222222', 173, '2012-4-4');
INSERT INTO userTBL VALUES('KKH', '김경호', 1971, '전남', '019', '33333333', 177, '2007-7-7');
INSERT INTO userTBL VALUES('JYP', '조용필', 1950, '경기', '011', '44444444', 166, '2009-4-4');
INSERT INTO userTBL VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO userTBL VALUES('LJB', '임재범', 1963, '서울', '016', '66666666', 182, '2009-9-9');
INSERT INTO userTBL VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO userTBL VALUES('EJW', '은지원', 1972, '경북', '011', '88888888', 174, '2014-3-3');
INSERT INTO userTBL VALUES('JKW', '조관우', 1965, '경기', '018', '99999999', 172, '2010-10-10');
INSERT INTO userTBL VALUES('BBK', '바비킴', 1973, '서울', '010', '00000000', 176, '2013-5-5');

--4)
CREATE SEQUENCE idSEQ; -- 순차번호 입력을 위해서 시퀀스 생성

--5)
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '운동화', NULL   , 30,   2);

--6)
COMMIT;

--SELECT 문 : 테이블에 저장되어 있는 데이터 확인. 조회 명령어
SELECT * FROM usertbl;
SELECT * FROM buytbl;

--특정한 조건의 데이터만 조회(SELECT ~ FROM ~ WHRER)

/*
문법
SELECT 컬럼명, 컬럼명 2 FROM 테이블명 WHERE 조건식;
*/

--질의 내용 : 이름이 김경호인 데이터를 조회하라.
SELECT * FROM USERTBL WHERE USERNAME = '김경호';

SELECT * FROM USERTBL WHERE USERNAME = '은지원';

--질의내용 : 1970년 이상 출생을 하고, 키는 182CM 이상인 데이터를 조회하라.
SELECT * FROM USERTBL WHERE birthyear >= 1970 AND height >= 182;

--질의내용 : 1970년 이상 출생을 하거나, 키는 182CM 이상인 데이터를 조회하라.
SELECT * FROM USERTBL WHERE BIRTHYEAR >= 1970 OR HEIGHT >= 182;

--질의내용 : 키가 180이상이면서 183이하인 데이터를 조회하라
SELECT * FROM USERTBL WHERE HEIGHT >=180 AND HEIGHT <=183;

--위와 동일한 구문.
SELECT * FROM USERTBL WHERE HEIGHT BETWEEN 180 AND 183;

--질의내용 : 주소가 경남이거나 전남 또는 경북 데이터를 조회하라.
SELECT * FROM USERTBL WHERE ADDR = '경남' OR ADDR = '전남' OR ADDR = '경북';

--위와 동일구문
SELECT * FROM USERTBL WHERE ADDR IN ('경남', '전남', '경북');

--숫자데이터 컬럼의 경우에는 사칙연산이 가능하다.
SELECT * FROM buytbl;

--주문금액을 출력하시오
--별표는 성능이 떨어지기 때문에 데이터를 직접 가지고 오는 것이 좋다.
SELECT idnum, USERID, PRODNAME, GROUPNAME, PRICE, AMOUNT, PRICE * AMOUNT AS TOT_PRICE FROM BUYTBL;

SELECT idnum, USERID, PRODNAME, GROUPNAME, PRICE, AMOUNT, PRICE * 1.1 FROM BUYTBL;

-- LIKE 패턴 매칭
--질의내용 : 이름 중 성이 "김" 씨인 데이터를 출력하라. 와일드 카드 문자 % : 길이가 0인 이상의 문자열.
SELECT * FROM USERTBL WHERE USERNAME LIKE '김%';


--질의 내용 : 성까지 포함한 전체이름이 3글자이면서, 종신으로 끝나는 데이터를 조회하라 / 와일드카드문자 _ : 길이가 1개를 의미
SELECT * FROM USERTBL WHERE USERNAME LIKE '_종신';
SELECT * FROM USERTBL WHERE USERNAME LIKE '김__';

--LIKE 패턴 보충설명할 것.
-- 더북 오라클 / 책 : 오라클 SQL과 PL/SQL을 다루는 기술 / https://thebook.io/006696/0063/

--질의 내용 : 사원 테이블에서 급여가 5000이 넘는 사원번호와 사원명을 조회.
SELECT  employee_id, emp_name FROM  employees WHERE   salary > 5000;

-- order by : 정렬, 
-- asc : 오름차순 모든 작업이 끝났을 때 가장 마지막에 작업해야 한다.
    SELECT  employee_id, emp_name
      FROM  employees
     WHERE  salary > 5000
     ORDER  BY employee_id; -- order by employee_id asc
     
-- desc : 내림차순
    SELECT  employee_id, emp_name
      FROM  employees
     WHERE  salary > 5000
     ORDER  BY employee_id desc; -- order by employee_id desc
     
-- 질의 내용 : 급여가 5000이상이고  job_id가 ‘IT_PROG’인 사원을 조회한다
    SELECT  employee_id, emp_name
      FROM  employees
     WHERE  salary >= 5000
       AND  job_id = 'IT_PROG'
     ORDER  BY employee_id;
     
--데이터는 대소문자를 구분한다.
--대소문자 구분하기 때문에 아래 예시는 결과가 나오지 않는다. 
--명령어는 대소문자를 구분하지 않지만, 데이터는 구분한다.
    SELECT  employee_id, emp_name
      FROM  employees
     WHERE  salary >= 5000
       AND  job_id = 'it_prog'
     ORDER  BY employee_id;
     
--USERTBL 테이블에서 생년월일을 오름차순으로 정렬하라.
SELECT * FROM USERTBL ORDER BY BIRTHYEAR ASC;

--질의내용 : USERTBL에서 키를 내림차순, 이름을 오름차순으로 정렬하라.
-- 키가 동일한 경우에만 이름이 오름차순으로 정렬이 된다.
SELECT * FROM USERTBL ORDER BY HEIGHT DESC, USERNAME ASC;

--질의내용 : USERTBL에서 주소를 오름차순으로 정렬하라.
SELECT * FROM USERTBL ORDER BY ADDR ASC;

SELECT ADDR FROM USERTBL ORDER BY ADDR ASC;

--질의내용 : 중복된 데이터를 1개만 남기고 나머지는 제거하는 기능 : DISTINCT
SELECT DISTINCT ADDR FROM USERTBL ORDER BY ADDR ASC;

-- USERNAME 컬럼과 ADDR컬럼에 동시에 만족되는 데이터가 존재시 DISTINCT 효과가 나온다.
SELECT DISTINCT USERNAME, ADDR FROM USERTBL ORDER BY ADDR ASC;

--더북 2장 데이터베이스를 구성하는 객체 살펴보기 https://thebook.io/006696/0025/
/*
01. 데이터베이스 객체의 개요
 - 데이터베이스 객체란 데이터베이스 내에 존재하는 논리적인 저장 구조를 말한다.
02. 테이블
*/
--테이블 생성
/*
테이블 생성
테이블은 CREATE 문으로 생성할 수 있는데, 기본 구문은 다음과 같다.

    CREATE TABLE [스키마.]테이블명( --스키마 : SQLDB
        컬럼1 컬럼1_데이터타입 [NULL, NOT NULL],
        컬럼2 컬럼2_데이터타입 [NULL, NOT NULL],
    ...
    )[TABLESPACE 테이블스페이스명];
*/

-- CREATE TABLE [SQLDB.]테이블명 : [SQLDB.] 접속된 상태이면 생략가능
-- 문자열 데이터타입 : char, varchar2, ncahr, nvarchar2
CREATE TABLE ex2_1 (
    column1 char(10),
    column2 varchar2(10),
    column3 nvarchar2(10),
    column4 number
);
--데이터 삽입
insert into ex2_1(column1, column2) values('abc', 'abc');

--데이터 타입 설명
--컬럼의 실제기억장소의 크기를 확인, char(10와 varchar2(10)의 차이점
--CHAR : 길이가 고정인 데이터. 최대 2000BYTE까지 지원해줌. 예> 주민번호 : 14자리 123456-1234567 CHAR(14)
--VARCHAR2 : 길이가 유동적인 데이터, 최대 4000BYTE까지 지원, 예> 아이디 8~15자 이내. VARCHAR2(15)

--length(column1) : 컬럼의 기억장소의 길이
select column1, length(column1), column2, length(column2) from ex2_1

CREATE TABLE ex2_2 (
    COLUMN1 VARCHAR2(3),
    COLUMN2 VARCHAR2(3 BYTE),
    COLUMN3 VARCHAR2(3 CHAR) --영문, 한글 상관없이 3글자가 들어감.
    //크기와 상관없이 한글 또는 영문 3글자을 입력목적
);

--오라클 데이터베이스 시스템
/*
    영문자, 숫자, 특수문자 : 1BYTE로 관리가 된다.
    한글 : 3BYTE로 관리가 되어 있다.
    한글의 경우 오라클 설치 환경에 따라 상대적이기 때문에 확인이 필요하며 2BYTE일 수도 있다.
*/
-- 함수 : LENGTHB() : 바이트 길이를 구하는 길이 / 매개변수에 제공되는 데이터의 바이트 정보를 확인.
SELECT LENGTHB('A'), LENGTHB('1'), LENGTHB('*'), LENGTHB('김') FROM DUAL; --1,1,1,3
SELECT LENGTHB('손흥민') FROM DUAL --9BYTE

--데이터 삽입. 영문문자열 데이터는 대소문자 구분. 'ABC' , 'abc'는 다른 문자열 데이터로 인식이 된다.
--INSERT INTO 테이블명(COLUMN1,COLUMN2,COLUMN3) VALUES(값1, 값2, 값3)
INSERT INTO ex2_2(COLUMN1,COLUMN2,COLUMN3) VALUES('abc', 'abc', 'abc');

-- 데이터 조회
SELECT COLUMN1, LENGTHB(COLUMN1), LENGTHB(COLUMN1), LENGTHB(COLUMN3) FROM ex2_2;

--한글데이터 입력 시도 에러발생
--ORA-12899: value too large for column "SQLDB"."EX2_2"."COLUMN1" (actual: 9, maximum: 3)
insert into ex2_2(COLUMN1,COLUMN2,COLUMN3) values('홍길동','홍길동','홍길동');

-- 설명 : COLUMN3컬럼이 VARCHAR2(3 CHAR)이므로, 한글 3개 문자를 데이터 삽입 성공
insert into ex2_2(COLUMN3) values('홍길동');

-- 데이터 조회
SELECT COLUMN1, LENGTHB(COLUMN1), LENGTHB(COLUMN1), LENGTHB(COLUMN3) FROM ex2_2;

--숫자 데이터 타입 : NUMBER [(PS, [S])]
--모두 내부적으로 NUMBER 데이터타입으로 변환되어 진행이 된다.
CREATE TABLE EX2_3 (
    COL_INT INTEGER,
    COL_DEC DECIMAL,
    COL_NUM NUMBER
);

-- user_tab_cols라는 시스템 뷰 : 테이블의 컬럼정보를 확인할 때 사용하는 용도
SELECT column_id, column_name, data_type, data_length
FROM user_tab_cols
WHERE table_name = 'EX2_3' --테이블명이 데이터로 사용할 경우 대문자로 입력해야 한다.
ORDER BY column_id;

--날짜형 데이터 타입 :DATE - 초단위까지 관리, TIMESTAMP - 밀리세컨드단위까지 관리한다.
CREATE TABLE EX2_5 (
    COL_DATE        DATE,
    COL_TIMESTAMP   TIMESTAMP
);

--날짜 함수 : SYSDATE, SYSTIMESTAMP

--데이터삽입
INSERT INTO EX2_5(COL_DATE, COL_TIMESTAMP) VALUES(SYSDATE, SYSTIMESTAMP);

--데이터 조회, 출력되는 날짜 형식을 변경 : 
--도구 - 환경설정 - 데이터베이스 - NLS-날짜형식변경 YYYY-MM-DD HH24:MI:SS
SELECT * FROM EX2_5;

--시나리오 : 
/*
테이블명 : USERINFO
컬럼명 : 이름(U_NAME)VARCHAR2 50, 주소(U-ADDR)VARCHAR2 100, 연락처(U-TEL) VARCHAR2 20, 나이U-(AGE)NUMBER, 등록일(U-REG) DATE
*/
CREATE TABLE USERINFO (
    U_NAME  VARCHAR2(50),
    U_ADDR  VARCHAR2(100),
    U_TEL   VARCHAR2(20),
    U_AGE   NUMBER,
    U_REG   DATE
);

--데이터삽입
INSERT INTO USERINFO(U_NAME, U_ADDR, U_TEL, U_AGE, U_REG) VALUES('홍길동', '서울특별시 노원구', '01011111111', '210', SYSDATE);

--데이터 확인
SELECT * FROM USERINFO;

-- LOB 데이터 타입
--LOB는 ‘Large OBject’의 약자로 대용량 데이터를 저장할 수 있는 데이터 타입이다
/*
- 문자형 대용량 데이터는 CLOB나 NCLOB, / 4000BYTE보다 큰 문자열데이터 저장할때 사용한다.
- 나머지 그래픽, 이미지, 동영상 등의 데이터는 BLOB를 사용한다. 
- BFILE은 실제 이진 파일이 아닌 데이터베이스 외부에 있는 파일에 대한 로케이터(해당 파일을 가리키는 포인터)를 저장하며, 
실제 파일을 수정할 수는 없고 읽기만 가능하다.
*/

CREATE TABLE SAMPLE_1
(
    COL1    VARCHAR2(50),
    COL2    CLOB -- 정렬, ORDER BY 지원안함.
);

--데이터삽입
INSERT INTO SAMPLE_1(COL1, COL2) VALUES('진달래', '작업활엽 관목으로, 한반도에 주로 분포');
INSERT INTO SAMPLE_1(COL1, COL2) VALUES('개나리', '물푸레나무과 식물로 봄철에 노란 꽃을 피우는 관목의 한 종류');
INSERT INTO SAMPLE_1(COL1, COL2) VALUES('봉선화', '쌍떡잎식물 무환자무목 봉선화과의 한해살이풀');

--데이터조회
SELECT * FROM SAMPLE_1

--정렬: ORDER BY COL2
SELECT * FROM SAMPLE_1 ORDER BY COL1 ASC;

--정렬: ORDER BY COL2 에러가 발생된다. COL2컬럼이 CLOB 데이터타입이므로 정렬기능이 지원안됨.
SELECT * FROM SAMPLE_1 ORDER BY COL2 ASC;

--NULL
--NULL은 ‘값이 없음’을 의미하며 테이블을 생성할 때 컬럼 속성에 기술한다. 
--디폴트 값이 NULL이므로 별도로 지정하지 않으면 해당 컬럼은 NULL을 허용하게 된다. 

--NULL 허용 : 컬럼에 데이터를 입력해도 되고, 입력을 하지 않아도 된다.
--NOT NULL 허용 : 컬럼에 데이터를 반드시 입력해야 한다는 의미. 

CREATE TABLE SAMPLE_2 (
    COL1 NUMBER, --COL1 NUMER NULL과 동일하다. NULL을 허용 --INSERT문에서 생략이 가능하다.
    COL2 VARCHAR2(50) NOT NULL --INSERT문 사용할 때는 생략이 불가능하다.
);

--데이터 입력 오류 발생: ORA-01400: cannot insert NULL into ("SQLDB"."SAMPLE_2"."COL2")
INSERT INTO SAMPLE_2(COL1) VALUES(1);--COL2컬럼이 NOT NULL이므로 생략이 불가능하다. 에러발생

INSERT INTO SAMPLE_2(COL2) VALUES('테스트'); --COL1컬럼이 NULL 허용이기 때문에 생략이 가능하다.

INSERT INTO SAMPLE_2(COL1, COL2) VALUES(1, '테스트2');

--데이터조회
SELECT * FROM SAMPLE_2;

--주의사항 DBMS 종류에 따라 NULL처리가 조금씩 다를 수 있어, 실무에서 데이터베이스에 따른 NULL 사용법을 확인할 것.

/****************************제약조건****************************/
/*
① NOT NULL
컬럼명 데이터타입 NOT NULL
앞의 NULL에서 설명했듯이, 컬럼을 정의할 때 NOT NULL 제약조건을 명시하면 해당 컬럼에는 반드시 데이터를 입력해야 한다. 
즉 반드시 값이 들어 있어야 하는 컬럼에는 NOT NULL 제약조건을 만들어 사용한다.
*/

CREATE TABLE EX2_6(
    COL_NULL        VARCHAR2(10),
    COL_NOT_NULL    VARCHAR2(10) NOT NULL --오라클서버가 자동으로 SYS_C007042 제약조건객체이름을 생성하여 NOT NULL로 설정
);

--데이터 삽입시 컬럼명을 생략 할 경우에는 모든 컬럼명을 입력한다는 의미
--INSERT INTO EX2_6(컬럼명.......)
INSERT INTO EX2_6 VALUES('AA', ''); --'': ''안에 데이터가 없으면 NULL의 의미로 해석(오라클에서만 허용이 된다)
INSERT INTO EX2_6 VALUES('AA', NULL); --NULL을 넣으면 위와 같은 의미이다. ANSI-SQL표준
--위 2개 구문은 NULL문제로 인해 에러가 발생되었음. ORA-01400: cannot insert NULL into ("SQLDB"."EX2_6"."COL_NOT_NULL")

--1번과 2번의 구문은 동일한 구문이다.
INSERT INTO EX2_6 VALUES('AA', 'BB'); --1번
INSERT INTO EX2_6(COL_NULL, COL_NOT_NULL) VALUES('AA', 'BB'); --2번

--user_constraints 시스템 뷰 : 테이블의 제약조건 정보를 확인하는 용도.
SELECT constraint_name, constraint_type, table_name, search_condition
FROM user_constraints
WHERE table_name = 'EX2_6';

/*
② UNIQUE
UNIQUE 제약조건은 말 그대로 해당 컬럼에 들어가는 값이 유일해야 한다는 의미다. 즉 중복 값을 허용하지 않는다.

    컬럼명 데이터타입 UNIQUE
    혹은
    CONSTRAINTS 제약조건명 UNIQUE(컬럼명, ...)
    
    특징 : UNIQUE 
*/

CREATE TABLE SAMPLE_3 (
    U_NAME  VARCHAR(50)      NOT NULL,
    SSN     CHAR(14)        UNIQUE NOT NULL --오라클서버가 SYS_C007045 제약조건 객체이름으로 SSM컬럼에 UNIQUE제약조건을 설정
);
--데이터 입력
INSERT INTO SAMPLE_3 VALUES('손흥민', '123456-1234567');

--ORA-00001: unique constraint (SQLDB.SYS_C007045) violated
--동일한 주민등록번호가 존재하여, UNIQUE제약조건 에러발생
INSERT INTO SAMPLE_3 VALUES('김민재', '123456-1234567');

--제약조건을 설정시 문법적 1)컬럼수준 제약 2)테이블 수준제약이라는 방법이 있다.

--컬럼수준제약 : 컬럼을 정의할 때 적용
CREATE TABLE EX2_7 (
    COL_UNIQUE_NULL  VARCHAR2(10)    UNIQUE, -- 오라클서버가 UNIQUE제약조건이름을 자동생성
    COL_UNIQUE_NNULL VARCHAR2(10)    UNIQUE NOT NULL,
    COL_UNIQUE       VARCHAR2(10)
);

--테이블 수준제약 : 테이블의 컬럼을 모두 정의하고 난 후 마지막부분에 적용.
    /*
    CREATE TABLE EX2_7 (
    COL_UNIQUE_NULL  VARCHAR2(10)
    COL_UNIQUE_NNULL VARCHAR2(10)
    COL_UNIQUE       VARCHAR2(10),
    CONSTRAINT 제약조건이름(EX. UNIQUE_NM1) UNIQUE(컬럼명 COL_UNIQUE)
    );
    */
    
    --단일컬럼 각각에 UNIQUE제약조건이 적용, EX2_7테이블은 UNIQUE제약조건이 3개가 적용되어 있다
        CREATE TABLE EX2_7 (
    COL_UNIQUE_NULL  VARCHAR2(10) UNIQUE, --컬럼수준제약 NULL 허용, 오라클서버가 UNIQUE제약조건이름을 자동생성
    COL_UNIQUE_NNULL VARCHAR2(10) UNIQUE NOT NULL, --컬럼수준 제약
    COL_UNIQUE       VARCHAR2(10),
    CONSTRAINT UNIQUE_NM1 UNIQUE(COL_UNIQUE) --테이블 수준제약 
);

--보충설명 : 제약조건 명령어를 사용하면, 제약조건개체이름은 오라클서버가 자동으로 생성
--제약조건개체이름을 수동으로 정의하고 싶으면, 문법을 다음과 같이한다.
-- 예> CONSTRAINT UNIQUE_NM1 UNIQUE

--데이터 입력
insert into Ex2_7 VALUES('AA', 'AA', 'AA'); --첫번째 실행

insert into Ex2_7 VALUES('AA', 'AA', 'AA'); --두번째 실행
--ORA-00001: unique constraint (SQLDB.SYS_C007047) violated 오류발생

insert into Ex2_7 VALUES('', 'BB', 'BB'); --세번째 실행, insert into Ex2_7 VALUES(NULL, 'BB', 'BB');와 의미가 동일하다.

SELECT * FROM EX2_7;

--세번째 실행에서 NULL이 존재해도, 또 NULL은 사용이 가능하다, 고로 UNIQUE 비교대상에서 NULL은 중복대상에서 제외된다.
--다른 데이터베이스에서는 NULL은 단 1번만 허용하는 경우도 있다. 예>MS-SQL데이터베이스
insert into Ex2_7 VALUES('', 'CC', 'CC'); --네번째 실행 

SELECT * FROM EX2_7;

insert into Ex2_7 VALUES('', 'CC', 'CC'); --다섯번째 실행 
--ORA-00001: unique constraint (SQLDB.SYS_C007048) violated

commit;

--테이블에 컬럼을 2개이상 묶에서 UNIQUE제약조건 적용하기, (복합컬럼을 대상으로 UNIQUE제약조건 적용)
--테이블 수준제약 문법을 사용해야 복합컬럼을 UNIQUE 제약조건을 적용할 ㅜㅅ 있다.

--단일컬럼 각각을 UNIQUE 제약조건을 만든 예. 이 테이블에 UNIQUE제약 조건은 2개 생성
--예1> 잘못 이해를 하고 만든 예
CREATE TABLE SAMPLE_4 (
    COL1 NUMBER UNIQUE,
    COL2 VARCHAR2(10) UNIQUE,
    COL3 VARCHAR2(10),
    COL4 VARCHAR2(10)
);

--예2> 올바르게 이해하고 만든 예, 테이블 수준제약으로 해야 한다.
CREATE TABLE SAMPLE_5 (
    COL1 NUMBER,
    COL2 VARCHAR2(10),
    COL3 VARCHAR2(10),
    COL4 VARCHAR2(10),
    UNIQUE (COL_1, COL_2);
);

--데이터삽입
INSERT INTO SAMPLE_5(COL1, COL2)_5 CALUES(1, 'A'); --첫번째 실행
INSERT INTO SAMPLE_5 (COL1, COL2)_5 CALUES(1, 'B'); --두번째 실행

SELECT * FROM SAMPLE_5;

INSERT INTO SAMPLE_5 CALUES(1, 'A'); --세번째 실행


/*
③ 기본키
기본키Primary key라고도 하고 영어 그대로 ‘Primary key’라고 한다. 
보통 테이블에 키를 생성했다라고 할 때, 이는 기본키를 의미한다. 

특징 : 테이블 당 1개의 기본키만 생성할 수 있다.
기본키는 UNIQUE와 NOT NULL 속성을 동시에 가진 제약조건이다

단일컬럼을 기본키로 설정하면 단일키라고 하며 - 컬럼수준제약으로 만들 수 있으며 테이블 수준제약으로도 만들 수 있다.
복합컬럼을 기본키로 설정하면 복합키라고 한다. - 테이블 수준 제약으로 만들어야 함

    컬럼명 데이터타입 PRIMARY KEY
    혹은
    CONSTRAINTS 제약조건명 PRIMARY KEY(컬럼명, ...)
*/

-- 단일컬럼에 기본키 설정 : 단일키
CREATE TABLE EX2_8 (
    COL1    VARCHAR2(10) PRIMARY KEY, -- UNIQUE와 NOT NULL특징
    COL2    VARCHAR2(10)
);

--데이터 입력
--오라클 INSERT문
INSERT INTO EX2_8 VALUES('','AA'); --ORA-01400: cannot insert NULL into ("SQLDB"."EX2_8"."COL1")
--ANSI-SQL INSERT문
INSERT INTO EX2_8 VALUES(NULL,'AA'); --ORA-01400: cannot insert NULL into ("SQLDB"."EX2_8"."COL1")

INSERT INTO EX2_8 VALUES('AA','AA');
INSERT INTO EX2_8 VALUES('AA','AA'); --ORA-00001: unique constraint (SQLDB.SYS_C007052) violated


--복합키 테이블 예제
--예1 > 잘못 이해를 하고 만든 예
--에러 발생. 이유는 기본키는 테이블당 단 1개만 생성할 수 있다. 그러나 아래는 2개를 생성하고 있어 오류가 발생하였다. 
CREATE TABLE SAMPLE_6 (
    COL1 NUMBER PRIMARY KEY,
    COL2 VARCHAR2(10) PRIMARY KEY,
    COL3 VARCHAR2(10),
    COL4 VARCHAR2(10)
); --"table can have only one primary key"

--예2> 올바르게 이해하고 만든 예, 테이블 수준제약으로 해야 한다.
-- PRIMARY KEY 제약조건개체이름이 오라클 서버가 자동으로 생성을 해준다.
--그래서 제약조건객체이름이 스프링에서 페이징기능구현시 사용이 될 경우에는 
--제약조건객체이름이 수동으로 생성해 주어야 한다. (중요)
CREATE TABLE SAMPLE_7 (
    COL1 NUMBER,
    COL2 VARCHAR2(10),
    COL3 VARCHAR2(10),
    COL4 VARCHAR2(10),
    CONSTRAINT PK_SAMPLE_7_COL1_COL2 PRIMARY KEY (COL1, COL2)
);
--위의 테이블에 PRIMARY KEY(복합기)설정으로 COL1, COL2 컬럼에 동시에 만족하는 데이터는 중복될 수 없다.
--여러개의 컬럼을 하나의 기본키로 만드는 경우 최대 컬럼 수는 32개까지 가능하다.

/*
④ 외래키 또는 참조키, Foreign key라고도 함.
외래키Foreign key는 테이블 간의 참조 데이터 무결성을 위한 제약조건이다.

    CONSTRAINT 외래키명 FOREIGN KEY(컬럼명, ...)
    REFERENCES 참조 테이블(참조 테이블 컬럼명, ...)
*/

--부서테이블
CREATE TABLE DEPT (
    D_CODE      NUMBER          PRIMARY KEY, --이 컬럼이 참조받는 조건은 PRIMARY KEY OR UNIQUE 설정이 되어 있어야 한다.
    D_NAME      VARCHAR2(20)    NOT NULL
);

--사원테이블. 참조키가 설정되는 테이블, 사원테이블의 D_CODE컬럼은 부서테이블의 D_CODE컬럼의 데이터 타입이 동일해야 한다.
CREATE TABLE EMP (
    E_ID    NUMBER          PRIMARY KEY,
    E_NAME  VARCHAR2(20)    NOT NULL,
    D_CODE  NUMBER REFERENCES DEPT(D_CODE) --컬럼수준제약
);

--사원테이블
CREATE TABLE EMP (
    E_ID    NUMBER          PRIMARY KEY,
    E_NAME  VARCHAR2(20)    NOT NULL,
    D_CODE  NUMBER,
    FOREIGN KEY(D_CODE) REFERENCES DEPT(D_CODE) --테이블수준제약
);

--테이블 삭제 명령어 : 참조키가 설정된 테이블 삭제는 순서가 존재한다.
DROP TABLE EMP; --참조하는 테이블은 먼저 삭제 해야 한다. 
DROP TABLE DEPT; --참조 당하는 테이블은 나중에 삭제 해야 된다.

--테이블 참조키 설정된 모습을 툴로 확인하기
--보기 - DATE MODELER - 브라우저 선택 
--브라우저 도구모음에서 관계형 모델 [] 우클릭 선택 - 새 관계형 모델

--데이터 입력
--부서테이블
INSERT INTO DEPT VALUES(1, '총무부');
INSERT INTO DEPT VALUES(2, '개발부');
INSERT INTO DEPT VALUES(3, '영업부');
INSERT INTO DEPT VALUES(4, '홍보부');

SELECT * FROM DEPT

--사원테이블
INSERT INTO EMP VALUES(1001, '손흥민', 1);
INSERT INTO EMP VALUES(1002, '김민재', 3);
INSERT INTO EMP VALUES(1003, '황희찬', 2);
INSERT INTO EMP VALUES(1004, '이강인', 4);

INSERT INTO EMP VALUES(1005, '황선홍', 7);
--ORA-02291: integrity constraint (SQLDB.SYS_C007071) violated - parent key not found

/*
참조키 제약사항
외래키에 대한 제약사항은 다음과 같다.
반드시 참조하는 테이블이 먼저 생성되어야 하며, 참조키가 참조 테이블의 기본키로 만들어져 있어야 한다.
외래키에 사용할 수 있는 컬럼 개수는 최대 32개다.
여러 컬럼을 외래키로 만들려면, 참조하는 컬럼과 외래키 컬럼의 순서와 개수는 같아야 한다.
*/

/*
시스템 개발 현장에서는 보통 초창기에는 외래키를 생성하지 않는다. 
개발 중에는 수시로 데이터를 입력하고 삭제하는 경우가 빈번한데, 
외래키를 생성하면 여러 모로 불편한 것이 사실이다. 
그래서 개발 후 테스트 기간을 거쳐 어느 정도 시스템이 안정화된 이후 외래키를 생성할 때가 많다.
*/

/*
CHECK
마지막으로 알아볼 제약조건으로 CHECK가 있다. 
컬럼에 입력되는 데이터를 체크해 특정 조건에 맞는 데이터만 
입력 받고 그렇지 않으면 오류를 뱉어 낸다.

    CONSTRAINT 체크명 CHECK(체크조건)
*/

CREATE TABLE EX2_9 (
    NUM1    NUMBER 
    CONSTRAINTS CHECK1 CHECK(NUM1 BETWEEN 1 AND 9), 
    --NUM1 컬럼에 숫자 데이터 1~9범위로 입력가능
    GENDER VARCHAR2(10)
    CONSTRAINTS CHECK2 CHECK(GENDER IN ('MALE', 'FEMALE')) 
    --GENDER컬럼에 문자데이터 'MALE', 'FEMALE'문자데이터만 입력가능
);

--데이터 입력
INSERT INTO EX2_9 VALUES(10, 'MALE'); --숫자 10때문에 에러가 발생
--ORA-02290: check constraint (SQLDB.CHECK1) violated

INSERT INTO EX2_9 VALUES(5, 'FEMALE');

SELECT * FROM EX2_9

COMMIT; --커밋을 하지 않으면, 데이터를 입력한 것은 현재 임시상태에 있다, 그래서 물리적으로 입력한 데이터를 반영할려면 커밋을 해야한다.

--DEFAULT(기본값) : 제약조건은 아니지만 컬럼속성 명령어
CREATE TABLE EX2_10 (
    COL1    VARCHAR2(10)   NOT NULL,
    COL2    VARCHAR2(10)   NULL,
    CREATE_DATE DATE DEFAULT SYSDATE
);

--데이터입력
--CREATE_DATE 이 컬럼을 입력시 생략하게 되면 데이터 삽입시 DEFAULT SYSDATE 작동된다. 컴퓨터의 날짜와 시간을 읽어와서 삽입된다.
INSERT INTO EX2_10(COL1, COL2) VALUES('AA', 'BB'); 

-- CREATE_DATE 컬럼에 데이터 입력
INSERT INTO EX2_10 VALUES('AA', 'BB', '2024-04-04'); --'2024-04-04' 문자열 데이터가 날짜데이터로 형변환이 되어 저장된다.

--데이터 조회
SELECT * FROM EX2_10;


--실습
/*
CREATE TABLE DEPT_CONST (
    열_이름             VARCHAR2(40),
    자료형              VARCHAR2(30),
    길이               NUMBER,
    제약_조건           VARCHAR2(30),
    제약_조건_이름         VARCHAR2(30)
);

CREATE TABLE EMP_CONST (
    열_이름           VARCHAR2(30),
    자료형            VARCHAR2(30),
    길이              NUMBER,
    제약_조건          VARCHAR2(30),
    제약_조건_이름      VARCHAR2(30)
);

DROP TABLE DEPT_CONST;
DROP TABLE EMP_CONST;

--데이터 입력
INSERT INTO DEPT_CONST VALUES('DEPTNO', '정수형 숫자', 2, 'PRIMARY KEY', 'DEPTCONST_DEPTNO_PK');
INSERT INTO DEPT_CONST VALUES('DNAME', '가변형 문자열', 14, 'UNIQUE', 'DEPTCONST_DNAME_UNQ');
INSERT INTO DEPT_CONST VALUES('LOC', '가변형 문자열', 13, 'NOT NULL', 'DEPTCONST_LOC_NN');
*/

--부서테이블
CREATE TABLE DEPT_CONST (
    DEPTNO  NUMBER(2)       CONSTRAINT DEPTCONST_DEPTNO_PK PRIMARY KEY,
    DNAME   VARCHAR2(14)    CONSTRAINT DEPTCONST_DNAME_UNQ UNIQUE,
    LOC     VARCHAR2(13)    CONSTRAINT DEPTCONST_LOC_NN    NOT NULL
);

--사원테이블
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

--테이블 삭제
/*
DROP TABLE [스키마.]테이블명 [CASCADE CONSTRAINTS]
CASCADE CONSTRAINTS를 붙이면 삭제할 테이블의 기본키와 UNIQUE 키를 참조하는 참조 무결성 제약조건도 자동으로 삭제된다.
*/

DROP TABLE DEPT_CONST; -- EMP_CONST테이블로 부터 참조를 받고 있는 테이블이기 때문에 삭제가 안된다.

-- 삭제 순서 중요.
DROP TABLE EMP_CONST;
DROP TABLE DEPT_CONST;

--[CASCADE CONSTRAINTS] 사용
DROP TABLE DEPT_CONST CASCADE CONSTRAINTS; --EMP_CONST테이블의 참조치 제약조건을 자동삭제


--테이블 변경.
--테이블에 우클릭 후 변경가능함.
--기존에 생성했던 컬럼의 데이터 타입을 수정하거나 삭제, 새로운 컬럼을 넣어야 하는 경우가 발생

DROP TABLE EX2_10;

CREATE TABLE EX2_10 (
    COL1 VARCHAR2(10)    NOT NULL,
    COL2 VARCHAR2(10)    NULL,
    CREATE_DATE DATE DEFAULT SYSDATE
);

/*
① 컬럼명 변경: COL1 컬럼 이름을 COL11으로 변경
    ALTER TABLE [스키마.]테이블명 RENAME COLUMN 변경전컬럼명 TO 변경후컬럼명;
*/

ALTER TABLE EX2_10
RENAME COLUMN COL1 TO COL11;

--컬럼변경 확인
DESC EX2_10; --테이블 컬럼 구성을 확인할 수 있음

/*
② 컬럼 타입 변경: col2 컬럼을 VARCHAR2(10)에서 VARCHAR2(30)으로 변경
    ALTER TABLE [스키마.]테이블명 MODIFY 컬럼명 데이터타입;
*/
ALTER TABLE EX2_10
MODIFY COL2 VARCHAR2(30);

--컬럼 확인
DESC EX2_10;

/*
③ 컬럼 추가: col3 NUMBER 타입으로 신규 생성
    ALTER TABLE [스키마.]테이블명 ADD 컬럼명 데이터타입;
*/

ALTER TABLE EX2_10
ADD COL3 NUMBER;

--컬럼 확인
DESC EX2_10;

/*
④ 컬럼 삭제: col3 컬럼을 삭제
    ALTER TABLE [스키마.]테이블명 DROP COLUMN 컬럼명;
*/

ALTER TABLE EX2_10
DROP COLUMN COL3;

--컬럼확인
DESC EX2_10;

/*
⑤ 제약조건 추가: col11에 기본키 추가
    ALTER TABLE [스키마.]테이블명 ADD CONSTRAINTS 제약조건명 PRIMARY KEY (컬럼명, ..);
*/
ALTER TABLE EX2_10
ADD CONSTRAINTS PK_EX2_10 PRIMARY KEY(COL11);

/*
⑥ 제약조건 삭제: col11에서 기본키 삭제
    ALTER TABLE [스키마.]테이블명 DROP CONSTRAINTS 제약조건명;
*/
ALTER TABLE EX2_10
DROP CONSTRAINTS PK_EX2_10;


DESC EX2_10;

/*
DDL - DATE DEFINITION LANGUAGE
CREATE TABLE : 생성
ALTER TABLE : 변경
DROP TABLE : 삭제

DML - DATE MANIPULATION LANGUAGE
SELECT, INSERT, UPDATE, DELETE, MERGE

DCL
GRANT, DENY
*/

/*
테이블 복사
프로젝트를 하다 보면 기존에 있는 테이블을 복사해서 사용할 경우가 발생한다. 
예를 들어, 사용하고 있는 기존 테이블의 테이블의 구조를 자주 변경한다면 
미리 복사해 만들어 테스트해보거나, 테이블 데이터 자체를 백업용으로 만들어 놓을 수도 있다.
    CREATE TABLE [스키마.]테이블명 AS
    SELECT 컬럼1, 컬럼2, ...
    FROM 복사할 테이블명;
    
    기본키는 복사가 안된다, 그러나 다른 제약조건은 복사된다.
*/

SELECT * FROM EX2_9;

--설명 : SELECT * FROM EX2_9 실행결과 데이터를 EX2_9_1테이블을 생성하여 관리하겠다.
CREATE TABLE EX2_9_1
AS
SELECT * FROM EX2_9;

--확인
SELECT * FROM EX2_9_1;

--시나리오 : 사원테이블 중 부서코드가 50번인 데이터를 보관하는 테이블을 생성하라. EMP_DEPART

CREATE TABLE EMP_DEPARTMENT_ID_50
AS
SELECT employee_id, EMP_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, SALARY, MANAGER_ID, DEPARTMENT_ID 
FROM EMPLOYEES 
WHERE DEPARTMENT_ID = 50;

--확인
SELECT * FROM EMP_DEPARTMENT_ID_50;

--시나리오 : 사원데이터에서 급여가 5000이상인 데이터를 EMP_SALARY_5000 테이블 명으로 생성하라.
--컬럼명은 사원번호, 사원이름, 급여, 커미션, 부서코드 사용

CREATE TABLE EMP_SALARY_5000
AS
SELECT employee_id, EMP_NAME, SALARY, COMMISSION_PCT, DEPARTMENT_ID 
FROM EMPLOYEES
WHERE SALARY >= 5000;
--확인
SELECT * FROM EMP_SALARY_5000;

--데이터 입력
--사원번호가 201번이 존재 한 상태. 
--기본키가 복사가 안되어서 사원번호 201은 중복저장이 가능하게 된다.
INSERT INTO EMP_SALARY_5000 VALUES(201, 'DDK ALI', 20000, NULL, 20);

SELECT * FROM EMP_SALARY_5000 ORDER BY EMPLOYEE_ID;













































