--7�� ������ ���� ����� ������ ���� ��� ���� �ٷ��
--01 | ������ ����
--������ ����
--������ ����HierarchicalQuery �� 2���� ������ ���̺� ����� �����͸� ������ ������ ����� ��ȯ�ϴ� ������ ���Ѵ�. 
--������ ������ ���� ���� ������ ������ 
--���-�븮-����-����� ���� ����, 
--�Ǹź�-������ ���� �μ� ����, 
--������ �а�, 
--���� ��ó ���� 
--������ ������ ���Ѵ�. 
--���� ������ ���� ���α׷��� �޴� ����, �亯�� �Խ��ǻӸ� �ƴ϶� �� å�� ������ �̿� ���Եȴ�. 
--���� ���, �μ� ���̺� �ִ� �μ� ������ ������ ���� ����-���� �μ��� ���� �� �ִ�.

--������ ������ ��¸������� �ۼ��� �ڵ�
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

--������ ���� ����

--    SELECT expr1, expr2, ...
--    FROM ���̺�
--    WHERE ����
--    START WITH[�ֻ��� ����]
--    CONNECT BY [NOCYCLE][PRIOR ������ ���� ����];

--DEPARTMENTS(�μ�)���̺��� ������ ���������� ����϶�.
--�ֻ��� �μ� �Ѻα�ȹ�� ������ ���� �μ� ������ ����� ����
--LPAD(' ' , 3 * (LEVEL-1)) || : ����
SELECT LEVEL, department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id = parent_id; --������ �Ʒ���(TOP DOWN) PRIOR Ű���带 �ڽ��÷��� ����


--����/����θ� �������� ���� �μ��� ����϶�.
SELECT department_id, Department_Name
FROM departments
START WITH department_id = 30
CONNECT BY department_id = PRIOR parent_id; -- �Ʒ����� ����(BOTTOM UP) PRIOR Ű���带 �θ��÷��� ����

--�� ������ ���� ����
--������ ������ ������ ������ �°� ������� ��µǴµ� ORDER BY ���� �� ������ ������ �� �ִ�.
--�׷��� ORDER BY ���� ����ϸ� �ȵȴ�.
SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id  = parent_id
ORDER BY department_name; -- : ������ ���� �μ����� ��� ������ ����Ǿ�, ������ ���� ��±����� ������ ����.


SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id  = parent_id
ORDER BY LEVEL; 

-- ������ ������ ���� ������ ���� �ִ�.
--�μ������� ���ĵʰ� ���ÿ� ������ �������� �����Ϸ��� ORDER SIBLINGS BY ���� ����ؾ� �Ѵ�.
SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id  = parent_id
ORDER SIBLINGS BY department_name; --������ ���� ���� �ο쿡 ���ؼ� ����

--�� CONNECT_BY_ROOT
--CONNECT_BY_ROOT�� ������ �������� �ֻ��� �ο츦 ��ȯ�ϴ� �����ڴ�. 
--�������̹Ƿ� CONNECT_BY_ROOT �������� ǥ������ �´�.

SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL,
CONNECT_BY_ROOT department_name AS root_name
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id  = parent_id;

--�� CONNECT_BY_ISLEAF
--CONNECT_BY_ISLEAF�� CONNECT BY ���ǿ� ���ǵ� ���迡 ���� �ش� �ο찡 
--������ �ڽ� �ο��̸� 1��, �׷��� ������ 0�� ��ȯ�ϴ� �ǻ� �÷��̴�.
--��, �ؿ� �ƹ��� ������ 1, ������ 0�̴�.

SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL, CONNECT_BY_ISLEAF
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id  = parent_id;

--�� SYS_CONNECT_BY_PATH (colm, char)
--SYS_CONNECT_BY_PATH�� ������ ���������� ����� �� �ִ� �Լ���, 
--��Ʈ ��忡�� ������ �ڽ��� ����� ����� ��� ������ ��ȯ�Ѵ�. 
--�� �Լ��� ù ��° �Ķ���ͷδ� �÷���, �� ��° �Ķ������ char�� �÷� �� �����ڸ� �ǹ��Ѵ�. 
--�μ��� ���� ��θ� �����ش�.

SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL,
SYS_CONNECT_BY_PATH( department_name, '|')
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id  = parent_id;

--�� ��° �Ű������� �����ڷ� �ش� �÷� ���� ���Ե� ���ڴ� ����� �� ���ٴ� ���� �����ؾ� �Ѵ�. 
--�� �������� ����/����δ� ��/�����ڰ� ���� �ִµ�, �����ڷ� ��/���� ����ϸ� ������ ���� ������ �߻��Ѵ�.

--����/������� '/'���� ���� ������ �߻�.

SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL,
SYS_CONNECT_BY_PATH( department_name, '/')
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id  = parent_id;


--�� CONNECT_BY_ISCYCLE
--��ġë������ �𸣰����� ����Ŭ�� ������ ������ ����(�ݺ�) �˰����� ����Ѵ�. 
--������ ������ ������ ���̺� �ִ� �����Ϳ� ���� �������� ����ǹǷ�, 
--���������δ� ������ ���� �ڽ� ��带 ã�ư���. 
--���� �˰��򿡼� ������ ���� ������ �߸� �ָ� ���ѷ����� Ÿ�� �ȴٴ� ���ε�, 
--������ ���������� �θ�-�ڽ� ���� ���踦 �����ϴ� ���� �߸� �ԷµǸ� ���ѷ����� Ÿ�� ������ �߻��Ѵ�.

--���� ���, ������(170)�� �θ� �μ��� ����/�����(30)�ε�, 
--����/������� parent_id ���� ����η� �ٲٸ� 
--�� �μ��� ��ȣ ������ �Ǿ� ���ѷ����� �߻��� ���̴�.

UPDATE departments
SET parent_id = 170
WHERE department_id = 30;

SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL,
parent_id
FROM departments
START WITH department_id = 30
CONNECT BY PRIOR department_id  = parent_id;
--SQL ����: ORA-01436: CONNECT BY�� ������ �߻��Ǿ����ϴ�.


--�μ��� �����μ� ���� �߸� �ԷµǾ�, ���� �߻� �� �ذ��ϱ� ���� ����

SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name AS depname, LEVEL,
CONNECT_BY_ISCYCLE IsLoop,
           parent_id
FROM departments
START WITH department_id = 30
CONNECT BY NOCYCLE PRIOR department_id  = parent_id;

ROLLBACK; -- ����/������� parent_id ���� ����η� ������ update���� ���.



--03 | �м� �Լ��� window �Լ�
--�м� �Լ�AnalyticFunction �� ���̺� �ִ� �ο쿡 ���� Ư�� �׷캰�� ���� ���� ������ �� ���ȴ�. 
--���� ���� ���� �� ������ �׷� ������ ����ϴµ�, �̶� GROUP BY ���� ���� ���� ���� ����� �׷캰�� �ο� ���� �پ���. 
--�̿� ����, ���� �Լ��� ����ϸ� �ο��� �ս� ���̵� �׷캰 ���� ���� ������ �� �� �ִ�. 
--�м� �Լ����� ����ϴ� �ο캰 �׷��� ������(window)��� �θ��µ�, �̴� ���� �� ����� ���� �ο��� ������ �����ϴ� ������ �Ѵ�.
--�׷� ���ݺ��� �м� �Լ��� ���� �ڼ��� �˾ƺ���. �м� �Լ� ������ ������ ����.

�м� �Լ�(�Ű�����) OVER
       ������(PARTITION BY expr1, expr2,...
                  ORDER BY expr3, expr4...
                window ��)

--�м� �Լ�
--�� ROW_NUMBER( )
--ROW_NUMBER�� ROWNUM �ǻ� �÷��� ����� ����� �ϴµ�, 
--��Ƽ������ ���ҵ� �׷캰�� �� �ο쿡 ���� ������ ��ȯ�ϴ� �Լ���. 
--��� ���̺��� �μ��� ������� �ο� ���� ����� ����.

ROWNUM �ǻ��÷�
SELECT ROWNUM, emp_name, email FROM employees;

SELECT ROWNUM, emp_name, email FROM employees WHERE rownum<=5;

--�߰� ������ ���� ����� �� ����.
SELECT ROWNUM, emp_name, email FROM employees WHERE ROWNUM >=5 AND ROWNUM <=10;

--group by ����
--��� ���̺��� �μ��� ������� �ο� �� 
SELECT count(*) from employees group by department_id;

--PARTITION BY �μ��� ���� �����ͺ��� �з��� �ϰڴ�.
SELECT department_id, emp_name, 
ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY emp_name) dep_rows
FROM employees;

-- �ؼ� ����
-- 1)(PARTITION BY department_id ORDER BY emp_name): emp_name�� �̸����� ��Ƽ���� ������.
-- 2)ROW_NUMBER() ��ȣ �ο�
-- 3) SELECT department_id, emp_name, FROM employees;�� ������ �ȴ�.

--ROW_NUMBER �Լ���??
--  �� PARTITION ������ ORDER BY���� ���� ���ĵ� ������ �������� ������ ���� ��ȯ�ϴ� �Լ��Դϴ�.?
-- ?������ �Լ�(Window Funtion)�� �׷� �� ����?�Լ��Դϴ�.

--����ROW_NUMBER() OVER(PARTITION BY [�׷����� �÷�] ORDER BY [������ �÷�])
--  PARTITION BY�� ����, ORDER BY�� �ʼ�


--�� RANK( ), DENSE_RANK( ) : ��Ƽ�Ǻ��� ������ �ű�� �Լ�
--Rank �Լ��� ��Ƽ�Ǻ� ������ ��ȯ�Ѵ�. �μ����� �޿� ������ �Ű� ����.

SELECT department_id, emp_name, salary,
RANK() OVER (PARTITION BY department_id ORDER BY salary) dep_rank
FROM employees;

--�� �μ��� ������� �޿� ������ ����϶�.
SELECT department_id, emp_name, salary,
RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) dep_rank
FROM employees;
--�� ����� ���� ����
--50�� �μ����� ������ �޿��� �޴� ����� ������ ������ ��ȯ�ƴµ� (2��) 
--�� ���� ������ �� �� �ǳʶپ�(4��) �Ű����ٴ� ���� ��������.
--���� 2���� 3���̶�� ���� ������ 5���� �� ���̴�.

--DENSE_RANK �Լ��� RANK�� ��������� ���� ������ ������ ���� ������ �� �� �ǳʶ��� �ʰ� �Ű�����.
SELECT department_id, emp_name, salary,
DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary ) dep_rank
FROM employees;
-- 50�� �μ����� ���� ������ 2�� ���� ������ 4���� �ƴ� 3���� ��ȯ������ Ȯ���� �� �ִ�.

--TOP n ���� - ž������
--�м� �Լ��� ���� �о߰� �ſ� ����. 
--���� ���, Ư�� ���ǿ� �´� ���� Ȥ�� ���� n���� �����͸� �����ϴ� TOP n ������ ���� �ۼ��� �� �ִ�. 
--�� �μ����� �޿��� ���� 3�������� ����� �����ϴ� ������ �ۼ��� ����.

SELECT department_id, emp_name, salary,
DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary desc) dep_rank
FROM employees

--�� select���� from ������ ����Ѵ�.(�ζ��� ��)

SELECT * FROM (SELECT department_id, emp_name, salary,
DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary desc) dep_rank
FROM employees)
WHERE dep_rank <= 3;

--04 | ���� ���̺� INSERT
--���������� �˾� �� ���� ���̺� INSERT ������ �� �ϳ��� INSERT �������� 
--���� ���� INSERT ���� �����ϴ� ȿ���� �� �� ���� �Ӹ� 
--�ƴ϶� Ư�� ���ǿ� �´� �����͸� Ư�� ���̺� �Էµǰ� �� �� �ִ� �����̴�. 

--���� ���� ���̺� INSERT ���� ������ ���� ����.

    INSERT ALL| FIRST
    WHEN ����1 THEN
    ��INTO [��Ű��.]���̺��(�÷�1, �÷�2, ...) VALUES(��1, ��2, ...)
    WHEN ����2 THEN
    ��INTO [��Ű��.]���̺��(�÷�1, �÷�2, ...) VALUES(��1, ��2, ...)
        ...
     ELSE
    �� INTO [��Ű��.]���̺��(�÷�1, �÷�2, ...) VALUES(��1, ��2, ...)
    SELECT ��;

--? ALL: ����Ʈ ������ ���� WHEN �������� ������� �� �� ������ ������ INSERT�� ��� �����϶�� �ǹ̴�.

--? FIRST: ���� WHEN �� ���ǽĿ� ���� INSERT���� ������ ��, 
--���� ������ ��ȯ�� �ο쿡 ���� ������ ���� WHEN ���� ������ 
--�ش� INSERT���� �����ϰ� �������� ���ؼ��� ���� �򰡸� ���� �ʰ� ������.

--? WHEN ���� THEN �� ELSE: Ư�� ���ǿ� ���� INSERT�� ������ �� �ش� ������ ���.

--? SELECT ��: ���� ���̺� INSERT ���������� �ݵ�� ���� ������ ���ݵǾ�� �ϸ�, 
--���� ������ ����� ���ǿ� ���� ���� �����͸� INSERT �Ѵ�.

CREATE TABLE ex7_3 (
emp_id    NUMBER,
emp_name  VARCHAR2(100));

CREATE TABLE ex7_4 (
emp_id    NUMBER,
emp_name  VARCHAR2(100));

INSERT INTO ex7_3 VALUES (101, 'ȫ�浿');
INSERT INTO ex7_3 VALUES (102, '������');

--���� 1
INSERT ALL
    INTO ex7_3 VALUES (103, '������')
    INTO ex7_3 VALUES ('104', '�����ҹ�')
SELECT * FROM DUAL;

select * from ex7_3;

rollback;

--���� 2
INSERT ALL INTO ex7_3 VALUES (emp_id, emp_name)
SELECT 103 emp_id, '������' emp_name FROM DUAL
UNION ALL
SELECT 104 emp_id, '�����ҹ�' emp_name FROM DUAL;

--���� 3
INSERT ALL 
INTO ex7_3 VALUES (105, '������')
INTO ex7_4 VALUES (105, '������')
SELECT * FROM DUAL;

select * from ex7_3;
select * from ex7_4;

--���ǿ� ���� ���� INSERT
TRUNCATE TABLE ex7_3;

TRUNCATE TABLE ex7_4;

INSERT ALL
    WHEN department_id = 30 THEN
    INTO ex7_3 VALUES (employee_id, emp_name)
    WHEN department_id = 90 THEN
    INTO ex7_4 VALUES (employee_id, emp_name)
    SELECT department_id, employee_id, emp_name FROM employees;
/*
SELECT department_id, employee_id, emp_name FROM employees;: ����� ����� ���Ե����ͷ� ���
department_id �μ��÷��� �����Ͱ� 30�̸� ex7_3 ���̺� ������ ����
department_id �μ��÷��� �����Ͱ� 90�̸� ex7_4 ���̺� ������ ����
�� �μ��÷��� 30�� ex7_3�� ���� �ְ�, 90�� ex7_4�� ���� �ִ´�.
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

select * from ex7_3; --�μ��� 30�� ������ �� 6��
select * from ex7_4; --�μ��� 90�� ������ �� 3��
select * from ex7_5; --�μ��� 30, 90�� ������ �� 98��

--INSERT FIRST
--���������� �˾� �� ������ INSERT ALL ��� INSERT FIRST�� ����ϴ� ����
--ALL�� FIRST�� �������� �ԷµǴ� ��� �ο츦 �������� WHEN ���ǿ� ������ ó���ϴ� ��Ŀ� �ִ�. 
--���� FIRST�� ����ߴٸ� ù ��°�� ���� ���� TRUE�� �� �� �ش� �ο찡 �Էµǰ� ������. 
--���� �� ���� WHEN ���� ����� TRUE�� �Ǵ��� �̹� ���� �ܰ迡�� �Է��� �����Ƿ� �� �ο�� �߰��� �Էµ��� �ʴ´�. 

TRUNCATE TABLE ex7_3;
TRUNCATE TABLE ex7_4;

--1�� insert all
INSERT ALL
    WHEN employee_id < 116 THEN
    INTO ex7_3 VALUES (employee_id, emp_name)
    WHEN salary < 5000 THEN
    INTO ex7_4 VALUES (employee_id, emp_name)
    SELECT department_id, employee_id, emp_name,  salary FROM employees WHERE department_id = 30;

select * from ex7_3;
select * from ex7_4;

--2�� insert first : 
--115���� �����Ͱ� WHEN employee_id < 116 then���� ture�� �Ǿ�
---- �����Ͱ� ex7-3 ������ ������ �ǰ�, 
--when salary < 5000 then �������� 115�� �����Ͱ� ������ �Ǵ��� ���Ե��� �ʴ´�.
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
















































































































