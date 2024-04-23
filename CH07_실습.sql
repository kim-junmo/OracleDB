--7장 복잡한 연산 결과를 추출해 내는 고급 쿼리 다루기
--01 | 계층형 쿼리
--계층형 구조
--계층형 쿼리HierarchicalQuery 는 2차원 형태의 테이블에 저장된 데이터를 계층형 구조로 결과를 반환하는 쿼리를 말한다. 
--계층형 구조란 상하 수직 관계의 구조로 
--사원-대리-과장-부장과 같은 직급, 
--판매부-영업부 같은 부서 구조, 
--대학의 학과, 
--정부 부처 등이 
--계층형 구조에 속한다. 
--또한 엑셀과 같은 프로그램의 메뉴 구조, 답변형 게시판뿐만 아니라 이 책의 목차도 이에 포함된다. 
--예를 들어, 부서 테이블에 있는 부서 정보는 다음과 같이 상위-하위 부서로 나눌 수 있다.

--계층형 형태의 출력목적으로 작성한 코드
    SELECT department_id,
           department_name,
           0 AS PARENT_ID,
           1 as levels,
           parent_id || department_id AS sort
      FROM departments
     WHERE parent_id IS NULL
     UNION ALL
    SELECT t2.department_id,
           LPAD(' ' , 3 * (2-1)) || t2.department_name AS department_name,
           t2.parent_id,
           2 AS levels,
           t2.parent_id || t2.department_id AS sort
      FROM departments t1,
           departments t2
     WHERE t1.parent_id is null
       AND t2.parent_id = t1.department_id
     UNION ALL
    SELECT t3.department_id,
           LPAD(' ' , 3 * (3-1)) || t3.department_name AS department_name,
           t3.parent_id,
           3 as levels,
           t2.parent_id || t3.parent_id || t3.department_id as sort
      FROM departments t1,
           departments t2,
           departments t3
     WHERE t1.parent_id IS NULL
       AND t2.parent_id = t1.department_id
       AND t3.parent_id = t2.department_id
     UNION ALL
    SELECT t4.department_id,
           LPAD(' ' , 3 * (4-1)) || t4.department_name as department_name,
           t4.parent_id,
           4 as levels,
           t2.parent_id || t3.parent_id || t4.parent_id || t4.department_id AS sort
      FROM departments t1,
           departments t2,
           departments t3,
           departments t4
     WHERE t1.parent_id IS NULL
       AND t2.parent_id = t1.department_id
       AND t3.parent_id = t2.department_id
       and t4.parent_id = t3.department_id
     ORDER BY sort;

--계층형 쿼리 문법

--    SELECT expr1, expr2, ...
--    FROM 테이블
--    WHERE 조건
--    START WITH[최상위 조건]
--    CONNECT BY [NOCYCLE][PRIOR 계층형 구조 조건];

--DEPARTMENTS(부서)테이블의 상하위 수직구조로 출력하라.
--최상위 부서 총부기획부 순서로 하위 부서 구조를 출력한 형태
--LPAD(' ' , 3 * (LEVEL-1)) || : 띄어쓰기
SELECT LEVEL, department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id = parent_id; --위에서 아래로(TOP DOWN) PRIOR 키워드를 자식컬럼에 사용시


--구매/생산부를 기준으로 하위 부서를 출력하라.
SELECT department_id, Department_Name
FROM departments
START WITH department_id = 30
CONNECT BY department_id = PRIOR parent_id; -- 아래에서 위로(BOTTOM UP) PRIOR 키워드를 부모컬럼에 사용시

--① 계층형 쿼리 정렬
--계층형 쿼리는 계층형 구조에 맞게 순서대로 출력되는데 ORDER BY 절로 그 순서를 변경할 수 있다.
--그래서 ORDER BY 절은 사용하면 안된다.
SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id  = parent_id
ORDER BY department_name; -- : 정렬을 사용시 부서명의 출력 순서가 변경되어, 상하위 연결 출력구조를 볼수가 없다.


SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id  = parent_id
ORDER BY LEVEL; 

-- 계층형 쿼리를 위한 정렬이 따로 있다.
--부서명으로 정렬됨과 동시에 계층형 구조까지 보존하려면 ORDER SIBLINGS BY 절을 사용해야 한다.
SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id  = parent_id
ORDER SIBLINGS BY department_name; --레벨이 같은 형제 로우에 한해서 정렬

--② CONNECT_BY_ROOT
--CONNECT_BY_ROOT는 계층형 쿼리에서 최상위 로우를 반환하는 연산자다. 
--연산자이므로 CONNECT_BY_ROOT 다음에는 표현식이 온다.

SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL,
CONNECT_BY_ROOT department_name AS root_name
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id  = parent_id;

--③ CONNECT_BY_ISLEAF
--CONNECT_BY_ISLEAF는 CONNECT BY 조건에 정의된 관계에 따라 해당 로우가 
--최하위 자식 로우이면 1을, 그렇지 않으면 0을 반환하는 의사 컬럼이다.
--즉, 밑에 아무도 없으면 1, 있으면 0이다.

SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL, CONNECT_BY_ISLEAF
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id  = parent_id;

--④ SYS_CONNECT_BY_PATH (colm, char)
--SYS_CONNECT_BY_PATH는 계층형 쿼리에서만 사용할 수 있는 함수로, 
--루트 노드에서 시작해 자신의 행까지 연결된 경로 정보를 반환한다. 
--이 함수의 첫 번째 파라미터로는 컬럼이, 두 번째 파라미터인 char은 컬럼 간 구분자를 의미한다. 
--부서에 대한 경로를 보여준다.

SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL,
SYS_CONNECT_BY_PATH( department_name, '|')
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id  = parent_id;

--두 번째 매개변수인 구분자로 해당 컬럼 값에 포함된 문자는 사용할 수 없다는 점을 주의해야 한다. 
--위 쿼리에서 구매/생산부는 ‘/’문자가 속해 있는데, 구분자로 ‘/’를 사용하면 다음과 같은 오류가 발생한다.

--구매/생산부의 '/'으로 인해 오류가 발생.

SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL,
SYS_CONNECT_BY_PATH( department_name, '/')
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id  = parent_id;


--⑤ CONNECT_BY_ISCYCLE
--눈치챘는지는 모르겠지만 오라클의 계층형 쿼리는 루프(반복) 알고리즘을 사용한다. 
--계층형 구조나 레벨은 테이블에 있는 데이터에 따라 동적으로 변경되므로, 
--내부적으로는 루프를 돌며 자식 노드를 찾아간다. 
--루프 알고리즘에서 주의할 점은 조건을 잘못 주면 무한루프를 타게 된다는 점인데, 
--계층형 쿼리에서도 부모-자식 간의 관계를 정의하는 값이 잘못 입력되면 무한루프를 타고 오류가 발생한다.

--예를 들어, 생산팀(170)의 부모 부서는 구매/생산부(30)인데, 
--구매/생산부의 parent_id 값을 생산부로 바꾸면 
--두 부서가 상호 참조가 되어 무한루프가 발생할 것이다.

UPDATE departments
SET parent_id = 170
WHERE department_id = 30;

SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL,
parent_id
FROM departments
START WITH department_id = 30
CONNECT BY PRIOR department_id  = parent_id;
--SQL 오류: ORA-01436: CONNECT BY의 루프가 발생되었습니다.


--부서의 상위부서 값이 잘못 입력되어, 루프 발생 시 해결하기 위한 쿼리

SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name AS depname, LEVEL,
CONNECT_BY_ISCYCLE IsLoop,
           parent_id
FROM departments
START WITH department_id = 30
CONNECT BY NOCYCLE PRIOR department_id  = parent_id;

ROLLBACK; -- 구매/생산부의 parent_id 값을 생산부로 변경한 update구문 취소.



--03 | 분석 함수와 window 함수
--분석 함수AnalyticFunction 란 테이블에 있는 로우에 대해 특정 그룹별로 집계 값을 산출할 때 사용된다. 
--집계 값을 구할 때 보통은 그룹 쿼리를 사용하는데, 이때 GROUP BY 절에 의해 최종 쿼리 결과는 그룹별로 로우 수가 줄어든다. 
--이에 반해, 집계 함수를 사용하면 로우의 손실 없이도 그룹별 집계 값을 산출해 낼 수 있다. 
--분석 함수에서 사용하는 로우별 그룹을 윈도우(window)라고 부르는데, 이는 집계 값 계산을 위한 로우의 범위를 결정하는 역할을 한다.
--그럼 지금부터 분석 함수에 대해 자세히 알아보자. 분석 함수 구문은 다음과 같다.

분석 함수(매개변수) OVER
       　　　(PARTITION BY expr1, expr2,...
                  ORDER BY expr3, expr4...
                window 절)

--분석 함수
--① ROW_NUMBER( )
--ROW_NUMBER는 ROWNUM 의사 컬럼과 비슷한 기능을 하는데, 
--파티션으로 분할된 그룹별로 각 로우에 대한 순번을 반환하는 함수다. 
--사원 테이블에서 부서별 사원들의 로우 수를 출력해 보자.

ROWNUM 의사컬럼
SELECT ROWNUM, emp_name, email FROM employees;

SELECT ROWNUM, emp_name, email FROM employees WHERE rownum<=5;

--중간 범위의 값을 출력할 수 없다.
SELECT ROWNUM, emp_name, email FROM employees WHERE ROWNUM >=5 AND ROWNUM <=10;

--group by 문법
--사원 테이블에서 부서별 사원들의 인원 수 
SELECT count(*) from employees group by department_id;

--PARTITION BY 부서가 같은 데이터별로 분류를 하겠다.
SELECT department_id, emp_name, 
ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY emp_name) dep_rows
FROM employees;

-- 해석 순서
-- 1)(PARTITION BY department_id ORDER BY emp_name): emp_name의 이름으로 파티션을 나눈다.
-- 2)ROW_NUMBER() 번호 부여
-- 3) SELECT department_id, emp_name, FROM employees;가 진행이 된다.

--ROW_NUMBER 함수란??
--  각 PARTITION 내에서 ORDER BY절에 의해 정렬된 순서를 기준으로 고유한 값을 반환하는 함수입니다.?
-- ?윈도우 함수(Window Funtion)로 그룹 내 순위?함수입니다.

--문법ROW_NUMBER() OVER(PARTITION BY [그룹핑할 컬럼] ORDER BY [정렬할 컬럼])
--  PARTITION BY는 선택, ORDER BY는 필수


--② RANK( ), DENSE_RANK( ) : 파티션별로 순위를 매기는 함수
--Rank 함수는 파티션별 순위를 반환한다. 부서별로 급여 순위를 매겨 보자.

SELECT department_id, emp_name, salary,
RANK() OVER (PARTITION BY department_id ORDER BY salary) dep_rank
FROM employees;

--각 부서별 사원들의 급여 순위를 출력하라.
SELECT department_id, emp_name, salary,
RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) dep_rank
FROM employees;
--위 결과에 대한 설명
--50번 부서에서 동일한 급여를 받는 사원은 동일한 순위가 반환됐는데 (2위) 
--그 다음 순위는 한 번 건너뛰어(4위) 매겨졌다는 점에 유의하자.
--만약 2위가 3명이라면 다음 순위는 5위가 될 것이다.

--DENSE_RANK 함수는 RANK와 비슷하지만 같은 순위가 나오면 다음 순위가 한 번 건너뛰지 않고 매겨진다.
SELECT department_id, emp_name, salary,
DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary ) dep_rank
FROM employees;
-- 50번 부서에서 동일 순위인 2위 다음 순번이 4위가 아닌 3위로 반환됐음을 확인할 수 있다.

--TOP n 쿼리 - 탑엔쿼리
--분석 함수는 응용 분야가 매우 많다. 
--예를 들어, 특정 조건에 맞는 상위 혹은 하위 n개의 데이터만 추출하는 TOP n 쿼리도 쉽게 작성할 수 있다. 
--각 부서별로 급여가 상위 3위까지인 사원을 추출하는 쿼리를 작성해 보자.

SELECT department_id, emp_name, salary,
DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary desc) dep_rank
FROM employees

--위 select문을 from 절에서 사용한다.(인라인 뷰)

SELECT * FROM (SELECT department_id, emp_name, salary,
DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary desc) dep_rank
FROM employees)
WHERE dep_rank <= 3;

--04 | 다중 테이블 INSERT
--마지막으로 알아 볼 다중 테이블 INSERT 구문은 단 하나의 INSERT 문장으로 
--여러 개의 INSERT 문을 수행하는 효과를 낼 수 있을 뿐만 
--아니라 특정 조건에 맞는 데이터만 특정 테이블에 입력되게 할 수 있는 문장이다. 

--먼저 다중 테이블 INSERT 문의 구문을 살펴 보자.

    INSERT ALL| FIRST
    WHEN 조건1 THEN
    　INTO [스키마.]테이블명(컬럼1, 컬럼2, ...) VALUES(값1, 값2, ...)
    WHEN 조건2 THEN
    　INTO [스키마.]테이블명(컬럼1, 컬럼2, ...) VALUES(값1, 값2, ...)
        ...
     ELSE
    　 INTO [스키마.]테이블명(컬럼1, 컬럼2, ...) VALUES(값1, 값2, ...)
    SELECT 문;

--? ALL: 디폴트 값으로 이후 WHEN 조건절을 명시했을 때 각 조건이 맞으면 INSERT를 모두 수행하라는 의미다.

--? FIRST: 이후 WHEN 절 조건식에 따른 INSERT문을 수행할 때, 
--서브 쿼리로 반환된 로우에 대해 조건이 참인 WHEN 절을 만나면 
--해당 INSERT문을 수행하고 나머지에 대해서는 조건 평가를 하지 않고 끝낸다.

--? WHEN 조건 THEN … ELSE: 특정 조건에 따라 INSERT를 수행할 때 해당 조건을 명시.

--? SELECT 문: 다중 테이블 INSERT 구문에서는 반드시 서브 쿼리가 동반되어야 하며, 
--서브 쿼리의 결과를 조건에 따라 평가해 데이터를 INSERT 한다.

CREATE TABLE ex7_3 (
emp_id    NUMBER,
emp_name  VARCHAR2(100));

CREATE TABLE ex7_4 (
emp_id    NUMBER,
emp_name  VARCHAR2(100));

INSERT INTO ex7_3 VALUES (101, '홍길동');
INSERT INTO ex7_3 VALUES (102, '김유신');

--유형 1
INSERT ALL
    INTO ex7_3 VALUES (103, '강감찬')
    INTO ex7_3 VALUES ('104', '연개소문')
SELECT * FROM DUAL;

select * from ex7_3;

rollback;

--유형 2
INSERT ALL INTO ex7_3 VALUES (emp_id, emp_name)
SELECT 103 emp_id, '강감찬' emp_name FROM DUAL
UNION ALL
SELECT 104 emp_id, '연개소문' emp_name FROM DUAL;

--유형 3
INSERT ALL 
INTO ex7_3 VALUES (105, '가가가')
INTO ex7_4 VALUES (105, '나나나')
SELECT * FROM DUAL;

select * from ex7_3;
select * from ex7_4;

--조건에 따른 다중 INSERT
TRUNCATE TABLE ex7_3;

TRUNCATE TABLE ex7_4;

INSERT ALL
    WHEN department_id = 30 THEN
    INTO ex7_3 VALUES (employee_id, emp_name)
    WHEN department_id = 90 THEN
    INTO ex7_4 VALUES (employee_id, emp_name)
    SELECT department_id, employee_id, emp_name FROM employees;
/*
SELECT department_id, employee_id, emp_name FROM employees;: 실행된 결과를 삽입데이터로 사용
department_id 부서컬럼의 데이터가 30이면 ex7_3 테이블에 데이터 삽입
department_id 부서컬럼의 데이터가 90이면 ex7_4 테이블에 데이터 삽입
즉 부서컬럼의 30은 ex7_3에 전부 넣고, 90은 ex7_4에 전부 넣는다.
*/

CREATE TABLE ex7_5 (
emp_id    NUMBER,
emp_name  VARCHAR2(100));

INSERT ALL
    WHEN department_id = 30 THEN
    INTO ex7_3 VALUES (employee_id, emp_name)
    WHEN department_id = 90 THEN
    INTO ex7_4 VALUES (employee_id, emp_name)
    ELSE
    INTO ex7_5 VALUES (employee_id, emp_name)
    SELECT department_id, employee_id, emp_name FROM  employees;

select * from ex7_3; --부서가 30인 데이터 총 6개
select * from ex7_4; --부서가 90인 데이터 총 3개
select * from ex7_5; --부서가 30, 90외 데이터 총 98개

--INSERT FIRST
--마지막으로 알아 볼 내용은 INSERT ALL 대신 INSERT FIRST를 사용하는 형태
--ALL과 FIRST의 차이점은 입력되는 대상 로우를 기준으로 WHEN 조건에 맞으면 처리하는 방식에 있다. 
--만약 FIRST를 명시했다면 첫 번째로 조건 값이 TRUE가 될 때 해당 로우가 입력되고 끝난다. 
--만약 그 다음 WHEN 조건 결과가 TRUE가 되더라도 이미 이전 단계에서 입력이 됐으므로 그 로우는 추가로 입력되지 않는다. 

TRUNCATE TABLE ex7_3;
TRUNCATE TABLE ex7_4;

--1번 insert all
INSERT ALL
    WHEN employee_id < 116 THEN
    INTO ex7_3 VALUES (employee_id, emp_name)
    WHEN salary < 5000 THEN
    INTO ex7_4 VALUES (employee_id, emp_name)
    SELECT department_id, employee_id, emp_name,  salary FROM employees WHERE department_id = 30;

select * from ex7_3;
select * from ex7_4;

--2번 insert first : 
--115번의 데이터가 WHEN employee_id < 116 then절이 ture가 되어
---- 데이터가 ex7-3 데이터 삽입이 되고, 
--when salary < 5000 then 절에서는 115번 데이터가 만족이 되더라도 삽입되지 않는다.
INSERT FIRST
    WHEN employee_id < 116 THEN
    INTO ex7_3 VALUES (employee_id, emp_name)
    WHEN salary < 5000 THEN
    INTO ex7_4 VALUES (employee_id, emp_name)
    SELECT department_id, employee_id, emp_name, salary FROM employees WHERE department_id = 30;

select * from ex7_3;
select * from ex7_4;

SELECT department_id, employee_id, emp_name, salary FROM employees WHERE employee_id = 115;

commit;
















































































































