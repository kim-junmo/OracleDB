/*
01 | SELECT��
���� �⺻���� SQL������ ���̺��̳� �信 �ִ� �����͸� ��ȸ�� �� ����ϴ� �����̴�. 
SQL�� �� ���󵵷� �� �� ���� ���� ����ϴ� ���� SELECT���̸�, �⺻ ������ ������ ����.

    SELECT * Ȥ�� �÷�
    FROM [��Ű��.]���̺�� Ȥ�� [��Ű��.]���
    WHERE ����
    ORDER BY �÷�;
*/

-- ���� EMPLOYESS���̺��� �޿� (SALARY)�� 5000�� �Ѵ� �����ȣ�� ������� ��ȸ

SELECT employee_id, EMP_NAME FROM EMPLOYEES 
WHERE salary > 5000

SELECT employee_id, EMP_NAME FROM EMPLOYEES 
WHERE salary > 5000
ORDER BY employee_id ASC; --�������� ASC��������

SELECT employee_id, EMP_NAME FROM EMPLOYEES 
WHERE salary > 5000
ORDER BY employee_id DESC; --�������� DESC��������

-- ���� �޿��� 5000�̻��̰� JOB ID ��'IT_PROG'�� ����� ��ȸ�Ѵٸ�, AND�����ڿ� JOB_ID�� �˻��ϴ� ������ �߰��Ѵ�.
SELECT employee_id, EMP_NAME FROM EMPLOYEES 
WHERE salary > 5000 AND JOB_ID = 'IT_PROG' -- ���ڿ� �����ʹ� ��ҹ��� ������ �ϹǷ� ������ ��
ORDER BY employee_id ASC;

--'IT_PROG' �ҹ����� �����Ͱ� �������� �ʴ´�.
SELECT employee_id, EMP_NAME FROM EMPLOYEES 
WHERE salary > 5000 AND JOB_ID = 'it_prog' -- ���ڿ� �����ʹ� ��ҹ��� ������ �ϹǷ� ������ ��
ORDER BY employee_id ASC;


--���� �޿��� 5000�̻��̰� JOB ID ��'IT_PROG'�� ����� ��ȸ�Ѵٸ�, 
--�޿��� 5000�̻��� ��� Ȥ�� JOB_ID ���� 'IT_PROG�� ����� ��ȸ
SELECT employee_id, EMP_NAME FROM EMPLOYEES 
WHERE salary > 5000 OR JOB_ID = 'it_prog' -- ���ڿ� �����ʹ� ��ҹ��� ������ �ϹǷ� ������ ��
ORDER BY employee_id ASC;

/*
INSERT��
�űԷ� �����͸� �Է��� ���� INSERT���� ����ϴµ�, 
ũ�� �⺻ ����, �÷��� ���� ����, INSERT ~SELECT ���·� ���� �� �ִ�.

    INSERT INTO [��Ű��.]���̺�� (�÷�1, �÷�2, ...)
    VALUES (��1, ��2, ...);
    
    ������ ������ �ݵ�� �����ϴ� �÷��� ���� ���� ����, 
    �׸��� ������ Ÿ���� ��ġ�ؾ߸� �Ѵ�. 
    ��ġ���� ������ ������ �߻��Ͽ� ����Ÿ�� �Էµ��� �ʴ´�.
*/

CREATE TABLE EX3_1 (
    COL1    VARCHAR2(10),
    COL2    NUMBER,
    COL3    DATE
);

--�����ͻ���
INSERT INTO EX3_1(COL1, COL2, COL3) VALUES('ABC', 10 , SYSDATE);

--������ ��ȸ
SELECT * FROM EX3_1;

--�÷� ������ �ٲٴ��� VALUES���� �ִ� ���� �ٲ� ������ ���߱⸸ �ϸ� ������ ����.
INSERT INTO EX3_1(COL3, COL1, COL2)VALUES(SYSDATE, 'DEF', 20);

--������ ��ȸ
SELECT * FROM EX3_1;

--������ Ÿ���� ������ ������ ������ �߻� COL3�� DATEŸ���̹Ƿ� 30�� ���ڵ����Ϳ��� �����߻�
INSERT INTO EX3_1(COL1, COL2, COL3) VALUES('ABC', 10 , 30);

--�÷����� ������� ������ VALUES������ ���̺��� �÷� ������� �ش� �÷� ���� ����ؾ� �ϴ� ���´�
INSERT INTO EX3_1 VALUES('GHI', 10, SYSDATE);

--�÷��� ���� ������ ���� �÷�(�ʵ�, ��)�� NULL�̰ų� DEFAULT�� ��쿡�� ���������ϴ�.
--COL3 �÷��� ���� ������ ������ NULL�� ���� ���� ������. ������ ���Խ� NULL�� ó���ȴ�.
INSERT INTO EX3_1(COL1, COL2)VALUES('FDS', 20);

--������ ��ȸ
SELECT * FROM EX3_1;

/*
INSERT ~ SELECT ����
    INSERT INTO [��Ű��.]���̺�� (�÷�1, �÷�2, ...)
    SELECT ��;
*/
--Ű����(�����)�� �빮��, �������� �ҹ��� ���� �������� �۾��ϴ� ���⵵ �ִ�.
CREATE TABLE ex3_2 (
    emp_id      NUMBER,
    emp_name    VARCHAR2(100)
);

--�ǹ����� ���� ���.
INSERT INTO EX3_2(emp_id, emp_name)
SELECT employee_id, emp_name FROM employees
WHERE salary > 5000;

--������ ��ȸ
SELECT * FROM EX3_2;

--���̺� ���(���̺� ����)
CREATE TABLE EMPLOYEES_BAK
AS
SELECT employee_id, emp_name FROM employees
WHERE salary > 5000;

--������ ��ȸ
SELECT * FROM EMPLOYEES_BAK;

/*
UPDATE�� (������ ����)
���̺� �ִ� ���� �����͸� ������ �� ����ϴ� ������ UPDATE���̴�.

    UPDATE [��Ű��.]���̺��
    SET �÷�1 = ���氪1,
        �÷�2 = ���氪2,
    ...
    WHERE ����;
*/
--������ ��ȸ
SELECT * FROM EX3_1;

--EX3_1 ���̺��� COL2 ���� ��� 50���� �����غ���.

UPDATE EX3_1
SET COL2 = 50; --WHERE ���ǽ��� �����Ǹ�, ���̺��� ��� �����͸� �����ϴ� �ǹ�.

--������ ��ȸ
SELECT * FROM EX3_1;

--COL1 �÷����� ;ABD'�������� COL2 �÷� ���� 100���� �����϶�.
UPDATE EX3_1
SET COL2 = 100
WHERE COL1 = 'ABC';

--������ ��ȸ 100 ���� Ȯ��
SELECT * FROM EX3_1 WHERE COL1 = 'ABC';

--������ ��ȸ
SELECT * FROM EX3_2 ORDER BY EMP_ID ASC;

����  EX3_2���� EMP_ID �÷��� �����Ͱ� 150�� �������� �̸��� �÷��� �̸��� 'Peter Tucker Jnuior'�� �����϶�.

UPDATE EX3_2
SET EMP_NAME = 'Peter Tucker JunIor', �÷��� = ���氪, �÷��� = ���氪
WHERE EMP_ID = 150;


SELECT * FROM EX3_2 WHERE EMP_ID = 150;

--�ó����� EMPLYEES���̺��� SALARY�÷����� �޿��� 8000 �̻��� �����͸�
--�����÷����� EMPLOYEE_ID, EMP_NAME, EMAIL, SALARY �����Ǵ� ���̺�(EMP_SALARY_8000)�� �����϶�. ���̺� ����
CREATE TABLE EMP_SALARY_8000 
AS
SELECT employee_id, EMP_NAME, EMAIL, SALARY FROM EMPLOYEES
WHERE SALARY > 8000;

SELECT * FROM EMP_SALARY_8000 ORDER BY EMPLOYEE_ID ASC;

--���� EMP_SALARY_8000���̺���� �����ȣ�� 100���� �����͸� EMAIL�÷��� KINGS �� �����ϰ�, SALARY�÷��� 20000���� �����϶�.
UPDATE EMP_SALARY_8000
SET EMAIL = 'KINGS', SALARY = 20000
WHERE EMPLOYEE_ID = 100;

SELECT * FROM EMP_SALARY_8000 WHERE EMPLOYEE_ID = 100;

/*
MERGE�� -> JOIN������ �н��� ���Ŀ� �����մϴ�.
MERGE���� ������ ���ؼ� ���̺� �ش� ���ǿ� �´� �����Ͱ� ������ INSERT, ������ UPDATE�� �����ϴ� �����̴�. 
Ư�� ���ǿ� ���� � ���� INSERT��, �� �ٸ� ��쿡�� UPDATE���� �����ؾ� �� ��, 
���ſ��� �ش� ������ ó���ϴ� ������ ������ �ۼ��ؾ� ������, MERGE���� ���� ���п� ���� �� �������� ó���� �� �ְ� �Ǿ���.

    MERGE INTO [��Ű��.]���̺��
        USING (update�� insert�� ������ ��õ)
             ON (update�� ����)
    WHEN MATCHED THEN
           SET �÷�1 = ��1, �÷�2 = ��2, ...
    WHERE update ����
           DELETE WHERE update_delete ����
    WHEN NOT MATCHED THEN
           INSERT (�÷�1, �÷�2, ...) VALUES (��1, ��2,...)
           WHERE insert ����;
           
�뵵 : ���θ� ��ٱ��� ���
-����ڰ� ��ǰ�� ��ٱ��Ͽ� �߰��� ��� ���� ����ڿ� ��ǰ�� ���� ������ 
��ٱ��Ͽ� �����ϸ� ��������(UPDATE), �������� ������ ����ڿ� ��ǰ�����Ͱ� ����(INSERT)�ȴ�. 
*/

--https://gent.tistory.com/406 MERGER���� ����.
--SCOTT���� ���� ���

--1) ���� ���̺� ���(DUAL)
--�ó����� : ������̺��� �����ȣ�� 7738�� �����ϸ� ������Ʈ �۾��� �ϰ�, �������� ������ �����۾��� ����.

SELECT * FROM emp WHERE empno = 7738; --�����Ͱ� ����.

MERGE
    INTO emp a
    USING dual
    ON(a.empno = 7738)
    WHEN MATCHED THEN --���� ������ TRUE�̸� 
    UPDATE
        SET a.deptno = 20 --���������δ� UPDATE emp a SET a.deptno = 20 WHERE a.empno = 7738
    WHEN NOT MATCHED THEN
    INSERT (a.empno, a.ename, a.deptno) --���������δ� INSERT emp a (a.emp, a.ename, a.deptno) VALUES(7788, 'SCOTT', 20);
    VALUES(7738, 'SCOTT', 20);
    
ROLLBACK;

-- 2)JOIN�� ���
--SCOTT ���� ���ӿ��� job_history���̺��� �������� ����.

SELECT *
FROM job_history a, emp b
WHERE a.empno = b.empno
AND a.empno = 7738;

MERGE
 INTO job_history a
USING emp b
 on (a.empno = 7738 AND a.empno = b.empno)
 WHEN MATCHED THEN
    UPDATE
        SET a.job = b.job, a.deptno = b.deptno
 WHEN NOT MATCHED THEN
    INSERT (a.empno, a.job, a.deptno) VALUES(b.empno, b.job, b.deptno);

--MERGE�ȿ��� DELETE�� ���
MERGE
 INTO emp a
 USING dual
    ON (a.empno = 7738)
    WHEN MATCHED THEN
        UPDATE
            SET a.deptno = 20 WHERE a.job = 'analyst'
        DELETE
            WHERE a.job<> 'analyst';

/*
 DELETE��
���̺� �ִ� �����͸� ������ �� DELETE���� ����Ѵ�.

    �� �Ϲ� ����
    DELETE [FROM] [��Ű��.]���̺��
    WHERE delete ����; 

    �� Ư�� ��Ƽ�Ǹ� ������ ����� ����
    DELETE [FROM] [��Ű��.]���̺�� PARTITION (��Ƽ�Ǹ�)
    WHERE delete ����;
*/

--EMP_SALARY_8000 ���̺� ���.
SELECT * FROM EMP_SALARY_8000 ORDER BY EMPLOYEE_ID ASC;

DELETE FROM EMP_SALARY_8000
WHERE EMPLOYEE_ID = 100;

--������ ��ȸ
SELECT * FROM EMP_SALARY_8000 
WHERE EMPLOYEE_ID = 100;

--EMP_SALARY_8000���̺��� �ó����� �޿��� 10,000~13,000�����͸� �����϶�
DELETE FROM EMP_SALARY_8000 
WHERE SALARY >=10000 AND SALARY <= 13000;

--������ ��ȸ
SELECT * FROM EMP_SALARY_8000 
WHERE SALARY >=10000 AND SALARY <= 13000;

-- �� AND ������ ������.
/*
SELECT * FROM EMP_SALARY_8000; 
WHERE SALARY BETWEEN 10000 AND 13000;
*/

--�ó����� �����ȣ�� 101�� �Ǵ� 145���� �����͸� �����϶�.
DELETE FROM EMP_SALARY_8000 
WHERE EMPLOYEE_ID = 101 OR EMPLOYEE_ID = 145;

--������ Ȯ��
SELECT * FROM EMP_SALARY_8000 
WHERE EMPLOYEE_ID = 101 OR EMPLOYEE_ID = 145;

--���̺� ������ ����, ����, ���� �۾��� COMMIT OR ROLLBACK ��ɾ ������ �޴´�.
COMMIT; --���̺� �۾��ߴ� ������ �ӽ��۾��� �����̴�. �ü������ ����� �������� ���������Ͽ� ���� USERS.DBF���Ͽ� ���������� �ݿ��ϱ� ���� ��ɾ� 
ROLLBACK; -- ���̺� �۾��ߴ� ������ �ӽ��۾��� �����̴�. �۾��� ������ ��ҽ��� USERS.DBF���Ͽ� ���������� �ݿ��� �ȵȴ�.

/*
TRUNCATE��
�����͸� ������ ���� DELETE���� ����ϴµ� �̿� ���� ����� �����ϴ� ������ �ٷ� TRUNCATE���̴�. 
DELETE���� �����͸� ������ �Ŀ� COMMIT�� �����ؾ� �����Ͱ� ������ �����ǰ�, �ݴ�� ROLLBACK�� �����ϸ� �����Ͱ� �����Ǳ� ������ ���͵ȴ�. 
������ DDL���� ���ϴ� TRUNCATE���� �ѹ� �����ϸ� �����Ͱ� �ٷ� �����ǰ� ROLLABCK�� �����ϴ��� ���� �� ���·� ���͵��� �ʴ´�. 
���� TRUNCATE������ WHERE ������ ���� �� ����. �� ���̺� ������ ��ü�� �ٷ� �����ȴ�. 
������ ����� �����Ƿ� TRUNCATE���� ����� ���� �׻� ���Ǹ� ��￩�� �Ѵ�.

    TRUNCATE TABLE [��Ű����.]���̺��;
*/
CREATE TABLE ex3_4 (
    employee_id NUMBER
);

INSERT INTO ex3_4 VALUES(100);

--������ ��ȸ
SELECT * FROM ex3_4;

ROLLBACK; --���� �Է��� �����Ͱ� ��ҵ�.

INSERT INTO ex3_4 VALUES(100);

--������ ��ȸ
SELECT * FROM ex3_4;

COMMIT; --�������� �����ͺ��̽� ���Ͽ� �۾������� �ݿ��ȴ�.

--���ǽ� WHERE�� ������ ������ �ȵȴ�. ROLLBACK ���� �ȵǾ� ������ �Ұ����ϴ�. ��û �����ؼ� ���.
TRUNCATE TABLE ex3_4; --Table EX3_4��(��) �߷Ƚ��ϴ�.

ROLLBACK;

--������ ��ȸ
SELECT * FROM ex3_4; --�ѹ� ����� �ȵǾ ���������Ͱ� �������� �ʴ´�.

/*
�ǻ��÷�
�ǻ��÷�Pseudo-column�̶� ���̺��� �÷�ó�� ���������� ������ ���̺� ��������� �ʴ� �÷��� ���Ѵ�
SELECT �������� �ǻ��÷��� ����� �� ������, �ǻ��÷� ���� INSERT, UPDATE, DELETE �� ���� ����.
2���� ��06.�������� ������ �н��ߴ� NEXTVAL, CURRVAL�� �ǻ��÷��� �����̴�.
*/

-- ROWNUM : �������� ��ȯ�Ǵ� �� �ο�鿡 ���� ���� ���� ��Ÿ���� �ǻ��÷��̴�
-- ���������� ��ô �߿��ϰ� ����

SELECT ROWNUM, employee_id, EMP_NAME, SALARY FROM employees WHERE SALARY >=5000;

--1) ROWNUM�� �̿��Ͽ� ȭ�鿡 ��µǴ� �����͸� ����
SELECT ROWNUM, employee_id, EMP_NAME, SALARY FROM employees
WHERE ROWNUM <=5;

SELECT ROWNUM, employee_id, EMP_NAME, SALARY FROM employees
WHERE ROWNUM <=10;

SELECT ROWNUM, employee_id, EMP_NAME, SALARY FROM employees
WHERE ROWNUM <=20;

--�߰������� ���ǿ� �ش��ϴ� �����ʹ� ����ϸ� ����� ����. (�߿�)
SELECT ROWNUM, employee_id, EMP_NAME, SALARY FROM employees
WHERE ROWNUM >=6 AND ROWNUM <=10;

--2) ROWID�� ���̺� ����� �� �ο찡 ����� �ּ� ���� ����Ű�� �ǻ��÷��̴�. 
--�� �ο츦 �ĺ��ϴ� ���̹Ƿ� ROWID�� ������ ���� ������

SELECT ROWNUM, ROWID, employee_id, EMP_NAME, SALARY FROM employees
WHERE ROWNUM <=5;

/*
������
������Operator�� ������ �����Ѵ�. ����Ŭ�� �پ��� �����ڸ� �����ϰ� �ִµ�, �̵��� �����ϸ� ������ ����.

���� ������: +, -, *, /   /NUMBER������Ÿ�Կ� �ش��ϴ� �÷� �Ǵ� ���� �����Ϳ� ���ȴ�.
��+���� ��-���� ���� ����� 1���� ���� �����ڷ� ���� �� ���� ����� ������ ��Ÿ����. 
���� �� ���� ����, �� ���� �����ڷ� ���� ���� ���� ������ ���� ������ �Ѵ�. 
�׸��� ��*���� ����, ��/���� ������ ������ �Ѵ�.
*/
--���̺� ���� ����
DESC employees;

SELECT employee_id, COMMISSION_PCT, SALARY*12+COMMISSION_PCT AS"����" FROM EMPLOYEES
ORDER BY employee_id;

--�� ��°�� �� NULL�� Ȯ�εǴ� ���� �÷� �����Ͱ� NULL�� �����ϸ�, ����� NULL�� �ȴ�.
SELECT 10+20 FROM DUAL;

--����� NULL�� �����ϸ� ����� NULL�� �ȴ�. NULL���� ����� NULL���� �Լ��� �н��ؾ��Ѵ�.
SELECT 10+20+NULL FROM DUAL; --NULL

/*
�� ������: >, <, >=, <=, =, <>, !=, \^=
�� ������ �����ϴ� �����ڷ� ���п��� ����ϴ� �ε�ȣ�� ���ӻ��� ����. 
��, �� ���� �������� �Ǵ��ϴ� ��ȣ ������(=)�� �ݴ��� �񵿵� �����ڷδ� ��< >��, ��!=��, ��\^=���� �ִµ�, 
�� �� �������� ������ ��ȯ ����� ��� ����. 
�� ��< >��, ��!=��, ��\^=���� ���� �ʴٶ�� �����ϸ� ��.
���� ���� ���� �� ���� �Ӹ� �ƴ϶� ���ڿ� ��¥���� �� �����ϴ�.
*/

/*
���� ���� : https://gent.tistory.com/311 �ּ�����
ǥ���� 
ǥ����Expression�̶� �� �� �̻��� ���� ������, SQL �Լ� ���� ���յ� ���̴�. 
�� �������� Ư�� ���ǿ� ���� ���� �����ؼ� ���̴� CASE ǥ����(���� CASE���̶�� �Ѵ�)�� ���� �˾� ����.

    CASE WHEN ����1 THEN ��1
         WHEN ����2 THEN ��2
    ...
         ELSE ��Ÿ ��
    END
*/

SELECT emp_name, EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEES ORDER BY EMPLOYEE_ID; 


--CASE�� ����
--1) IF�� ����, DEPARTMENT_ID�÷��� �����Ͱ� 10���̸� NEW YORK, 20���̸� DALLAS ��Ÿ�� UNKNOWN

SELECT 
    emp_name, employee_id, department_id, 
    CASE 
        WHEN DEPARTMENT_ID = 10 THEN 'NEW YORK'
        WHEN DEPARTMENT_ID = 20 THEN 'DALLAS'
        ELSE 'UNKNOWN'
    END AS DEPARTMENT_CITY
FROM 
    EMPLOYEES
    ORDER BY DEPARTMENT_ID;

--2) SWITCH�� ����
SELECT emp_name, EMPLOYEE_ID, DEPARTMENT_ID,
    CASE DEPARTMENT_ID
    WHEN 10 THEN 'NEW YORK'
    WHEN 20 THEN 'DALLAS'
    ELSE 'UNKNOWN'
    END AS DEPARTMENT_CITY
FROM 
    EMPLOYEES
    ORDER BY DEPARTMENT_ID;

--ELSE�� �����ϴ� ��� ������ �����Ǵ� ��찡 ������ NULL�� ��ȯ�ȴ�.
SELECT 
    emp_name, EMPLOYEE_ID, DEPARTMENT_ID, 
    CASE 
        WHEN DEPARTMENT_ID = 10 THEN 'NEW YORK'
        WHEN DEPARTMENT_ID = 20 THEN 'DALLAS'
        ELSE ' ' --NULL�� �������� ó��
    END AS DEPARTMENT_CITY
FROM 
    EMPLOYEES
    ORDER BY Department_Id;
    
--�ó����� : SALARY(�޿���) 15000 �̻��̸� ��׿���, 10000�̻��̸� �������, �������� �Ϲݿ������� ����϶�.CASE���� IF�� �������� �۾�
--�����ȣ, �̸�, �޿�, ��������
SELECT employee_id, emp_name, salary,
    CASE
        WHEN salary >= 15000 THEN '��׿���'
        WHEN salary >= 10000 THEN '�������'
        ELSE '�Ϲݿ���'
    END AS salary_gubun
FROM
    employees
    ORDER BY salary;

--��øCASE �߰� �����۾� ����
SELECT 
    emp_name, employee_id, department_id, salary,
    CASE 
        WHEN DEPARTMENT_ID = 10 THEN 
            CASE WHEN SALARY >=15000 THEN '1���'
                 WHEN SALARY >=10000 THEN '2���'
                 WHEN SALARY >=3000 THEN '3���'
        END
        WHEN DEPARTMENT_ID = 20 THEN 
            CASE 
                WHEN SALARY >=18000 THEN '1���'
                WHEN SALARY >=15000 THEN '2���'
                WHEN SALARY >=5000 THEN '3���'
            END
        WHEN DEPARTMENT_ID = 30 THEN 
            CASE 
                WHEN SALARY >=8000 THEN '1���'
                WHEN SALARY >=5000 THEN '2���'
                WHEN SALARY >=2000 THEN '3���'
            END
        ELSE ' ' --NULL�� �������� ó��
    END AS DEPARTMENT_CITY
FROM 
    EMPLOYEES
    ORDER BY Department_Id;
/*
�� ���ǽ�
�� ���ǽ��� �� �����ڳ� ANY, SOME, ALL Ű����� ���ϴ� ���ǽ��� ���Ѵ�. 
���⼭�� ANY, SOME, ALL �񱳿� ���ؼ� �˾� ���ٵ� ���� ANY�� ���� ����.
*/

--salary(�޿�)�� 2000 �Ǵ� 3000 �Ǵ� 4000 �����͸� ��ȸ�϶�.
--1), 2)�� �����ϴ�..
--1)
SELECT employee_id, salary
FROM employees
WHERE salary = ANY (2000, 3000, 4000)
ORDER BY employee_id;

--2)
SELECT employee_id, salary
    FROM employees
        WHERE salary = 2000 
            OR salary =3000 
            OR salary =4000
        ORDER BY employee_id;

--3) salary(�޿���) 2000�̰�, 3000�̰� 4000�� �����͸� ��ȸ�϶�. �������� ������ �����Ƿ� ����� ����.
SELECT employee_id, salary
FROM employees
WHERE salary = ALL (2000, 3000, 4000)
ORDER BY employee_id;

--salary(�޿�)�� 4000���� ū �����͸� ��ȸ
SELECT employee_id, salary
FROM employees
WHERE salary > ALL (2000, 3000, 4000)
ORDER BY employee_id;

----salary(�޿�)�� 2000���� ū ������, 3000���� ū ������, 4000���� ū �����͸� ��ȸ
--ANY, SOME�� ������ �ǹ̸� ���Ѵ�.
SELECT employee_id, salary
FROM employees
WHERE salary > ANY (2000, 3000, 4000)
ORDER BY employee_id;

SELECT employee_id, salary
FROM employees
WHERE salary > SOME (2000, 3000, 4000)
ORDER BY employee_id;

/*
�� ���ǽ�
�� ���ǽ��� ���������� AND, OR, NOT�� ����ϴ� ���ǽ��� ���Ѵ�. 
AND�� ��� ������ �����ؾ� �ϰ� OR�� ���� ���� �� �ϳ��� �����ص� TRUE�� ��ȯ�ȴ�. 
NOT�� ���ǽ� �� ����� ����(FALSE)�� �� ���ϴ� ���, �� TRUE�� ��ȯ�Ѵ�.
*/
--salary(�޿�) �÷��� ������ �������� ����, ������ �ٸ� �� �ִ�.
SELECT employee_id, salary
FROM employees
WHERE NOT (salary >= 2500) --salary < 2500�� �����ϴ�.
ORDER BY employee_id;

SELECT employee_id, salary
FROM employees
WHERE salary < 2500 
ORDER BY employee_id;

/*
NULL ���ǽ�
NULL ���ǽ��� Ư�� ���� NULL���� ���θ� üũ�ϴ� ���ǽ��̴�. 
�ռ� UPDATE���� �˾� ���鼭 NULL���� ���δ� IS NULL�� IS NOT NULL�� üũ�Ѵٴ� ������ �н��ߴ�. 
�ٽ� ���������� Ư�� �÷� ���� NULL������ ���θ� üũ�� �� ��ȣ ������(=, < >)�� ����ϸ� ����� ������ ���Ѵ�. 
���� ���, �޿��� NULL���� Ȥ�� �ƴ��� ���θ� üũ�Ϸ��� ��salary = NULL�� Ȥ�� ��salary < > NULL�� ���·� ���ϸ� �� �ǰ� 
��salary IS NULL�� Ȥ�� ��salary IS NOT NULLL�� ���·� ���ؾ� �Ѵ�.
*/

--���ǽĿ��� ���Ǵ� IS NULL, IS NOT NULL
--commission_pct �÷��� �����Ͱ� NULL
SELECT employee_id, emp_name, salary, commission_pct FROM employees
WHERE commission_pct IS NULL

--commission_pct �÷��� �����Ͱ� NOT NULL
SELECT employee_id, emp_name, salary, commission_pct FROM employees
WHERE commission_pct IS NOT NULL

/*
IN ���ǽ�
IN ���ǽ��� �������� ����� ���� ���Ե� ���� ��ȯ�ϴµ� �տ��� ����� ANY�� ����ϴ�.
*/
--�� ������ �޿��� salary(�޿���) 2000�̰�, 3000�̰� 4000�� �����ϴ� ����� ������ ���
SELECT employee_id, emp_name, salary FROM employees
WHERE salary IN (2000,3000,4000); --OR�� ��ȯ����

--�� ������ �޿��� salary(�޿���) 2000, 3000 4000�� ���Ե��� �ʴ� ����� ������ ���
--������ Ǯ��� "salary< >2000 AND salary< >3000 AND salary< >4000�̸�, "< >ALL"�ε� �ٲ� �� �� �ִ�. 
SELECT employee_id, salary
FROM employees
WHERE salary NOT IN (2000, 3000, 4000)
ORDER BY employee_id;

--EXISTS ���ǽ� : JOIN������ �н� �� ���Ŀ� ������ ��

/*
LIKE ���ǽ�
LIKE ���ǽ��� ���ڿ��� ������ �˻��� �� ����ϴ� ���ǽ��̴�. 
*/

-- ��� ���̺��� ����̸��� ��A���� ���۵Ǵ� ����� ��ȸ�ϴ� ������ �ۼ��Ѵٸ� ������ ���� LIKE ���ǽ��� ����Ѵ�.
SELECT emp_name
FROM employees
WHERE emp_name LIKE 'A%'
ORDER BY emp_name;

--�߸��ϴ� ���
SELECT emp_name
FROM employees
WHERE emp_name = 'A%'
ORDER BY emp_name;

--Al�� ���۵Ǵ� ��� ����� ��ȸ�� ������. 
SELECT emp_name
FROM employees
WHERE emp_name LIKE 'Al%'
ORDER BY emp_name;

/*
��%���� ��, ��, �߰� ��� �� �� ������ ���ǽ��� �˻��� �� ��ҹ��ڸ� �����Ѵٴ� ���� ��������. 
��%���ʹ� �ٸ��� ��_��(����, ������ھ�)�� ������ ���� ��ü�� �ƴ� �� ���ڸ� ���Ѵ�.
*/

CREATE TABLE EX3_5 (
    NAME    VARCHAR2(30)
);

INSERT INTO EX3_5 VALUES('ȫ�浿');
INSERT INTO EX3_5 VALUES('ȫ���');
INSERT INTO EX3_5 VALUES('ȫ���');
INSERT INTO EX3_5 VALUES('ȫ���');
INSERT INTO EX3_5 VALUES('ȫ��');

SELECT * FROM EX3_5;

--ȫ��� �����ϴ� �̸��� ��ȸ�϶�.
SELECT * FROM EX3_5
WHERE NAME LIKE 'ȫ��%'; --2���� �ڽŵ� ����

--ȫ��� �����ϴ� ��ü �̸��� 3���ڸ� ��ȸ�϶�.
SELECT * FROM EX3_5
WHERE NAME LIKE 'ȫ��_';

/*
�ٽ�����
  1 �����͸� �����ϴ� ��ǥ���� DML������ SELECT, INSERT, UPDATE, DELETE, MERGE�� �ִ�.
  2 MERGE���� INSERT�� UPDATE�� ȥ�յ� ���·�, Ư�� ���ǿ� ���� INSERT�� UPDATE�� �����Ѵ�.
  3 ������ ���� �Ŀ��� Ʈ����� ó���� ���� �ݵ�� COMMIT�̳� ROLLBACK�� �ؾ� �Ѵ�.
  4 DML, DDL�� �ܿ��� SQL ������ �ǻ��÷�, ������, ǥ����, ���ǽ����� �����ȴ�.
  5 �����ڴ� �پ��� ������ �����ϸ�, ����, ����, ��, ����, ������ ���� �����ڰ� �ִ�.
  6 ���ǽ��� �ϳ� �̻��� ǥ���İ� �� �����ڰ� ���յ� ������ TRUE, FALSE, UNKNOWN �� ���� Ÿ���� ��ȯ�ϸ�, 
    ��, ��, NULL, BETWEEN, IN, EXISTS ���ǽ��� �ִ�.
*/
COMMIT;
