--5�� �׷� ������ ���� ������ �˾� ����
--�⺻ ���� �Լ�
--4�忡�� SQL �Լ��� ���� �˾ƺôµ� �̹� ������ ���캼 ���� �Լ��� SQL �Լ��� �����̴�. 
--�����Լ��� ��� �����͸� Ư�� �׷����� ���� ���� �� �׷쿡 ���� ����, ���, �ִ�, �ּڰ� ���� ���ϴ� �Լ��� ���Ѵ�. 
--�׷� ��ǥ���� ���� �Լ��� ���� �ϳ��� ���� ����.

--�� COUNT (expr)
--COUNT�� ���� ��� �Ǽ�, �� ��ü �ο� ���� ��ȯ�ϴ� ���� �Լ���. ���̺� ��ü �ο�� ���� WHERE �������� �ɷ��� �ο� ���� ��ȯ�Ѵ�.

--������̺��� ������ ���
SELECT COUNT(*) FROM employees;

--�μ����̺��� ������ ���
SELECT COUNT(*) FROM Departments;

-- * ��� �÷����� ����� �� �ִ�.
--NULL�� �ƴ� �ǿ� ���ؼ��� �ο��� ���� ��ȯ   
SELECT COUNT(employee_id) FROM employees; --107��
SELECT COUNT(department_id) FROM employees; --106��, �μ��÷����� null������ 1���� �����ϰ� ī��Ʈ�Լ��� ����� �Ǿ���.

--�ߺ��� ������ ����, ������̺� �����ϴ� �μ��ڵ��� ���� Ȯ��.
SELECT DISTINCT department_id FROM employees ORDER BY 1; --12��
SELECT COUNT(DISTINCT department_id) FROM employees ORDER BY 1; --11��

--�� SUM(expr)
--SUM�� expr�� ��ü �հ踦 ��ȯ�ϴ� �Լ��� �Ű����� expr���� �������� �� �� �ִ�.
--��� ���̺��� �޿��� �������̹Ƿ� �� ����� �޿� �Ѿ��� ���� ����.
--�ѱ޿��� ��ȸ.
SELECT SUM(salary) FROM employees;

--SUM �Լ� ���� expr �տ� DISTINCT�� �� �� �ִµ�, �̶� ���� �ߺ��� �޿��� 1���� ������ ��ü �հ踦 ��ȯ�Ѵ�.
SELECT SUM(salary), SUM(DISTINCT salary) FROM employees;

--�� AVG(expr)
--AVG�� �Ű����� ���³� ���ӻ��� COUNT, SUM�� �����ϸ� ��հ��� ��ȯ�Ѵ�.
SELECT AVG(salary), AVG(DISTINCT salary) FROM employees;

--MIN(expr), MAX(expr)
--MIN�� MAX�� ���� �ּڰ��� �ִ��� ��ȯ�Ѵ�.
SELECT MIN(salary), MAX( salary) FROM employees;

--MIN, MAX �Լ������� DISTINCT�� ����� ���� ������, 
--���� �ּڰ��� �ִ��� ��ȯ�ϹǷ� ���� DISTINCT�� ����� �ʿ�� ����.
SELECT MIN(DISTINCT salary), MAX(DISTINCT salary) FROM employees;

--�� VARIANCE(expr), STDDEV(expr)
--VARIANCE�� �л���, STDDEV�� ǥ�������� ���� ��ȯ�Ѵ�. 
--�л��̶� �־��� ������ ���� ���� ��հ����� ������ ������ ���� �̸� �����ؼ� ����� ���� ���ϸ�, 
--ǥ�������� �л� ���� �������̴�. �л��� ������ ����̹Ƿ�, 
--������ ��迡���� ����� �߽����� ������ ��� ���� �����ϴ����� ��Ÿ���� ��ġ�� ǥ�������� ��ǥ�� ����Ѵ�.
SELECT VARIANCE(salary), STDDEV(salary) FROM employees;

--02 | GROUP BY ���� HAVING ��
--���ݱ��� �˾ƺ� ���� �Լ��� ������ ��� ��� ��ü�� �������� �����͸� �����ߴµ�, 
--��ü�� �ƴ� Ư�� �׷����� ���� �����͸� ������ ���� �ִ�. 
--�̶� ���Ǵ� ������ �ٷ� GROUP BY ���̴�. 
--�׷����� ���� �÷����̳� ǥ������ GROUP BY ���� ����ؼ� ����ϸ� 
--GROUP BY ������ WHERE�� ORDER BY�� ���̿� ��ġ�Ѵ�.

--���μ��� �� �޿����� ��ȸ����.
--GROUP BY��ɾ ����ϸ�, SELECT���� �÷����� ���������� ����ؾ��Ѵ�.
--GROUP BY�÷���� GROUP BY�� ���� �����Լ��� �� �� �ִ�.
SELECT department_id, 
COUNT(*) AS "�μ��̸�", SUM(salary) AS "�ѱ޿���", AVG(SALARY) AS "��ձ޿�" FROM employees 
GROUP BY department_id ORDER BY department_id;

--�ѱ� ������¸� ��ȸ
SELECT * FROM KOR_LOAN_STATUS;

--kor_loan_status ���̺��� ����, 
--������ ������� �ܾ�(������ �ʾ�)�� ��� �ְ�, 
--��������(gubun)�� �����ô㺸���⡯�� ����Ÿ���⡯ �� ������ �����Ѵ�. 
--�׷� 2013�� ������ ������� �� �ܾ��� ���� ����.
SELECT period, region, SUM(loan_jan_amt) Tot_Loan FROM kor_loan_status
WHERE PERIOD LIKE '2013%'
GROUP BY period, region
ORDER BY period, region;

--HAVING ���� GROUP BY�� ������ ��ġ�� GROUP BY�� ����� ������� �ٽ� ���͸� �Ŵ� ������ �����Ѵ�. �� HAVING ���� ���� ���·� ����Ѵ�. 
--���� ���, �� ���� ������� �����ܾ��� 100�� �̻��� �Ǹ� �����Ѵٸ� ������ ���� ������ �ۼ��ϸ� �ȴ�.
SELECT period, region, SUM(loan_jan_amt) Tot_Loan FROM kor_loan_status
WHERE period = '201311'
GROUP BY period, region
HAVING SUM(loan_jan_amt) > 100000;

--EMPLOYEES(���)���̺� ����.
--1.�� �μ��� �ִ� �޿�, �ּұ޿�, ��ձ޿��� ���϶�.
SELECT department_id, MAX(SALARY), MIN(SALARY), AVG(SALARY) 
FROM employees
GROUP BY department_id; --������ �μ��ڵ带 �׷�ȭ

SELECT department_id AS "�μ���ȣ", 
MAX(SALARY)AS "�ִ�޿�", MIN(SALARY)AS "�ּұ޿�", ROUND(AVG(SALARY),1 ) AS "��ձ޿�"
FROM employees
GROUP BY department_id --������ �μ��ڵ带 �׷�ȭ
ORDER BY department_id; 

--�� ���� �������� ��ձ޿��� ������������ ��ȸ�϶�
SELECT department_id AS "�μ���ȣ", 
MAX(SALARY)AS "�ִ�޿�", MIN(SALARY)AS "�ּұ޿�", ROUND(AVG(SALARY),1 ) AS "��ձ޿�"
FROM employees
GROUP BY department_id --������ �μ��ڵ带 �׷�ȭ
ORDER BY ROUND(AVG(SALARY),1 ); 

--�� ���� �������� ��ձ޿��� ���������� ��Ī���� ����Ͽ� ��ȸ�϶�
SELECT department_id AS "�μ���ȣ", 
MAX(SALARY)AS "�ִ�޿�", MIN(SALARY)AS "�ּұ޿�", ROUND(AVG(SALARY),1 ) AS "��ձ޿�"
FROM employees
GROUP BY department_id --������ �μ��ڵ带 �׷�ȭ
ORDER BY "��ձ޿�"; 

-- �ó����� : ������̺��� ��å��(job_id) ���� ��, �ִ�޿�, �ּұ޿�, ��ձ޿��� �Ҽ��� ù°�ڸ����� ���϶�.
SELECT Job_Id AS "��å", COUNT(*) AS "������",
MAX(salary) AS "�ִ�޿�", MIN(salary) AS "�ּұ޿�", ROUND(AVG(salary),1) AS "��ձ޿�"
FROM employees
GROUP BY Job_Id
ORDER BY "�ִ�޿�";

SELECT Job_Id AS "��å", COUNT(*) AS "������",
MAX(salary) AS "�ִ�޿�", MIN(salary) AS "�ּұ޿�", ROUND(AVG(salary),1) AS "��ձ޿�"
FROM employees
GROUP BY Job_Id
HAVING COUNT(*) > 10
ORDER BY "�ִ�޿�";

--ROLLUP ���� CUBE ��
--ROLLUP�� CUBE�� GROUP BY������ ���Ǿ� �׷캰 �Ұ踦 �߰��� ���� �ִ� ������ �Ѵ�.

--ROLLUP(expr1, expr2, ��)
--rollup�� expr�� ����� ǥ������ �������� ������ ���, �� �߰����� ���� ������ ���� �ش�. 
--ROLLUP ���� ����� �� �ִ� ǥ���Ŀ��� �׷��� ���, �� SELECT ����Ʈ���� ���� �Լ��� ������ �÷� ���� ǥ������ �� �� ������, 
--����� ǥ���� ���� ����(�����ʿ��� ���� ������)�� ���� �������� ������ ����� ��ȯ�ȴ�. 
--ǥ���� ������ n���̸� N+1 ��������, ���� �������� ���� ���� ������ �����Ͱ� ����ȴ�.

--2013�⵵ �Ⱓ(period), ����������(gubun) �� �ܾ��� ���Ѱ��̴�.
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY period, gubun
ORDER BY period;

--�� �������� 2013�� 10�� �߰��հ�, 2013�� 11�� �߰��հ�, ��ü�հ踦 �����϶�
--GROUP BY ROLLUP(period, gubun): �÷��� +1 = 3���� ���·� �����͸� ��ȸ
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY ROLLUP(period, gubun);
/*
PERIOD GUBUN                            TOTL_JAN
------ ------------------------------ ----------
201310 ��Ÿ����                           676078  ���� 3
201310 ���ô㺸����                     411415.9   ���� 3
201310                                 1087493.9 ���� 2
201311 ��Ÿ����                         681121.3  ���� 3
201311 ���ô㺸����                     414236.9   ���� 3
201311                                 1095358.2 ���� 2
                                       2182852.1 ���� 1

���� 3 : �Ұ� : GROUP BY�� ������� ���� ���� 3�� ����
���� 2 : �߰����
���� 1 : ��ü���
*/

--GROUP BY period, ROLLUP(gubun); ROLLUP�÷� ���� 1�� (1+1 = 2) 2���� ���� ������ ���
--����2(period, gubun), ���� 1(period)�̷� ���°� �ȴ�.
--��ü�հ�� ���ܵȴ�.

SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY period, ROLLUP(gubun);

--PERIOD GUBUN                            TOTL_JAN
-------- ------------------------------ ----------
--201310 ��Ÿ����                           676078  ���� 2
--201310 ���ô㺸����                     411415.9   ���� 2
--201310                                 1087493.9 ���� 1
--201311 ��Ÿ����                         681121.3  ���� 2
--201311 ���ô㺸����                     414236.9   ���� 2
--201311                                 1095358.2 ���� 1

--GROUP BY expr1, ROLLUP(expr2)
--������ 1+1=2 ���� 2���·� ���
--(expr1, expr2), (expr1)

--GROUP BY expr1, ROLLUP(expr2, expr3)�� ����ߴٸ�, 
--������ ��2+1=3�������� ������ ����� 
--(expr1, expr2, expr3), (expr1, expr2), (expr1)���� ���谡 �ǰ� ��ü �հ�� ������� �ʴ´�. 
--�̷� ������ ����(partial) ROLLUP�̶�� �Ѵ�.


--GROUP BY ROLLUP(expr1, expr2, expr3)�� ����ߴٸ�, 
--�÷��� 3+1 = 4 ��ü 4���� ���·� ���
--(expr1, expr2, expr3), (expr1, expr2), (expr1), ��ü�հ�



--CUBE(expr1, expr2, ��)
--CUBE�� ROLLUP�� ����ϳ� ������ �ణ �ٸ���. ROLLUP�� �������� ������ ���踦 �ߴٸ�, 
--CUBE�� ����� ǥ���� ������ ���� ������ ��� ���պ��� ������ ����� ��ȯ�Ѵ�. 
--CUBE�� 2��(expr ��)���� ��ŭ �������� ���� �ȴ�. 
--���� ���, expr ���� 3�̸�, ���� ����� ������ �� 2^3^ = 8���� �ȴ�.

SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY CUBE(period, gubun);

--2�� CUBE�÷��� �� = 4���� ����
--PERIOD GUBUN                            TOTL_JAN
-------- ------------------------------ ----------
--                                       2182852.1 ���� 1(��ü�հ�)
--       ��Ÿ����                        1357199.3   ���� 2-1
--       ���ô㺸����                     825652.8   ���� 2-1
--201310                                 1087493.9 ���� 2-2
--201310 ��Ÿ����                           676078   ���� 3
--201310 ���ô㺸����                     411415.9    ���� 3
--201311                                 1095358.2 ���� 2-2
--201311 ��Ÿ����                         681121.3   ���� 3
--201311 ���ô㺸����                     414236.9    ���� 3

--expr ���� 2�̹Ƿ� 2^2^ = 4�� �Ǿ� �� �� ���� �������� ���谡 �Ǵµ�, 
--�� ����� ���� ��ü(��), ����������(��), ���� (��), ���� ���� ������(��)�� �ܾ��� ����Ǿ���.
--ROLLUP�� ���������� ���� CUBE ������ ����� �� �ִ�. 
--���� ��� GROUP BY expr1, CUBE(expr2, expr3)�� ������� ��, 
--(expr1, expr2, expr3), (expr1, expr2), (expr1, expr3), (expr1) �� 4����(2^2^) �������� ����ȴ�.

SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY ROLLUP(period, gubun); --�÷��� 3+1 = 3���� (period, gubun), (period), (��ü�հ�)
--GROUP BY CUBE(period, gubun) : 2�� �÷� ���� ���� = 4���� (period, gubun), (period), (gubun), (��ü�հ�)

SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY period, CUBE( gubun ); --2�� ���� (period, gubun), (period)

--PERIOD GUBUN                            TOTL_JAN
-------- ------------------------------ ----------
--201310                                 1087493.9 (period, gubun)
--201310 ��Ÿ����                           676078   (period)
--201310 ���ô㺸����                     411415.9    (period)
--201311                                 1095358.2 (period, gubun)
--201311 ��Ÿ����                         681121.3   (period)
--201311 ���ô㺸����                     414236.9    (period)

--����(Set) �����ڴ� �̷��� ������ ������ ������� ������ �����ϴ� �����ڸ� ���ϸ�, 
--�� �����δ� UNION, UNION ALL, INTERSECT, MINUS�� �ִ�.

--UNION
--UNON�� �������� �ǹ��Ѵ�. 
--���� ���, �� ���� ������ ������ ������ �� ���� ����(SELECT ���)�� ��� ������ ����� ��ȯ�ȴ�. 

CREATE TABLE exp_goods_asia (
           country VARCHAR2(10),
           seq     NUMBER,
           goods   VARCHAR2(80));

    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 1, '�������� ������');
    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 2, '�ڵ���');
    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 3, '��������ȸ��');
    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 4, '����');
    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 5,  'LCD');
    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 6,  '�ڵ�����ǰ');
    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 7,  '�޴���ȭ');
    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 8,  'ȯ��źȭ����');
    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 9,  '�����۽ű� ���÷��� �μ�ǰ');
    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 10,  'ö �Ǵ� ���ձݰ�');

    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 1, '�ڵ���');
    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 2, '�ڵ�����ǰ');
    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 3, '��������ȸ��');
    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 4, '����');
    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 5, '�ݵ�ü������');
    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 6, 'ȭ����');
    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 7, '�������� ������');
    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 8, '�Ǽ����');
    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 9, '���̿���, Ʈ��������');
    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 10, '����');

COMMIT;

--�ѱ� ���� ǰ�� ��ȸ - 10��
SELECT goods
FROM exp_goods_asia
WHERE country = '�ѱ�'
ORDER BY seq;

--�Ϻ� ���� ǰ�� ��ȸ - 10��
SELECT goods
FROM exp_goods_asia
WHERE country = '�Ϻ�'
ORDER BY seq;

--�� 2�� ������ �ϳ��� ���ļ� ���. -15��
--UNION��ɾ�� GOODS�÷��� �ߺ��� ���� ǰ���� �ϳ��� ���Խ��� ������ش�.
SELECT goods FROM exp_goods_asia
WHERE country = '�ѱ�'
UNION
SELECT goods FROM exp_goods_asia
WHERE country = '�Ϻ�'

--�ѱ��� �Ϻ��� ��ġ�� ǰ�� ���
SELECT goods FROM exp_goods_asia
WHERE country = '�ѱ�'
UNION ALL --��� �����͸� ���
SELECT goods FROM exp_goods_asia
WHERE country = '�Ϻ�'

--INTERSECT
--INTERSECT�� �������� �ƴ� �������� �ǹ��Ѵ�. 
--�� ������ ���տ��� ����� �׸� ������ ����.
SELECT goods
FROM exp_goods_asia
WHERE country = '�ѱ�'
INTERSECT
SELECT goods
FROM exp_goods_asia
WHERE country = '�Ϻ�';

--MINUS
--MINUS�� �������� �ǹ��Ѵ�. 
--�� �� ������ ������ �������� �ٸ� ������ ���հ� ����� �׸��� ������ ����� ������ ����.
--�ѱ������Ϳ��� �Ϻ������͸� ���� �ѱ��� �����ϴ� �׸��� ���´�.
SELECT goods
FROM exp_goods_asia
WHERE country = '�ѱ�'
MINUS
SELECT goods
FROM exp_goods_asia
WHERE country = '�Ϻ�';

--�Ϻ��� �����ϴ� ǰ���� ��ȸ�϶�.
SELECT goods
FROM exp_goods_asia
WHERE country = '�Ϻ�'
MINUS
SELECT goods
FROM exp_goods_asia
WHERE country = '�ѱ�';

--���� �������� ���ѻ���
--�� ���� �����ڷ� ����Ǵ� �� SELECT���� SELECT ����Ʈ�� ������ ������Ÿ���� ��ġ�ؾ� �Ѵ�
SELECT goods
FROM exp_goods_asia
WHERE country = '�ѱ�'
UNION
SELECT seq, goods
FROM exp_goods_asia
WHERE country = '�Ϻ�';
--�� ������ �÷����� ��ġ���� �ʾ� �����߻�
--�Ʒ�ó�� �����ؾ���.
SELECT seq, goods
FROM exp_goods_asia
WHERE country = '�ѱ�'
UNION
SELECT seq, goods
FROM exp_goods_asia
WHERE country = '�Ϻ�';

--�÷��� ������ ����������, ������Ÿ���� �ٸ� ��� ���� �߻�.
SELECT seq --NUMBER ������ Ÿ��
FROM exp_goods_asia
WHERE country = '�ѱ�'
UNION
SELECT goods --VARCHAR2 ������Ÿ��
FROM exp_goods_asia
WHERE country = '�Ϻ�';

--��  ���� �����ڷ� SELECT ���� ������ �� ORDER BY���� �� ������ ���忡���� ����� �� �ִ�
SELECT goods
FROM exp_goods_asia
WHERE country = '�ѱ�'
ORDER BY goods
UNION
SELECT goods
FROM exp_goods_asia
WHERE country = '�Ϻ�';
     
--���� ������ �����ϸ� ������ ����
SELECT goods
FROM exp_goods_asia
WHERE country = '�ѱ�'
UNION
SELECT goods
FROM exp_goods_asia
WHERE country = '�Ϻ�'
ORDER BY goods;
-- ORDER BY�� ���� ������ �������� �ʴ�. ��ü�� ���� ����� �����ϴ� �ǹ̷� ���ȴ�.

--�� BLOB, CLOB, BFILE Ÿ���� �÷��� ���ؼ��� ���� �����ڸ� ����� �� ����
--�� UNION, INTERSECT, MINUS �����ڴ� LONG�� �÷����� ����� �� ����

--GROUPING SETS ��
--GROUPING SETS�� ROLLUP�̳� CUBEó�� GROUP BY ���� ����ؼ� �׷� ������ ���Ǵ� ���̴�. 
--�� �� �� �������� �Ұ��ϴ� ������ GROUPING SETS ���� �׷� �����̱� �ϳ� UNION ALL ������ ���� �ֱ� �����̴�. 
--���� ���, GROUPING SETS (expr1, expr2, expr3)�� GROUP BY ���� ������� ��, ��ȣ �ȿ� �ִ� �� ǥ���ĺ��� ���� ���谡 �̷������. 
--�� ���� ����� ((GROUP BY expr1) UNION ALL (GROUP BY expr2) UNION ALL (GROUP BY expr3)) ���°� �ȴ�.

SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY GROUPING SETS(period, gubun); --(GROUP BY period) UNION ALL (GROUP BY gubun)

SELECT period, gubun, region, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
AND region IN ('����', '���')
GROUP BY GROUPING SETS(period, (gubun, region)); --(GROUP BY period) UNION ALL (GROUP BY (gubun, region))
