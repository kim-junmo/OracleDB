-- 1. ALLEN 과 부서가 같은 사원들의 사원명, 입사일을 출력(급여 내림차순 정렬)
SELECT DEPTNO FROM EMP WHERE ENAME = 'ALLEN';

SELECT ename, hirEdate FROM EMP WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'ALLEN')
ORDER BY SAL DESC;

-- 2. 가장 높은 급여를 받는 사원보다 입사일이 늦은 사원의 이름, 입사일을 출력
SELECT MAX(SAL) FROM EMP; --가장 높은 급여
?
SELECT HIREDATE FROM EMP WHERE SAL = (SELECT MAX(SAL) FROM EMP); --가장 높은 급여를 받는 사원의 입사일

SELECT ENAME, HIREDATE FROM EMP WHERE HIREDATE > (SELECT HIREDATE FROM EMP WHERE SAL = (SELECT MAX(SAL) FROM EMP));
?
-- 3. 이름에 'T' 자가 들어가는 사원들의 급여의 합을 구하세요. (LIKE 사용)

SELECT sum(sal) FROM emp WHERE ename LIKE '%T%';
?
-- 4. 모든 사원의 평균급여를 구하세요. 소수 둘째자리 반올림표현
SELECT AVG(sal) FROM emp;
SELECT ROUND(AVG(sal), 2) FROM emp;
?
-- 5. 각 부서별 평균 급여를 구하세요. 소수 둘째자리 반올림표현 (GROUP BY)

SELECT deptno, ROUND(AVG(sal), 2)
FROM emp
GROUP BY deptno
ORDER BY deptno;

-- 6. 각 부서별 평균급여, 전체급여, 최고급여, 최저급여를 구하여 평균급여가 높은 순으로 출력. 평균은 소수 둘째자리 반올림표현
SELECT ROUND(AVG(sal), 2), SUM(sal), MAX(sal), MIN(sal)
FROM emp
GROUP BY deptno
ORDER BY AVG(sal);

-- 7. 20번 부서의 최고 급여보다 많은 사원의 사원번호, 사원명, 급여를 출력
SELECT MAX(sal) FROM emp WHERE deptno = 20;
?
SELECT ename, empno, sal FROM emp WHERE SAL > (SELECT MAX(sal) FROM emp WHERE deptno = 20);
?
-- 8. SMITH 와 같은 부서에 속한 사원들의 평균급여보다 큰 급여를 받는 모든 사원의 사원명, 급여를 출력
--스미스 부서
SELECT deptno FROM emp WHERE ename = 'SMITH';
?--SMITH 와 같은 부서에 속한 사원들의 평균급여
SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH');
?
SELECT ename, sal FROM emp WHERE sal > (SELECT AVG(sal) FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'));

-- 9. 회사내의 최소급여와 최대급여의 차이를 구하세요. 
SELECT MAX(sal) - MIN(sal) FROM emp;
?
-- 10. WARD 의 급여에서 1000 을 뺀 급여보다 적게 받는 사원의 이름, 급여를 출력.
--1. WARD 의 급여에서 1000 을 뺀 급여
SELECT sal - 1000 FROM emp WHERE ename = 'WARD'; 

SELECT ename, sal FROM emp WHERE sal < (SELECT sal - 1000 FROM emp WHERE ename = 'WARD');

-- 11. JOB이 MANAGER인 사원들 중 최소급여를 받는 사원보다 급여가 적은 사원이름, 급여를 출력
--JOB이 MANAGER인 사원들 중 최소급여
SELECT MIN(sal) FROM emp WHERE job = 'MANAGER';
?
SELECT ename, sal FROM emp WHERE sal < (SELECT MIN(sal) FROM emp WHERE job = 'MANAGER');

-- 12. 이름이 S로 시작하고 마지막글자가 H인 사원의 이름을 출력
SELECT ENAME FROM EMP WHERE ENAME LIKE 'S%H';
?
-- 13. WARD 가 소속된 부서 사원들의 평균 급여보다, 급여가 높은 사원의 이름,급여를 출력.
--WARD 가 소속된 부서
SELECT deptno FROM emp WHERE ename = 'WARD';

--WARD 가 소속된 부서 사원들의 평균 급여
SELECT AVG(sal) FROM emp WHERE DEPTNO = (SELECT deptno FROM emp WHERE ename = 'WARD');
?
SELECT ENAME, SAL FROM EMP WHERE SAL > (SELECT AVG(sal) FROM emp WHERE DEPTNO = (SELECT deptno FROM emp WHERE ename = 'WARD'));

-- 14-1. EMP테이블의 모든 사원수를 출력
SELECT COUNT(*) FROM EMP;
?
-- 15. 업무별(JOB) 사원수를 출력
SELECT JOB, COUNT (*) FROM EMP GROUP BY JOB;
?
-- 16. 최소급여를 받는 사원과 같은 부서의 모든 사원명을 출력
최소급여를 받는 사원
SELECT MIN(sal) FROM Emp;

SELECT DEPTNO FROM EMP WHERE SAL = (SELECT MIN(sal) FROM Emp);

SELECT ENAME FROM EMP WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE SAL = (SELECT MIN(sal) FROM Emp));