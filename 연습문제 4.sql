-- 1. �ּұ޿��� �޴� ����� ���� �μ����� �ٹ��ϴ� ��� �����, �μ����� ���

--1) �ּұ޿�
SELECT MIN(sal) FROM emp;

--2) �ּ� �޿��� �޴� ����� �μ�
SELECT DEPTNO FROM EMP WHERE SAL = (SELECT MIN(sal) FROM emp);

--3)
SELECT E.ENAME, D.DNAME 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND e.deptno = (SELECT DEPTNO FROM EMP WHERE SAL = (SELECT MIN(sal) FROM emp));

-- 2. CLARK���� �Ի����� ���� ����� ���� �μ����� �ٹ��ϴ� ������� �μ���, �̸�, �޿��� ��� 
--1)CLARK���� �Ի���
SELECT hiredate FROM emp WHERE ename = 'CLARK';

--2) CLARK���� �Ի����� ���� ����� ���� �μ����� �ٹ��ϴ� ������� �μ���
SELECT DEPTNO FROM EMP WHERE HIREDATE > (SELECT hiredate FROM emp WHERE ename = 'CLARK');

--3)
SELECT E.ename, D.dname, e.sal
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND e.deptno IN (SELECT deptno FROM emp WHERE hiredate > (SELECT hiredate FROM emp WHERE ename = 'CLARK'));

-- 3. �̸��� 'K'�ڰ� ���� ����� �� �޿��� ���� ���� ����� �μ���, �����, �޿��� ��� 
--1)�̸��� 'K'�ڰ� ���� ����� �� ���� ���� �޿�
SELECT MIN(SAL) FROM EMP WHERE ENAME LIKE '%K%';

SELECT E.ename, D.dname, e.sal
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND E.SAL = (SELECT MIN(SAL) FROM EMP WHERE ENAME LIKE '%K%');

-- 4. Ŀ�̼� ����� ���� ����� �Ի����� ���� ���� ����� �μ���, �����, �Ի����� ���
--1) Ŀ�̼� ����� ���� ����� �Ի����� ���� ����
SELECT MIN(hiredate) FROM emp WHERE comm IS NULL;

SELECT D.dname, E.ename, e.hiredate
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND e.hiredate = (SELECT MIN(hiredate) FROM emp WHERE comm IS NULL);

-- 5. ��ġ�� ��ī���� �μ��� ���� ������� �̸��� �μ����� ���.
--1. ��ġ�� ��ī���� �μ�
SELECT deptno FROM DEPT WHERE LOC = 'CHICAGO';

SELECT E.ename, D.dname 
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND E.deptno = (SELECT deptno FROM DEPT WHERE LOC = 'CHICAGO');

-- 6. KING�� �޿����� CLARK�� �޿��� �� ������� ���� �޿��� �޴� ����� �μ���, �̸�, �޿��� ��� 
--1) KING�� �޿����� CLARK�� �޿��� �� ���̾�
--1-1) KING�� �޿�
SELECT sal FROM emp WHERE ename ='KING';
--1-2)CLARK�� �޿�
SELECT sal FROM emp WHERE ename ='CLARK';

SELECT (SELECT sal FROM emp WHERE ename ='KING') - (SELECT sal FROM emp WHERE ename ='CLARK') FROM DUAL;

SELECT D.dname, E.ename, e.sal  
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND e.sal < (SELECT (SELECT sal FROM emp WHERE ename ='KING') - (SELECT sal FROM emp WHERE ename ='CLARK') FROM DUAL);

-- 7. DALLAS�� ��ġ�� �μ��� ���� ����� �ѻ����, ��ձ޿�,��ü�޿�,�ְ�޿�,�����޿��� ���ϼ���. 
--1) DALLAS�� ��ġ�� �μ�
SELECT deptno FROM Dept WHERE LOC = 'DALLAS';

SELECT COUNT(*), ROUND(AVG(SAL), 1), SUM(SAL), MAX(SAL), MIN(SAL)
FROM emp 
WHERE Deptno = (SELECT deptno FROM Dept WHERE LOC = 'DALLAS');

-- 8. Ŀ�̼� ��������� ������ �̸��� 'N'�ڰ� ���� ����� �� �޿��� ���� ���� ����� �����, �޿�,�μ����� ���
--1. Ŀ�̼� ��������� ������ �̸��� 'N'�ڰ� ���� ����� �� �޿��� ���� ����
SELECT MIN(sal) FROM emp WHERE comm IS NOT NULL AND ename LIKE ('%N%');

SELECT  E.ename, e.sal, D.dname
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND E.sal = (SELECT MIN(sal) FROM emp WHERE comm IS NOT NULL AND ename LIKE ('%N%'));


-- 9. ALLEN ���� �Ի����� ���� ����� �μ���,������� ���
--1)ALLEN ���� �Ի���
SELECT hiredate FROM emp WHERE ename = 'ALLEN';

SELECT D.dname, E.ename
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND E.Hiredate < (SELECT hiredate FROM emp WHERE ename = 'ALLEN');

-- 10. EMP ���̺��� �̸��� 5������ ����� �޿��� ���� ���� ����� �̸�, �޿� , �μ����� ���
--1) EMP ���̺��� �̸��� 5������ ����� �޿��� ���� ���� ���
SELECT MAX(SAL) FROM EMP WHERE LENGTH(ename) = 5;

SELECT  E.ename, e.sal, D.dname
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND e.sal = (SELECT MAX(SAL) FROM EMP WHERE LENGTH(ename) = 5);


-- 11. CLARK �� ���� �μ��� ��� �������� �޿��� ���� ����� �Ի����� ���� ���� ����� �μ���, �����, �޿��� ���
--1) CLARK �� ���� �μ�
SELECT deptno FROM emp WHERE ename = 'CLARK';

--2) CLARK �� ���� �μ��� ��� ����
SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'CLARK');

--3) CLARK �� ���� �μ��� ��� �������� �޿��� ���� ����� �Ի����� ���� ����
SELECT MIN(Hiredate) FROM EMP WHERE sal > 
(SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'CLARK'));

SELECT  D.dname, E.ename, e.sal
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND E.hiredate = (
SELECT MIN(Hiredate) FROM emp WHERE sal > 
(SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'CLARK'))
);

-- 12. ALLEN�� �μ����� ���
SELECT D.dname FROM DEPT D, EMP E WHERE E.deptno = D.deptno AND E.ENAME = 'ALLEN';
 
-- 13. �̸��� J�� ���� ����� ��, �޿��� ���� ���� ����� �����ȣ, �̸�, �μ���, �޿�, �μ���ġ�� ���
--1)�̸��� J�� ���� ����� ��, �޿��� ���� ���� ���
SELECT MAX(sal) FROM emp WHERE ename LIKE '%J%';

SELECT  D.dname, E.ename, e.sal, d.loc
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND e.sal = (SELECT MAX(sal) FROM emp WHERE ename LIKE '%J%');

-- 14. �ι�°�� ���� �޿��� �޴� ����� �̸��� �μ���,�޿��� ���
--ù��°�� ���� �޿�
SELECT MAX(sal) FROM emp;

--�ι�°�� ���� �޿�
SELECT MAX(sal) FROM emp WHERE sal < (SELECT MAX(sal) FROM emp);

SELECT E.ename, D.dname, e.sal
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND Sal = (SELECT MAX(sal) FROM emp WHERE sal < (SELECT MAX(sal) FROM emp));

-- 15. �Ի����� 2��°�� ���� ����� �μ���� �̸�, �Ի����� ���
--�Ի����� 1��°�� ���� ���
SELECT MIN(hiredate) FROM emp;
--�Ի����� 2��°�� ���� ���
SELECT MIN(hiredate) FROM emp WHERE hiredate > (SELECT MIN(hiredate) FROM emp);

SELECT E.ename, D.dname, e.hiredate
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND hiredate = (SELECT MIN(hiredate) FROM emp WHERE hiredate > (SELECT MIN(hiredate) FROM emp));

-- 16. DALLAS�� ��ġ�� �μ��� ��� �� �ִ� �޿��� �޴� ����� �޿����� �ּ� �޿��� �޴� ����� �޿��� �� ����� ���
--DALLAS�� ��ġ�� �μ�
SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS';

--DALLAS�� ��ġ�� �μ��� ��� �� �ִ� �޿��� �޴� ���
SELECT MAX(sal) FROM emp WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS');

--DALLAS�� ��ġ�� �μ��� ��� �� �ּ� �޿��� �޴� ���
SELECT MIN(sal) FROM emp WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS');

SELECT MAX(SAL) - MIN(SAL)
FROM EMP E, DEPT D
WHERE E.deptno = D.deptno
AND D.LOC = 'DALLAS';

COMMIT;