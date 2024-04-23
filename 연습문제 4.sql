-- 1. 최소급여를 받는 사원과 같은 부서에서 근무하는 모든 사원명, 부서명을 출력

--1) 최소급여
SELECT MIN(sal) FROM emp;

--2) 최소 급여를 받는 사원의 부서
SELECT DEPTNO FROM EMP WHERE SAL = (SELECT MIN(sal) FROM emp);

--3)
SELECT E.ENAME, D.DNAME 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND e.deptno = (SELECT DEPTNO FROM EMP WHERE SAL = (SELECT MIN(sal) FROM emp));

-- 2. CLARK보다 입사일이 늦은 사원과 같은 부서에서 근무하는 사원들의 부서명, 이름, 급여를 출력 
--1)CLARK보다 입사일
SELECT hiredate FROM emp WHERE ename = 'CLARK';

--2) CLARK보다 입사일이 늦은 사원과 같은 부서에서 근무하는 사원들의 부서명
SELECT DEPTNO FROM EMP WHERE HIREDATE > (SELECT hiredate FROM emp WHERE ename = 'CLARK');

--3)
SELECT E.ename, D.dname, e.sal
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND e.deptno IN (SELECT deptno FROM emp WHERE hiredate > (SELECT hiredate FROM emp WHERE ename = 'CLARK'));

-- 3. 이름에 'K'자가 들어가는 사원들 중 급여가 가장 적은 사원의 부서명, 사원명, 급여를 출력 
--1)이름에 'K'자가 들어가는 사원들 중 가장 적은 급여
SELECT MIN(SAL) FROM EMP WHERE ENAME LIKE '%K%';

SELECT E.ename, D.dname, e.sal
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND E.SAL = (SELECT MIN(SAL) FROM EMP WHERE ENAME LIKE '%K%');

-- 4. 커미션 계약이 없는 사원중 입사일이 가장 빠른 사원의 부서명, 사원명, 입사일을 출력
--1) 커미션 계약이 없는 사원중 입사일이 가장 빠른
SELECT MIN(hiredate) FROM emp WHERE comm IS NULL;

SELECT D.dname, E.ename, e.hiredate
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND e.hiredate = (SELECT MIN(hiredate) FROM emp WHERE comm IS NULL);

-- 5. 위치가 시카고인 부서에 속한 사원들의 이름과 부서명을 출력.
--1. 위치가 시카고인 부서
SELECT deptno FROM DEPT WHERE LOC = 'CHICAGO';

SELECT E.ename, D.dname 
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND E.deptno = (SELECT deptno FROM DEPT WHERE LOC = 'CHICAGO');

-- 6. KING의 급여에서 CLARK의 급여를 뺀 결과보다 적은 급여를 받는 사원의 부서명, 이름, 급여를 출력 
--1) KING의 급여에서 CLARK의 급여를 뺀 차이액
--1-1) KING의 급여
SELECT sal FROM emp WHERE ename ='KING';
--1-2)CLARK의 급여
SELECT sal FROM emp WHERE ename ='CLARK';

SELECT (SELECT sal FROM emp WHERE ename ='KING') - (SELECT sal FROM emp WHERE ename ='CLARK') FROM DUAL;

SELECT D.dname, E.ename, e.sal  
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND e.sal < (SELECT (SELECT sal FROM emp WHERE ename ='KING') - (SELECT sal FROM emp WHERE ename ='CLARK') FROM DUAL);

-- 7. DALLAS에 위치한 부서에 속한 사원의 총사원수, 평균급여,전체급여,최고급여,초저급여를 구하세요. 
--1) DALLAS에 위치한 부서
SELECT deptno FROM Dept WHERE LOC = 'DALLAS';

SELECT COUNT(*), ROUND(AVG(SAL), 1), SUM(SAL), MAX(SAL), MIN(SAL)
FROM emp 
WHERE Deptno = (SELECT deptno FROM Dept WHERE LOC = 'DALLAS');

-- 8. 커미션 계약조건이 있으며 이름에 'N'자가 들어가는 사원들 중 급여가 가장 적은 사원의 사원명, 급여,부서명을 출력
--1. 커미션 계약조건이 있으며 이름에 'N'자가 들어가는 사원들 중 급여가 가장 적은
SELECT MIN(sal) FROM emp WHERE comm IS NOT NULL AND ename LIKE ('%N%');

SELECT  E.ename, e.sal, D.dname
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND E.sal = (SELECT MIN(sal) FROM emp WHERE comm IS NOT NULL AND ename LIKE ('%N%'));


-- 9. ALLEN 보다 입사일이 빠른 사원의 부서명,사원명을 출력
--1)ALLEN 보다 입사일
SELECT hiredate FROM emp WHERE ename = 'ALLEN';

SELECT D.dname, E.ename
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND E.Hiredate < (SELECT hiredate FROM emp WHERE ename = 'ALLEN');

-- 10. EMP 테이블에서 이름이 5글자인 사원중 급여가 가장 높은 사원의 이름, 급여 , 부서명을 출력
--1) EMP 테이블에서 이름이 5글자인 사원중 급여가 가장 높은 사원
SELECT MAX(SAL) FROM EMP WHERE LENGTH(ename) = 5;

SELECT  E.ename, e.sal, D.dname
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND e.sal = (SELECT MAX(SAL) FROM EMP WHERE LENGTH(ename) = 5);


-- 11. CLARK 이 속한 부서의 평균 연봉보다 급여가 높은 사원중 입사일이 가장 빠른 사원의 부서명, 사원명, 급여를 출력
--1) CLARK 이 속한 부서
SELECT deptno FROM emp WHERE ename = 'CLARK';

--2) CLARK 이 속한 부서의 평균 연봉
SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'CLARK');

--3) CLARK 이 속한 부서의 평균 연봉보다 급여가 높은 사원중 입사일이 가장 빠른
SELECT MIN(Hiredate) FROM EMP WHERE sal > 
(SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'CLARK'));

SELECT  D.dname, E.ename, e.sal
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND E.hiredate = (
SELECT MIN(Hiredate) FROM emp WHERE sal > 
(SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'CLARK'))
);

-- 12. ALLEN의 부서명을 출력
SELECT D.dname FROM DEPT D, EMP E WHERE E.deptno = D.deptno AND E.ENAME = 'ALLEN';
 
-- 13. 이름에 J가 들어가는 사원들 중, 급여가 가장 높은 사원의 사원번호, 이름, 부서명, 급여, 부서위치를 출력
--1)이름에 J가 들어가는 사원들 중, 급여가 가장 높은 사원
SELECT MAX(sal) FROM emp WHERE ename LIKE '%J%';

SELECT  D.dname, E.ename, e.sal, d.loc
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND e.sal = (SELECT MAX(sal) FROM emp WHERE ename LIKE '%J%');

-- 14. 두번째로 많은 급여를 받는 사원의 이름과 부서명,급여를 출력
--첫번째로 많은 급여
SELECT MAX(sal) FROM emp;

--두번째로 많은 급여
SELECT MAX(sal) FROM emp WHERE sal < (SELECT MAX(sal) FROM emp);

SELECT E.ename, D.dname, e.sal
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND Sal = (SELECT MAX(sal) FROM emp WHERE sal < (SELECT MAX(sal) FROM emp));

-- 15. 입사일이 2번째로 빠른 사원의 부서명과 이름, 입사일을 출력
--입사일이 1번째로 빠른 사원
SELECT MIN(hiredate) FROM emp;
--입사일이 2번째로 빠른 사원
SELECT MIN(hiredate) FROM emp WHERE hiredate > (SELECT MIN(hiredate) FROM emp);

SELECT E.ename, D.dname, e.hiredate
FROM emp E, Dept D
WHERE E.deptno = D.deptno
AND hiredate = (SELECT MIN(hiredate) FROM emp WHERE hiredate > (SELECT MIN(hiredate) FROM emp));

-- 16. DALLAS에 위치한 부서의 사원 중 최대 급여를 받는 사원의 급여에서 최소 급여를 받는 사원의 급여를 뺀 결과를 출력
--DALLAS에 위치한 부서
SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS';

--DALLAS에 위치한 부서의 사원 중 최대 급여를 받는 사원
SELECT MAX(sal) FROM emp WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS');

--DALLAS에 위치한 부서의 사원 중 최소 급여를 받는 사원
SELECT MIN(sal) FROM emp WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS');

SELECT MAX(SAL) - MIN(SAL)
FROM EMP E, DEPT D
WHERE E.deptno = D.deptno
AND D.LOC = 'DALLAS';

COMMIT;