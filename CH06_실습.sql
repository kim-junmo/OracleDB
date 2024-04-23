--01 | 조인의 종류
--조인의 종류를 열거해 보면 내부 조인, 외부 조인, 동등 조인, 안티 조인, 셀프 조인, 세미 조인, 카타시안 조인(CATASIAN PRODUCT), ANSI 조인이 있는데, 
--이 8가지 조인 방법이 상대적으로 독립적인 개념은 아니다. 즉 내부 조인의 상대 개념이 외부 조인이며, 
--외부 조인을 제외한 셀프 조인, 안티 조인 등은 모두 내부 조인에 포함된다. 
--조인 종류가 많긴 하나, 각 명칭을 모두 암기할 필요는 없다. 
--개발자는 수능시험을 보는 학생이 아니므로, 명칭보다는 각 조인 방법을 이해하는 것이 중요하다
--일반적으로 내부 조인과 외부 조인만 구분할 수 있으면 충분하다.

--오라클에서 조인을 할 때 오라클 조인(Oracle Join)과 안시 조인(ANSI JOIN)을 사용할 수 있다. 
--오라클 9i 까지는 오라클 조인만 사용할 수 있으며, 오라클 10g부터는 안시 조인을 추가로 사용할 수 있다.

--조인
--정의 : 2개의 테이블에서 컬럼끼리 비교하여, 동일한 데이터행을 수평적으로 결합하는 기능

--표준: 오라클 조인과 ansi조인 
--조인은 내부 조인(INNER JOIN), 외부 조인(OUTER JOIN)으로 구분한다.

--내부 조인(INNER JOIN) : 일반적으로 조인을 이야기하면 INNER JOIN을 의미한다.
--벤다이어그램의 교집합을 생각하면 편함.

--외부 조인(OUTER JOIN) : inner join의 결과에다가 일치되지 않는 데이터도 포함하여 출력하는 의미
--    1)LEFT OUTER JOIN
--    2)RIGHT OUTER JOIN
--    3)FULL OUTER JOIN

--질의, 사원번호, 이름, 부서명을 조회하라.
--사원테이블 : 사원번호, 이름
--부서테이블 : 부서명

--ORACLE INNER JOIN
SELECT 사원번호, 이름, 부서명
FROM 사원테이블, 부서테이블
WHERE 사원테이블.부서코드 = 부서테이블.부서코드 --JOIN 조건식

--* : employees 테이블의 코든 컬럼과 부서테이블의 모든 컬럼
SELECT employee_id, emp_name, department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id;

--테이블 별칭을 사용하여 INNER JOIN하는 구문
SELECT a.employee_id, a.emp_name, b.department_name
FROM employees a, departments b
WHERE a.department_id = b.department_id;

--시나리오 EMP테이블과 DEPT테이블을 조인하여, 데이터를 출력하라.
SELECT e_id, e_name, d_name
FROM emp, dept
WHERE emp.d_code = dept.d_code
AND EMP.E_ID = 1001; --1001번만 보는 명령어

--ANSI JOIN(INNER JOIN)
SELECT employee_id, emp_name, department_name
FROM employees INNER JOIN departments --, 대신 INNER JOIN이 들어감
ON employees.department_id = departments.department_id; -- WHERE 대신 ON이 들어감

--테이블 별칭을 사용하여 inner join 구문
select e.employee_id , e.emp_name , d.department_name 
from employees e INNER JOIN departments d
on e.department_id = d.department_id;

SELECT e_id, e_name, d_name
FROM emp INNER JOIN dept
ON emp.d_code = dept.d_code;

SELECT e_id, e_name, d_name
FROM emp INNER JOIN dept
ON emp.d_code = dept.d_code
WHERE EMP.E_ID = 1001; --AND 대신 WHERE로 변경됨

--테이블 3개 조인 (오라클 문법)
SELECT *
FROM employees, departments, job_history
WHERE employees.department_id = departments.department_id
AND departments.department_id = job_history.department_id;

--ANSI-SQL
SELECT *
FROM employees INNER JOIN departments
ON employees.department_id = departments.department_id
INNER JOIN job_history
ON departments.department_id = job_history.department_id;

--외부 조인(OUTER JOIN)
--① 일반 조인
--일치되는 데이터만 수평적인 결합으로 출력
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM departments a,
    job_history b
WHERE a.department_id = b.department_id;
     
--일치되는 데이터행과 일치되지 않은 데이터도 포함하여 출력, 즉 job_history 에 없는 부서는 조회되지 않아서 포함해서 출력

--② 외부 조인
--27개 부서 중 job_history테이블에 없는 값도 출력하라.
--department_id테이블 : 모든 부서정보(27건), job_history테이블: 부서들 중 프로젝트를 진행한 정보가 존재, (+)표시
--1) left outer join
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM  departments a, job_history b
WHERE a.department_id = b.department_id (+) ; --31건

--2) right outer join
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM  job_history b, departments a
WHERE b.department_id (+) = a.department_id ; --31건

--1,2번의 결과 동일

--3) left outer join : job_history테이블에 일치하지 않는 부서가 존재하지 않는다.
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM  job_history b, departments a
WHERE b.department_id = a.department_id (+) ; --10건

--4) inner join
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM  job_history b, departments a
WHERE b.department_id = a.department_id ; --10건

--3,4번의 결과 동일

--FULL OUTER JOIN : ORACLE의 문법으로는 FULL OUTER JOIN 지원이 안된다. 
--  -> ANSI JOIN(FULL OUTER JOIN)으로 사용해야됨.
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM  job_history b, departments a
WHERE b.department_id(+) = a.department_id(+);


--ANSI OUTER JOIN(FULL OUTER JOIN)변환작업

--1) left outer join
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM  departments a LEFT OUTER JOIN job_history b
ON a.department_id = b.department_id; --31건

--2) right outer join
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM  job_history b RIGHT OUTER JOIN departments a
ON b.department_id = a.department_id; --31건

--3) FULL OUTER JOIN
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM  job_history b FULL OUTER JOIN departments a
ON b.department_id = a.department_id; --31건



--테이블 3개 조인 (ansi 문법)
SELECT *
FROM employees INNER JOIN departments
ON employees.department_id = departments.department_id
INNER JOIN job_history
ON departments.department_id = job_history.department_id;

CREATE TABLE HONG_A  (EMP_ID INT);
CREATE TABLE HONG_B  (EMP_ID INT);

INSERT INTO HONG_A VALUES ( 10);
INSERT INTO HONG_A VALUES ( 20);
INSERT INTO HONG_A VALUES ( 40);
INSERT INTO HONG_B VALUES ( 10);
INSERT INTO HONG_B VALUES ( 20);
INSERT INTO HONG_B VALUES ( 30);

COMMIT;

SELECT * FROM HONG_A;
SELECT * FROM HONG_B;

--FULL OUTER JOIN
SELECT *
FROM HONG_A FULL OUTER JOIN HONG_B
ON hong_a.emp_id = HONG_B.emp_id;

--JOIN에서는 분류가 그닥 중요하지 않고 INNER JOIN, OUTER JOIN인지 판단하는게 중요.

--세미 조인
--세미 조인(SEMI-JOIN)은 서브 쿼리를 사용해 서브 쿼리에 존재하는 데이터만 메인 쿼리에서 추출하는 조인 방법으로 IN과 EXISTS 연산자를 사용한 조인
--즉 서브쿼리를 알아야됨.

--셀프 조인 : 테이블 명은 동일한데, 동일한 테이블을 별칭을 두어 값을 비교하는 방법
--셀프란 말에서 알 수 있듯이, 셀프 조인(SELF-JOIN)은 서로 다른 두 테이블이 아닌 동일한 한 테이블을 사용해 조인하는 방법을 말한다.

--사원 테이블에서 부서코드가 20인 사원을 출력하라.
SELECT employee_id, EMP_NAME, department_id
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 20;

--EMPLOYEE_ID EMP_NAME                  DEPARTMENT_ID
------------- ------------------------- -------------
--        201 Michael Hartstein         20
--        202 Pat Fay                   20
--위의 수직적으로 출력되는 데이터를 수평적으로 결합하여, 출력하고자 할 때 SELF JOIN을 사용

SELECT a.employee_id, a.emp_name, b.employee_id, b.emp_name, a.department_id
FROM employees a, employees b
WHERE a.employee_id < b.employee_id --......①
AND a.department_id = b.department_id
AND a.department_id = 20;

--EMPLOYEE_ID EMP_NAME            EMPLOYEE_ID  EMP_NAME  DEPARTMENT_ID
------------- ------------------- ------------ --------- --------------
--201         Michael Hartstein   202          Pat Fay   20

--카타시안 조인(오라클)과 CROSS JOIN(ANSI)는 동일한 의미이다.
--카타시안 조인 : 연구목적으로 만들어짐
--카타시안 조인(CATASIAN PRODUCT)은 WHERE 절에 조인 조건이 없는 조인을 말한다. 
--즉 FROM 절에 테이블을 명시했으나, 두 테이블 간 조인 조건이 없는 조인이다. 
--a,B,C,D와 1,2,3,4의 데이터가 있을 때 카타시안 조인을 사용하면 
--A(1,2,3,4), B(1,2,3,4), C(1,2,3,4), D(1,2,3,4) 총 16개 값이 나온다. 
--Where절 : 조인조건식이 없다.
--2889건 : employee 107건 * department27건
--카타시안 조인
SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
FROM employees a, departments b;

--CROSS 조인
--앞에서 WHERE 절에 조인 조건을 명시하지 않은 카타시안 조인이 있었다. 이를 ANSI 조인에서는 CROSS 조인이라고 한다.
SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
FROM employees a CROSS JOIN departments b;


--문법시 헷살려 하는 경우
--USING을 사용하면서 b.department_id에 별칭을 사용해서 오류가 발생.
SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
FROM employees a INNER JOIN departments b
USING (department_id) --ON a.department_id = b.department_id
WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');

--SQL 오류: ORA-25154: USING 절의 열 부분은 식별자를 가질 수 없음.

--<잘 된 경우>
--USING을 사용하고 싶으면 department_id이 컬럼명에 별칭이 생략되어야 한다.
SELECT a.employee_id, a.emp_name, department_id, b.department_name
FROM employees a INNER JOIN departments b
USING (department_id)
WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');

--ON을 사용하고 별칭을 사용하지 않아 에러발생.
SELECT a.employee_id, a.emp_name, department_id, b.department_name
FROM employees a INNER JOIN departments b
ON a.department_id = b.department_id
WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');

--USING을 사용하지 않고 ON을 사용했을 때는 b.department_id처럼 별칭 사용 필수.
SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
FROM employees a INNER JOIN departments b
ON a.department_id = b.department_id
WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');

--두 테이블 간 조인 조건에 사용되는 컬럼명이 동일한 경우가 많긴 하지만 다를 때도 있으므로, 
--USING 대신 ON 절을 사용하는 것이 일반적이다.
--외부 조인은 OUTER라는 키워드를 붙이는데, 이는 생략이 가능하다. 
--즉 LEFT JOIN 혹은 RIGHT JOIN이라고 명시해도 이는 외부 조인을 의미한다.

/*
04 | 서브 쿼리
서브 쿼리Sub-Query 란 한 SQL 문장 안에서 보조로 사용되는 또 다른 SELECT문을 의미한다. 
최종 결과를 출력하는 쿼리를 메인 쿼리라고 한다면, 
이를 위한 중간 단계 혹은 보조 역할을 하는 SELECT문을 서브 쿼리라 한다. 
조인 절에서 소개했던 SQL문 중 괄호 안에 들어있는 SELECT문이 바로 서브 쿼리에 속한다. 
하나의 SQL문을 기준으로 메인 쿼리를 제외한 나머지 모든 SELECT문을 서브 쿼리로 보면 되며, 
따라서 서브 쿼리는 여러 개를 사용할 수 있다.

서브 쿼리는 다양한 형태로 사용된다. 
즉 SELECT, FROM, WHERE 절 모두에서 사용할 수 있을 뿐만 아니라, 
INSERT, UPDATE, MERGE, DELETE 문에서도 사용할 수 있다. 
서브 쿼리는 그 특성과 형태에 따라 다음과 같이 구분할 수 있다.

메인 쿼리와의 연관성에 따라

연관성 없는(Noncorrelated) 서브 쿼리
연관성 있는 서브 쿼리
형태에 따라

일반 서브 쿼리(SELECT 절)
인라인 뷰(FROM 절)
중첩 쿼리(WHERE 절)
*/

--연관성 없는 서브 쿼리
--특징 : 메인쿼리의 영향을 받지 않고, 단독으로도 실행이 가능하다 (오류가 발생하지 않는다.)
--메인 쿼리와의 연관성이 없는 서브 쿼리를 말한다. 
--즉 메인 테이블과 조인 조건이 걸리지 않는 서브 쿼리를 가리킨다.

--전 사원의 평균 급여 이상을 받는 사원 수를 조회하는 쿼리다

--1) 사원의 평균 급여
SELECT AVG(salary) FROM employees; --6461.831775700934579439252336448598130841

--유형 1 : 서브쿼리가 단일행 반환
--메인쿼리 : 앞의 SELECT, 서브쿼리 : 안의 SELECT
SELECT * FROM employees
WHERE SALARY >=(SELECT AVG(salary) FROM employees);

SELECT count(*)
FROM employees
WHERE salary >=  ( SELECT AVG(salary)
FROM employees );

--유형 2 
--서브쿼리의 결과가 여러행인 경우에는 IN 키워드 사용,
--서브쿼리의 결과가 하나일 경우만 등호 또는 부등호 연산자 사용이 가능하다.
--부서 테이블에서 parent_id가 NULL인 부서번호를 가진 사원의 총 건수를 반환하는 쿼리

--부서 테이블에서 parent_id가 NULL인 부서번호
SELECT department_id FROM departments
WHERE parent_id IS NULL;

SELECT count(*)
FROM employees
WHERE department_id IN ( SELECT department_id
                         FROM departments
                         WHERE parent_id IS NULL);

--서브쿼리의 결과가 하나일 경우만 등호 또는 부등호 연산자 사용이 가능하다.
SELECT count(*)
FROM employees
WHERE department_id = ( SELECT department_id
                         FROM departments
                         WHERE parent_id IS NULL);

SELECT count(*)
FROM employees
WHERE department_id = (10,20,30); --등호, 부등호는 여러개의 결과값과 비교불가능, 에러발생

SELECT count(*)
FROM employees
WHERE department_id IN (10,20,30); --여러개의 결과값이 비교가능, 정상작동

--유형 3 

SELECT employee_id, emp_name, job_id FROM employees
       WHERE (employee_id, job_id) IN (SELECT employee_id, job_id FROM job_history);

--안됨
CREATE TABLE t1(
    COL1 NUMBER PRIMARY KEY
    COL2 VARCHAR2(10) PRIMARY KEY   
);

--복합키로 인해 가능
CREATE TABLE t1(
    COL1 NUMBER 
    COL2 VARCHAR2(10) 
    PRIMARY KEY(COL1, COL2)
);



--연관성 있는 서브 쿼리
--메인 쿼리와의 연관성이 있는 서브 쿼리, 즉 메인 테이블과 조인 조건이 걸린 서브 쿼리를 말한다.
--보충 설명 : 서브쿼리에서 사용하는 컬럼명이 메인쿼리 테이블의 컬럼명을 참조하고 있는 형태.
SELECT a.department_id, a.department_name
FROM departments a
WHERE EXISTS (SELECT 1
              FROM job_history b
              WHERE a.department_id = b.department_id);

--EXISTS()함수 사용법
--()안에 결과가 존재하면 TRUE로 리턴을 해준다. 존재하지 않으면 FALSE를 반환한다. 
SELECT 1 FROM DUAL WHERE 1 = 0; -- 조건식이 FALSE일 경우에는 1이 데이터행으로 출력 안됨
SELECT 1 FROM DUAL WHERE 1 != 0; -- 조건식이 TURE 일 경우에는 1이 데이터행으로 출력됨

--EXISTS함수는 서브쿼리에서  데이터가 존재하지 않아 FALSE 처리가 되고, 출력결과가 없다
SELECT * FROM DEPARTMENTS WHERE EXISTS(SELECT 1 FROM DUAL WHERE 1 = 0); 
--EXISTS함수는 서브쿼리에서  데이터가 존재하지 않아 TRUE 처리가 되고, 출력결과가 있다
SELECT * FROM DEPARTMENTS WHERE EXISTS(SELECT 1 FROM DUAL WHERE 1 != 0);

--아래 연관성이 있는 서브쿼리.
--WHERE절에서 사용
SELECT a.department_id, a.department_name
FROM departments a --27건
WHERE EXISTS (SELECT 1
              FROM job_history b
              WHERE a.department_id = b.department_id); --6건, 중복된 department_id 컬럼의 데이터가 제거됨
/*
출력
DEPARTMENT_ID DEPARTMENT_NAME 
------------- ----------------
           20 마케팅
           50 배송부
           60 IT
           80 영업부
           90 기획부
          110 경리부 
*/

--동작설명
SELECT department_id FROM departments; --27건

SELECT department_id FROM job_history; --10건
/*
메인쿼리인 departments 테이블의 27건 데이터가 하나씩 
1) 서브쿼리 WHERE a.department_id = b.department_id 일치가 되면 1이 데이터로 출력되고,
EXISTS 함수는 TRUE가 되어, 일치되는 a.department_id가 메인 쿼리로 반환된다.

2) 서브쿼리 WHERE a.department_id = b.department_id 일치되지 않으면 1이 데이터로 출력이 되지 않고
EXISTS 함수는 FALSE가 되어, 일치되지 않는 a.department_id가 메인쿼리로 반환되지 않는다.

결과는 메인쿼리로 반환된 데이터 행의 컬럼명인 a.department_id, a.department_name만 출력이 된다.
*/

--연관선 있는 서브쿼리를 조인으로 변환
SELECT a.department_id, a.department_name
FROM departments a --27건
WHERE EXISTS (SELECT 1
              FROM job_history b
              WHERE a.department_id = b.department_id); --6건, 중복된 데이터 행이 제거됨.
    
--JOIN문법으로           
SELECT a.department_id, a.department_name
FROM departments a, job_history b
WHERE a.department_id = b.department_id; --10건 출력, 중복된 데이터행이 제거안됨.

--DISTINCT
SELECT DISTINCT a.department_id, a.department_name
FROM departments a, job_history b
WHERE a.department_id = b.department_id; --6건 출력

/*************************************************************/
--SELECT 절에서 사용
SELECT a.employee_id,
           ( SELECT b.emp_name
               FROM employees b
              WHERE a.employee_id = b.employee_id) AS emp_name,
           a.department_id,
           ( SELECT b.department_name
               FROM departments b
              WHERE a.department_id = b.department_id) AS dep_name
FROM job_history a;

SELECT a.employee_id  AS emp_name, a.department_id AS dep_name FROM job_history a;

--동작설명
/*
job_history테이블의 10건의 데이터가 하나씩 서브쿼리의 조건식에서 WHERE a.employee_id = b.employee_id가 비교되어 일치하면, 반환이 되고
일치하지 않으면 메인쿼리에서 버려진다.
일지되는 데이터만 메인쿼리 SELECT에서 a.employee_id,  a.department_id 여기서 출력된다.
*/

--인라인 뷰 : 면접때 가장 많이 물어보는 
--FROM 절에 사용하는 서브 쿼리를 인라인 뷰InlineView 라고 한다. 
--원래 FROM 절에는 테이블이나 뷰가 오는데, 서브 쿼리를 FROM 절에 사용해 하나의 테이블이나 뷰처럼 사용할 수 있다. 
--뷰를 해체하면 하나의 독립적인 SELECT문이므로 FROM 절에 사용하는 서브 쿼리도 하나의 뷰로 볼 수 있어서 인라인 뷰라는 이름이 붙은 것이다.

--SELECT * FROM 테이블명 또는 뷰명 ;
--SELECT * FROM (연관성 없는 서브쿼리) -> 인라인뷰

--유형 1
SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
FROM employees a, departments b,
           (SELECT AVG(c.salary) AS avg_salary
            FROM departments b, employees c
            WHERE b.parent_id = 90  -- 기획부
            AND b.department_id = c.department_id) d
WHERE a.department_id = b.department_id
AND a.salary > d.avg_salary;

--employees a -> SELECT * FROM employees;를 A로 지칭
--departments b -> SELECT * FROM departments;를 B로 지칭

--유형 2
--SELECT a.* FROM 
--(SELECT a.sales_month, ROUND(AVG(a.amount_sold)) 
-- AS month_avg
-- FROM sales a, customers b, countries c
-- WHERE a.sales_month BETWEEN '200001' AND '200012'
-- AND a.cust_id = b.CUST_ID
-- AND b.COUNTRY_ID = c.COUNTRY_ID
-- AND c.COUNTRY_NAME = 'Italy' -- 이탈리아
-- GROUP BY a.sales_month)a,
-- (SELECT ROUND(AVG(a.amount_sold)) AS year_avg
--  FROM sales a, customers b, countries c
--  WHERE a.sales_month BETWEEN '200001' AND '200012'
--  AND a.cust_id = b.CUST_ID
--  AND b.COUNTRY_ID = c.COUNTRY_ID
--  AND c.COUNTRY_NAME = 'Italy' -- 이탈리아
--  ) b
--WHERE a.month_avg > b.year_avg ;

--복잡한 쿼리를 작성해야 할 때, 어떻게 해야 할까?
--정답은 없다. 오히려 정답이 있는 것이 이상하다. 
--조회 대상 테이블과 컬럼, 원하는 결과가 때에 따라 모두 다르기 때문이다. 
--복잡한 문제를 풀 때 사용하는 방법이 있는데, 바로 “분할해서 정복하라(Divide & Conquer)” 이다. 
--복잡한 쿼리를 작성할 때에도 작은 단위로 분할한 뒤, 다시 합치면 의외로 간단히 해결할 수 있다. 

--(1) 최종적으로 조회되는 결과 항목을 정의한다.
--(2) 필요한 테이블과 컬럼을 파악한다.
--(3) 작은 단위로 분할해서 쿼리를 작성한다.
--(4) 분할한 단위의 쿼리를 하나로 합쳐 최종 결과를 산출한다.
--(5) 결과를 검증한다.
















