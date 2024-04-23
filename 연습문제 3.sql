-- 1. 업무(JOB)가 MANAGER인 사원의 이름, 부서명, 입사일을 출력
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

-- 2. 사원명이 WARD인 사원의 급여, 부서번호, 부서위치, 커미션을 출력
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

-- 3. 30번 부서에 속하는 사원의 이름, 부서번호, 부서위치를 출력
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


-- 4-1. 급여가 1250을 초과, 3000이하인 사원의 이름, 급여, 부서명을 출력
--ORACLE INNER JOIN
SELECT e.ename, e.deptno, d.dname
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL>1250 AND E.SAL<=3000;

--ANSI INNER JOIN 1번
SELECT e.ename, e.deptno, d.dname
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.SAL>1250 AND E.SAL<=3000;

--ANSI INNER JOIN 2번
SELECT e.ename, e.deptno, d.dname
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.SAL>1250 AND E.SAL<=3000;

--1번과 2번의 결과가 동일하다. 
--동일한 결과가 나오더라도 성능으로는 ON절에 조건을 걸어주는 것이 낫다.

-- 4-2. 급여가 1250이상 3000 이하인 사원의이름, 급여(BETWEEN 사용)
--ORACLE INNER JOIN
SELECT e.ename, e.deptno, d.dname
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL BETWEEN 1250 AND 3000;

--ANSI INNER JOIN 1번
SELECT e.ename, e.deptno, d.dname
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.SAL BETWEEN 1250 AND 3000;

-- 5. 커미션이 0 인 사원의 이름, 부서위치, 커미션을 출력
SELECT e.ename, d.loc, e.comm
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.COMM = 0;

SELECT e.ename, d.loc, e.comm
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.COMM = 0;

-- 6.커미션 계약을 하지않은 사원의 이름, 부서명을 출력
SELECT e.ename, d.dname
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.COMM IS NULL ;

SELECT e.ename, d.dname
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.COMM IS NULL ;


-- 7. 입사일이 1981/06/09보다 늦은 사원이 이름, 부서위치, 입사일 출력(입사일 오름차순)
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


-- 8. 모든 사원의 급여마다 1000을 더한 급여액, 사원명, 급여, 부서명을 출력
SELECT E.ENAME, E.SAL +1000, E.SAL, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT E.ENAME, E.SAL +1000, E.SAL, D.DNAME
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;


-- 9. FORD의 입사일, 부서명을 출력
SELECT e.hiredate, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND e.ename = 'FORD';


-- 10. 사원명이 ALLEN인 사원의 급여, 부서번호, 부서위치를 출력

SELECT e.sal, e.deptno, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND e.ename = 'ALLEN';

-- 11. ALLEN의 급여보다 높은 급여를 받는 사원의 사원명, 부서명, 부서위치, 급여를 출력
--ALLEN의 급여
SELECT SAL FROM EMP WHERE ENAME = 'ALLEN';

SELECT e.ename, d.dname, D.LOC, e.sal
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND e.sal > (SELECT SAL FROM EMP WHERE ENAME = 'ALLEN');


-- 12. 가장 높은/낮은 커미션을 구하세요.
SELECT MAX(COMM), MIN(COMM) FROM EMP;


-- 13. 가장 높은 커미션을 받는 사원의 이름, 부서명을 구하세요.
SELECT e.ename, d.dname
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND e.comm = (SELECT MAX(COMM) FROM EMP);

-- 14. JOB이 CLERK 인 사원들의 급여의 합을 구하세요
SELECT SUM(SAL) 
FROM EMP
WHERE JOB ='CLERK';

-- 15. JOB 이 CLERK 인 사원들의 급여의 합보다 급여가 많은 사원이름, 부서명을 출력
SELECT E.ENAME, d.dname
FROM EMP E, DEPT D 
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL > (SELECT SUM(SAL) FROM EMP WHERE JOB = 'CLERK');

-- 16. JOB이 CLERK인 사원들의 급여와 같은 급여를 받는 사원의 이름,부서명,급여를 출력(급여가 높은순으로 출력)
--1.JOB이 CLERK인 사원들의 급여
SELECT SAL FROM EMP WHERE JOB = 'CLERK';

SELECT E.ENAME, d.dname, e.sal
FROM EMP E, DEPT D 
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL IN (SELECT SAL FROM EMP WHERE JOB = 'CLERK')
ORDER BY E.SAL;

COMMIT;