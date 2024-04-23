-- 1. ����(JOB)�� MANAGER �� ����� �̸�, �Ի��� ���
SELECT ename, hiredate FROM emp WHERE job = 'MANAGER';
?
-- 2. ������� WARD �� ����� �޿�, Ŀ�̼��� ���
SELECT sal, Comm FROM emp WHERE ename = 'WARD';
?
-- 3. 30�� �μ��� ���ϴ� ����� �̸�, �μ���ȣ�� ���
SELECT ename, deptno FROM emp WHERE deptno = 30;
?
-- 4-1. �޿��� 1250�� �ʰ�, 3000������ ����� �̸�, �޿��� ���
SELECT ename, sal FROM emp WHERE (Sal>1250 AND sal<=3000);

-- 4-2. �޿��� 1250�̻��̰�, 3000������ ����� �̸�, �޿��� ���(������ ���Ե�)
SELECT ename, sal FROM emp WHERE SAL BETWEEN 1250 AND 3000;

-- 5. Ŀ�̼��� 0 �� ����� �̸�, Ŀ�̼��� ���
SELECT ename, comm FROM emp WHERE comm = 0;
?
-- 6-1. Ŀ�̼� ����� ���� ���� ����� �̸��� ���
SELECT ename FROM emp WHERE COMM IS NULL;
?
-- 6-2. Ŀ�̼� ����� �� ����� �̸��� ���
SELECT ENAME FROM EMP WHERE COMM IS NOT NULL;
?
-- 7. �Ի����� 1981/06/09 ���� ���� ����� �̸�, �Ի��� ���(�Ի����� �������� ��������.)
SELECT ename, hiredate 
FROM emp
WHERE hiredate > '1981/06/09'
ORDER BY hiredate;
?
-- 8. ��� ����� �޿����� 1000�� ���� �޿��� ���
SELECT sal+1000 AS SAL FROM emp;
?
-- 9. FORD �� �Ի���, �μ���ȣ�� ���
SELECT hiredate, deptno FROM emp
WHERE ENAME = 'FORD';
?
-- 10. ������� ALLEN�� ����� �޿��� ����ϼ���.
SELECT sal FROM emp WHERE ENAME = 'ALLEN';
?
-- 11. ALLEN�� �޿����� ���� �޿��� �޴� ����� �����, �޿��� ���
SELECT sal FROM EMP WHERE ENAME = 'ALLEN';
?
SELECT ENAME, SAL FROM EMP WHERE SAL >(SELECT sal FROM EMP WHERE ENAME = 'ALLEN');
?
-- 12. ���� ����/���� Ŀ�̼��� ���ϼ���.(�ִ밪/�ּҰ�)
SELECT MAX(COMM),MIN(COMM) FROM EMP;

-- 13. ���� ���� Ŀ�̼��� �޴� ����� �̸��� ���ϼ���.
SELECT MAX(COMM) FROM EMP;
?
SELECT ENAME FROM EMP WHERE COMM = (SELECT MAX(COMM) FROM EMP);
?
-- 14. ���� ���� Ŀ�̼��� �޴� ����� �Ի��Ϻ��� ���� ����� �̸� �Ի����� ��� 
SELECT HIREDATE FROM EMP WHERE COMM = (SELECT MAX(COMM) FROM EMP);

SELECT ename, hiredate FROM emp WHERE hiredate > (
                                                SELECT hiredate FROM emp WHERE comm = (SELECT MAX(comm) FROM emp)
                                                );

-- 15. JOB�� CLERK �� ������� �޿��� ���� ���ϼ���.
SELECT SUM(SAL) FROM EMP WHERE JOB = 'CLERK';
?
-- 16. JOB �� CLERK �� ������� �޿��� �պ��� �޿��� ���� ����̸��� ���.
SELECT ENAME FROM EMP WHERE SAL > (SELECT SUM(SAL) FROM EMP WHERE JOB = 'CLERK');
?
-- 17. JOB�� CLERK �� ������� �޿��� ���� �޿��� �޴� ����� �̸�, �޿��� ���(�޿� ������������)
SELECT sal FROM emp WHERE JOB = 'CLERK';
?
SELECT ename, sal FROM emp WHERE sal IN (SELECT sal FROM emp WHERE JOB = 'CLERK')
ORDER BY sal DESC;

-- 18. EMP���̺��� �������
