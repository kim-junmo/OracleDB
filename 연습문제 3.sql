-- 1. ����(JOB)�� MANAGER�� ����� �̸�, �μ���, �Ի����� ���
--ORACLE INNER JOIN
SELECT E.ENAME, d.dname, e.hiredate
FROM emp E, dept D
WHERE E.deptno = D.deptno
AND E.JOB = 'MANAGER';

--ANSI INNER JOIN
SELECT E.ENAME, d.dname, e.hiredate
FROM emp E INNER JOIN dept D
ON E.deptno = D.deptno
AND E.JOB = 'MANAGER';

-- 2. ������� WARD�� ����� �޿�, �μ���ȣ, �μ���ġ, Ŀ�̼��� ���
--ORACLE INNER JOIN
SELECT e.sal, e.deptno, D.LOC, e.comm
FROM EMP E, DEPT D
WHERE E.DEPTNO = d.deptno
AND E.ENAME = 'WARD';

--ANSI INNER JOIN
SELECT e.sal, e.deptno, D.LOC, e.comm
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = d.deptno
AND E.ENAME = 'WARD';

-- 3. 30�� �μ��� ���ϴ� ����� �̸�, �μ���ȣ, �μ���ġ�� ���
--ORACLE INNER JOIN
SELECT e.ename, e.deptno, d.loc
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 30;

--ANSI INNER JOIN
SELECT e.ename, e.deptno, d.loc
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 30;


-- 4-1. �޿��� 1250�� �ʰ�, 3000������ ����� �̸�, �޿�, �μ����� ���
--ORACLE INNER JOIN
SELECT e.ename, e.deptno, d.dname
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL>1250 AND E.SAL<=3000;

--ANSI INNER JOIN 1��
SELECT e.ename, e.deptno, d.dname
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.SAL>1250 AND E.SAL<=3000;

--ANSI INNER JOIN 2��
SELECT e.ename, e.deptno, d.dname
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.SAL>1250 AND E.SAL<=3000;

--1���� 2���� ����� �����ϴ�. 
--������ ����� �������� �������δ� ON���� ������ �ɾ��ִ� ���� ����.

-- 4-2. �޿��� 1250�̻� 3000 ������ ������̸�, �޿�(BETWEEN ���)
--ORACLE INNER JOIN
SELECT e.ename, e.deptno, d.dname
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL BETWEEN 1250 AND 3000;

--ANSI INNER JOIN 1��
SELECT e.ename, e.deptno, d.dname
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.SAL BETWEEN 1250 AND 3000;

-- 5. Ŀ�̼��� 0 �� ����� �̸�, �μ���ġ, Ŀ�̼��� ���
SELECT e.ename, d.loc, e.comm
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.COMM = 0;

SELECT e.ename, d.loc, e.comm
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.COMM = 0;

-- 6.Ŀ�̼� ����� �������� ����� �̸�, �μ����� ���
SELECT e.ename, d.dname
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.COMM IS NULL ;

SELECT e.ename, d.dname
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.COMM IS NULL ;


-- 7. �Ի����� 1981/06/09���� ���� ����� �̸�, �μ���ġ, �Ի��� ���(�Ի��� ��������)
SELECT e.ename, d.loc, e.hiredate
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.HIREDATE > '1981/06/09'
ORDER BY E.HIREDATE;

SELECT e.ename, d.loc, e.hiredate
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.HIREDATE > '1981/06/09'
ORDER BY E.HIREDATE;


-- 8. ��� ����� �޿����� 1000�� ���� �޿���, �����, �޿�, �μ����� ���
SELECT E.ENAME, E.SAL +1000, E.SAL, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT E.ENAME, E.SAL +1000, E.SAL, D.DNAME
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;


-- 9. FORD�� �Ի���, �μ����� ���
SELECT e.hiredate, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND e.ename = 'FORD';


-- 10. ������� ALLEN�� ����� �޿�, �μ���ȣ, �μ���ġ�� ���

SELECT e.sal, e.deptno, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND e.ename = 'ALLEN';

-- 11. ALLEN�� �޿����� ���� �޿��� �޴� ����� �����, �μ���, �μ���ġ, �޿��� ���
--ALLEN�� �޿�
SELECT SAL FROM EMP WHERE ENAME = 'ALLEN';

SELECT e.ename, d.dname, D.LOC, e.sal
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND e.sal > (SELECT SAL FROM EMP WHERE ENAME = 'ALLEN');


-- 12. ���� ����/���� Ŀ�̼��� ���ϼ���.
SELECT MAX(COMM), MIN(COMM) FROM EMP;


-- 13. ���� ���� Ŀ�̼��� �޴� ����� �̸�, �μ����� ���ϼ���.
SELECT e.ename, d.dname
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND e.comm = (SELECT MAX(COMM) FROM EMP);

-- 14. JOB�� CLERK �� ������� �޿��� ���� ���ϼ���
SELECT SUM(SAL) 
FROM EMP
WHERE JOB ='CLERK';

-- 15. JOB �� CLERK �� ������� �޿��� �պ��� �޿��� ���� ����̸�, �μ����� ���
SELECT E.ENAME, d.dname
FROM EMP E, DEPT D 
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL > (SELECT SUM(SAL) FROM EMP WHERE JOB = 'CLERK');

-- 16. JOB�� CLERK�� ������� �޿��� ���� �޿��� �޴� ����� �̸�,�μ���,�޿��� ���(�޿��� ���������� ���)
--1.JOB�� CLERK�� ������� �޿�
SELECT SAL FROM EMP WHERE JOB = 'CLERK';

SELECT E.ENAME, d.dname, e.sal
FROM EMP E, DEPT D 
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL IN (SELECT SAL FROM EMP WHERE JOB = 'CLERK')
ORDER BY E.SAL;

COMMIT;