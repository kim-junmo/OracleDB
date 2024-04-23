/*
뷰View는 하나 이상의 테이블이나 다른 뷰의 데이터를 볼 수 있게 하는 데이터베이스 객체다. 
실제 데이터는 뷰를 구성하는 테이블에 담겨 있지만 마치 테이블처럼 사용할 수 있다. 
또한 테이블 뿐만 아니라 다른 뷰를 참조해 새로운 뷰를 만들어 사용할 수 있다
데이터를 본다는 의미가 있으므로 뷰의 정의는 데이터를 조회하는 SELECT문으로 구성된다.

테이블은 실제 데이터를 관리한다. 그러나 뷰는 데이터를 관리하는 것이 아닌 SELECT문의 코드를 관리한다.
그래서 뷰를 열면 SELECT문이 실행이 되어, 데이터를 조회하게 되는 것이다.
*/
/*
뷰 생성
    CREATE OR REPLACE VIEW [스키마.]뷰명 AS
    SELECT 문장;
    
용도 : 1) SELECT문으로 시작하는 긴 문장, 2)보안적으로 중요한 컬럼을 가지고 있는 테이블 사용을 막고 뷰로 대체할때
*/

--뷰 생성 및 수정 (CREATE OR REPLACE)
--설명 : VW_EMPLOYEES_DEPARTMENT_ID_50 뷰이름으로 SELECT 구문의 코드를 저장하여 관리한다.
--SELECT 문이 긴 구문 또는 보안적으로 중요한 컬럼(예 : SALARY 급여)
--보안때문에 원본 테이블을 숨기는 효과도 있다.
CREATE OR REPLACE VIEW VW_EMPLOYEES_DEPARTMENT_ID_50
AS
SELECT employee_id, EMP_NAME, HIRE_DATE, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

--뷰 실행(비유: 함수를 호출하는 의미). 아래처럼 작성하면, 뷰가 관리하는 SELECT문이 실행이 되어 데이터를 확인할 수 있다.
SELECT * FROM VW_EMPLOYEES_DEPARTMENT_ID_50;

/*
뷰 삭제
    DROP VIEW [스키마.]뷰명;
*/
DROP VIEW VW_EMPLOYEES_DEPARTMENT_ID_50;

/*
06 | 시퀀스
시퀀스(Sequence)는 자동 순번을 반환하는 데이터베이스 객체다. 
*/

/*
? INCREMENT BY 증감숫자: 증감숫자는 0이 아닌 정수. 양수이면 증가, 음수이면 감소. 디폴트 값은 1

? START WITH 시작숫자: 시작숫자의 디폴트 값은 증가일 때는 MINVALUE, 감소일 경우 MAXVALUE.

? NOMINVALUE: 디폴트 값으로 증가일 때 1, 감소의 경우 -(1027 -1).

? MINVALUE 최솟값: 최솟값은 시작숫자와 작거나 같아야 하고 MANVALUE보다 작아야 한다.

? NOMAXVALUE: 디폴트 값으로 증가일 때 1028-1, 감소의 경우 -1.

? MAXVALUE 최댓값: 최댓값은 시작숫자와 같거나 커야 하고 MINVALUE보다 커야 한다.

? NOCYCLE: 디폴트 값으로 최대나 최솟값에 도달하면 생성 중지.

? CYCLE: 증가는 최댓값에 도달하면 다시 최솟값부터 시작, 감소는 최솟값에 도달하면 다시 최댓값에서 시작.

? NOCACHE: 디폴트로 메모리에 시퀀스 값을 미리 할당해 놓지 않으며 디폴트 값은 20.

? CACHE: 메모리에 시퀀스 값을 미리 할당해 놓음.
*/

--시퀀스 생성
CREATE SEQUENCE MY_SEQ1
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 1000
NOCYCLE
NOCACHE;

CREATE SEQUENCE MY_SEQ2; -- 최소값 1, 증가값 1

--시퀀스 명령어
--NEXTVAL : 사용할 때 마다 처음에만 최소값 1이 출력되고 다음에는 증가값 1이 더해진 값이 출력된다.
--CURRVAL : 연재 시퀀스 값을 확인할때 사용한다. 

SELECT MY_SEQ2.NEXTVAL FROM DUAL; -- 최소값 1
SELECT MY_SEQ2.NEXTVAL FROM DUAL; -- 증가값이 작동 +1 결과가 2

--시퀀스 값 확인
--주의> 시퀀스 처음 만들고 NEXTVAL 명령어를 사용하지 않고 해당 명령어를 사용하면 안된다.
SELECT MY_SEQ2.CURRVAL FROM DUAL;

CREATE SEQUENCE MY_SEQ3;
SELECT MY_SEQ2.CURRVAL FROM DUAL; --에러발생

--시퀀스 사용.
CREATE SEQUENCE MY_SEQ4;

CREATE TABLE SAMPLE_8 (
  IDX       NUMBER          PRIMARY KEY,
  NAME      VARCHAR2(20)    NOT NULL,
  REG_DATE  DATE            DEFAULT SYSDATE
);

INSERT INTO SAMPLE_8(IDX, NAME) VALUES(MY_SEQ4.NEXTVAL, '손흥민'); --초기값 1

INSERT INTO SAMPLE_8(IDX, NAME) VALUES(MY_SEQ4.NEXTVAL, '황희찬'); --INCREMENT_BY

INSERT INTO SAMPLE_8(IDX, NAME) VALUES(MY_SEQ4.NEXTVAL, '김민재'); --INCREMENT_BY

INSERT INTO SAMPLE_8(IDX, NAME) VALUES(MY_SEQ4.NEXTVAL, '이강인'); --INCREMENT_BY

SELECT * FROM SAMPLE_8;

CREATE SEQUENCE MY_SEQ5
MINVALUE 1000 --초기값
INCREMENT BY 10;  --음수값으로도 사용가능하다.

SELECT MY_SEQ5.NEXTVAL FROM DUAL; --1000

SELECT MY_SEQ5.NEXTVAL FROM DUAL; --1010

SELECT MY_SEQ5.NEXTVAL FROM DUAL; --1020


--시퀀스 생성
CREATE SEQUENCE 시퀀스명

--시퀀스 수정
ALTER SEQUENCE 시퀀스명
INCREMENT BY 5;

ALTER SEQUENCE 시퀀스명
MAXVALUE 999999;

--START WITH 속성은 수정에서 변경 불가능

--시퀀스 삭제
DROP SEQUENCE 시퀀스명;

--04 | 인덱스
--인덱스Index는 테이블에 있는 데이터를 빨리 찾기 위한 용도의 데이터베이스 객체다. 
--? 인덱스 구성 컬럼 개수에 따른 분류: 단일 인덱스와 결합 인덱스
--? 유일성 여부에 따른 분류: UNIQUE 인덱스, NON-UNIQUE 인덱스
--? 인덱스 내부 구조에 따른 분류: B-tree 인덱스(일반적으로 가장 많이 사용함), 비트맵 인덱스, 함수 기반 인덱스

--테이블에 primary key 제약조건을 생성하면, 다종으로 인덱스가 생성된다.
-- 기본키
--1)단일키 : 컬럼 1개
--2)복합키 : 컬럼 복수로 하나의 단위로 묶어서 적용

--인덱스 생성
--    CREATE[UNIQUE] INDEX [스키마명.]인덱스명
--    ON [스키마명.]테이블명(컬럼1, 컬럼2, ...);

--컬럼 1개로 인덱스 구성 : 단일 인덱스
CREATE UNIQUE INDEX ex2_10_ix01
ON ex2_10 (col11); 
--COL1컬럼명에 중복된 데이터는 허용하지 않으면서, 
--검색시 이 컬럼의 데이터를 검색시 성능향상의 목적으로 인덱스 생성한다.

--옵티마이저(Optimaizer) : select문을 실행시 빠른 처리가 될 수 있도록 네비게이션 같은 기능.
SELECT * FROM ex2_10 WHERE COL1 = 값;

--결합 인덱스, 중복방지 안됨
--검색이 많은 것부터 앞으로 놔두어서 사용해야함.
CREATE INDEX EX2_10_IX2
ON EX2_10(COL11, COL2)


CREATE TABLE 회원 (
회원아이디, --PRIVATE KEY
이름,
주민등록번호 --

CREATE UNIQUE INDEX 회원_INX
ON 회원(주민등록번호):

--인덱스는 기본적으로 정렬된 구조 상태로 만들어준다.
--그러므로 인덱스를 너무 많이 만들면 SELECT 외에 INSERT, DELETE, UPDATE 시 성능에 부하가 뒤따른다.

--인덱스를 생성할 때 고려해야 할 사항을 정리하면 다음과 같다.

--? 일반적으로 테이블 전체 로우 수의 15%이하의 데이터를 조회할 때 인덱스를 생성한다
--물론 15%는 정해진 것은 아니며 테이블 건수, 데이터 분포 정도에 따라 달라진다.

--? 테이블 건수가 적다면(코드성 테이블) 굳이 인덱스를 만들 필요가 없다
--데이터 추출을 위해 테이블이나 인덱스를 탐색하는 것을 스캔(scan)이라고 하는데, 
--테이블 건수가 적으면 인덱스를 경유하기보다 테이블 전체를 스캔하는 것이 빠르다.

--? 데이터의 유일성 정도가 좋거나 범위가 넓은 값을 가진 컬럼을 인덱스로 만드는 것이 좋다

--? NULL이 많이 포함된 컬럼은 인덱스 컬럼으로 만들기 적당치 않다

--? 결합 인덱스를 만들 때는, 컬럼의 순서가 중요하다
--보통, 자주 사용되는 컬럼을 순서상 앞에 두는 것이 좋다.

--? 테이블에 만들 수 있는 인덱스 수의 제한은 없으나, 너무 많이 만들면 오히려 성능 부하가 발생한다





