/*
SQL �Լ�
01 ���� �Լ�

02 ���� �Լ�

03 ��¥ �Լ�

04 ��ȯ �Լ�

05 NULL ���� �Լ�

06 ��Ÿ �Լ�
*/


--���� �Լ��� ���� ������ �ϴ� �Լ��� ���� ��� ��, �Ű������� ��ȯ ���� ��κ� ���� ���´�.

--�� ABS(n)
--ABS �Լ��� �Ű������� ���ڸ� �޾� �� ���밪�� ��ȯ�ϴ� �Լ���.
SELECT ABS(10),ABS(-10),ABS(-10.123) FROM DUAL; 

--�� CEIL(n)�� FLOOR(n)
--CEIL �Լ��� �Ű����� n�� ���ų� ���� ū ������ ��ȯ�Ѵ�.
SELECT CEIL(10.123),CEIL(10.541),CEIL(11.001) FROM DUAL; --�ø��Լ�(11,11,12)

--FLOOR �Լ��� CEIL �Լ��ʹ� �ݴ�� �Ű����� n���� �۰ų� ���� ū ������ ��ȯ�Ѵ�.
SELECT FLOOR(10.123),FLOOR(10.541),FLOOR(11.001)FROM DUAL; --�����Լ�(10, 10, 11)

--�� ROUND(n, i)�� TRUNC(n1, n2)
--ROUND �Լ��� �Ű����� n�� �Ҽ��� ���� (i+1)�� °���� �ݿø��� ����� ��ȯ�Ѵ�. 
--i�� ������ �� �ְ� ����Ʈ ���� 0, �� �Ҽ��� ù ��° �ڸ����� �ݿø��� �Ͼ ���� �κ��� ���� �ڸ��� ����� �ݿ��ȴ�.

--�Ű����� 1���� ����� ��
SELECT ROUND(10.154),ROUND(10.541),ROUND(11.001) FROM DUAL; --�ݿø��Լ�(10, 11, 11)

--�Ű����� 2���� ����� ��, 2��° �Ű������� ���, ���� ���ο� ���� ����� �ٸ���.
/*
2��° �Ű������� ����̸�, �Ҽ��κ��� ����Ų��.
N+1�� ��ġ�� �ݿø� ���θ� ����Ѵ�.
*/
SELECT ROUND(10.154, 1),ROUND(10.154, 2),ROUND(10.154, 3) FROM DUAL; --10.2, 10.15, 10.54
--10.154���� 1��° �ڸ��� 2��° �ڸ����� �ݿø��Ͽ� ����� �ȴ�. �׷��� ���� 10.2

/*
2��° �Ű������� �����̸�, �����κ��� ����Ų��.
N�� ��ġ�� �ݿø� ���θ� ����Ѵ�.
*/
SELECT ROUND(0, 3), ROUND(115.155, -1), ROUND(115.155, -2) FROM DUAL; --0, 120, 100

--TRUNC �Լ�
--TRUNC �Լ��� �ݿø��� ���� �ʰ� n1�� �Ҽ��� ���� n2�ڸ����� ������ �߶� ����� ��ȯ�Ѵ�. 
--n2 ���� ������ �� ������ ����Ʈ ���� 0�̰�, ����� ���� �Ҽ��� �������� ������, ������ ���� �Ҽ��� ���� ���� �ڸ����� �߶󳽴�.
SELECT TRUNC(115.155), TRUNC(115.155, 1), TRUNC(115.155, 2), TRUNC(115.155, -2) FROM DUAL; --115, 115.1, 115.15, 100

--�� POWER(n2, n1)�� SQRT(n)
--POWER �Լ��� n2�� n1 ������ ����� ��ȯ�Ѵ�. 
--n1�� ������ �Ǽ� ��� �� �� �ִµ�, n2�� ������ �� n1�� ������ �� �� �ִ�.
SELECT POWER(3, 2), POWER(3, 3), POWER(3, 3.0001) FROM DUAL; --�����Լ� (9, 27, 27.00296...)

--SQRT �Լ��� n�� �������� ��ȯ�Ѵ�.
SELECT SQRT(2), SQRT(5) FROM DUAL; --��Ʈ(1.4..., 2.236...)

--�� MOD(n2, n1)�� REMAINDER(n2, n1)
--MOD �Լ��� n2�� n1���� ���� ������ ���� ��ȯ�Ѵ�.
SELECT MOD(19,4), MOD(19.123, 4.2) FROM DUAL; --�������� �� �������� ���� ���ϴ� �Լ� (3, 2.323)

--REMAINDER �Լ� ���� n2�� n1���� ���� ������ ���� ��ȯ�ϴµ�, �������� ���ϴ� ������ ���� ����� MOD �Լ��ʹ� �ణ �ٸ���.
-MOD �� n2 - n1 * FLOOR (n2/n1)
--REMAINDER �� n2 - n1 * ROUND (n2/n1)
SELECT REMAINDER(19,4), REMAINDER(19.123, 4.2) FROM DUAL; --19-4(�ݿø� 19/4) = 5

/*
���� �Լ�
���� �Լ��� ���� ����� �����̸� ��ȯ ���� �Լ��� ���� ���ڳ� ���ڸ� ��ȯ�Ѵ�.
*/
--INITCAP(char), LOWER(char), UPPER(char)
--INITCAP �Լ��� �Ű������� ������ char�� ù ���ڴ� �빮�ڷ�, �������� �ҹ��ڷ� ��ȯ�ϴ� �Լ���. 
--�̶� ù ���ڸ� �ν��ϴ� ������ ����� ���ĺ�(���� ����)�� ������ ���ڴ�. 
--�� �����̳� ���ĺ��� �ƴ� ���ڸ� ���� �� ���� ù ���ĺ� ���ڸ� �빮�ڷ� ��ȯ�Ѵ�.
SELECT INITCAP('never say goodbye'), INITCAP('never6say*good��bye') FROM DUAL; --Never Say Goodbye, Never6say*Good��Bye

SELECT emp_name, INITCAP(emp_name) FROM employees; --Allan McEwen -> Allan Mcewen

--�ҹ���, �빮�� ��ȯ
SELECT LOWER('NEVER SAY GOODBYE'), UPPER('never say goodbye') FROM DUAL;

SELECT EMP_NAME, LOWER(EMP_NAME), UPPER(EMP_NAME) FROM EMPLOYEES;

/*
CONCAT(char1, char2), SUBSTR(char, pos, len), SUBSTRB(char, pos, len)
CONCAT �Լ��� ��||�� ������ó�� �Ű������� ������ �� ���ڸ� �ٿ� ��ȯ�Ѵ�
*/
SELECT CONCAT('I Have', ' A Dream'), 'I Have' || ' A Dream' FROM DUAL;

SELECT CONCAT(emp_name, salary),emp_name || ' ' || salary FROM employees;

/*
SUBSTR�� ���� �Լ� �� ���� ���� ���Ǵ� �Լ���, 
�߶�� ��� ���ڿ��� char�� pos��° ���ں��� 
len���̸�ŭ �߶� ����� ��ȯ�ϴ� �Լ���. 
pos ������ 0�� ���� ����Ʈ ���� 1, �� ù ��° ���ڸ� ����Ű��, 
������ ���� char ���ڿ� �� ������ ������ ����� ��ġ�� �ǹ��Ѵ�. 
���� len ���� �����Ǹ� pos��° ���ں��� ������ ��� ���ڸ� ��ȯ�Ѵ�.
*/
SELECT SUBSTR('ABCDEFG', 1, 4), SUBSTR('ABCDEFG', -1, 4) FROM DUAL;
--1�� ��ġ, 4�� ���� / -1�� ������������ ù��°

SELECT SUBSTR(EMP_NAME, 1, 3) FROM EMPLOYEES;
SELECT emp_name, SUBSTR(emp_name, 1, 3) || '****' FROM EMPLOYEES;

--����Ʈ ����.
SELECT SUBSTRB('ABCDEFG', 1, 4), SUBSTRB('�����ٶ󸶹ٻ�', 1, 4) FROM DUAL; --�ѱ��� 3����Ʈ�� ������ �Ǿ� �־� �������� ����

--�ѱ� ����Ʈ Ȯ�� ���
SELECT LENGTHB('��') FROM DUAL;

SELECT LENGTHB('��') FROM DUAL;

/*
�� LTRIM(char, set), RTRIM(char, set)
LTRIM �Լ��� �Ű������� ���� char ���ڿ����� set���� ������ ���ڿ��� ���� ������ ������ �� ������ ���ڿ��� ��ȯ�Ѵ�. 
�� ��° �Ű������� set�� ������ �� ������, ����Ʈ�� ���� ���� �� ���ڰ� ���ȴ�. 
RTRIM �Լ��� LTRIM �Լ��� �ݴ�� ������ ������ ������ �� ������ ���ڿ��� ��ȯ�Ѵ�.
*/
--�Ű����� 1�� ����� ���
SELECT LENGTH('  ABCDEF'), LENGTH(LTRIM('  ABCDEF')), LENGTH(LTRIM('ABCDEF ')) FROM DUAL; 

--�Ű����� 2�� ����� ���, 2���� �Ű����� ���� ���� ������ �� �Ǵ� �������� �� �ѹ��� �����Ѵ�.
SELECT LTRIM('ABCDEFGABC', 'ABC'),
           LTRIM('�����ٶ�', '��'),
           RTRIM('ABCDEFGABC', 'ABC'),
           RTRIM('�����ٶ�', '��')
FROM DUAL;
--���� LTRIM�� RTRIM�� �־��� ���ڿ����� ���� Ȥ�� ������ ������ ������ �� ���� ����Ѵ�

/*
�� LPAD(expr1, n, expr2), RPAD(expr1, n, expr2)
LPAD �Լ��� �Ű������� ���� expr2 ���ڿ�(������ �� ����Ʈ�� ���� �� ����)�� n�ڸ���ŭ ���ʺ��� ä�� expr1�� ��ȯ�ϴ� �Լ���. 
�Ű����� n�� expr2�� expr1�� ������ ��ȯ�Ǵ� �� �ڸ����� �ǹ��Ѵ�. 
���� ���, ������ ���� ��ȭ��ȣ�� ��02���ε� ��ȭ��ȣ �÷��� ������ȣ�� ������ LPAD �Լ��� ��ȣ 02�� �ڵ����� ä�� ���� �� �ִ�.
*/
CREATE TABLE ex4_1 (phone_num VARCHAR2(30));

    INSERT INTO ex4_1 VALUES ('111-1111');
    INSERT INTO ex4_1 VALUES ('111-2222');
    INSERT INTO ex4_1 VALUES ('111-3333');
    
    SELECT * FROM ex4_1;

COMMIT; --������ �۾������� ���� �����ͺ��̽� ���Ͽ� ���������� �ݿ��Ѵ�.

SELECT phone_num, LPAD(phone_num, 12, '(02)'), RPAD(phone_num, 12, '(02)') FROM ex4_1;

/*
 REPLACE(char, search_str, replace_str), TRANSLATE(expr, FROM_str, to_str)
REPLACE �Լ��� char ���ڿ����� search_str ���ڿ��� ã�� �̸� replace_str ���ڿ��� ��ü�� ����� ��ȯ�ϴ� �Լ���.
*/
SELECT REPLACE('���� �ʸ� �𸣴µ� �ʴ� ���� �˰ڴ°�?', '��', '��') FROM DUAL;

SELECT REPLACE('���� �ʸ� �𸣴µ� �ʴ� ���� �˰ڴ°�?', '����', '�ʴ�') FROM DUAL;

--���ڿ��� �ִ� ��� ������ �����϶�.
SELECT LTRIM(' ABC DEF '),
           RTRIM(' ABC DEF '),
           REPLACE(' ABC DEF ', ' ', '')
      FROM DUAL;

--REPLACE�� TRANSLATE������
SELECT REPLACE('���� �ʸ� �𸣴µ� �ʴ� ���� �˰ڴ°�?', '����', '�ʸ�') AS rep, --���� �̶�� �ܾ ã�Ƽ� �ʸ��� ����
           TRANSLATE('���� �ʸ� �𸣴µ� �ʴ� ���� �˰ڴ°�?', '����', '�ʸ�') AS trn --���� �ʷ� �ٲٰ� / ���� ã�� ���� ����ã�� ����ȴ�.
      FROM DUAL;
      
/*
�� INSTR(str, substr, pos, occur), LENGTH(chr), LENGTHB(chr)
INSTR �Լ��� str ���ڿ����� substr�� ��ġ�ϴ� ��ġ�� ��ȯ�ϴµ�, 
pos�� ���� ��ġ�� ����Ʈ ���� 1, occur�� �� ��° ��ġ�ϴ����� ����ϸ� ����Ʈ ���� 1�̴�.
*/

--'����', 5, 2 �����̶�� �ܾ ���� 5��°���� 2��° ���� �ܾ��� ��ġ�� ã�ƶ�.
SELECT INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����, ���� ���� ��ſ� ����', '����') AS INSTR1,
       INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����, ���� ���� ��ſ� ����', '����', 5) AS INSTR2, --5���� ��ġ���� �����̶�� �ܾ ã�ƶ�.
       INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����, ���� ���� ��ſ� ����', '����', 5, 2) AS INSTR3
       FROM DUAL;

--LENGTH �Լ��� �Ű������� ���� ���ڿ��� ������ ��ȯ�ϸ�, LENGTHB �Լ��� �ش� ���ڿ��� ����Ʈ ���� ��ȯ�Ѵ�.

SELECT LENGTH('���ѹα�'), --����
       LENGTHB('���ѹα�') --����Ʈ ��
       FROM DUAL;

/*
03 | ��¥ �Լ�
��¥ �Լ��� DATE �Լ��� TIMESTAMP �Լ��� ���� ��¥���� ������� ������ ������ ����� ��ȯ�ϴ� �Լ���. 
��¥ �Լ� ���� ��κ� ��ȯ ����� ��¥���̳� �Լ��� ���� ���ڸ� ��ȯ�� ���� �ִ�.
*/


--SYSDATE - ��,��,��,��, SYSTIMESTAMP - ��,��,��,��,�и���

SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

--�� ADD_MONTHS (date, integer)
--ADD_MONTHS �Լ��� �Ű������� ���� ��¥�� interger ��ŭ�� ���� ���� ��¥�� ��ȯ�Ѵ�.

--��¥�� ���� �ǹ�, ������ ����ϸ� �� �ǹ̵� ���� �� �ִ�.
SELECT ADD_MONTHS(SYSDATE, 1), ADD_MONTHS(SYSDATE, -1) FROM DUAL;

--�� MONTHS_BETWEEN(date1, date2)
--MONTHS_BETWEEN �Լ��� �� ��¥ ������ ���� ���� ��ȯ�ϴµ�, date2�� date1���� ���� ��¥�� �´�.

SELECT MONTHS_BETWEEN(SYSDATE, ADD_MONTHS(SYSDATE, 1)) mon1,
       MONTHS_BETWEEN(ADD_MONTHS(SYSDATE, 1), SYSDATE) mon2
       FROM DUAL;

SELECT EMPLOYEE_ID, emp_name, MONTHS_BETWEEN(SYSDATE, HIRE_DATE) 
AS mon1, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))/12 AS "�ټӳ��" 
FROM EMPLOYEES;

--�� LAST_DAY(date) LAST_DAY�� date ��¥�� �������� �ش� ���� ������ ���ڸ� ��ȯ�Ѵ�.

SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY('2024-02-01'), LAST_DAY(SYSDATE) FROM DUAL;

--�� ROUND(date, format), TRUNC(date, format)
--ROUND�� TRUNC�� ���� �Լ��̸鼭 ��¥ �Լ��ε� ���̴µ�, ROUND�� format�� ���� �ݿø��� ��¥��, TRUNC�� �߶� ��¥�� ��ȯ�Ѵ�.

SELECT SYSDATE, ROUND(SYSDATE, 'month'), TRUNC(SYSDATE, 'month') FROM DUAL;

--ROUND�Լ��� 15�ϱ����� �ݿø��� �ȵȴ�. / TRUNC�Լ��� �� ���ؿ��� ���� �����Ѵ�.
SELECT '2024-04-15', ROUND(TO_DATE('2024-04-15'), 'month'), TRUNC(TO_DATE('2024-04-15'), 'month') FROM DUAL;

--ROUND�Լ��� 16�� �̻��� ��쿡�� �ݿø��� �Ǿ�, �Ѵ��� ��������./TRUNC�Լ��� �� ���ؿ��� ���� �����Ѵ�.
SELECT '2024-04-16', ROUND(TO_DATE('2024-04-16'), 'month'), TRUNC(TO_DATE('2024-04-16'), 'month') FROM DUAL;

--�� NEXT_DAY (date, char)
--NEXT_DAY�� date�� char�� ����� ��¥�� ���� �� ���� ���ڸ� ��ȯ�Ѵ�.
--���� ��¥���� ���ƿ��� �ݿ�����?
SELECT NEXT_DAY(SYSDATE, '�ݿ���') FROM DUAL;

--char�� �� �� �ִ� ���� ���Ͽ��ϡ����� ������ϡ������ε�, 
--�� ���� NLS_LANG�̶� ����Ŭ ȯ�� ������ ���� �ѱ��� �� ����, 
--��SUNDAY��, ��MONDAY�� ó�� ������ �� ���� �ִ�.

--04 | ��ȯ �Լ�
--��ȯ �Լ��� ���� �ٸ� ������ ������ Ÿ������ ��ȯ�� ����� ��ȯ�ϴ� �Լ��� ���Ѵ�. 
--3�忡�� ����ߵ��� ����Ŭ�� �ڵ����� ����ȯ�� ���ִ� ���� ������ ����ȯ�̶� �ϴµ� 
--�� ������ �н��ϴ� ��ȯ �Լ��� ���� ����ȯ�� ���� ó���ϴ� ���� ����� ����ȯ�̶�� �Ѵ�.

--�� TO_CHAR (���� Ȥ�� ��¥, format)
--���ڳ� ��¥�� ���ڷ� ��ȯ�� �ִ� �Լ��� �ٷ� TO_CHAR��, 
--�Ű������δ� ���ڳ� ��¥�� �� �� �ְ� ��ȯ ����� Ư�� ���Ŀ� �°� ����� �� �ִ�.

--���� 123456789�� 3�ڸ����� �޸��� ����Ͽ� ���ڵ����ͷ� ��ȯ.
SELECT TO_CHAR(123456789, '999,999,999') FROM DUAL;

--��¥ �����͸� ��-��-�� ������ ���ڵ����ͷ� ��ȯ
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;

--TO_NUMBER(expr, format)
--���ڳ� �ٸ� ������ ���ڸ� NUMBER ������ ��ȯ�ϴ� �Լ���.
--���ڵ����͸� ���������� ��ȯ
SELECT TO_NUMBER('123456') FROM DUAL;

--�� TO_DATE(char, format), TO_TIMESTAMP(char, format)
--���ڸ� ��¥������ ��ȯ�ϴ� �Լ���. 
--���� �Ű������δ� [ǥ 4-1]�� �ִ� �׸��� �� �� ������, 
--TO_DATE�� DATE ������ TO_TIMESTAMP�� TIMESTAMP ������ ��ȯ�� ���� ��ȯ�Ѵ�.

--���ڿ������͸� ��¥������ ��ȯ
SELECT TO_DATE('20140101', 'YYYY-MM-DD') FROM DUAL;

SELECT TO_DATE('20140101 13:44:50', 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

--NULL ���� �Լ� (�����Լ��� NULL�Լ��� ���� ���� ���ǰ� ��¥�Լ�, ��ȯ�Լ�, �����Լ��� ���󵵰� ��������)
--3�忡�� �˾ƺõ��� NULL�� ���� ���� IS NULL�̳� IS NOT NULL ������ ����Ͽ��µ�, 
--����Ŭ������ NULL�� ���� ������� ó���ϴ� SQL �Լ��� �����ϰ� �ִ�.

--NVL(expr1, expr2), NVL2((expr1, expr2, expr3)
--NVL �Լ��� expr1�� NULL�� �� expr2�� ��ȯ�Ѵ�.

--manager_id �÷��� �����Ͱ� NULL�̸�, employee_id �÷��� ������ ��ȯ�ǰ�, 
--manager_id �÷��� �����Ͱ� �����ϸ�(NOT NULL), manager_id �÷��� ���� ��ȯ�ȴ�.
SELECT NVL(manager_id, employee_id) FROM employees WHERE manager_id IS NULL;

SELECT NVL(NULL, 10), NVL(10, 20) FROM DUAL;

--NVL2�� NVL�� Ȯ���� �Լ��� expr1�� NULL�� �ƴϸ� expr2��, NULL�̸� expr3�� ��ȯ�ϴ� �Լ���.

--���� ������ Ŀ�̼�(commission_pct)�� NULL�� ����� �׳� �޿���, NULL�� �ƴϸ� ���޿� + (�޿� * Ŀ�̼�)���� ��ȸ�ϰ� �ִ�.
SELECT employee_id, salary, commission_pct, 
       NVL2(commission_pct, salary + (salary * commission_pct), salary) AS salary2
       FROM employees;

--NVL2�� ���� NULL�̸� 20�� ���, NULL�� �ƴϸ� 20�� ���
SELECT NVL2(NULL, 10, 20), NVL2(10, 20, 30) FROM DUAL;

--NULL�� ����� ����� NULL�� �ȴ�. (�߿�)
SELECT NULL + 100 FROM DUAL; 

--�� COALESCE (expr1, expr2, ��)
--COALESCE �Լ��� �Ű������� ������ ǥ���Ŀ��� NULL�� �ƴ� ù ��° ǥ������ ��ȯ�ϴ� �Լ���.

--COALESCE (salary * commission_pct, salary) �� ���� NULL�̸� salary�÷��� ���� ��ȯ�ǰ�
--COALESCE (salary * commission_pct, salary) �� ���� NOT NULL�̸� �ڽ��� ������� ��ȯ�ȴ�.
SELECT employee_id, salary, commission_pct,
       COALESCE (salary * commission_pct, salary) AS salary2
       FROM employees;

SELECT COALESCE (NULL, NULL, NULL), COALESCE(NULL, NULL, 1), COALESCE(NULL, 1, 2), COALESCE(1, 2, 3) FROM DUAL;


--�� LNNVL(���ǽ�)
--LNNVL�� �Ű������� ������ ���ǽ��� ����� FALSE�̸� TURE��, ���ǽ��� ����� TRUE�̸� FALSE�� ��ȯ. 

SELECT emp_name, commission_pct FROM employees 
WHERE LNNVL(commission_pct = 0);

--�� ������ ����ó�� ������ �� �ִ�.
SELECT emp_name, commission_pct FROM employees 
WHERE commission_pct IS NULL OR commission_pct != 0; --49��

SELECT SALARY FROM EMPLOYEES
WHERE LNNVL(SALARY > 5000); --49��

SELECT SALARY FROM EMPLOYEES
WHERE SALARY <= 5000; --49��

--�� NULLIF (expr1, expr2)
--NULLIF �Լ��� expr1�� expr2�� ���� ������ NULL��, ���� ������ expr1�� ��ȯ�Ѵ�.

SELECT NULLIF(100, 100), NULLIF(100, 200) FROM DUAL; 

--job_history ���̺��� start_date�� end_date�� ������ ������ �� ������ ������ NULL��, ���� ������ ����⵵�� ����ϴ� ������.
SELECT employee_id,
       TO_CHAR(start_date, 'YYYY') start_year,
       TO_CHAR(end_date, 'YYYY') end_year,
       NULLIF(TO_CHAR(end_date, 'YYYY'), TO_CHAR(start_date, 'YYYY') ) nullif_year
       FROM job_history;

--06 | ��Ÿ �Լ�
--�� GREATEST(expr1, expr2, ��), LEAST(expr1, expr2, ��)
--GREATEST�� �Ű������� ������ ǥ���Ŀ��� ���� ū ����, LEAST�� ���� ���� ���� ��ȯ�ϴ� �Լ���.

SELECT GREATEST(1, 2, 3, 2) AS "���� ū ��",
       LEAST(1, 2, 3, 2) AS "���� ���� ��"
       FROM DUAL;

--���� �Ӹ� �ƴ϶� ���ڵ� ���� �� �ִ�.
SELECT GREATEST('�̼���', '������', '�������'),
       LEAST('�̼���', '������', '�������')
       FROM DUAL;

--DECODE (expr, search1, result1, search2, result2, ��, default)
--DECODE�� expr�� search1�� ���� �� ���� ������ result1��, ���� ������ �ٽ� search2�� ���� ���� ������ result2�� ��ȯ�ϰ�, 
--�̷� ������ ��� ���� �� ���������� ���� ���� ������ default ���� ��ȯ�Ѵ�.

SELECT prod_id,
       DECODE(channel_id, 3, 'Direct',
                          9, 'Direct',
                          5, 'Indirect',
                          4, 'Indirect',
                              'Others')  decodes
       FROM sales
       WHERE rownum < 10;

--�ٽ�����
--1 ���� ����ϴ� ����� ������ ���� ��ȯ�ϴ� ���� �Լ��� �ϴµ�, ����Ŭ������ SQL �Լ��� �����ϰ� �ִ�.
--2 �Լ��� ���� ���� �� Ư���� ���� ũ�� ���� �Լ�, ���� �Լ�, ��¥ �Լ�, NULL �����Լ�, ��ȯ �Լ��� ���� �� �ִ�.
--3 ����Ŭ������ �� ���̳� ǥ������ ������ Ÿ���� �ٸ��� ������ ������ �� ���� ��Ģ�� ���� �ڵ����� ����ȯ�� ó�����ִµ� �̸� ������ ����ȯ�̶�� �Ѵ�. 
--  �ݸ� ����ڰ� ���� ����ȯ�� �ϴ� ���� ����� ����ȯ�̶�� �ϴµ�, ��ȯ �Լ��� ����� ����ȯ�� ó���� �� �ִ�.
--4 SQL �Լ��� Ư�� ������ ���� �� ����� ��ȯ�ϹǷ�, SELECT ����Ʈ, WHERE ��, INSERT���� VALUES ��, UPDATE ���� SET �� ��� ��� �����ϴ�.
