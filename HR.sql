-- PL/SQL

-- SQL : DCL, DDL, DML, TCL 4������ �з�.
-- DML : SELECT, INSERT, UPDATE, EROP, MERGE ��ɾ��н�
-- SELECT : ���̺��� �����͸� ��ȸ�ϴ� ��ɾ�.

/*
SELECT �÷���, �÷���, ........ FORM ���̺��
*/

--SQL��ɾ�� ��ҹ��� ������ ����
-- *�� ���̺��� ��� �÷����� ���� ���� �ǹ���.
SELECT * FROM employees;

--��Ű�� : ���̺�� ���� �����ͺ��̽� ��ü���� ������ ������ ��� �����ϴ� �ǹ�.
SELECT * FROM HR.employees; --����(����)���°� ������ HR�� �Ǿ� ������ ��Ű���� ���������ϴ�. 

--������̺��� �����ȣ, �̸�, ���ڿ���, �Ի���, �޿��� ��ȸ�϶�.
SELECT employee_id, first_name || last_name, email, hire_date, salary FROM employees;
-- ||�� ���ϱ� ���� ������ ���ϰ� ����.

--���̺��� �÷��� �����Ͽ�, ���콺�� �巡���ϴ� ���.
SELECT employee_id, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, SALARY FROM employees;

-- FIRST_NAME�� LAST_NAME�� �ϳ��� �����ϱ� ||
-- �����ͺ��̽������� ���ڿ��� ��������ǥ�� ǥ���Ѵ�. '' (ū����ǥ ""�� ������� �ʴ´�.)
SELECT employee_id, FIRST_NAME || ' ' || LAST_NAME, EMAIL, HIRE_DATE, SALARY FROM employees;

-- �÷� ��Ī ���. AS
SELECT employee_id, FIRST_NAME || ' ' || LAST_NAME AS NAME, EMAIL, HIRE_DATE, SALARY FROM employees;

-- 1) �÷��� AS ��Ī, 2) �÷��� ��Ī
SELECT employee_id E_ID, FIRST_NAME || ' ' || LAST_NAME AS NAME, EMAIL EM, HIRE_DATE HD, SALARY SAL 
FROM employees;

--�μ����̺��� �μ����� ��ȸ�϶�.
SELECT department_name FROM departments;

--�μ����̺��� �μ��ڵ�, �μ����� ��ȸ�϶�.
SELECT department_id, DEPARTMENT_NAME FROM departments;

SELECT 
department_id, DEPARTMENT_NAME --�μ��ڵ�, �μ���
FROM departments;

-- �ѱ� �̸����ε� ��Ī�� ����� �� ������ ���߿����� ������� �ʴ´�.
SELECT employee_id �����ȣ, MANAGER_ID �����ھ��̵� FROM employees;

--��Ī�� ������� ����� ��쿡�� "" ū����ǥ�� ���
SELECT employee_id "��� ��ȣ", MANAGER_ID "������ ���̵�" FROM employees;

-- ���� �ּ�
/*
������ �ּ�
*/