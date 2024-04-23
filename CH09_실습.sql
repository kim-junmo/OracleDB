--9�� PL/SQL ����� �Լ�, ���ν��� �˾� ����
/*
 <������ 1���� ���>
IF ���� THEN
   ���� ó��;
END IF;
     
    <������ 2���� ���>
IF ���� THEN
   ���� ó�� 1;
ELSE
   ���� ó��2;
END IF;
     
    <������ n���� ���>
IF ����1 THEN
   ���� ó��1;
ELSIF ����2 THEN
   ���� ó��2;
    ...
ELSE
   ���� ó��n;
END IF;
*/

DECLARE
    vn_num1 NUMBER := 1;
    vn_num2 NUMBER := 2;
BEGIN
    IF vn_num1 > vn_num2 THEN
        DBMS_OUTPUT.PUT_LINE(vn_num1 || ' �� ū�� ');
    ELSE
        DBMS_OUTPUT.PUT_LINE(vn_num2 || ' �� ū�� ');
    END IF;
END;

SET SERVEROUTPUT ON;

DECLARE
      vn_salary NUMBER := 0;
      vn_department_id NUMBER := 0;
      
BEGIN
--�μ��ڵ带 �������� ��ȯ
      vn_department_id := ROUND(DBMS_RANDOM.VALUE (10, 120), -1);

      SELECT salary
      INTO vn_salary
      FROM employees
      WHERE department_id = vn_department_id
      AND ROWNUM = 1; --������ �μ��� ����� �������� ��� �տ� ������ 1���� ����.

      DBMS_OUTPUT.PUT_LINE(vn_salary);

      IF vn_salary BETWEEN 1 AND 3000 THEN
         DBMS_OUTPUT.PUT_LINE('����');
      ELSIF vn_salary BETWEEN 3001 AND 6000 THEN
         DBMS_OUTPUT.PUT_LINE('�߰�');
      ELSIF vn_salary BETWEEN 6001 AND 10000 THEN
         DBMS_OUTPUT.PUT_LINE('����');
      ELSE
         DBMS_OUTPUT.PUT_LINE('�ֻ���');
      END IF;
END;

--10~120������ �Ǽ����� �������� ��ȯ
select dbms_Random.value(10, 120) from dual;



select round(dbms_Random.value(10, 120), -1) from dual;


--CASE��
--CASE���� 3�忡�� ����� CASE ǥ���İ� ����ϴ�. 
--SELECT ������ CASE ǥ������ ����ߵ��� PL/SQL ���α׷� �������� CASE���� ����� �� �ִµ�, �� ������ ������ ����.

--<���� 1>
--CASE ǥ����
--    WHEN ���1 THEN
--         ó����1;
--    WHEN ���2 THEN
--        ó����2;
--        ...
--        ELSE
--             ��Ÿ ó����;
--    END CASE;
   
--<���� 2>
--    CASE WHEN ǥ����1 THEN
--             ó����1;
--        WHEN ǥ����2 THEN
--             ó����2;
--        ...
--        ELSE
--             ��Ÿ ó����;
--    END CASE;

SET SERVEROUTPUT ON;

DECLARE
    vn_salary    NUMBER := 0;
    vn_department_id    NUMBER :=0;
BEGIN
    vn_department_id := round(dbms_random.VALUE(10,120), -1);

    SELECT salary
    INTO vn_salary
    FROM employees
    WHERE DEPARTMENT_ID = vn_department_id
    AND ROWNUM = 1;
    
    DBMS_OUTPUT.PUT_LINE(VN_SALARY);
    CASE WHEN VN_SALARY BETWEEN 1 AND 3000 THEN
        DBMS_OUTPUT.PUT_LINE('����');
        WHEN VN_SALARY BETWEEN 3001 AND 6000 THEN
        DBMS_OUTPUT.PUT_LINE('�߰�');
        WHEN VN_SALARY BETWEEN 6001 AND 10000 THEN
        DBMS_OUTPUT.PUT_LINE('����');
    ELSE
        DBMS_OUTPUT.PUT_LINE('�ֻ���');
    END CASE;
END;
COMMIT;

--LOOP��
--LOOP���� ������ ���� �ݺ��ؼ� ������ ó���ϴ� �ݺ����̴�. 
--�̷��� �ݺ������� LOOP�� �ܿ��� WHILE��, FOR���� �ִµ�, 
--���� ���� �⺻���� ������ �ݺ����� LOOP���� ���� ���� ����.

--LOOP
--    ó����;
--    EXIT [WHEN ����];
--    END LOOP;

--������ 3�� ���
DECLARE
        VN_BASE_NUM NUMBER :=3;
        VN_CNT      NUMBER :=1;
BEGIN
      LOOP
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || vn_cnt || '= ' || vn_base_num * vn_cnt);
          vn_cnt := vn_cnt + 1;      -- ������ ���鼭 vn_cnt ���� 1�� ������

          EXIT WHEN vn_cnt > 9;      -- vn_cnt�� 9���� ũ�� ���� ����
      END LOOP;
END;


--WHILE��
--�Ϲ����� ���α׷��� ���� ��ǥ���� �ݺ����� ������� WHILE���� FOR���� �� �� �ִ�. 
--����Ŭ������ ���� �� �� ������ �����ϴµ�, ���� WHILE���� ���� ���� ����.

--WHILE ����
--LOOP
--      ó����;
--END LOOP;

--���� 1
--������ 3�� ���
DECLARE
      vn_base_num NUMBER := 3;
      vn_cnt      NUMBER := 1;
BEGIN
    WHILE  vn_cnt <= 9            -- vn_cnt�� 9���� �۰ų� ���� ���� �ݺ� ó��
    LOOP
      DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || vn_cnt || '= ' || vn_base_num * vn_cnt);
      vn_cnt := vn_cnt + 1;      -- vn_cnt ���� 1�� ����
    END LOOP;
END;

-- ���� 2
DECLARE
      vn_base_num NUMBER := 3;
      vn_cnt      NUMBER := 1;
BEGIN

      WHILE  vn_cnt <= 9           -- vn_cnt�� 9���� �۰ų� ���� ���� �ݺ� ó��
      LOOP
         DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || vn_cnt || '= ' || vn_base_num * vn_cnt);
         EXIT WHEN vn_cnt = 5;     -- vn_cnt ���� 5�� �Ǹ� ���� ����
         vn_cnt := vn_cnt + 1;     -- vn_cnt ���� 1�� ����
      END LOOP;
END;

--FOR��
--FOR���� �ٸ� ���α׷��� ���� ����ϴ� �Ͱ� ����� �����̴�. 
--����Ŭ���� �����ϴ� FOR���� �⺻ ������ ������ ����.

--FOR �ε��� IN [REVERSE]�ʱ갪..������
--LOOP
--    ó����;
--END LOOP;

DECLARE
      vn_base_num NUMBER := 3;
BEGIN
       FOR i IN 1..9
       LOOP
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
       END LOOP;
END;

--FOR �������� ����ϴ� �ε����� ����ο��� �������� �ʰ� 
--��������� ��������. �̹����� REVERSE�� ����� ������ �ٲ� ����.
DECLARE
       vn_base_num NUMBER := 3;
BEGIN
       FOR i IN REVERSE 1..9 --I���� 9~1�� ����ȴ�.
       LOOP
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
       END LOOP;
END;

--CONTINUE��
--CONTINUE���� FOR�� WHILE ���� �ݺ����� �ƴ�����, 
--�ݺ��� ������ Ư�� ���ǿ� ������ �� ó�� ������ �ǳʶٰ� 
--����� ���� �������� �ǳʰ� ������ ��� ������ �� ����Ѵ�. 
--EXIT�� ������ ������ ���� �����µ� ����, CONTINUE�� ���� ������ �������� �Ѿ��. 

DECLARE
       vn_base_num NUMBER := 3;
BEGIN

       FOR i IN 1..9
       LOOP
          CONTINUE WHEN i=5; --EXIT WHEN I=5;�� �ݴ�(5���� �ݺ�)
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
       END LOOP;
END;

--GOTO��
--PL/SQL �ڵ� �󿡼� GOTO���� ������ GOTO���� �����ϴ� �󺧷� ��� �Ѿ��. 
--������ ��� ���α׷����� ���� ��� ����.
--�ſ� ������ �����̱� ������ �������� ����
--��(LACEL) : Ư�� ������ �̸��� �ο� <<���̸�>>

DECLARE
       vn_base_num NUMBER := 3;
BEGIN
       <<third>> --��
       FOR i IN 1..9
       LOOP
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
          IF i = 3 THEN
             GOTO fourth;
          END IF;
       END LOOP;

       <<fourth>>
       vn_base_num := 4;
       FOR i IN 1..9
       LOOP
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
       END LOOP;
END;

--NULL��
--PL/SQL������ NULL���� ����� �� �ִ�. 
--NULL���� �ƹ��͵� ó������ �ʴ� �����̴�. 
--�ƹ� �͵� ó������ �ʴµ� ���� ����� �ʿ䰡 ������? 
--PL/SQL �ڵ带 �ۼ��ϴ� ���� ������ �ʿ��� ���� �ִ�. 
--NULL���� ���� IF���̳� CASE���� �ۼ��� �� �ַ� ����ϴµ�, 
--���ǿ� ���� ó�� ������ �ۼ��ϰ� �տ��� �ۼ��� ��� ���ǿ� ���յ��� ���� ��, 
--�� ELSE���� ������ �� �ƹ��͵� ó������ �ʰ� ���� ��� NULL���� ����Ѵ�.
IF vn_variable = 'A' THEN
       ó������1;
ELSIF vn_variable = 'B' THEN
       ó������2;
       
ELSE NULL;

END IF;

CASE WHEN vn_variable = 'A' THEN
        ó������1;
WHEN vn_variable = 'B' THEN
        ó������2;
         
    ELSE NULL;
END CASE;

--02 | PL/SQL�� ����� ���� �Լ�
--�ٸ� �Լ��� ���ν����� ������ �׽�Ʈ�� �� ����ϴ� ���� ��κ�

--PL/SQL�� �̿��� ����� �����Լ�, ���ν��� ���� 4�忡�� ��� �Լ���.

--�Լ���
--SQL �Լ��� ����Ŭ���� �����ϴ� ���� �Լ��̰�(�׷��� ��Ʈ�� �Լ���� ��), //4�忡�� ��� �Լ���.
--���⿡�� ���ϴ� �Լ��� ����ڰ� ���� ������ �����ϴ� ����� ���� �Լ��� ���Ѵ�.
/*
CREATE OR REPLACE FUNCTION �Լ� �̸� (�Ű�����1, �Ű�����2, ...)
    RETURN ������Ÿ��;
    IS[AS] --DELCARE Ű���� ����
      ����, ��� �� ����
    BEGIN
      �����
    ��
      RETURN ��ȯ��;
    [EXCEPTION
      ���� ó����]
    END [�Լ� �̸�];
*/

--�������� ���ϴ� �Լ�
--CREATE(����) OR REPLACE(����)
CREATE OR REPLACE FUNCTION my_mod(num1 NUMBER, num2 NUMBER)
    RETURN NUMBER  -- ��ȯ ������ Ÿ�� NUMBER

IS
    vn_remainder    NUMBER :=0; --��ȯ�� ������
    vn_quoitient    NUMBER :=0; --��
BEGIN
    vn_quoitient := FLOOR(num1 / num2);
    vn_remainder := num1 - (num2 * vn_quoitient);
    
    RETURN vn_remainder;

END;

--�Լ� ȣ��
--���� ������ �Լ��� ȣ���� ����. 
--�Լ� ȣ�� ����� �Ű������� ���� ������ ���� �Լ���� �Ű������� ����ϱ⵵ �ϰ�, �Լ��� ����ϱ⵵ �Ѵ�.
--�׸��� �Լ��� ��ȯ ���� �����Ƿ� SELECT ���忡�� ����� ���� �ְ� PL/SQL ��� �������� ����� �� �ִ�.

--    <�Ű������� ���� �Լ� ȣ��>
--    �Լ��� Ȥ�� �Լ���()
   
--    <�Ű������� �ִ� �Լ� ȣ��>
--    �Լ���(�Ű�����1, �Ű�����2,...)

SELECT my_mod(14, 4) FROM DUAL; --2

SELECT 14/3 FROM DUAL;

SELECT FLOOR(14/3) FROM DUAL; -- FLOOR�� �����Լ�

--�������� ��ȯ�ϴ� �Լ�
CREATE OR REPLACE FUNCTION fn_get_country_name(p_country_id NUMBER)
    RETURN VARCHAR2
IS
    vs_country_name countries.country_name%TYPE;
BEGIN
    SELECT country_name
    INTO vs_country_name
    FROM countries
    WHERE country_id = p_country_id;
    
    RETURN vs_country_name; --������ ��ȯ
END;

SELECT fn_get_country_name(52777) COUNT1, fn_get_country_name(10000) COUNT2 FROM DUAL;

SELECT COUNTRY_NAME FROM COUNTRIES
WHERE COUNTRY_ID = 10000;

--10000���� ���� �ڵ尡 �������� �ʾ� NULL ��� '����' ���ڿ��� ����ϴ� �Լ� ������ ����

CREATE OR REPLACE FUNCTION fn_get_country_name(p_country_id NUMBER)
    RETURN VARCHAR2
IS
    vs_country_name countries.country_name%TYPE;
    VN_COUNT NUMBER :=0;
BEGIN
    SELECT COUNT(*)
    INTO VN_COUNT
    FROM countries
    WHERE country_id = p_country_id;
    
    IF VN_COUNT = 0 THEN
    vs_country_name := '�ش籹�� ����';
    ELSE
    
    SELECT country_name
    INTO vs_country_name
    FROM countries
    WHERE country_id = p_country_id;
    
    END IF;
    
    RETURN vs_country_name; --������ ��ȯ
END;

SELECT fn_get_country_name(52777) COUNT1, fn_get_country_name(10000) COUNT2 FROM DUAL;

--03 | ���ν��� (PL/SQL�� �̿��� ���ν��� ����)

--�Լ��� Ư�� ������ ������ �� ��� ���� ��ȯ������ 
--���ν����� Ư���� ������ ó���ϱ⸸ �ϰ� ��� ���� ��ȯ������ �ʴ� ���� ���α׷��̴�. 

--���ν��� �ȿ� �Լ��� ���� �� �ִ�.

--�Ϲ������� ������Ʈ ���忡���� �ý��� ���谡 ���� �� ������ �����ϰ� 
--�� ������ ���� ������ ������ �����ؾ� �ϴµ�, �������� ���� ������ �ַ� ���ν����� ������ ó���Ѵ�. 
--�� ���̺��� �����͸� ������ �Ը��� �°� �����ϰ� �� ����� �ٸ� ���̺� �ٽ� �����ϰų� �����ϴ� 
--�Ϸ��� ó���� �� �� �ַ� ���ν����� ����Ѵ�.

--���ν��� ����
--�Լ��� ���ν��� ��� DB�� ����� ��ü�̹Ƿ� ���ν����� ������(Stored, �����) ���ν������ �θ��⵵ �ϴµ� 
--�� å������ �׳� ���ν������ �ϰڴ�(�Լ��� ������ �Լ���� �Ѵ�). ���ν����� ���� ������ ������ ����.

    CREATE OR REPLACE PROCEDURE ���ν��� �̸�
        (�Ű�������1[IN |OUT | IN OUT] ������Ÿ��[:= ����Ʈ ��],
         �Ű�������2[IN |OUT | IN OUT] ������Ÿ��[:= ����Ʈ ��],
         
        )
    IS[AS]
      ����, ��� �� ����
    BEGIN
      �����
    ��
    [EXCEPTION
      ���� ó����]
    END [���ν��� �̸�];

-- JOBS ���̺� ������ �����ϴ� ���ν��� ����
CREATE OR REPLACE PROCEDURE my_new_job_proc
( -- �Ķ���� �ڿ��� IN, OUT, IN OUT
  p_job_id      IN JOBS.JOB_ID%TYPE, --IN�� �ǹ̰� �Է¸Ű�����
  p_job_title   IN JOBS.JOB_TITLE%TYPE, 
  p_max_salary  IN JOBS.MAX_salary%TYPE, 
  p_min_salary  IN JOBS.MIN_salary%TYPE 
)
IS

BEGIN

    INSERT INTO JOBS(job_id, job_title, max_salary, min_salary, create_date, update_date)
    VALUES(p_job_id, p_job_title, p_max_salary, p_min_salary, sysdate, sysdate);
    
    COMMIT;
    
END;


--���ν��� ����
--�Լ��� ��ȯ ���� �����Ƿ� ������ �� ��ȣ�⡯�̶�� ��������� 
--���ν����� ��ȣ�⡯ Ȥ�� �����࡯�Ѵٰ� ǥ���ϴµ�, 
--�����δ� ���ڸ� ���� ����ϴ� ���̴�. 
--���ν����� ��ȯ ���� �����Ƿ� �Լ�ó�� SELECT ������ ����� �� ���� ������ ���� �����ؾ� �Ѵ�.

--    <���ν��� ����1>
--    EXEC Ȥ�� EXECUTE ���ν�����(�Ű�����1 ��, �Ű�����2 ��, ...);
--�׷� my_new_job_proc ���ν����� ������ ����.


--���� ���� �ȿ� �Ʒ� ���ν��� ȣ�� ������ �����ϰ� �ȴ�.
EXEC my_new_job_proc('SM_JOB1', 'SAMPLE JOB1', 1000, 5000);

SELECT *
FROM JOBS
WHERE job_id = 'SM_JOB1';



--�Ű������� �ʱⰪ ���
CREATE OR REPLACE PROCEDURE my_new_job_proc
( -- �Ķ���� �ڿ��� IN, OUT, IN OUT�� ����� �� ����
  p_job_id      IN JOBS.JOB_ID%TYPE, --IN�� �ǹ̰� �Է¸Ű�����
  p_job_title   IN JOBS.JOB_TITLE%TYPE, 
  p_max_salary  IN JOBS.MAX_salary%TYPE, 
  p_min_salary  IN JOBS.MIN_salary%TYPE 
)
IS
    VN_cnt number :=0;

BEGIN

    --p_job_id ���� �ߺ��˻��Ͽ� �������� ������ ����, �����ϸ� ����
    SELECT COUNT(*)
    INTO VN_CNT
    FROM JOBS
    WHERE job_id = p_job_id;
    
    IF VN_cnt = 0 THEN

    INSERT INTO JOBS(job_id, job_title, max_salary, min_salary, create_date, update_date)
    VALUES(p_job_id, p_job_title, p_max_salary, p_min_salary, sysdate, sysdate);
    ELSE
        UPDATE JOBS
            SET job_id = p_job_id, JOB_TITLE = p_job_title, max_salary = p_max_salary, min_salary = p_min_salary,
                update_date = SYSDATE
            WHERE job_id = p_job_id;
    
    END IF;
    COMMIT;
    
END;

--������ ��ȸ
SELECT *
FROM JOBS
WHERE job_id = 'SM_JOB1';


EXEC my_new_job_proc('SM_JOB1', 'SAMPLE JOB1', 2000, 6000);

--�̷��Ե� ǥ���� �����ϴ�.
--�Ű������� ���� �����Ͽ� ���ν��� ���డ��.
EXECUTE my_new_job_proc (p_job_id => 'SM_JOB1', p_job_title => 'Sample JOB1', p_min_sal => 2000, p_max_sal => 7000);

--�Ű����� ���� �����ϸ� ������ �߻��Ѵ�. �ʼ��� 4�� ����Ͼ� �ϴµ� 2�� ����Ͽ� ����.
EXECUTE my_new_job_proc ('SM_JOB1', 'Sample JOB1');



--���� ���� �ȿ� �Ʒ� ���ν��� ȣ�� ������ �����ϰ� �ȴ�.
EXEC my_new_job_proc('SM_JOB1', 'SAMPLE JOB1', 1000, 5000);

SELECT *
FROM JOBS
WHERE job_id = 'SM_JOB1';

--�Ű������� �ʱⰪ ���
CREATE OR REPLACE PROCEDURE my_new_job_proc
( -- �Ķ���� �ڿ��� IN, OUT, IN OUT�� ����� �� ����
  p_job_id      IN JOBS.JOB_ID%TYPE, --IN�� �ǹ̰� �Է¸Ű�����
  p_job_title   IN JOBS.JOB_TITLE%TYPE, 
  p_max_salary  IN JOBS.MAX_salary%TYPE :=10, 
  p_min_salary  IN JOBS.MIN_salary%TYPE :=100
)
IS
    VN_cnt number :=0;

BEGIN

    --p_job_id ���� �ߺ��˻��Ͽ� �������� ������ ����, �����ϸ� ����
    SELECT COUNT(*)
    INTO VN_CNT
    FROM JOBS
    WHERE job_id = p_job_id;
    
    IF VN_cnt = 0 THEN

    INSERT INTO JOBS(job_id, job_title, max_salary, min_salary, create_date, update_date)
    VALUES(p_job_id, p_job_title, p_max_salary, p_min_salary, sysdate, sysdate);
    ELSE
        UPDATE JOBS
            SET job_id = p_job_id, JOB_TITLE = p_job_title, max_salary = p_max_salary, min_salary = p_min_salary,
                update_date = SYSDATE
            WHERE job_id = p_job_id;
    
    END IF;
    COMMIT;
    
END;


--�Ű������� �ʱⰪ�� �����ϹǷ�, �Ű������� 2���� ��밡��.
EXECUTE my_new_job_proc ('SM_JOB1', 'Sample JOB1');

--������ ��ȸ�� �Ű������� �ʱⰪ�� ����.
SELECT *
FROM JOBS
WHERE job_id = 'SM_JOB1';

--�ּ�, �ִ� �޿� �Ű������� �������� �ʾҾ ����Ʈ ���� �����ϸ� 
--�� ���� �Ű������� �Ҵ�Ǿ� ó���Ǿ����� �� �� �ִ�. 
--�� ���� ������ ���� ����Ʈ ���� IN �Ű��������� ����� �� �ִ�.



--OUT, IN OUT �Ű������� �̿��� ���ν��� �۾�
--OUT : ��ȯ��(���ϰ�)
--�����͸� ���� �Ǵ� ���� ��¥�� �޾ƿ��� ���ν���

CREATE OR REPLACE PROCEDURE my_new_job_proc
( -- �Ķ���� �ڿ��� IN, OUT, IN OUT�� ����� �� ����
  p_job_id      IN JOBS.JOB_ID%TYPE, --IN�� �ǹ̰� �Է¸Ű�����
  p_job_title   IN JOBS.JOB_TITLE%TYPE, 
  p_max_salary  IN JOBS.MAX_salary%TYPE :=10, 
  p_min_salary  IN JOBS.MIN_salary%TYPE :=100,
  p_upd_update  OUT JOBS.UPDATE_DATE%TYPE
)
IS
    VN_cnt number :=0;
    VN_CUR_DATE JOBS.UPDATE_DATE%TYPE := SYSDATE;
BEGIN

    --p_job_id ���� �ߺ��˻��Ͽ� �������� ������ ����, �����ϸ� ����
    SELECT COUNT(*)
    INTO VN_CNT
    FROM JOBS
    WHERE job_id = p_job_id;
    
    --�������� ������ 
    IF VN_cnt = 0 THEN

    INSERT INTO JOBS(job_id, job_title, max_salary, min_salary, create_date, update_date)
    VALUES(p_job_id, p_job_title, p_max_salary, p_min_salary, VN_CUR_DATE, VN_CUR_DATE);
    ELSE--�����ϸ�
        UPDATE JOBS
            SET job_id = p_job_id, JOB_TITLE = p_job_title, max_salary = p_max_salary, min_salary = p_min_salary,
                update_date = VN_CUR_DATE
            WHERE job_id = p_job_id;
    
    END IF;
    
    --OUT�Ű������� �۾���¥ ����
    p_upd_update := vn_cur_date;
    
    COMMIT;
    
END;

set SERVEROUTPUT ON;
--OUT �Ű������� �ִ� ���ν��� ����

DECLARE
    vd_cur_date JOBS.UPDATE_DATE%TYPE; --���ν��� p_upd_update  OUT JOBS.UPDATE_DATE%TYPE �Ű������� ���� ���� �޴� ����
BEGIN
    --���ν��� �ܵ� ����� exec Ű���� ���, but �ܵ��� �ƴ� ��� �ݵ�� �����ؾ� �Ѵ�.
    --EXEC my_new_job_proc('SM_JOB1', 'SAMPLE JOB1', 2000, 6000, vd_cur_date);
    --EXEC ������ �����߻�

    my_new_job_proc('SM_JOB1', 'SAMPLE JOB1', 2000, 6000, vd_cur_date);
    
    DBMS_OUTPUT.PUT_LINE(vd_cur_date);
END;

commit;

--RETURN��
--�Լ����� ����� RETURN���� ���ν��������� ����� �� �ִµ� �� ���ӻ��� ó�� ������ �ٸ���. 
--�Լ������� ������ ������ �����ϰ� ��� ���� ��ȯ�ϴ� ������ ������,
--���ν��������� RETURN���� ������ ���� ������ ó������ �ʰ� ������ ����, �� ���ν����� �������� ������. 
--�ݺ������� ���� ���ǿ� ���� ������ ���������� ���� EXIT�� ����ϴ� �Ͱ� �����ϴ�.

CREATE OR REPLACE PROCEDURE my_new_job_proc
    ( p_job_id    IN  JOBS.JOB_ID%TYPE,
      p_job_title IN  JOBS.JOB_TITLE%TYPE,
      p_min_sal   IN  JOBS.MIN_SALARY%TYPE := 10,
      p_max_sal   IN  JOBS.MAX_SALARY%TYPE := 100
      --p_upd_date  OUT JOBS.UPDATE_DATE%TYPE
    )
    IS
      vn_cnt NUMBER := 0;
      vn_cur_date JOBS.UPDATE_DATE%TYPE := SYSDATE;
    BEGIN
      -- 1000 ���� ������ �޽��� ��� �� ���� ������
      IF p_min_sal < 1000 THEN
         DBMS_OUTPUT.PUT_LINE('�ּ� �޿����� 1000 �̻��̾�� �մϴ�');
         RETURN; --���ν����� ���ᰡ �ǰ� �Ʒ� ������ ������ ���� �ʴ´�.
      END IF;

      -- ������ job_id�� �ִ��� üũ
      SELECT COUNT(*)
        INTO vn_cnt
        FROM JOBS
       WHERE job_id = p_job_id;
       END;















