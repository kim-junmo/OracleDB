----10장 예외처리와 트랜잭션 알아 보기
--프로그램을 개발하다 보면 다양한 경우의 수를 산정해서 
--오류 확인 및 예외처리를 하는 것이 보통인데 PL/SQL 역시 마찬가지다.

--시스템 예외로는 나눗셈 연산을 할 때 0으로 나눈다거나 
--SELECT INTO 절을 사용해 데이터를 가져올 때 
--조건에 만족하는 데이터가 없으면 발생하는 예외 등이 있다. 
--즉 시스템 예외는 오라클 내부에 미리 정의된 예외라고 할 수 있다.

--예외처리 구문
--    EXCEPTION WHEN 예외명1 THEN 예외처리 구문1
--     WHEN 예외명2 THEN 예외처리 구문2
--     ...
--     WHEN OTHERS THEN 예외처리 구문n;

--자바로 설명하자면
--try {
--}
--catch(예외클래스 e) {
--예외처리 구문 1
--}
--catch(예외클래스 e) {
--예외처리 구문 2
--}

--PL/SQL 구문
--함수 또는 프로시저 이름으로 만들지 않고 아래와 같이 코드를 구성하면, 이를 익명 블록이라고 한다.
DECLARE
    vi_num NUMBER :=0;
BEGIN
    vi_num := 10 / 0; --제수가 0으로 사용되어, 예외 발생이 되어 강제적으로 종료가 됨, 아래 구문이 실행하지 못함.
    DBMS_OUTPUT.PUT_LINE('Success');
    
    --예외처리 작업
    EXCEPTION WHEN OTHERS THEN --OTHERS : 예외 오류를 모를 경우 일반적으로 사용하는 키워드
        DBMS_OUTPUT.PUT_LINE('오류가 발생했습니다.');
    
END;

--1)예외 처리가 없는 프로시저
CREATE OR REPLACE PROCEDURE ch10_no_exception_proc
IS
    vi_num NUMBER :=0;
BEGIN
    vi_num :=10 / 0; --예외 발생 구문
    DBMS_OUTPUT.PUT_LINE('Success');
END;

--2)예외 처리가 있는 프로시저
CREATE OR REPLACE PROCEDURE ch10_exception_proc
IS
    vi_num NUMBER :=0;
BEGIN
    vi_num :=10 / 0; --예외 발생 구문
    DBMS_OUTPUT.PUT_LINE('Success');
    
    --예외처리
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('오류가 발생했습니다');
END;

--예외처리가 없는 프로시저 실행
DECLARE
    vi_num NUMBER :=0; --사용하지 않아도 임의의 변수 선언할 것
BEGIN
    ch10_no_exception_proc; --예외처리가 존재하지 않는다.
    DBMS_OUTPUT.PUT_LINE('Success'); --이 구문이 앞에 예외처리가 없는 프로시저가 실행되어 예외발생이 되어 실행되지 않는다.
END;

--예외처리가 있는 프로시저 실행
DECLARE
    vi_num NUMBER :=0; --사용하지 않아도 임의의 변수 선언할 것
BEGIN
    ch10_exception_proc; --예외처리가 존재
    DBMS_OUTPUT.PUT_LINE('Success'); --이 구문은 예외처리가 되어 있기 때문에 실행됨.
END;


--2)예외 처리가 있는 프로시저 수정
CREATE OR REPLACE PROCEDURE ch10_exception_proc
IS
    vi_num NUMBER :=0;
BEGIN
    vi_num :=10 / 0; --예외 발생 구문
    DBMS_OUTPUT.PUT_LINE('Success');
    
    --예외처리
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('오류가 발생했습니다');
    DBMS_OUTPUT.PUT_LINE('SQL ERROR CODE' || SQLCODE);--에러코드
    DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE' || SQLERRM);--에러메세지
    DBMS_OUTPUT.PUT_LINE(SQLERRM(SQLCODE)); --에러코드와 에러메세지
END;


--프로시저 실행
DECLARE
    vi_num NUMBER :=0; --사용하지 않아도 임의의 변수 선언할 것
BEGIN
    ch10_exception_proc; --예외처리가 존재
    DBMS_OUTPUT.PUT_LINE('Success'); --이 구문은 예외처리가 되어 있기 때문에 실행됨.
END;

--예외처리를 OTHERS사용하지 않고 ZERO_DIVIDE 예외처리명을 사용할 경우
CREATE OR REPLACE PROCEDURE ch10_exception_proc
IS
      vi_num NUMBER := 0;
BEGIN
      vi_num := 10 / 0;
      DBMS_OUTPUT.PUT_LINE('Success!');

EXCEPTION WHEN ZERO_DIVIDE THEN
      DBMS_OUTPUT.PUT_LINE('오류가 발생했습니다');
      DBMS_OUTPUT.PUT_LINE('SQL ERROR CODE: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE: ' || SQLERRM);
END;

--예외처리명을 2개 이상으로 사용하는 프로시저로 변경
CREATE OR REPLACE PROCEDURE ch10_exception_proc
IS
      vi_num NUMBER := 0;
BEGIN
      vi_num := 10 / 0;
      DBMS_OUTPUT.PUT_LINE('Success!');

EXCEPTION 
WHEN ZERO_DIVIDE THEN
      DBMS_OUTPUT.PUT_LINE('오류1');
      DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE1: ' || SQLERRM);
WHEN OTHERS THEN --OTHERS 예외처리명을 마지막 순서로 사용해야 한다.
      DBMS_OUTPUT.PUT_LINE('오류2');
      DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE2: ' || SQLERRM);
END;

--SELECT INTO 예외 발생
CREATE OR REPLACE PROCEDURE ch10_UPD_jObid_proc
(
    p_empolyee_id   employees.employee_id%TYPE
    p_job_id        job_id%TYPE
)
IS
    vn_cat          number :=0;
BEGIN
    SELECT COUNT(*)
    INTO vn_cat
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF vn_cat = 0 THEN
        DBMS_OUTPUT.PUT_LINE('job_id가 없습니다.');
        RETURN;
    ELSE
    UPDATE employees
    SET job_id = p_job_id;
    WHERE employee_id = P_Employee_Id;
    END IF;
    
    COMMIT;
END;

--위의 프로시저를 예외처리 로직이 사용된 코드로 변경하자.
CREATE OR REPLACE PROCEDURE ch10_UPD_jObid_proc
(
    p_empolyee_id   employees.employee_id%TYPE
    p_job_id        job_id%TYPE
)
IS
    vn_cat          number :=0;
BEGIN
--조건식이 일치하지 않으면 오라클에서는 SELECT INTO 구문이 예외가 발생하도록 설계되어 있다.
    SELECT 1
    INTO vn_cat
    FROM jobs
    WHERE job_id = p_job_id;  --조건식이 FALSE이면 예외 발생.

    UPDATE employees
    SET job_id = p_job_id;
    WHERE employee_id = P_Employee_Id;

    COMMIT;
    
    EXCEPTION 
        WHEN NO_DATE_FOUND THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            DBMS_OUTPUT.PUT_LINE(P_JOB_ID || '에 해당하는 JOB ID가 없습니다.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('기타에러:'|| SQLEERM');
END;

--프로시저를 생성시 SELECT문 결과형태를 사용하면 안된다.(중요)
--EX)
CREATE OR REPLACE PROCEDURE udp_select
IS
BEGIN
    SELECT * FROM employees; --SELECT INTO문법을 이용한 변수에 할당하는 것은 가능하다.
END;
--위의 구문은 PLS-00428: an INTO clause is expected in this SELECT statement 다음 에러 발생
--오라클에서는 안되고 ms-sql에서는 사용가능하다.





















































































































































































