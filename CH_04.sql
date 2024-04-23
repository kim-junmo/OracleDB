/*
SQL 함수
01 숫자 함수

02 문자 함수

03 날짜 함수

04 변환 함수

05 NULL 관련 함수

06 기타 함수
*/


--숫자 함수란 수식 연산을 하는 함수로 연산 대상 즉, 매개변수나 반환 값이 대부분 숫자 형태다.

--① ABS(n)
--ABS 함수는 매개변수로 숫자를 받아 그 절대값을 반환하는 함수다.
SELECT ABS(10),ABS(-10),ABS(-10.123) FROM DUAL; 

--② CEIL(n)과 FLOOR(n)
--CEIL 함수는 매개변수 n과 같거나 가장 큰 정수를 반환한다.
SELECT CEIL(10.123),CEIL(10.541),CEIL(11.001) FROM DUAL; --올림함수(11,11,12)

--FLOOR 함수는 CEIL 함수와는 반대로 매개변수 n보다 작거나 가장 큰 정수를 반환한다.
SELECT FLOOR(10.123),FLOOR(10.541),FLOOR(11.001)FROM DUAL; --내림함수(10, 10, 11)

--③ ROUND(n, i)와 TRUNC(n1, n2)
--ROUND 함수는 매개변수 n을 소수점 기준 (i+1)번 째에서 반올림한 결과를 반환한다. 
--i는 생략할 수 있고 디폴트 값은 0, 즉 소수점 첫 번째 자리에서 반올림이 일어나 정수 부분의 일의 자리에 결과가 반영된다.

--매개변수 1개를 사용한 예
SELECT ROUND(10.154),ROUND(10.541),ROUND(11.001) FROM DUAL; --반올림함수(10, 11, 11)

--매개변수 2개를 사용한 예, 2번째 매개변수가 양수, 음수 여부에 따라 기능이 다르다.
/*
2번째 매개변수가 양수이면, 소수부분을 가리킨다.
N+1의 위치를 반올림 여부를 계산한다.
*/
SELECT ROUND(10.154, 1),ROUND(10.154, 2),ROUND(10.154, 3) FROM DUAL; --10.2, 10.15, 10.54
--10.154에서 1번째 자리는 2번째 자리에서 반올림하여 계산이 된다. 그래서 값이 10.2

/*
2번째 매개변수가 음수이면, 정수부분을 가리킨다.
N의 위치를 반올림 여부를 계산한다.
*/
SELECT ROUND(0, 3), ROUND(115.155, -1), ROUND(115.155, -2) FROM DUAL; --0, 120, 100

--TRUNC 함수
--TRUNC 함수는 반올림을 하지 않고 n1을 소수점 기준 n2자리에서 무조건 잘라낸 결과를 반환한다. 
--n2 역시 생략할 수 있으며 디폴트 값은 0이고, 양수일 때는 소수점 기준으로 오른쪽, 음수일 때는 소수점 기준 왼쪽 자리에서 잘라낸다.
SELECT TRUNC(115.155), TRUNC(115.155, 1), TRUNC(115.155, 2), TRUNC(115.155, -2) FROM DUAL; --115, 115.1, 115.15, 100

--④ POWER(n2, n1)와 SQRT(n)
--POWER 함수는 n2를 n1 제곱한 결과를 반환한다. 
--n1은 정수와 실수 모두 올 수 있는데, n2가 음수일 때 n1은 정수만 올 수 있다.
SELECT POWER(3, 2), POWER(3, 3), POWER(3, 3.0001) FROM DUAL; --제곱함수 (9, 27, 27.00296...)

--SQRT 함수는 n의 제곱근을 반환한다.
SELECT SQRT(2), SQRT(5) FROM DUAL; --루트(1.4..., 2.236...)

--⑤ MOD(n2, n1)와 REMAINDER(n2, n1)
--MOD 함수는 n2를 n1으로 나눈 나머지 값을 반환한다.
SELECT MOD(19,4), MOD(19.123, 4.2) FROM DUAL; --나누었을 때 나머지의 값을 구하는 함수 (3, 2.323)

--REMAINDER 함수 역시 n2를 n1으로 나눈 나머지 값을 반환하는데, 나머지를 구하는 내부적 연산 방법이 MOD 함수와는 약간 다르다.
-MOD → n2 - n1 * FLOOR (n2/n1)
--REMAINDER → n2 - n1 * ROUND (n2/n1)
SELECT REMAINDER(19,4), REMAINDER(19.123, 4.2) FROM DUAL; --19-4(반올림 19/4) = 5

/*
문자 함수
문자 함수는 연산 대상이 문자이며 반환 값은 함수에 따라 문자나 숫자를 반환한다.
*/
--INITCAP(char), LOWER(char), UPPER(char)
--INITCAP 함수는 매개변수로 들어오는 char의 첫 문자는 대문자로, 나머지는 소문자로 반환하는 함수다. 
--이때 첫 문자를 인식하는 기준은 공백과 알파벳(숫자 포함)을 제외한 문자다. 
--즉 공백이나 알파벳이 아닌 문자를 만난 후 다음 첫 알파벳 문자를 대문자로 변환한다.
SELECT INITCAP('never say goodbye'), INITCAP('never6say*good가bye') FROM DUAL; --Never Say Goodbye, Never6say*Good가Bye

SELECT emp_name, INITCAP(emp_name) FROM employees; --Allan McEwen -> Allan Mcewen

--소문자, 대문자 변환
SELECT LOWER('NEVER SAY GOODBYE'), UPPER('never say goodbye') FROM DUAL;

SELECT EMP_NAME, LOWER(EMP_NAME), UPPER(EMP_NAME) FROM EMPLOYEES;

/*
CONCAT(char1, char2), SUBSTR(char, pos, len), SUBSTRB(char, pos, len)
CONCAT 함수는 ‘||’ 연산자처럼 매개변수로 들어오는 두 문자를 붙여 반환한다
*/
SELECT CONCAT('I Have', ' A Dream'), 'I Have' || ' A Dream' FROM DUAL;

SELECT CONCAT(emp_name, salary),emp_name || ' ' || salary FROM employees;

/*
SUBSTR는 문자 함수 중 가장 많이 사용되는 함수로, 
잘라올 대사 문자열인 char의 pos번째 문자부터 
len길이만큼 잘라낸 결과를 반환하는 함수다. 
pos 값으로 0이 오면 디폴트 값인 1, 즉 첫 번째 문자를 가리키며, 
음수가 오면 char 문자열 맨 끝에서 시작한 상대적 위치를 의미한다. 
또한 len 값이 생략되면 pos번째 문자부터 나머지 모든 문자를 반환한다.
*/
SELECT SUBSTR('ABCDEFG', 1, 4), SUBSTR('ABCDEFG', -1, 4) FROM DUAL;
--1은 위치, 4는 개수 / -1는 우측에서부터 첫번째

SELECT SUBSTR(EMP_NAME, 1, 3) FROM EMPLOYEES;
SELECT emp_name, SUBSTR(emp_name, 1, 3) || '****' FROM EMPLOYEES;

--바이트 단위.
SELECT SUBSTRB('ABCDEFG', 1, 4), SUBSTRB('가나다라마바사', 1, 4) FROM DUAL; --한글이 3바이트로 설정이 되어 있어 가까지만 나옴

--한글 바이트 확인 방법
SELECT LENGTHB('가') FROM DUAL;

SELECT LENGTHB('뷁') FROM DUAL;

/*
③ LTRIM(char, set), RTRIM(char, set)
LTRIM 함수는 매개변수로 들어온 char 문자열에서 set으로 지정된 문자열을 왼쪽 끝에서 제거한 후 나머지 문자열을 반환한다. 
두 번째 매개변수인 set은 생략할 수 있으며, 디폴트로 공백 문자 한 글자가 사용된다. 
RTRIM 함수는 LTRIM 함수와 반대로 오른쪽 끝에서 제거한 뒤 나머지 문자열을 반환한다.
*/
--매개변수 1개 사용한 경우
SELECT LENGTH('  ABCDEF'), LENGTH(LTRIM('  ABCDEF')), LENGTH(LTRIM('ABCDEF ')) FROM DUAL; 

--매개변수 2개 사용한 경우, 2번쨰 매개변수 값에 오는 내용을 좌 또는 우측에서 단 한번만 제거한다.
SELECT LTRIM('ABCDEFGABC', 'ABC'),
           LTRIM('가나다라', '가'),
           RTRIM('ABCDEFGABC', 'ABC'),
           RTRIM('가나다라', '라')
FROM DUAL;
--보통 LTRIM과 RTRIM은 주어진 문자열에서 좌측 혹은 우측의 공백을 제거할 때 많이 사용한다

/*
④ LPAD(expr1, n, expr2), RPAD(expr1, n, expr2)
LPAD 함수는 매개변수로 들어온 expr2 문자열(생략할 때 디폴트는 공백 한 문자)을 n자리만큼 왼쪽부터 채워 expr1을 반환하는 함수다. 
매개변수 n은 expr2와 expr1이 합쳐져 반환되는 총 자릿수를 의미한다. 
예를 들어, 서울의 지역 전화번호는 ‘02’인데 전화번호 컬럼에 지역번호가 없으면 LPAD 함수로 번호 02를 자동으로 채워 넣을 수 있다.
*/
CREATE TABLE ex4_1 (phone_num VARCHAR2(30));

    INSERT INTO ex4_1 VALUES ('111-1111');
    INSERT INTO ex4_1 VALUES ('111-2222');
    INSERT INTO ex4_1 VALUES ('111-3333');
    
    SELECT * FROM ex4_1;

COMMIT; --데이터 작업내용을 실제 데이터베이스 파일에 물리적으로 반영한다.

SELECT phone_num, LPAD(phone_num, 12, '(02)'), RPAD(phone_num, 12, '(02)') FROM ex4_1;

/*
 REPLACE(char, search_str, replace_str), TRANSLATE(expr, FROM_str, to_str)
REPLACE 함수는 char 문자열에서 search_str 문자열을 찾아 이를 replace_str 문자열로 대체한 결과를 반환하는 함수다.
*/
SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?', '나', '너') FROM DUAL;

SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?', '나는', '너는') FROM DUAL;

--문자열이 있는 모든 공백을 제거하라.
SELECT LTRIM(' ABC DEF '),
           RTRIM(' ABC DEF '),
           REPLACE(' ABC DEF ', ' ', '')
      FROM DUAL;

--REPLACE와 TRANSLATE차이점
SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?', '나는', '너를') AS rep, --나는 이라는 단어를 찾아서 너를로 변경
           TRANSLATE('나는 너를 모르는데 너는 나를 알겠는가?', '나는', '너를') AS trn --나는 너로 바꾸고 / 는을 찾아 를로 각각찾아 변경된다.
      FROM DUAL;
      
/*
⑥ INSTR(str, substr, pos, occur), LENGTH(chr), LENGTHB(chr)
INSTR 함수는 str 문자열에서 substr과 일치하는 위치를 반환하는데, 
pos는 시작 위치로 디폴트 값은 1, occur은 몇 번째 일치하는지를 명시하며 디폴트 값은 1이다.
*/

--'만약', 5, 2 만약이라는 단어를 문장 5번째에서 2번째 만약 단어의 위치를 찾아라.
SELECT INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약') AS INSTR1,
       INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약', 5) AS INSTR2, --5번쨰 위치에서 만약이라는 단어를 찾아라.
       INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약', 5, 2) AS INSTR3
       FROM DUAL;

--LENGTH 함수는 매개변수로 들어온 문자열의 개수를 반환하며, LENGTHB 함수는 해당 문자열의 바이트 수를 반환한다.

SELECT LENGTH('대한민국'), --길이
       LENGTHB('대한민국') --바이트 수
       FROM DUAL;

/*
03 | 날짜 함수
날짜 함수는 DATE 함수나 TIMESTAMP 함수와 같은 날짜형을 대상으로 연산을 수행해 결과를 반환하는 함수다. 
날짜 함수 역시 대부분 반환 결과는 날짜형이나 함수에 따라 숫자를 반환할 때도 있다.
*/


--SYSDATE - 년,월,일,초, SYSTIMESTAMP - 년,월,일,초,밀리초

SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

--② ADD_MONTHS (date, integer)
--ADD_MONTHS 함수는 매개변수로 들어온 날짜에 interger 만큼의 월을 더한 날짜를 반환한다.

--날짜에 더한 의미, 음수를 사용하면 뺀 의미도 구할 수 있다.
SELECT ADD_MONTHS(SYSDATE, 1), ADD_MONTHS(SYSDATE, -1) FROM DUAL;

--③ MONTHS_BETWEEN(date1, date2)
--MONTHS_BETWEEN 함수는 두 날짜 사이의 개월 수를 반환하는데, date2가 date1보다 빠른 날짜가 온다.

SELECT MONTHS_BETWEEN(SYSDATE, ADD_MONTHS(SYSDATE, 1)) mon1,
       MONTHS_BETWEEN(ADD_MONTHS(SYSDATE, 1), SYSDATE) mon2
       FROM DUAL;

SELECT EMPLOYEE_ID, emp_name, MONTHS_BETWEEN(SYSDATE, HIRE_DATE) 
AS mon1, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))/12 AS "근속년수" 
FROM EMPLOYEES;

--④ LAST_DAY(date) LAST_DAY는 date 날짜를 기준으로 해당 월의 마지막 일자를 반환한다.

SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY('2024-02-01'), LAST_DAY(SYSDATE) FROM DUAL;

--⑤ ROUND(date, format), TRUNC(date, format)
--ROUND와 TRUNC는 숫자 함수이면서 날짜 함수로도 쓰이는데, ROUND는 format에 따라 반올림한 날짜를, TRUNC는 잘라낸 날짜를 반환한다.

SELECT SYSDATE, ROUND(SYSDATE, 'month'), TRUNC(SYSDATE, 'month') FROM DUAL;

--ROUND함수는 15일까지는 반올림이 안된다. / TRUNC함수는 월 기준에서 일을 제거한다.
SELECT '2024-04-15', ROUND(TO_DATE('2024-04-15'), 'month'), TRUNC(TO_DATE('2024-04-15'), 'month') FROM DUAL;

--ROUND함수는 16일 이상일 경우에는 반올림이 되어, 한달이 더해진다./TRUNC함수는 월 기준에서 일을 제거한다.
SELECT '2024-04-16', ROUND(TO_DATE('2024-04-16'), 'month'), TRUNC(TO_DATE('2024-04-16'), 'month') FROM DUAL;

--⑥ NEXT_DAY (date, char)
--NEXT_DAY는 date를 char에 명시한 날짜로 다음 주 주중 일자를 반환한다.
--현재 날짜에서 돌아오는 금요일은?
SELECT NEXT_DAY(SYSDATE, '금요일') FROM DUAL;

--char로 올 수 있는 값은 ‘일요일’에서 ‘토요일’까지인데, 
--이 값은 NLS_LANG이란 오라클 환경 변수에 따라 한글이 올 수도, 
--‘SUNDAY’, ‘MONDAY’ 처럼 영문이 올 수도 있다.

--04 | 변환 함수
--변환 함수란 서로 다른 유형의 데이터 타입으로 변환해 결과를 반환하는 함수를 말한다. 
--3장에서 언급했듯이 오라클이 자동으로 형변환을 해주는 것을 묵시적 형변환이라 하는데 
--이 절에서 학습하는 변환 함수를 통해 형변환을 직접 처리하는 것을 명시적 형변환이라고 한다.

--① TO_CHAR (숫자 혹은 날짜, format)
--숫자나 날짜를 문자로 변환해 주는 함수가 바로 TO_CHAR로, 
--매개변수로는 숫자나 날짜가 올 수 있고 반환 결과를 특정 형식에 맞게 출력할 수 있다.

--숫자 123456789를 3자리마다 콤마를 사용하여 문자데이터로 변환.
SELECT TO_CHAR(123456789, '999,999,999') FROM DUAL;

--날짜 데이터를 년-월-일 형태의 문자데이터로 변환
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;

--TO_NUMBER(expr, format)
--문자나 다른 유형의 숫자를 NUMBER 형으로 변환하는 함수다.
--문자데이터를 숫자형으로 변환
SELECT TO_NUMBER('123456') FROM DUAL;

--③ TO_DATE(char, format), TO_TIMESTAMP(char, format)
--문자를 날짜형으로 변환하는 함수다. 
--형식 매개변수로는 [표 4-1]에 있는 항목이 올 수 있으며, 
--TO_DATE는 DATE 형으로 TO_TIMESTAMP는 TIMESTAMP 형으로 변환해 값을 반환한다.

--문자열데이터를 날짜형으로 변환
SELECT TO_DATE('20140101', 'YYYY-MM-DD') FROM DUAL;

SELECT TO_DATE('20140101 13:44:50', 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

--NULL 관련 함수 (문자함수와 NULL함수가 가장 많이 사용되고 날짜함수, 변환함수, 숫자함수로 사용빈도가 나누어짐)
--3장에서 알아봤듯이 NULL을 비교할 때는 IS NULL이나 IS NOT NULL 구문을 사용하였는데, 
--오라클에서는 NULL을 연산 대상으로 처리하는 SQL 함수를 제공하고 있다.

--NVL(expr1, expr2), NVL2((expr1, expr2, expr3)
--NVL 함수는 expr1이 NULL일 때 expr2를 반환한다.

--manager_id 컬럼의 데이터가 NULL이면, employee_id 컬럼의 값으로 반환되고, 
--manager_id 컬럼의 데이터가 존재하면(NOT NULL), manager_id 컬럼의 값이 반환된다.
SELECT NVL(manager_id, employee_id) FROM employees WHERE manager_id IS NULL;

SELECT NVL(NULL, 10), NVL(10, 20) FROM DUAL;

--NVL2는 NVL을 확장한 함수로 expr1이 NULL이 아니면 expr2를, NULL이면 expr3를 반환하는 함수다.

--앞의 쿼리는 커미션(commission_pct)이 NULL인 사원은 그냥 급여를, NULL이 아니면 ‘급여 + (급여 * 커미션)’을 조회하고 있다.
SELECT employee_id, salary, commission_pct, 
       NVL2(commission_pct, salary + (salary * commission_pct), salary) AS salary2
       FROM employees;

--NVL2의 값이 NULL이면 20이 출력, NULL이 아니면 20이 출력
SELECT NVL2(NULL, 10, 20), NVL2(10, 20, 30) FROM DUAL;

--NULL과 연산시 결과는 NULL이 된다. (중요)
SELECT NULL + 100 FROM DUAL; 

--② COALESCE (expr1, expr2, …)
--COALESCE 함수는 매개변수로 들어오는 표현식에서 NULL이 아닌 첫 번째 표현식을 반환하는 함수다.

--COALESCE (salary * commission_pct, salary) 이 값이 NULL이면 salary컬럼의 값이 반환되고
--COALESCE (salary * commission_pct, salary) 이 값이 NOT NULL이면 자신의 결과값이 반환된다.
SELECT employee_id, salary, commission_pct,
       COALESCE (salary * commission_pct, salary) AS salary2
       FROM employees;

SELECT COALESCE (NULL, NULL, NULL), COALESCE(NULL, NULL, 1), COALESCE(NULL, 1, 2), COALESCE(1, 2, 3) FROM DUAL;


--③ LNNVL(조건식)
--LNNVL은 매개변수로 들어오는 조건식의 결과가 FALSE이면 TURE로, 조건식의 결과가 TRUE이면 FALSE로 반환. 

SELECT emp_name, commission_pct FROM employees 
WHERE LNNVL(commission_pct = 0);

--위 구문을 다음처럼 변경할 수 있다.
SELECT emp_name, commission_pct FROM employees 
WHERE commission_pct IS NULL OR commission_pct != 0; --49건

SELECT SALARY FROM EMPLOYEES
WHERE LNNVL(SALARY > 5000); --49건

SELECT SALARY FROM EMPLOYEES
WHERE SALARY <= 5000; --49건

--④ NULLIF (expr1, expr2)
--NULLIF 함수는 expr1과 expr2을 비교해 같으면 NULL을, 같지 않으면 expr1을 반환한다.

SELECT NULLIF(100, 100), NULLIF(100, 200) FROM DUAL; 

--job_history 테이블에서 start_date와 end_date의 연도만 추출해 두 연도가 같으면 NULL을, 같지 않으면 종료년도를 출력하는 쿼리다.
SELECT employee_id,
       TO_CHAR(start_date, 'YYYY') start_year,
       TO_CHAR(end_date, 'YYYY') end_year,
       NULLIF(TO_CHAR(end_date, 'YYYY'), TO_CHAR(start_date, 'YYYY') ) nullif_year
       FROM job_history;

--06 | 기타 함수
--① GREATEST(expr1, expr2, …), LEAST(expr1, expr2, …)
--GREATEST는 매개변수로 들어오는 표현식에서 가장 큰 값을, LEAST는 가장 작은 값을 반환하는 함수다.

SELECT GREATEST(1, 2, 3, 2) AS "가장 큰 값",
       LEAST(1, 2, 3, 2) AS "가장 작은 값"
       FROM DUAL;

--숫자 뿐만 아니라 문자도 비교할 수 있다.
SELECT GREATEST('이순신', '강감찬', '세종대왕'),
       LEAST('이순신', '강감찬', '세종대왕')
       FROM DUAL;

--DECODE (expr, search1, result1, search2, result2, …, default)
--DECODE는 expr과 search1을 비교해 두 값이 같으면 result1을, 같지 않으면 다시 search2와 비교해 값이 같으면 result2를 반환하고, 
--이런 식으로 계속 비교한 뒤 최종적으로 같은 값이 없으면 default 값을 반환한다.

SELECT prod_id,
       DECODE(channel_id, 3, 'Direct',
                          9, 'Direct',
                          5, 'Indirect',
                          4, 'Indirect',
                              'Others')  decodes
       FROM sales
       WHERE rownum < 10;

--핵심정리
--1 자주 사용하는 기능을 구현해 값을 반환하는 것을 함수라 하는데, 오라클에서도 SQL 함수를 제공하고 있다.
--2 함수는 연산 대상과 그 특성에 따라 크게 숫자 함수, 문자 함수, 날짜 함수, NULL 관련함수, 변환 함수로 나눌 수 있다.
--3 오라클에서는 두 값이나 표현식의 데이터 타입이 다르면 연산을 수행할 때 일정 규칙에 따라 자동으로 형변환을 처리해주는데 이를 묵시적 형변환이라고 한다. 
--  반면 사용자가 직접 형변환을 하는 것을 명시적 형변환이라고 하는데, 변환 함수로 명시적 형변환을 처리할 수 있다.
--4 SQL 함수는 특정 연산을 수행 후 결과를 반환하므로, SELECT 리스트, WHERE 절, INSERT문의 VALUES 절, UPDATE 문의 SET 절 등에서 사용 가능하다.
