---7장 다중행 함수와 데이터 그룹화
--7-1
SELECT SUM(SAL)
   FROM EMP;
   
--7-2 오류 발생 GROUP BY 필요
SELECT DEPTNO, SUM(SAL)
   FROM EMP;
 --GROUP BY DEPTNO;
 
 --7-3 다중행 함수 : 널값 제외 처리
 SELECT SUM(COMM) AS "추가수당 합계"
    FROM EMP;
    
--7-4 DISTINCT : 중복 데이터 제외하여 계산
SELECT SUM(DISTINCT SAL),
               SUM(ALL SAL),
               SUM(SAL)
   FROM EMP;
   
--7-5 EMP 테이블 행 갯수 
SELECT COUNT(COMM),
               COUNT(MGR),
               COUNT(EMPNO),
               COUNT(*), -- 모든 것
               COUNT(1) -- 첫 번째 컬럼 , 실무
   FROM EMP;
   
--7-6 부서번화가 30번 직원 수
SELECT COUNT(*)
   FROM EMP
WHERE DEPTNO = 30;


--7-7-- NULL 데이터는 반환 개수에서 제외
SELECT COUNT(DISTINCT SAL), 
               COUNT(ALL SAL),
               COUNT(SAL)
   FROM EMP; 
   
--7-8
SELECT COUNT(COMM)
   FROM EMP;
   
--7-9
SELECT COUNT(COMM)
   FROM EMP
WHERE COMM IS NOT NULL;

--7-10 10번 부서에서 최대급여 출력
SELECT MAX(SAL)
   FROM EMP
WHERE DEPTNO = 10;

--7-11 10번 부서에서 최소급여 출력
SELECT MIN(SAL)
   FROM EMP
WHERE DEPTNO = 10;

--7-12 20번 부서에서 사원의 입사일 중 제일 최근 입사일 출력
SELECT MAX(HIREDATE)
   FROM EMP
WHERE DEPTNO = 20;  --1980-07-13

--7-13 20번 부서에서 사원의 입사일 중 제일 오래된 입사일 출력
SELECT MIN(HIREDATE)
   FROM EMP
WHERE DEPTNO = 20;  --1980-12-17


--STDDEV 표준편차, VARIANCE분산
SELECT CEIL(STDDEV(SAL)), CEIL( VARIANCE(SAL))
   FROM EMP;




--7-14 부서 번호가 30인 사원들의  평균 급여 출려
SELECT  CEIL(AVG(SAL)) -- 올림값
             , FLOOR(AVG(COMM)) -- 내림값
             , SIGN(10-5)
             , SIGN(5-10) -- 만기일 계산할 때 사용..? / 양수 OR 음수
             , SIGN(7-7)
   FROM EMP
WHERE DEPTNO = 30;

--7-15 DISTINCT로 중복을 제거한 급여 열의 평균 급여 출력
SELECT AVG(DISTINCT SAL)
   FROM EMP
WHERE DEPTNO = 30;

--07-2절 결과값을 원하는 열로 출력하는 GROUP BY절
--7-16 집합 연산자
SELECT CEIL( AVG(SAL)), '10' AS DEPTNO FROM EMP WHERE DEPTNO = 10
UNION
SELECT CEIL( AVG(SAL)), '20' AS DEPTNO FROM EMP WHERE DEPTNO = 20
UNION
SELECT CEIL( AVG(SAL)), '30' AS DEPTNO FROM EMP WHERE DEPTNO = 30;

--7-17
SELECT CEIL(AVG(SAL)), DEPTNO
   FROM EMP
GROUP BY DEPTNO;

--7-18 부서 번호 및 직책별 평균 급여로 정렬
SELECT DEPTNO, JOB, AVG(SAL)
   FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

--7-19 GROUP BY절에 없는 열을 SELECT절에 포함했을 경우 오류남
SELECT ENAME, DEPTNO, AVG(SAL)
   FROM EMP
GROUP BY DEPTNO; -- ENAME도 포함되어야 함. / ORA-00979: not a GROUP BY expression 오류 발생


SELECT DISTINCT DEPTNO, CHG_SAL
   FROM(
        SELECT DEPTNO
             ,CEIL( AVG(SAL) OVER (ORDER BY DEPTNO)) AS CHG_SAL
   FROM EMP
);

SELECT DEPTNO
              ,CEIL( AVG(SAL))
   FROM EMP
 GROUP BY DEPTNO;
 
 --7-22
SELECT DEPTNO, JOB, AVG(SAL)
   FROM EMP
GROUP BY DEPTNO, JOB
   HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;

--7-23
SELECT DEPTNO, JOB, AVG(SAL)
   FROM EMP
WHERE SAL <= 3000
GROUP  BY DEPTNO, JOB
   HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;


--중간문제1
SELECT COUNT(*)
   FROM EMPLOYEES
WHERE SALARY >= 8000;

--중간문제2
SELECT COUNT(*)
   FROM EMPLOYEES
WHERE HIRE_DATE > '2007/01/01';

--중간문제3
SELECT SUM(MAX_SALARY), CEIL(AVG(MAX_SALARY))
   FROM JOBS;
   
--중간문제4
SELECT SUM(SALARY), AVG(SALARY)
   FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

--중간문제5
SELECT FIRST_NAME, SALARY,
               AVG(NVL(COMMISSION_PCT , 0)) 
               OVER (ORDER BY FIRST_NAME) COM_AVG,
               NVL(COMMISSION_PCT, 0)
   FROM EMPLOYEES
 WHERE DEPARTMENT_ID BETWEEN 50 AND 80;
 
 --중간문제6
 SELECT MIN(MAX_SALARY), MAX(MAX_SALARY)
    FROM JOBS;
    
--중간문제7
 SELECT MIN(MAX_SALARY), MAX(MAX_SALARY)
    FROM JOBS
WHERE JOB_TITLE = 'Programmer';


--중간문제8
SELECT MIN(HIRE_DATE), MAX(HIRE_DATE)
   FROM employees
WHERE DEPARTMENT_ID = 50;

--중간문제9
SELECT FIRST_NAME, SALARY,
              VARIANCE(SALARY) OVER(ORDER BY HIRE_DATE)
   FROM EMPLOYEES
WHERE DEPARTMENT_ID = 100;

--07-4 그룹화와 관련된 여러 함수 = ROLLUP, CUBE, GROUPING, SETS함수
--7-24 기존 GROUP BY절만 사용한 그룹화
SELECT  DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
   FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

--7-25 ROLLUP
SELECT  DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL))
   FROM EMP
 GROUP BY ROLLUP(DEPTNO, JOB);
 
 --ROLLUP(A,B)
 /*  
     1. A그룹별 B그룹별 해당하는 결과 출력
     2. A그룹에 해당하는 결과 출력
     3. 전체 데이터 결과 출력
 */
 
--7-26 CUBE
SELECT  DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL))
   FROM EMP
 GROUP BY CUBE(DEPTNO, JOB)
 ORDER BY DEPTNO, JOB;
 /*  CUBE(A, B) - 해당 항목 모든 경우의 수를 모두 집계 출력
     1. A그룹별 B그룹별 해당하는 결과 출력
     2. A그룹에 해당하는 결과 출력
     3. B그룹에 해당하는 결과 출력
     4. 전체 데이터 결과 출력
 */
 
 --7-27 DEPTNO를 먼저 그룹화한 후 ROLLUP 함수에 JOB 지정하기
 SELECT DEPTNO, JOB, COUNT(*)
    FROM EMP
 GROUP BY DEPTNO, ROLLUP(JOB);
 
  --7-28 JOB를 먼저 그룹화한 후 ROLLUP 함수에 DEPTNO 지정하기
 SELECT DEPTNO, JOB, COUNT(*)
    FROM EMP
 GROUP BY JOB, ROLLUP(DEPTNO);
 
 --7-29 GROUPING SETS 함수
 SELECT DEPTNO, JOB, COUNT(*)
    FROM EMP
GROUP BY GROUPING SETS(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

--7-30 DEPTNO, JOB 열의 그룹화 결과 여부를 GROUPING 함수로 확인하기
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL)),
               GROUPING(DEPTNO),
               GROUPING(JOB)
   FROM EMP
 GROUP BY  CUBE(DEPTNO, JOB)
 ORDER BY DEPTNO, JOB;
 
 --7-31 DECODE문으로 GROUPING 함수로 결과 표기하기
SELECT DECODE(GROUPING(DEPTNO), 1, 'ALL_DEPT', DEPTNO) AS DEPTNO,
               DECODE(GROUPING(JOB), 1, 'ALL_JOB', JOB) AS JOB,
               COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL))
   FROM EMP
 GROUP BY  CUBE(DEPTNO, JOB)
 ORDER BY DEPTNO, JOB;
 
SELECT DEPTNO
   FROM EMP
 GROUP BY DEPTNO;
 
 --7-33
 SELECT DEPTNO, ENAME
    FROM EMP
GROUP BY DEPTNO, ENAME;

--11G 버전부터
--LISTAGG() : 부서별 사원 이름을 나란히 나열하여 출력
--7-34
SELECT DEPTNO,
               LISTAGG(ENAME, ', ')
              WITHIN GROUP (ORDER BY SAL DESC) AS ENAMES
   FROM EMP
GROUP BY DEPTNO;

--7-38 DECODE문을 활용하여 PIVOT 함수와 같은 출력 구현
SELECT DEPTNO
              , MAX(DECODE(JOB, 'CLERK', SAL)) AS "CLERK"
              , MAX(DECODE(JOB, 'SALESMAN', SAL)) AS "SALESMAN"
              , MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS "PRESIDENT"
              , MAX(DECODE(JOB, 'ANALYST', SAL)) AS "ANALYST"
   FROM EMP
 GROUP BY DEPTNO
 ORDER BY DEPTNO;
 
 --7-36 PIVOT
 SELECT *
    FROM (SELECT DEPTNO, JOB, SAL
                     FROM EMP)
   PIVOT (MAX(SAL)
                 FOR DEPTNO IN (10, 20, 30)
                 )
 ORDER BY JOB;
 
 --7-37 부서별 직책 최고 급여 2차원 표 형태로 출력
  SELECT *
    FROM (SELECT DEPTNO, JOB, SAL
                     FROM EMP)
   PIVOT (MAX(SAL)
                 FOR JOB IN ('CLERK' AS CLERK,
                                         'SALESMAN' AS SALESMAN,
                                         'PRESIDENT' AS PRESIDENT,
                                         'MANAGER' AS MANAGER,
                                         'ANALYST' AS ANALYST)
                 )
 ORDER BY DEPTNO;

--7-39
SELECT *
    FROM(SELECT DEPTNO
              , MAX(DECODE(JOB, 'CLERK', SAL)) AS "CLERK"
              , MAX(DECODE(JOB, 'SALESMAN', SAL)) AS "SALESMAN"
              , MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS "PRESIDENT"
              , MAX(DECODE(JOB, 'ANALYST', SAL)) AS "ANALYST"
           FROM EMP
 GROUP BY DEPTNO
 ORDER BY DEPTNO)
 UNPIVOT(
      SAL FOR JOB IN (CLERK, SALESMAN, PRESIDENT, ANALYST))
ORDER BY DEPTNO, JOB;

--문제1
SELECT DEPTNO,
              CEIL( AVG(SAL)) AS AVG_SAL,
              MAX(SAL) AS MAX_SAL,
              MIN(SAL) AS MIN_SAL,
              COUNT(*) AS CNT
   FROM EMP
GROUP  BY DEPTNO;

--문제2
SELECT JOB,  COUNT(*)
   FROM  EMP
GROUP BY JOB
HAVING COUNT(JOB) >= 3;

--문제3
SELECT SUBSTR(HIREDATE , 1, 4) AS HIRE_YEAR , 
               DEPTNO,
               COUNT(*) AS CNT
   FROM EMP
GROUP BY SUBSTR(HIREDATE , 1, 4) , DEPTNO
ORDER BY SUBSTR(HIREDATE , 1, 4) , DEPTNO ;

--문제4
SELECT NVL2(COMM, '0', 'X') AS EXIST_COMM,
               COUNT(*) AS CNT
   FROM EMP
GROUP BY NVL2(COMM, '0', 'X')
ORDER BY NVL2(COMM, '0', 'X') DESC;

--문제5
SELECT DEPTNO,
               SUBSTR(HIREDATE , 1, 4) AS HIRE_YEAR , 
               COUNT(*) AS CNT,
               MAX(SAL) AS MAX_SAL,
               SUM(SAL) AS SUM_SAL,
               AVG(SAL) AS AVG_SAL
   FROM EMP
GROUP BY ROLLUP(DEPTNO, SUBSTR(HIREDATE , 1, 4));

