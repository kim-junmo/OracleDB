--8�� PL/SQL�� ������ ������� ���� ����
--PL/SQL�� ������ ���� ������ ����� Ư¡�� ��� ������ �ִٰ� �ռ� �����ߴ�. 
--���ڴ� SQL�� ����� �� �ֱ� �����̰�, 
--���ڴ� �Ϲ� ���α׷��� ���ó�� ������ ���� �Ҵ��ϰ� ����ó���� �� �� ������, 
--Ư�� ����� ó���ϴ� �Լ��� ���ν����� ���� �� �ִ� ����� �����ϱ� �����̴�. 
--PL/SQL�� �Ϲ� ���α׷��� ���� �ٸ� ���� ��� �ڵ尡 DB ���ο��� ������� 
--ó�������ν� ���� �ӵ��� ���� ���鿡�� ū ������ �ִٴ� ���̴�.

--PL/SQL : ����Ͻ� ������ �����ϱ� ���� ����
--��DB ���α׷��֡��̶� �ϸ� SQL�� ����� DML���� ����ϴ� ���� ��Ī
--���� ������ ����Ͻ� ������ ����� ���� PL/SQL�� ����� ����
--PL/SQL�� �Ϲ� ���α׷��� ���� �����ϴ� ���� ����� ž��
--�ٸ� ���α׷��� ���� �ٸ� ���� PL/SQL�� DB�� ���� ž��Ǿ� 
--�����ϵǰ� ����Ǿ� ���� �鿡���� ����ϰ�, DB ���� ó���� �� �� ������ ����� ����

--�� sql�� pl/sql�� �ٸ� ����̴�.

SET SERVEROUTPUT ON; --dbms_output.put_line(vi_num); ��°���� ���� ȭ�鿡�� ���� ���� ����.

-- �͸� ���
DECLARE
    vi_num NUMBER; --��������
BEGIN
    vi_num := 100; --���� ��
    dbms_output.put_line(vi_num); --JAVA System.out.println()�� �����ϴ�.
END;

--PL/SQL ����� �������

--1) ����
--������ �ٸ� ���α׷��� ���� ����ϴ� ������ ������ ������ 
--����ο��� ���� ������ �ϰ� ����ο��� ����Ѵ�. 
--���� ���� ����� ������ ����.

--������ ������Ÿ�� := �ʱ갪;
--���� ����� ���ÿ� �ʱ갪�� �Ҵ��� �� �ִµ�, �ʱ갪�� �Ҵ����� ������ 
--������ Ÿ�Կ� ������� �� ������ �ʱ갪�� NULL�� �ȴ�.

--������ ������ �� �ִ� ������ Ÿ���� ũ�� �� ������ ������ �� �ִµ�, 
--�ϳ��� SQL ������ Ÿ���̰� �ٸ� �ϳ��� PL/SQL ������ Ÿ��
--�߿� : PL/SQL ������ Ÿ�Կ��� SQL ������ Ÿ���� ���ԵǾ� �ֱ� �����̴�
--BOOLEAN, PLS_INTEGER, BINARY_INTEGER ��



--2) ���
--����� �����ʹ� �޸� �� �� ���� �Ҵ��ϸ� ������ �ʴ´�. 
--��� ���� ���� ����� ����ϴ�.

--����� CONSTANT ������Ÿ�� := �����;

--����� ������ ���� �ݵ�� CONSTANT�� Ű���带 �ٿ� ������ �����ϸ�, 
--������ �� �ݵ�� �ʱ�ȭ�ؾ� �ϰ� ����ο��� ����� �ٸ� ������ ������ �� ����. 
--�ֳ��ϸ� �� �״�� ����� ����ϱ�!

DECLARE
    --����� : ���� �� ��� ���� ��ġ
    a INTEGER := 2**2*3**2; --(2�� 2���� ���ϱ� 3�� 2����)
BEGIN
    --����� : dbms_output.put_line('a = ' || to_char(a));
    dbms_output.put_line('a = ' || a);
END;

--DML��
--PL/SQL ��� �󿡼� ����ϴ� ����, ���, �����ڴ� ��� �������� �뵵�� ���� ���̴�. 
--������ PL/SQL ����� �ۼ��ϴ� ������ ������ ���̺� �� �ִ� �����͸� �̸����� �����ؼ� 
--Ư�� ������ ���� ���𰡸� ó���ϴ� ���̸�, ���� �ַ� ���Ǵ� ���� SQL���̴�. 
--SQL�� �� DDL�� PL/SQL �󿡼� ���� �� �� ����(���� ���� ����� ���� ���� �ƴϴ�) 
--DML���� ����Ѵ�.

--�ó����� : ��� ���̺��� Ư�� ����� �̸��� �μ����� ������ ����ϴ� �ڵ带 �ۼ��Ѵ�

--1) �Ϲ� SQL������ ����Ͽ� 100���� ã�ƶ�.
SELECT e.emp_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.employee_id = 100;

-- 2) PL/SQL ����
DECLARE
    VS_EMP_NAME VARCHAR2(80); --����� ����
    vs_dep_name VARCHAR2(80); --�μ��� ����
BEGIN
    SELECT e.emp_name, d.department_name
    INTO VS_EMP_NAME, vs_dep_name --�÷��� ���� ������ ��� ���
    FROM employees e, departments d
    WHERE e.department_id = d.department_id
    AND e.employee_id = 100;
    
    --������ ���
    DBMS_OUTPUT.PUT_LINE(vs_emp_name || ' - ' || vs_dep_name);
    
END;

--������ ������Ÿ���� ���̺� �÷�Ÿ������ �ڵ����� ���� %TYPE
--������ ���̺��.�÷���%TYPE;
--����? ���̺��� �÷� ������Ÿ���� ����Ǵ��� Ÿ���� �ڵ������� �ǹǷ� �ڵ� ������ �� �ʿ䰡 ����.

DECLARE
    vs_emp_name employees.emp_name%TYPE; --����� ����
    vs_dep_name departments.department_name%TYPE; --�μ��� ����
BEGIN
    SELECT e.emp_name, d.department_name
    INTO vs_emp_name, vs_dep_name --�÷��� ���� ������ ��� ���
    FROM employees e, departments d
    WHERE e.department_id = d.department_id
    AND e.employee_id = 100;
    
    --������ ���
    DBMS_OUTPUT.PUT_LINE(vs_emp_name || ' - ' || vs_dep_name);
    
END;

--PL/SQL �������� SELECT�� �ܿ��� INSERT, UPDATE, MERGE, DELETE���� �� �� ������ 
--�̵鿡 ���ؼ��� ���� �پ��� ������ ���� ���캼 ���̴�.

--SQL�� PL/SQL ������ Ÿ�Ժ� ����
--SQL ������Ÿ���� PL/SQL������Ÿ�Կ��� ����������, ���̰� �� �� ũ�� ����Ѵ�. (�߿�)

--VARCHAR2 Ÿ���� SQL������ �ִ� ũ�Ⱑ 4000 byte����. 
--������ PL/SQL������ VARCHAR2 Ÿ���� 32KB(32, 767 byte)���� ���

CREATE TABLE ch08_varchar2 (VAR1 VARCHAR2(5000)); --4000BYTE �ʰ��� �����߻�.
--Ÿ�Լ���
CREATE TABLE ch08_varchar2 (VAR1 VARCHAR2(4000));

--������ Ÿ��
INSERT INTO ch08_varchar2 values('4000����Ʈ ũ�ⵥ����')

DECLARE
    vs_sql_varchar2     VARCHAR2(4000);
    vs_plsql_varchar2     VARCHAR2(32767);
BEGIN
    SELECT VAR1
    INTO vs_plsql_varchar2
    FROM ch08_varchar2;
    
    vs_plsql_varchar2 := vs_plsql_varchar2 || ' - ' || vs_plsql_varchar2 || ' - ' || vs_plsql_varchar2;
    
    --�� ������ ũ�⸦ ����Ѵ�.
    DBMS_OUTPUT.PUT_LINE('SQL VARCHAR ���� : ' || LENGTHB(vs_sql_varchar2));
    DBMS_OUTPUT.PUT_LINE('PL/SQL VARCHAR ���� : ' || LENGTHB(vs_plsql_varchar2));
END;

--SQL VARCHAR ���� : 4000
--PL/SQL VARCHAR ���� : 32767

--  �ٽ�����
--  1 PL/SQL�� ���� ���� ���α׷� ������ ����̶�� �Ѵ�.

--  2 �̸��� ���� ����� �͸� ����̶� �ϰ�, ������ �̸��� �ִ� ��Ͽ��� �Լ�, ���ν���, ��Ű�� ���� �ִ�.

--  3 PL/SQL ����� �����, �����, ���� ó���η� �����Ǵµ�, ����ο� ���� ó���δ� ������ �����ϴ�.

--  4 ����ο����� ������ ���, Ŀ�� ���� ������ �� �ִ�. ������ ������ �� �ʱ�ȭ�� �����ϴ�.

--  5 ����� ���� �� �ݵ�� �ʱ�ȭ�ؾ� �ϸ�, �ѹ� �ʱ�ȭ�� ����� ������ �� ����.

--  6 ���̺��� �÷��� ����� ������ ��� ���� �� %TYPE Ű���带 ����ϸ� �ڵ����� ������ Ÿ���� ���� �� �ִ�.

--  7 PL/SQL ��Ͽ����� SQL���� ���� ��� ������ Ÿ�԰� �����ڸ� ����� �� �ִ�.

--  8 PRAGMA Ű���带 ����� Ư�� ������ �°� �����Ϸ����� ������ �� ������, ���� �ٿ� ����� �� �ִ�.

commit;
