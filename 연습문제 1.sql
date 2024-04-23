-- 1. 업무(JOB)가 MANAGER 인 사원의 이름, 입사일 출력
SELECT ename, hiredate FROM emp WHERE job = 'MANAGER';
?
-- 2. 사원명이 WARD 인 사원의 급여, 커미션을 출력
SELECT sal, Comm FROM emp WHERE ename = 'WARD';
?
-- 3. 30번 부서에 속하는 사원의 이름, 부서번호를 출력
SELECT ename, deptno FROM emp WHERE deptno = 30;
?
-- 4-1. 급여가 1250을 초과, 3000이하인 사원의 이름, 급여를 출력
SELECT ename, sal FROM emp WHERE (Sal>1250 AND sal<=3000);

-- 4-2. 급여가 1250이상이고, 3000이하인 사원의 이름, 급여를 출력(범위가 포함됨)
SELECT ename, sal FROM emp WHERE SAL BETWEEN 1250 AND 3000;

-- 5. 커미션이 0 인 사원이 이름, 커미션을 출력
SELECT ename, comm FROM emp WHERE comm = 0;
?
-- 6-1. 커미션 계약을 하지 않은 사원의 이름을 출력
SELECT ename FROM emp WHERE COMM IS NULL;
?
-- 6-2. 커미션 계약을 한 사원의 이름을 출력
SELECT ENAME FROM EMP WHERE COMM IS NOT NULL;
?
-- 7. 입사일이 1981/06/09 보다 늦은 사원이 이름, 입사일 출력(입사일을 기준으로 오름차순.)
SELECT ename, hiredate 
FROM emp
WHERE hiredate > '1981/06/09'
ORDER BY hiredate;
?
-- 8. 모든 사원의 급여마다 1000을 더한 급여를 출력
SELECT sal+1000 AS SAL FROM emp;
?
-- 9. FORD 의 입사일, 부서번호를 출력
SELECT hiredate, deptno FROM emp
WHERE ENAME = 'FORD';
?
-- 10. 사원명이 ALLEN인 사원의 급여를 출력하세요.
SELECT sal FROM emp WHERE ENAME = 'ALLEN';
?
-- 11. ALLEN의 급여보다 높은 급여를 받는 사원의 사원명, 급여를 출력
SELECT sal FROM EMP WHERE ENAME = 'ALLEN';
?
SELECT ENAME, SAL FROM EMP WHERE SAL >(SELECT sal FROM EMP WHERE ENAME = 'ALLEN');
?
-- 12. 가장 높은/낮은 커미션을 구하세요.(최대값/최소값)
SELECT MAX(COMM),MIN(COMM) FROM EMP;

-- 13. 가장 높은 커미션을 받는 사원의 이름을 구하세요.
SELECT MAX(COMM) FROM EMP;
?
SELECT ENAME FROM EMP WHERE COMM = (SELECT MAX(COMM) FROM EMP);
?
-- 14. 가장 높은 커미션을 받는 사원의 입사일보다 늦은 사원의 이름 입사일을 출력 
SELECT HIREDATE FROM EMP WHERE COMM = (SELECT MAX(COMM) FROM EMP);

SELECT ename, hiredate FROM emp WHERE hiredate > (
                                                SELECT hiredate FROM emp WHERE comm = (SELECT MAX(comm) FROM emp)
                                                );

-- 15. JOB이 CLERK 인 사원들의 급여의 합을 구하세요.
SELECT SUM(SAL) FROM EMP WHERE JOB = 'CLERK';
?
-- 16. JOB 이 CLERK 인 사원들의 급여의 합보다 급여가 많은 사원이름을 출력.
SELECT ENAME FROM EMP WHERE SAL > (SELECT SUM(SAL) FROM EMP WHERE JOB = 'CLERK');
?
-- 17. JOB이 CLERK 인 사원들의 급여와 같은 급여를 받는 사원의 이름, 급여를 출력(급여 내림차순으로)
SELECT sal FROM emp WHERE JOB = 'CLERK';
?
SELECT ename, sal FROM emp WHERE sal IN (SELECT sal FROM emp WHERE JOB = 'CLERK')
ORDER BY sal DESC;

-- 18. EMP테이블의 구조출력
