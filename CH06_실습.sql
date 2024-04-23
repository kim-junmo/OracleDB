--01 | ������ ����
--������ ������ ������ ���� ���� ����, �ܺ� ����, ���� ����, ��Ƽ ����, ���� ����, ���� ����, īŸ�þ� ����(CATASIAN PRODUCT), ANSI ������ �ִµ�, 
--�� 8���� ���� ����� ��������� �������� ������ �ƴϴ�. �� ���� ������ ��� ������ �ܺ� �����̸�, 
--�ܺ� ������ ������ ���� ����, ��Ƽ ���� ���� ��� ���� ���ο� ���Եȴ�. 
--���� ������ ���� �ϳ�, �� ��Ī�� ��� �ϱ��� �ʿ�� ����. 
--�����ڴ� ���ɽ����� ���� �л��� �ƴϹǷ�, ��Ī���ٴ� �� ���� ����� �����ϴ� ���� �߿��ϴ�
--�Ϲ������� ���� ���ΰ� �ܺ� ���θ� ������ �� ������ ����ϴ�.

--����Ŭ���� ������ �� �� ����Ŭ ����(Oracle Join)�� �Ƚ� ����(ANSI JOIN)�� ����� �� �ִ�. 
--����Ŭ 9i ������ ����Ŭ ���θ� ����� �� ������, ����Ŭ 10g���ʹ� �Ƚ� ������ �߰��� ����� �� �ִ�.

--����
--���� : 2���� ���̺��� �÷����� ���Ͽ�, ������ ���������� ���������� �����ϴ� ���

--ǥ��: ����Ŭ ���ΰ� ansi���� 
--������ ���� ����(INNER JOIN), �ܺ� ����(OUTER JOIN)���� �����Ѵ�.

--���� ����(INNER JOIN) : �Ϲ������� ������ �̾߱��ϸ� INNER JOIN�� �ǹ��Ѵ�.
--�����̾�׷��� �������� �����ϸ� ����.

--�ܺ� ����(OUTER JOIN) : inner join�� ������ٰ� ��ġ���� �ʴ� �����͵� �����Ͽ� ����ϴ� �ǹ�
--    1)LEFT OUTER JOIN
--    2)RIGHT OUTER JOIN
--    3)FULL OUTER JOIN

--����, �����ȣ, �̸�, �μ����� ��ȸ�϶�.
--������̺� : �����ȣ, �̸�
--�μ����̺� : �μ���

--ORACLE INNER JOIN
SELECT �����ȣ, �̸�, �μ���
FROM ������̺�, �μ����̺�
WHERE ������̺�.�μ��ڵ� = �μ����̺�.�μ��ڵ� --JOIN ���ǽ�

--* : employees ���̺��� �ڵ� �÷��� �μ����̺��� ��� �÷�
SELECT employee_id, emp_name, department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id;

--���̺� ��Ī�� ����Ͽ� INNER JOIN�ϴ� ����
SELECT a.employee_id, a.emp_name, b.department_name
FROM employees a, departments b
WHERE a.department_id = b.department_id;

--�ó����� EMP���̺�� DEPT���̺��� �����Ͽ�, �����͸� ����϶�.
SELECT e_id, e_name, d_name
FROM emp, dept
WHERE emp.d_code = dept.d_code
AND EMP.E_ID = 1001; --1001���� ���� ��ɾ�

--ANSI JOIN(INNER JOIN)
SELECT employee_id, emp_name, department_name
FROM employees INNER JOIN departments --, ��� INNER JOIN�� ��
ON employees.department_id = departments.department_id; -- WHERE ��� ON�� ��

--���̺� ��Ī�� ����Ͽ� inner join ����
select e.employee_id , e.emp_name , d.department_name 
from employees e INNER JOIN departments d
on e.department_id = d.department_id;

SELECT e_id, e_name, d_name
FROM emp INNER JOIN dept
ON emp.d_code = dept.d_code;

SELECT e_id, e_name, d_name
FROM emp INNER JOIN dept
ON emp.d_code = dept.d_code
WHERE EMP.E_ID = 1001; --AND ��� WHERE�� �����

--���̺� 3�� ���� (����Ŭ ����)
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

--�ܺ� ����(OUTER JOIN)
--�� �Ϲ� ����
--��ġ�Ǵ� �����͸� �������� �������� ���
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM departments a,
    job_history b
WHERE a.department_id = b.department_id;
     
--��ġ�Ǵ� ��������� ��ġ���� ���� �����͵� �����Ͽ� ���, �� job_history �� ���� �μ��� ��ȸ���� �ʾƼ� �����ؼ� ���

--�� �ܺ� ����
--27�� �μ� �� job_history���̺� ���� ���� ����϶�.
--department_id���̺� : ��� �μ�����(27��), job_history���̺�: �μ��� �� ������Ʈ�� ������ ������ ����, (+)ǥ��
--1) left outer join
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM  departments a, job_history b
WHERE a.department_id = b.department_id (+) ; --31��

--2) right outer join
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM  job_history b, departments a
WHERE b.department_id (+) = a.department_id ; --31��

--1,2���� ��� ����

--3) left outer join : job_history���̺� ��ġ���� �ʴ� �μ��� �������� �ʴ´�.
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM  job_history b, departments a
WHERE b.department_id = a.department_id (+) ; --10��

--4) inner join
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM  job_history b, departments a
WHERE b.department_id = a.department_id ; --10��

--3,4���� ��� ����

--FULL OUTER JOIN : ORACLE�� �������δ� FULL OUTER JOIN ������ �ȵȴ�. 
--  -> ANSI JOIN(FULL OUTER JOIN)���� ����ؾߵ�.
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM  job_history b, departments a
WHERE b.department_id(+) = a.department_id(+);


--ANSI OUTER JOIN(FULL OUTER JOIN)��ȯ�۾�

--1) left outer join
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM  departments a LEFT OUTER JOIN job_history b
ON a.department_id = b.department_id; --31��

--2) right outer join
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM  job_history b RIGHT OUTER JOIN departments a
ON b.department_id = a.department_id; --31��

--3) FULL OUTER JOIN
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM  job_history b FULL OUTER JOIN departments a
ON b.department_id = a.department_id; --31��



--���̺� 3�� ���� (ansi ����)
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

--JOIN������ �з��� �״� �߿����� �ʰ� INNER JOIN, OUTER JOIN���� �Ǵ��ϴ°� �߿�.

--���� ����
--���� ����(SEMI-JOIN)�� ���� ������ ����� ���� ������ �����ϴ� �����͸� ���� �������� �����ϴ� ���� ������� IN�� EXISTS �����ڸ� ����� ����
--�� ���������� �˾ƾߵ�.

--���� ���� : ���̺� ���� �����ѵ�, ������ ���̺��� ��Ī�� �ξ� ���� ���ϴ� ���
--������ ������ �� �� �ֵ���, ���� ����(SELF-JOIN)�� ���� �ٸ� �� ���̺��� �ƴ� ������ �� ���̺��� ����� �����ϴ� ����� ���Ѵ�.

--��� ���̺��� �μ��ڵ尡 20�� ����� ����϶�.
SELECT employee_id, EMP_NAME, department_id
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 20;

--EMPLOYEE_ID EMP_NAME                  DEPARTMENT_ID
------------- ------------------------- -------------
--        201 Michael Hartstein         20
--        202 Pat Fay                   20
--���� ���������� ��µǴ� �����͸� ���������� �����Ͽ�, ����ϰ��� �� �� SELF JOIN�� ���

SELECT a.employee_id, a.emp_name, b.employee_id, b.emp_name, a.department_id
FROM employees a, employees b
WHERE a.employee_id < b.employee_id --......��
AND a.department_id = b.department_id
AND a.department_id = 20;

--EMPLOYEE_ID EMP_NAME            EMPLOYEE_ID  EMP_NAME  DEPARTMENT_ID
------------- ------------------- ------------ --------- --------------
--201         Michael Hartstein   202          Pat Fay   20

--īŸ�þ� ����(����Ŭ)�� CROSS JOIN(ANSI)�� ������ �ǹ��̴�.
--īŸ�þ� ���� : ������������ �������
--īŸ�þ� ����(CATASIAN PRODUCT)�� WHERE ���� ���� ������ ���� ������ ���Ѵ�. 
--�� FROM ���� ���̺��� ���������, �� ���̺� �� ���� ������ ���� �����̴�. 
--a,B,C,D�� 1,2,3,4�� �����Ͱ� ���� �� īŸ�þ� ������ ����ϸ� 
--A(1,2,3,4), B(1,2,3,4), C(1,2,3,4), D(1,2,3,4) �� 16�� ���� ���´�. 
--Where�� : �������ǽ��� ����.
--2889�� : employee 107�� * department27��
--īŸ�þ� ����
SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
FROM employees a, departments b;

--CROSS ����
--�տ��� WHERE ���� ���� ������ ������� ���� īŸ�þ� ������ �־���. �̸� ANSI ���ο����� CROSS �����̶�� �Ѵ�.
SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
FROM employees a CROSS JOIN departments b;


--������ ���� �ϴ� ���
--USING�� ����ϸ鼭 b.department_id�� ��Ī�� ����ؼ� ������ �߻�.
SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
FROM employees a INNER JOIN departments b
USING (department_id) --ON a.department_id = b.department_id
WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');

--SQL ����: ORA-25154: USING ���� �� �κ��� �ĺ��ڸ� ���� �� ����.

--<�� �� ���>
--USING�� ����ϰ� ������ department_id�� �÷��� ��Ī�� �����Ǿ�� �Ѵ�.
SELECT a.employee_id, a.emp_name, department_id, b.department_name
FROM employees a INNER JOIN departments b
USING (department_id)
WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');

--ON�� ����ϰ� ��Ī�� ������� �ʾ� �����߻�.
SELECT a.employee_id, a.emp_name, department_id, b.department_name
FROM employees a INNER JOIN departments b
ON a.department_id = b.department_id
WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');

--USING�� ������� �ʰ� ON�� ������� ���� b.department_idó�� ��Ī ��� �ʼ�.
SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
FROM employees a INNER JOIN departments b
ON a.department_id = b.department_id
WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');

--�� ���̺� �� ���� ���ǿ� ���Ǵ� �÷����� ������ ��찡 ���� ������ �ٸ� ���� �����Ƿ�, 
--USING ��� ON ���� ����ϴ� ���� �Ϲ����̴�.
--�ܺ� ������ OUTER��� Ű���带 ���̴µ�, �̴� ������ �����ϴ�. 
--�� LEFT JOIN Ȥ�� RIGHT JOIN�̶�� ����ص� �̴� �ܺ� ������ �ǹ��Ѵ�.

/*
04 | ���� ����
���� ����Sub-Query �� �� SQL ���� �ȿ��� ������ ���Ǵ� �� �ٸ� SELECT���� �ǹ��Ѵ�. 
���� ����� ����ϴ� ������ ���� ������� �Ѵٸ�, 
�̸� ���� �߰� �ܰ� Ȥ�� ���� ������ �ϴ� SELECT���� ���� ������ �Ѵ�. 
���� ������ �Ұ��ߴ� SQL�� �� ��ȣ �ȿ� ����ִ� SELECT���� �ٷ� ���� ������ ���Ѵ�. 
�ϳ��� SQL���� �������� ���� ������ ������ ������ ��� SELECT���� ���� ������ ���� �Ǹ�, 
���� ���� ������ ���� ���� ����� �� �ִ�.

���� ������ �پ��� ���·� ���ȴ�. 
�� SELECT, FROM, WHERE �� ��ο��� ����� �� ���� �Ӹ� �ƴ϶�, 
INSERT, UPDATE, MERGE, DELETE �������� ����� �� �ִ�. 
���� ������ �� Ư���� ���¿� ���� ������ ���� ������ �� �ִ�.

���� �������� �������� ����

������ ����(Noncorrelated) ���� ����
������ �ִ� ���� ����
���¿� ����

�Ϲ� ���� ����(SELECT ��)
�ζ��� ��(FROM ��)
��ø ����(WHERE ��)
*/

--������ ���� ���� ����
--Ư¡ : ���������� ������ ���� �ʰ�, �ܵ����ε� ������ �����ϴ� (������ �߻����� �ʴ´�.)
--���� �������� �������� ���� ���� ������ ���Ѵ�. 
--�� ���� ���̺�� ���� ������ �ɸ��� �ʴ� ���� ������ ����Ų��.

--�� ����� ��� �޿� �̻��� �޴� ��� ���� ��ȸ�ϴ� ������

--1) ����� ��� �޿�
SELECT AVG(salary) FROM employees; --6461.831775700934579439252336448598130841

--���� 1 : ���������� ������ ��ȯ
--�������� : ���� SELECT, �������� : ���� SELECT
SELECT * FROM employees
WHERE SALARY >=(SELECT AVG(salary) FROM employees);

SELECT count(*)
FROM employees
WHERE salary >=  ( SELECT AVG(salary)
FROM employees );

--���� 2 
--���������� ����� �������� ��쿡�� IN Ű���� ���,
--���������� ����� �ϳ��� ��츸 ��ȣ �Ǵ� �ε�ȣ ������ ����� �����ϴ�.
--�μ� ���̺��� parent_id�� NULL�� �μ���ȣ�� ���� ����� �� �Ǽ��� ��ȯ�ϴ� ����

--�μ� ���̺��� parent_id�� NULL�� �μ���ȣ
SELECT department_id FROM departments
WHERE parent_id IS NULL;

SELECT count(*)
FROM employees
WHERE department_id IN ( SELECT department_id
                         FROM departments
                         WHERE parent_id IS NULL);

--���������� ����� �ϳ��� ��츸 ��ȣ �Ǵ� �ε�ȣ ������ ����� �����ϴ�.
SELECT count(*)
FROM employees
WHERE department_id = ( SELECT department_id
                         FROM departments
                         WHERE parent_id IS NULL);

SELECT count(*)
FROM employees
WHERE department_id = (10,20,30); --��ȣ, �ε�ȣ�� �������� ������� �񱳺Ұ���, �����߻�

SELECT count(*)
FROM employees
WHERE department_id IN (10,20,30); --�������� ������� �񱳰���, �����۵�

--���� 3 

SELECT employee_id, emp_name, job_id FROM employees
       WHERE (employee_id, job_id) IN (SELECT employee_id, job_id FROM job_history);

--�ȵ�
CREATE TABLE t1(
    COL1 NUMBER PRIMARY KEY
    COL2 VARCHAR2(10) PRIMARY KEY   
);

--����Ű�� ���� ����
CREATE TABLE t1(
    COL1 NUMBER 
    COL2 VARCHAR2(10) 
    PRIMARY KEY(COL1, COL2)
);



--������ �ִ� ���� ����
--���� �������� �������� �ִ� ���� ����, �� ���� ���̺�� ���� ������ �ɸ� ���� ������ ���Ѵ�.
--���� ���� : ������������ ����ϴ� �÷����� �������� ���̺��� �÷����� �����ϰ� �ִ� ����.
SELECT a.department_id, a.department_name
FROM departments a
WHERE EXISTS (SELECT 1
              FROM job_history b
              WHERE a.department_id = b.department_id);

--EXISTS()�Լ� ����
--()�ȿ� ����� �����ϸ� TRUE�� ������ ���ش�. �������� ������ FALSE�� ��ȯ�Ѵ�. 
SELECT 1 FROM DUAL WHERE 1 = 0; -- ���ǽ��� FALSE�� ��쿡�� 1�� ������������ ��� �ȵ�
SELECT 1 FROM DUAL WHERE 1 != 0; -- ���ǽ��� TURE �� ��쿡�� 1�� ������������ ��µ�

--EXISTS�Լ��� ������������  �����Ͱ� �������� �ʾ� FALSE ó���� �ǰ�, ��°���� ����
SELECT * FROM DEPARTMENTS WHERE EXISTS(SELECT 1 FROM DUAL WHERE 1 = 0); 
--EXISTS�Լ��� ������������  �����Ͱ� �������� �ʾ� TRUE ó���� �ǰ�, ��°���� �ִ�
SELECT * FROM DEPARTMENTS WHERE EXISTS(SELECT 1 FROM DUAL WHERE 1 != 0);

--�Ʒ� �������� �ִ� ��������.
--WHERE������ ���
SELECT a.department_id, a.department_name
FROM departments a --27��
WHERE EXISTS (SELECT 1
              FROM job_history b
              WHERE a.department_id = b.department_id); --6��, �ߺ��� department_id �÷��� �����Ͱ� ���ŵ�
/*
���
DEPARTMENT_ID DEPARTMENT_NAME 
------------- ----------------
           20 ������
           50 ��ۺ�
           60 IT
           80 ������
           90 ��ȹ��
          110 �渮�� 
*/

--���ۼ���
SELECT department_id FROM departments; --27��

SELECT department_id FROM job_history; --10��
/*
���������� departments ���̺��� 27�� �����Ͱ� �ϳ��� 
1) �������� WHERE a.department_id = b.department_id ��ġ�� �Ǹ� 1�� �����ͷ� ��µǰ�,
EXISTS �Լ��� TRUE�� �Ǿ�, ��ġ�Ǵ� a.department_id�� ���� ������ ��ȯ�ȴ�.

2) �������� WHERE a.department_id = b.department_id ��ġ���� ������ 1�� �����ͷ� ����� ���� �ʰ�
EXISTS �Լ��� FALSE�� �Ǿ�, ��ġ���� �ʴ� a.department_id�� ���������� ��ȯ���� �ʴ´�.

����� ���������� ��ȯ�� ������ ���� �÷����� a.department_id, a.department_name�� ����� �ȴ�.
*/

--������ �ִ� ���������� �������� ��ȯ
SELECT a.department_id, a.department_name
FROM departments a --27��
WHERE EXISTS (SELECT 1
              FROM job_history b
              WHERE a.department_id = b.department_id); --6��, �ߺ��� ������ ���� ���ŵ�.
    
--JOIN��������           
SELECT a.department_id, a.department_name
FROM departments a, job_history b
WHERE a.department_id = b.department_id; --10�� ���, �ߺ��� ���������� ���žȵ�.

--DISTINCT
SELECT DISTINCT a.department_id, a.department_name
FROM departments a, job_history b
WHERE a.department_id = b.department_id; --6�� ���

/*************************************************************/
--SELECT ������ ���
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

--���ۼ���
/*
job_history���̺��� 10���� �����Ͱ� �ϳ��� ���������� ���ǽĿ��� WHERE a.employee_id = b.employee_id�� �񱳵Ǿ� ��ġ�ϸ�, ��ȯ�� �ǰ�
��ġ���� ������ ������������ ��������.
�����Ǵ� �����͸� �������� SELECT���� a.employee_id,  a.department_id ���⼭ ��µȴ�.
*/

--�ζ��� �� : ������ ���� ���� ����� 
--FROM ���� ����ϴ� ���� ������ �ζ��� ��InlineView ��� �Ѵ�. 
--���� FROM ������ ���̺��̳� �䰡 ���µ�, ���� ������ FROM ���� ����� �ϳ��� ���̺��̳� ��ó�� ����� �� �ִ�. 
--�並 ��ü�ϸ� �ϳ��� �������� SELECT���̹Ƿ� FROM ���� ����ϴ� ���� ������ �ϳ��� ��� �� �� �־ �ζ��� ���� �̸��� ���� ���̴�.

--SELECT * FROM ���̺�� �Ǵ� ��� ;
--SELECT * FROM (������ ���� ��������) -> �ζ��κ�

--���� 1
SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
FROM employees a, departments b,
           (SELECT AVG(c.salary) AS avg_salary
            FROM departments b, employees c
            WHERE b.parent_id = 90  -- ��ȹ��
            AND b.department_id = c.department_id) d
WHERE a.department_id = b.department_id
AND a.salary > d.avg_salary;

--employees a -> SELECT * FROM employees;�� A�� ��Ī
--departments b -> SELECT * FROM departments;�� B�� ��Ī

--���� 2
--SELECT a.* FROM 
--(SELECT a.sales_month, ROUND(AVG(a.amount_sold)) 
-- AS month_avg
-- FROM sales a, customers b, countries c
-- WHERE a.sales_month BETWEEN '200001' AND '200012'
-- AND a.cust_id = b.CUST_ID
-- AND b.COUNTRY_ID = c.COUNTRY_ID
-- AND c.COUNTRY_NAME = 'Italy' -- ��Ż����
-- GROUP BY a.sales_month)a,
-- (SELECT ROUND(AVG(a.amount_sold)) AS year_avg
--  FROM sales a, customers b, countries c
--  WHERE a.sales_month BETWEEN '200001' AND '200012'
--  AND a.cust_id = b.CUST_ID
--  AND b.COUNTRY_ID = c.COUNTRY_ID
--  AND c.COUNTRY_NAME = 'Italy' -- ��Ż����
--  ) b
--WHERE a.month_avg > b.year_avg ;

--������ ������ �ۼ��ؾ� �� ��, ��� �ؾ� �ұ�?
--������ ����. ������ ������ �ִ� ���� �̻��ϴ�. 
--��ȸ ��� ���̺�� �÷�, ���ϴ� ����� ���� ���� ��� �ٸ��� �����̴�. 
--������ ������ Ǯ �� ����ϴ� ����� �ִµ�, �ٷ� �������ؼ� �����϶�(Divide & Conquer)�� �̴�. 
--������ ������ �ۼ��� ������ ���� ������ ������ ��, �ٽ� ��ġ�� �ǿܷ� ������ �ذ��� �� �ִ�. 

--(1) ���������� ��ȸ�Ǵ� ��� �׸��� �����Ѵ�.
--(2) �ʿ��� ���̺�� �÷��� �ľ��Ѵ�.
--(3) ���� ������ �����ؼ� ������ �ۼ��Ѵ�.
--(4) ������ ������ ������ �ϳ��� ���� ���� ����� �����Ѵ�.
--(5) ����� �����Ѵ�.
















