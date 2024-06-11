--9장 서브쿼리
--9-1 JONES인 사원의 급여 출력
SELECT SAL
  FROM EMP
WHERE ENAME = 'JONES';

--9-2 급여가 2975보다 높은 사원 정보 출력
SELECT *
 FROM EMP
WHERE SAL > 2975;

--9-3 서브쿼리로 JONES의 급여보다 높은 급여 받는 사원 정보 출력
SELECT *
 FROM EMP
WHERE SAL > (SELECT SAL
                       FROM EMP
                     WHERE ENAME = 'JONES'); -- 2975, 단일행 서브쿼리
                     
--서브쿼리 특징
-- 1. 괄호 ( )로 묶어서 사용.
-- 2. 특수한 경우를 제외한 대부분의 서브쿼리에는 ORDER BY절 사용할 수 없음.
-- 3. 서브쿼리의 SELECT절에 명시한 열은 메인쿼리의 비교 대상과 같은 자료형과 같은 개수로 지정해야 함.
-- 4. 서브쿼리에 있는 SELECT문의 결과 행 수는 함께 사용하는 메인쿼리의 연산자 종류와 호환 가능해야 함. (EX 단일행이라면 단일행 연산자를 사용)

-- 1분 복습 -- 사원 정보 중에서 사원 이름이 'ALLEN'인 사원의 추가 수당보다 많은 사람 구하기
SELECT *
 FROM EMP
WHERE COMM > (SELECT COMM
                           FROM EMP
                         WHERE ENAME = 'ALLEN');
                         
--9-4
SELECT *
 FROM EMP
WHERE HIREDATE < (SELECT HIREDATE
                               FROM EMP
                             WHERE ENAME = 'SCOTT');

SELECT *
 FROM EMPLOYEES
WHERE SALARY = ( SELECT SALARY
                             FROM EMPLOYEES
                           WHERE HIRE_DATE = '2006/01/03');
                           
--단일행 서브쿼리와 함수
--9-5 사원정보에서 평균 급여보다 많이 받는 사람 출력
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL,
           D.DEPTNO, D.DNAME, D.LOC
 FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND E.DEPTNO = 20
    AND E.SAL > (SELECT AVG(SAL)
                          FROM EMP);
                                 
--1분 복습
-- 전체 사원의 평균급여보다 작거나 같은 급여를 받고 있는 
-- 20번 부서의 사원 및 부서정보를 구하도록 쿼리 작성
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL,
           D.DEPTNO, D.DNAME, D.LOC
 FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND E.DEPTNO = 20
    AND E.SAL <= (SELECT AVG(SAL)
                            FROM EMP);
                            
--다중행 서브쿼리 연산자 : IN, ANY/SOME, ALL, EXISTS
--9-6
SELECT *
 FROM EMP
WHERE DEPTNO IN (20, 30);

--9-7 각 부서별 최고 급여와 동일한 급여를 받는 사원 정보 출력
SELECT *
 FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
                        FROM EMP
                      GROUP BY DEPTNO);
                      
--ANY / SOME 연산자
-- (조건식을 사용한 결과가 하나라도 TRUE 라면 메인쿼리 조건식을 TRUE로 반환해 주는 연산자)
--9-9
SELECT *
 FROM EMP
WHERE SAL = ANY (SELECT MAX(SAL)
                              FROM EMP
                            GROUP BY DEPTNO);
  
--9-10
SELECT *
 FROM EMP
WHERE SAL = SOME (SELECT MAX(SAL)
                                FROM EMP
                              GROUP BY DEPTNO);
                              
--30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원정보 출력하기
SELECT *
 FROM EMP
WHERE SAL < ANY (SELECT SAL
                              FROM EMP
                            WHERE DEPTNO = 30)
ORDER BY SAL, EMPNO; -- 2850보다 작게 받는 사원             

-- < ANY는 서브쿼리에 MAX 함수를 사용한 경우
SELECT *
 FROM EMP
WHERE SAL <  (SELECT MAX(SAL)
                              FROM EMP
                            WHERE DEPTNO = 30)
ORDER BY SAL, EMPNO;

--30번 부서 사원들의 최소 급여보다 많은 급여를 받는 사원정보 - 다중행 연산자 사용
SELECT *
 FROM EMP
WHERE SAL > ANY (SELECT SAL
                              FROM EMP
                            WHERE DEPTNO = 30);
                            
--ALL : 서브쿼리의 모든 결과가 조건식에 맞아야 TRUE
--9-14 부서번호가 30번인 사원들의 최소 급여보다 더 적은 급여를 받는 사원 출력
SELECT *
 FROM EMP
WHERE SAL < ALL(SELECT SAL
                           FROM EMP
                          WHERE DEPTNO = 30);
                          
 --9-15 부서번호가 30번인 사원들의 최대 급여보다 더 많은 급여를 받는 사원 출력
SELECT *
 FROM EMP
WHERE SAL > ALL(SELECT SAL
                           FROM EMP
                          WHERE DEPTNO = 30);
                          
--EXISTS 연산자 : 서브쿼리 결과 값이 존재하는 경우
--9-16
SELECT *
 FROM EMP
WHERE EXISTS (SELECT DNAME
                        FROM DEPT
                      WHERE DEPTNO = 10);
                      
--9-17
SELECT *
 FROM EMP
WHERE EXISTS (SELECT DNAME
                        FROM DEPT
                      WHERE DEPTNO = 50);      
                      
--1분 복습 : 다중행 연산자 사용
-- EMP 테이블의 사원 중에 10번 부서에 속한 모든 사원들보다 일찍 입사한 사원 정보를 출력
SELECT *
 FROM EMP
WHERE HIREDATE < ALL (SELECT HIREDATE
                                     FROM EMP
                                   WHERE DEPTNO = 10);
                                   
--상관 쿼리
-- : 메인쿼리와 서브쿼리 간에 서로 상관 참조하는 쿼리
--EX) 사원이 한 명이라도 있는 부서명 출력
SELECT DNAME
 FROM DEPT D
WHERE EXISTS (SELECT 1 FROM EMP WHERE DEPTNO = D.DEPTNO);

SELECT EMPNO FROM EMP WHERE DEPTNO = 10; -- ACCOUNTING
SELECT EMPNO FROM EMP WHERE DEPTNO = 20; -- RESEARCH
SELECT EMPNO FROM EMP WHERE DEPTNO = 30; -- SALES
SELECT EMPNO FROM EMP WHERE DEPTNO = 40; -- OPERATIONS // 결과값 없음

SELECT * FROM EMP;

--비교할 열이 여러 개인 다중열 서브쿼리

--9-18 : 다중열 서브쿼리 사용하기
SELECT *
 FROM EMP
 WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                                        FROM EMP
                                        GROUP BY DEPTNO);
                                        
-- 각 부서의 최대급여를 받는 사원의 부서코드, 이름, 급여를 출력하는데,
-- 부서코드 순으로 오름차순 정렬하여 출력하는 쿼리 작성
SELECT DEPTNO, ENAME, SAL
 FROM EMP E
WHERE SAL = (SELECT MAX(SAL)
                     FROM EMP
                     WHERE DEPTNO = E.DEPTNO)
ORDER BY DEPTNO;                     
                                        
-- SELECT절의 서브쿼리 : 스칼라쿼리 , 상관커리
SELECT E.EMPNO, E.ENAME, E.DEPTNO,
           (SELECT DNAME FROM DEPT WHERE DEPTNO = E.DEPTNO) DNAME
 FROM EMP E;        
 
 SELECT E.EMPNO, E.ENAME, E.DEPTNO,
            D.DNAME
 FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
 
 
 -- FROM 절에 사용하는 서브쿼리와 WITH절
 SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
  FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10,
            (SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;            

--WITH절 사용하기
WITH
E10 AS (SELECT * FROM EMP WHERE DEPTNO = 10),
D    AS (SELECT * FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
  FROM E10, D
WHERE E10.DEPTNO = D.DEPTNO;

-- 한 발 더 나아가기 / 상호 연관 서브쿼리
SELECT *
 FROM EMP E1
WHERE SAL > (SELECT MIN(SAL)
                      FROM EMP E2
                      WHERE E2.DEPTNO = E1.DEPTNO)
ORDER BY DEPTNO, SAL;              

--9-21 SELECT절에 서브쿼리 사용하기 스칼라 서브쿼리
SELECT EMPNO, ENAME, JOB, SAL,
           (SELECT GRADE
             FROM SALGRADE
            WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE,
            DEPTNO,
            (SELECT DNAME
              FROM DEPT
            WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME
            , (SELECT ENAME FROM EMP WHERE EMPNO = E.MGR) AS MGR
  FROM EMP E;
  
--문제1
SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME
 FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND E.JOB = (SELECT JOB
                        FROM EMP
                        WHERE ENAME = 'ALLEN');
                        
--문제2
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC, E.SAL,
           (SELECT GRADE
             FROM SALGRADE
             WHERE E.SAL BETWEEN LOSAL AND HISAL) AS GRADE
 FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND SAL > (SELECT AVG(SAL)
                      FROM EMP)
ORDER BY E.SAL DESC, EMPNO ASC;                  

--문제3
SELECT E.EMPNO, E.ENAME, E.JOB, D.DEPTNO, D.DNAME, D.LOC
 FROM  EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND E.DEPTNO = 10
    AND JOB NOT IN (SELECT JOB
                                FROM EMP
                              WHERE DEPTNO = 30);
                              
SELECT E.EMPNO, E.ENAME, E.JOB, D.DEPTNO, D.DNAME, D.LOC
 FROM  EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND E.DEPTNO = 10
    AND NOT EXISTS (SELECT JOB FROM EMP
                               WHERE DEPTNO = 30 AND JOB = E.JOB);                              
                       
--문제4
SELECT EMPNO, ENAME, SAL,
            (SELECT GRADE
             FROM SALGRADE
             WHERE SAL BETWEEN LOSAL AND HISAL) AS GRADE
 FROM EMP 
WHERE SAL > (SELECT MAX(SAL)
                      FROM EMP
                      WHERE JOB = 'SALESMAN')
ORDER BY EMPNO;                      
                      
                      
SELECT EMPNO, ENAME, SAL,
           (SELECT GRADE
             FROM SALGRADE
             WHERE SAL BETWEEN LOSAL AND HISAL) AS GRADE
 FROM EMP
WHERE SAL > ALL (SELECT SAL
                           FROM EMP
                           WHERE JOB = 'SALESMAN')
ORDER BY EMPNO;        
  

  