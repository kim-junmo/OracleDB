-- PL/SQL

-- SQL : DCL, DDL, DML, TCL 4가지로 분류.
-- DML : SELECT, INSERT, UPDATE, EROP, MERGE 명령어학습
-- SELECT : 테이블의 데이터를 조회하는 명령어.

/*
SELECT 컬럼명, 컬럼명, ........ FORM 테이블명
*/

--SQL명령어는 대소문자 구분은 안함
-- *는 테이블의 모든 컬럼명을 보는 것을 의미함.
SELECT * FROM employees;

--스키마 : 테이블과 같은 데이터베이스 객체들을 논리적인 단위로 묶어서 관리하는 의미.
SELECT * FROM HR.employees; --접속(연결)상태가 동일한 HR로 되어 있으면 스키마는 생략가능하다. 

--사원테이블에서 사원번호, 이름, 전자우편, 입사일, 급여를 조회하라.
SELECT employee_id, first_name || last_name, email, hire_date, salary FROM employees;
-- ||는 더하기 같은 성격을 지니고 있음.

--테이블의 컬럼을 선택하여, 마우스로 드래그하는 방법.
SELECT employee_id, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, SALARY FROM employees;

-- FIRST_NAME과 LAST_NAME을 하나로 연결하기 ||
-- 데이터베이스에서는 문자열을 작은따옴표로 표현한다. '' (큰따옴표 ""를 사용하지 않는다.)
SELECT employee_id, FIRST_NAME || ' ' || LAST_NAME, EMAIL, HIRE_DATE, SALARY FROM employees;

-- 컬럼 별칭 사용. AS
SELECT employee_id, FIRST_NAME || ' ' || LAST_NAME AS NAME, EMAIL, HIRE_DATE, SALARY FROM employees;

-- 1) 컬럼명 AS 별칭, 2) 컬럼명 별칭
SELECT employee_id E_ID, FIRST_NAME || ' ' || LAST_NAME AS NAME, EMAIL EM, HIRE_DATE HD, SALARY SAL 
FROM employees;

--부서테이블에서 부서명을 조회하라.
SELECT department_name FROM departments;

--부서테이블에서 부서코드, 부서명을 조회하라.
SELECT department_id, DEPARTMENT_NAME FROM departments;

SELECT 
department_id, DEPARTMENT_NAME --부서코드, 부서명
FROM departments;

-- 한글 이름으로도 별칭을 사용할 수 있지만 개발에서는 사용하지 않는다.
SELECT employee_id 사원번호, MANAGER_ID 관리자아이디 FROM employees;

--별칭을 띄워쓰기 사용할 경우에는 "" 큰따옴표를 사용
SELECT employee_id "사원 번호", MANAGER_ID "관리자 아이디" FROM employees;

-- 한줄 주석
/*
여려줄 주석
*/