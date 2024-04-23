-- 1. ALLEN �� �μ��� ���� ������� �����, �Ի����� ���(�޿� �������� ����)
SELECT DEPTNO FROM EMP WHERE ENAME = 'ALLEN';

SELECT ename, hirEdate FROM EMP WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'ALLEN')
ORDER BY SAL DESC;

-- 2. ���� ���� �޿��� �޴� ������� �Ի����� ���� ����� �̸�, �Ի����� ���
SELECT MAX(SAL) FROM EMP; --���� ���� �޿�
?
SELECT HIREDATE FROM EMP WHERE SAL = (SELECT MAX(SAL) FROM EMP); --���� ���� �޿��� �޴� ����� �Ի���

SELECT ENAME, HIREDATE FROM EMP WHERE HIREDATE > (SELECT HIREDATE FROM EMP WHERE SAL = (SELECT MAX(SAL) FROM EMP));
?
-- 3. �̸��� 'T' �ڰ� ���� ������� �޿��� ���� ���ϼ���. (LIKE ���)

SELECT sum(sal) FROM emp WHERE ename LIKE '%T%';
?
-- 4. ��� ����� ��ձ޿��� ���ϼ���. �Ҽ� ��°�ڸ� �ݿø�ǥ��
SELECT AVG(sal) FROM emp;
SELECT ROUND(AVG(sal), 2) FROM emp;
?
-- 5. �� �μ��� ��� �޿��� ���ϼ���. �Ҽ� ��°�ڸ� �ݿø�ǥ�� (GROUP BY)

SELECT deptno, ROUND(AVG(sal), 2)
FROM emp
GROUP BY deptno
ORDER BY deptno;

-- 6. �� �μ��� ��ձ޿�, ��ü�޿�, �ְ�޿�, �����޿��� ���Ͽ� ��ձ޿��� ���� ������ ���. ����� �Ҽ� ��°�ڸ� �ݿø�ǥ��
SELECT ROUND(AVG(sal), 2), SUM(sal), MAX(sal), MIN(sal)
FROM emp
GROUP BY deptno
ORDER BY AVG(sal);

-- 7. 20�� �μ��� �ְ� �޿����� ���� ����� �����ȣ, �����, �޿��� ���
SELECT MAX(sal) FROM emp WHERE deptno = 20;
?
SELECT ename, empno, sal FROM emp WHERE SAL > (SELECT MAX(sal) FROM emp WHERE deptno = 20);
?
-- 8. SMITH �� ���� �μ��� ���� ������� ��ձ޿����� ū �޿��� �޴� ��� ����� �����, �޿��� ���
--���̽� �μ�
SELECT deptno FROM emp WHERE ename = 'SMITH';
?--SMITH �� ���� �μ��� ���� ������� ��ձ޿�
SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH');
?
SELECT ename, sal FROM emp WHERE sal > (SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'));

-- 9. ȸ�系�� �ּұ޿��� �ִ�޿��� ���̸� ���ϼ���. 
SELECT MAX(sal) - MIN(sal) FROM emp;
?
-- 10. WARD �� �޿����� 1000 �� �� �޿����� ���� �޴� ����� �̸�, �޿��� ���.
--1. WARD �� �޿����� 1000 �� �� �޿�
SELECT sal - 1000 FROM emp WHERE ename = 'WARD'; 

SELECT ename, sal FROM emp WHERE sal < (SELECT sal - 1000 FROM emp WHERE ename = 'WARD');

-- 11. JOB�� MANAGER�� ����� �� �ּұ޿��� �޴� ������� �޿��� ���� ����̸�, �޿��� ���
--JOB�� MANAGER�� ����� �� �ּұ޿�
SELECT MIN(sal) FROM emp WHERE job = 'MANAGER';
?
SELECT ename, sal FROM emp WHERE sal < (SELECT MIN(sal) FROM emp WHERE job = 'MANAGER');

-- 12. �̸��� S�� �����ϰ� ���������ڰ� H�� ����� �̸��� ���
SELECT ENAME FROM EMP WHERE ENAME LIKE 'S%H';
?
-- 13. WARD �� �Ҽӵ� �μ� ������� ��� �޿�����, �޿��� ���� ����� �̸�,�޿��� ���.
--WARD �� �Ҽӵ� �μ�
SELECT deptno FROM emp WHERE ename = 'WARD';

--WARD �� �Ҽӵ� �μ� ������� ��� �޿�
SELECT AVG(sal) FROM emp WHERE DEPTNO = (SELECT deptno FROM emp WHERE ename = 'WARD');
?
SELECT ENAME, SAL FROM EMP WHERE SAL > (SELECT AVG(sal) FROM emp WHERE DEPTNO = (SELECT deptno FROM emp WHERE ename = 'WARD'));

-- 14-1. EMP���̺��� ��� ������� ���
SELECT COUNT(*) FROM EMP;
?
-- 15. ������(JOB) ������� ���
SELECT JOB, COUNT (*) FROM EMP GROUP BY JOB;
?
-- 16. �ּұ޿��� �޴� ����� ���� �μ��� ��� ������� ���
�ּұ޿��� �޴� ���
SELECT MIN(sal) FROM Emp;

SELECT DEPTNO FROM EMP WHERE SAL = (SELECT MIN(sal) FROM Emp);

SELECT ENAME FROM EMP WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE SAL = (SELECT MIN(sal) FROM Emp));