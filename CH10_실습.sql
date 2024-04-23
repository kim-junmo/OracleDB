----10�� ����ó���� Ʈ����� �˾� ����
--���α׷��� �����ϴ� ���� �پ��� ����� ���� �����ؼ� 
--���� Ȯ�� �� ����ó���� �ϴ� ���� �����ε� PL/SQL ���� ����������.

--�ý��� ���ܷδ� ������ ������ �� �� 0���� �����ٰų� 
--SELECT INTO ���� ����� �����͸� ������ �� 
--���ǿ� �����ϴ� �����Ͱ� ������ �߻��ϴ� ���� ���� �ִ�. 
--�� �ý��� ���ܴ� ����Ŭ ���ο� �̸� ���ǵ� ���ܶ�� �� �� �ִ�.

--����ó�� ����
--    EXCEPTION WHEN ���ܸ�1 THEN ����ó�� ����1
--     WHEN ���ܸ�2 THEN ����ó�� ����2
--     ...
--     WHEN OTHERS THEN ����ó�� ����n;

--�ڹٷ� �������ڸ�
--try {
--}
--catch(����Ŭ���� e) {
--����ó�� ���� 1
--}
--catch(����Ŭ���� e) {
--����ó�� ���� 2
--}

--PL/SQL ����
--�Լ� �Ǵ� ���ν��� �̸����� ������ �ʰ� �Ʒ��� ���� �ڵ带 �����ϸ�, �̸� �͸� ����̶�� �Ѵ�.
DECLARE
    vi_num NUMBER :=0;
BEGIN
    vi_num := 10 / 0; --������ 0���� ���Ǿ�, ���� �߻��� �Ǿ� ���������� ���ᰡ ��, �Ʒ� ������ �������� ����.
    DBMS_OUTPUT.PUT_LINE('Success');
    
    --����ó�� �۾�
    EXCEPTION WHEN OTHERS THEN --OTHERS : ���� ������ �� ��� �Ϲ������� ����ϴ� Ű����
        DBMS_OUTPUT.PUT_LINE('������ �߻��߽��ϴ�.');
    
END;

--1)���� ó���� ���� ���ν���
CREATE OR REPLACE PROCEDURE ch10_no_exception_proc
IS
    vi_num NUMBER :=0;
BEGIN
    vi_num :=10 / 0; --���� �߻� ����
    DBMS_OUTPUT.PUT_LINE('Success');
END;

--2)���� ó���� �ִ� ���ν���
CREATE OR REPLACE PROCEDURE ch10_exception_proc
IS
    vi_num NUMBER :=0;
BEGIN
    vi_num :=10 / 0; --���� �߻� ����
    DBMS_OUTPUT.PUT_LINE('Success');
    
    --����ó��
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('������ �߻��߽��ϴ�');
END;

--����ó���� ���� ���ν��� ����
DECLARE
    vi_num NUMBER :=0; --������� �ʾƵ� ������ ���� ������ ��
BEGIN
    ch10_no_exception_proc; --����ó���� �������� �ʴ´�.
    DBMS_OUTPUT.PUT_LINE('Success'); --�� ������ �տ� ����ó���� ���� ���ν����� ����Ǿ� ���ܹ߻��� �Ǿ� ������� �ʴ´�.
END;

--����ó���� �ִ� ���ν��� ����
DECLARE
    vi_num NUMBER :=0; --������� �ʾƵ� ������ ���� ������ ��
BEGIN
    ch10_exception_proc; --����ó���� ����
    DBMS_OUTPUT.PUT_LINE('Success'); --�� ������ ����ó���� �Ǿ� �ֱ� ������ �����.
END;


--2)���� ó���� �ִ� ���ν��� ����
CREATE OR REPLACE PROCEDURE ch10_exception_proc
IS
    vi_num NUMBER :=0;
BEGIN
    vi_num :=10 / 0; --���� �߻� ����
    DBMS_OUTPUT.PUT_LINE('Success');
    
    --����ó��
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('������ �߻��߽��ϴ�');
    DBMS_OUTPUT.PUT_LINE('SQL ERROR CODE' || SQLCODE);--�����ڵ�
    DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE' || SQLERRM);--�����޼���
    DBMS_OUTPUT.PUT_LINE(SQLERRM(SQLCODE)); --�����ڵ�� �����޼���
END;


--���ν��� ����
DECLARE
    vi_num NUMBER :=0; --������� �ʾƵ� ������ ���� ������ ��
BEGIN
    ch10_exception_proc; --����ó���� ����
    DBMS_OUTPUT.PUT_LINE('Success'); --�� ������ ����ó���� �Ǿ� �ֱ� ������ �����.
END;

--����ó���� OTHERS������� �ʰ� ZERO_DIVIDE ����ó������ ����� ���
CREATE OR REPLACE PROCEDURE ch10_exception_proc
IS
      vi_num NUMBER := 0;
BEGIN
      vi_num := 10 / 0;
      DBMS_OUTPUT.PUT_LINE('Success!');

EXCEPTION WHEN ZERO_DIVIDE THEN
      DBMS_OUTPUT.PUT_LINE('������ �߻��߽��ϴ�');
      DBMS_OUTPUT.PUT_LINE('SQL ERROR CODE: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE: ' || SQLERRM);
END;

--����ó������ 2�� �̻����� ����ϴ� ���ν����� ����
CREATE OR REPLACE PROCEDURE ch10_exception_proc
IS
      vi_num NUMBER := 0;
BEGIN
      vi_num := 10 / 0;
      DBMS_OUTPUT.PUT_LINE('Success!');

EXCEPTION 
WHEN ZERO_DIVIDE THEN
      DBMS_OUTPUT.PUT_LINE('����1');
      DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE1: ' || SQLERRM);
WHEN OTHERS THEN --OTHERS ����ó������ ������ ������ ����ؾ� �Ѵ�.
      DBMS_OUTPUT.PUT_LINE('����2');
      DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE2: ' || SQLERRM);
END;

--SELECT INTO ���� �߻�
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
        DBMS_OUTPUT.PUT_LINE('job_id�� �����ϴ�.');
        RETURN;
    ELSE
    UPDATE employees
    SET job_id = p_job_id;
    WHERE employee_id = P_Employee_Id;
    END IF;
    
    COMMIT;
END;

--���� ���ν����� ����ó�� ������ ���� �ڵ�� ��������.
CREATE OR REPLACE PROCEDURE ch10_UPD_jObid_proc
(
    p_empolyee_id   employees.employee_id%TYPE
    p_job_id        job_id%TYPE
)
IS
    vn_cat          number :=0;
BEGIN
--���ǽ��� ��ġ���� ������ ����Ŭ������ SELECT INTO ������ ���ܰ� �߻��ϵ��� ����Ǿ� �ִ�.
    SELECT 1
    INTO vn_cat
    FROM jobs
    WHERE job_id = p_job_id;  --���ǽ��� FALSE�̸� ���� �߻�.

    UPDATE employees
    SET job_id = p_job_id;
    WHERE employee_id = P_Employee_Id;

    COMMIT;
    
    EXCEPTION 
        WHEN NO_DATE_FOUND THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            DBMS_OUTPUT.PUT_LINE(P_JOB_ID || '�� �ش��ϴ� JOB ID�� �����ϴ�.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('��Ÿ����:'|| SQLEERM');
END;

--���ν����� ������ SELECT�� ������¸� ����ϸ� �ȵȴ�.(�߿�)
--EX)
CREATE OR REPLACE PROCEDURE udp_select
IS
BEGIN
    SELECT * FROM employees; --SELECT INTO������ �̿��� ������ �Ҵ��ϴ� ���� �����ϴ�.
END;
--���� ������ PLS-00428: an INTO clause is expected in this SELECT statement ���� ���� �߻�
--����Ŭ������ �ȵǰ� ms-sql������ ��밡���ϴ�.





















































































































































































