--6장
-- 문자 데이터를 가공하는 문자함수 page 130
--6-1 UPPER, LOWER, INITCAP
SELECT ENAME,  UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
   FROM EMP;
   
--6-2
SELECT *
   FROM EMP
WHERE UPPER(ENAME) = UPPER('Scott');

--6-3
SELECT *
   FROM EMP
WHERE UPPER(ENAME) LIKE UPPER('%scott%');

--6-4
SELECT  ENAME, LENGTH(ENAME)
   FROM EMP;
   
--6-5
SELECT ENAME, LENGTH(ENAME)
   FROM EMP
WHERE LENGTH(ENAME) >= 5;

--6-6
SELECT LENGTH('한글'), LENGTHB('한글')
   FROM DUAL;
   
SELECT SYSDATE FROM DUAL;

--연습문제 : 직책 이름이 6글자 이상인 데이터 출력 쿼리 작성
SELECT *
   FROM EMP
WHERE LENGTH(JOB) >= 6;

--문자열 일부를 추출하는 SUBSTR 함수 [중요]
--6-7
SELECT JOB
                -- , SUBSTR(JOB, 1, 2)
                -- , SUBSTR(JOB, 3, 2)
                -- , SUBSTR(JOB, 5) -- 인덱스 아님 1부터 시작
                      , SUBSTR(JOB, -5) -- 끝에서부터 5번째 글자까지
   FROM EMP;
   
--연습문제 : 사원 이름을 세 번째 글자부터 끝까지 출력하는 쿼리 작성
SELECT ENAME, SUBSTR(ENAME, 3)
   FROM EMP;
   
-- SUBSTR & LENGTH 
--6-8
SELECT JOB
            , SUBSTR(JOB, -LENGTH(JOB)) -- 처음부터 끝까지
            , SUBSTR(JOB, -LENGTH(JOB), 2) -- 처음부터 2번째까지
            , SUBSTR(JOB, -3) -- 끝에서부터 3번째까지
   FROM EMP;
   
-- INSTR
--6-9
SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_1
            ,  INSTR('HELLO, ORACLE!', 'L' , 5) AS INSTR_2
            ,  INSTR('HELLO, ORACLE!', 'L' , 2, 2) AS INSTR_3   
   FROM DUAL;
   
--6-10
SELECT *
   FROM EMP
WHERE INSTR(ENAME, 'S') > 0;

--6-11
SELECT *
   FROM EMP
WHERE ENAME LIKE '%S%';

--REPLACE 함수
--6-12
SELECT '010-1234-5678' AS REPLACE_BEFORE,
                REPLACE( '010-1234-5678' , '-', ' ') AS REPLACE_1,
                REPLACE( '010-1234-5678' , '-') AS REPLACE_2
   FROM DUAL;
   
--LPAD, RPAD
SELECT 'Oracle'
              , LPAD( 'Oracle', 10, '#') AS LPAD_1
              , RPAD( 'Oracle', 10, '*') AS RPAD_1
              , LPAD( 'Oracle', 10) AS LPAD_2
              , RPAD( 'Oracle', 10) AS RPAD_2
    FROM DUAL;
    
--6-14
-- SUBSTR(JIMIN, 1, 7)
SELECT
               RPAD('971225-', 14, '*') AS RPAD_JMNO,
               RPAD('010-1234-', 13, '*') AS RPAD_PHONE
   FROM DUAL;
    
--6-15
-- 두 열 사이에 파이프(|) 
SELECT CONCAT (EMPNO, ENAME),
               CONCAT (EMPNO, CONCAT(' | ' , ENAME)),
               EMPNO | | '|' | | ENAME
    FROM EMP
WHERE ENAME = 'SCOTT';

--6-16
SELECT '[' || TRIM('  _ _Oracle_ _ ') || ']' AS TRIM,
               '[' || TRIM(LEADING FROM '  _ _Oracle_ _ ') || ']' AS TRIM_LEADING,
               '[' || TRIM(TRAILING FROM '_ _Oracle_ _   ') || ']' AS TRIM_TRAILING,
               '[' || TRIM(BOTH FROM '_ _Oracle_ _   ') || ']' AS TRIM_BOTH
    FROM DUAL;
    
--6-17
SELECT '[' || TRIM('_' FROM '_  _Oracle_  _ ') || ']' AS TRIM,
               '[' || TRIM(LEADING'_' FROM '_   _Oracle_   _') || ']' AS TRIM_LEADING,
               '[' || TRIM(TRAILING'_' FROM '_  _Oracle_  _') || ']' AS TRIM_TRAILING,
               '[' || TRIM(BOTH '_' FROM '_  _Oracle_  _') || ']' AS TRIM_BOTH
    FROM DUAL;
    
--6-18
SELECT '[' || TRIM('_  _Oracle_  _ ') || ']' AS TRIM,
               '[' || LTRIM(' _Oracle_ ') || ']' AS LTRIM,
               '[' || LTRIM('<_Oracle_> ' , '_<') || ']' AS LTRIM_2,
               '[' || RTRIM( ' _Oracle_ ') || ']' AS RTRIM,
               '[' || RTRIM( '<_Oracle_>', '>_') || ']' AS RTRIM_2
    FROM DUAL;
    
    
--문제1
SELECT JOB_TITLE, LOWER(JOB_TITLE), UPPER(JOB_TITLE)
   FROM JOBS;    
   
--문제2
SELECT SUBSTR(FIRST_NAME, 1, 1) ,
               LAST_NAME
   FROM EMPLOYEES;
   
--문제3
SELECT REPLACE(JOB_ID, 'REP' , 'REPRESENTATIVE') AS REPL
   FROM EMPLOYEES;
   
--문제4
SELECT  CONCAT (SUBSTR(FIRST_NAME, 1, 1), CONCAT (' ', LAST_NAME))    
   FROM EMPLOYEES;


--문제5
SELECT  LENGTH(FIRST_NAME)+LENGTH(LAST_NAME)
   FROM EMPLOYEES;
   
--문제6
SELECT JOB_ID, INSTR(JOB_ID, 'A')
   FROM EMPLOYEES;
   
--문제7
SELECT LPAD(CITY, 15, '.'), RPAD(CITY, 15,'.')
   FROM LOCATIONS;
   
--문제8
SELECT CITY, LTRIM(CITY, 'S'), RTRIM(CITY, 'e')
   FROM LOCATIONS
WHERE CITY LIKE 'S%' OR CITY LIKE '%e';


--06장 -3절 함수
--ROUND 반올림 함수 
--6-19
SELECT ROUND(1234.5678) AS ROUND
              ,ROUND(1234.5678, 0) AS ROUND_0--소수점 첫째 자리에서 반올림 출력
              ,ROUND(1234.5678, 1) AS ROUND_1 -- 소수점 둘째 자리에서 반올림 출력
              ,ROUND(1234.5678, 2) AS ROUND_2 -- 소수점 셋째 자리에서 반올림 출력
              ,ROUND(1234.5678, -1) AS ROUND_MINUS1 --자연수 첫째자리에서 반올림
              ,ROUND(1234.5678, -2) AS ROUND_MINUS2--자연수 둘째자리에서 반올림
   FROM DUAL;
   
--TRUNC 버림 함수
--6-20
SELECT TRUNC(1234.5678) AS TRUNC
              ,TRUNC(1234.5678, 0) AS TRUNC_0--소수점 첫째 자리에서 버림
              ,TRUNC(1234.5678, 1) AS TRUNC_1 -- 소수점 둘째 자리에서 버림 출력
              ,TRUNC(1234.5678, 2) AS TRUNC_2 -- 소수점 셋째 자리에서 버림 출력
              ,TRUNC(1234.5678, -1) AS TRUNC_MINUS1 --자연수 첫째자리에서 버림
              ,TRUNC(1234.5678, -2) AS TRUNC_MINUS2--자연수 둘째자리에서 버림
   FROM DUAL;
   
--CEIL(입력된 숫자와 가까운 큰 정수) , FLOOR(입력된 숫자와 가까운 작은 정수) 함수
--6-21
SELECT CEIL(3.14)
              ,FLOOR(3.14)
              ,CEIL(-3.14)
              ,FLOOR(-3.14)
   FROM DUAL;

--MOD 나머지 함수
--6-22
SELECT MOD(15, 6)
              ,MOD(10,2)
              ,MOD(11,2)
   FROM DUAL;
   
-- 날짜 함수
--6-23
SELECT SYSDATE AS NOW
              ,SYSDATE -1 AS YESTERDAY
              ,SYSDATE +1 AS TOMORROW
   FROM DUAL;
   
--6-24
SELECT SYSDATE
             , ADD_MONTHS(SYSDATE, 4) + 17
    FROM DUAL;
    
--6-25 입사 10주년
SELECT  EMPNO, ENAME, HIREDATE,
                ADD_MONTHS(HIREDATE, 120) AS WORK10YEAR
   FROM EMP;
   
SELECT 12 * 38 FROM DUAL; --456개월

SELECT  EMPNO, ENAME, HIREDATE,
                ADD_MONTHS(HIREDATE, 456) AS WORK38YEAR
   FROM EMP;
   
--6-26 입사 38년 미만인 사원
SELECT  EMPNO, ENAME, HIREDATE,
                ADD_MONTHS(HIREDATE, 456) AS WORK38YEAR
   FROM EMP
WHERE ADD_MONTHS(HIREDATE, 456) > SYSDATE;
    
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3) EMPL
   FROM DUAL;
   
--6-27 MONTHS_BETWEEN
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
               MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTHS1,
               MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTHS2,
               TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH3
   FROM EMP;
   
--NEXT_DAY, LAST_DAY
--6-28
SELECT SYSDATE,
                NEXT_DAY(SYSDATE, '월요일'),
                LAST_DAY(SYSDATE)
  FROM DUAL;
  
--6-29
SELECT SYSDATE,
               TRUNC(SYSDATE, 'YYYY') AS FYYYY,
               TRUNC(SYSDATE, 'Q') AS FYYYY,
               TRUNC(SYSDATE, 'DDD') AS FYYYY
    FROM DUAL;
    
--6-33
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') SYSD
             , TO_CHAR(SYSDATE, 'YYYY') YYYY
             , TO_CHAR (SYSDATE, 'DAY') DAY
             , TO_CHAR (SYSDATE, 'DY') DY
             , TO_CHAR (SYSDATE, 'DD') DD
             , TO_CHAR (SYSDATE, 'MONTH') MONTH
            , TO_CHAR (SYSDATE, 'MON') MON
            , TO_CHAR (SYSDATE, 'MM') MON
   FROM DUAL;
   
   --6-35
SELECT SYSDATE
              , TO_CHAR (SYSDATE, 'MM') MM
             , TO_CHAR(SYSDATE, 'MON')MM 
             , TO_CHAR(SYSDATE, 'MON', NLS_DATE_LANGUAGE = JAPANESE') MON_JAPAN 
             , TO_CHAR(SYSDATE, 'MON', NLS_DATE_LANGUAGE = ENGLISH')MON_JAPAN 
   FROM DUAL;
   
--6-38 숫자형식
SELECT SAL, TO_CHAR(SAL, '999,999') SAL_1,
               TO_CHAR(SAL, '$999,999') SAL_1,
               TO_CHAR(SAL, 'L999,999') SAL_1,
               TO_CHAR(SAL, '000999999') SAL_2,
   FROM EMP;
   
--문자열을 숫자로
SELECT TO_NUMBER('1,300', '999,999')
             - TO_NUMBER('1,500', '999,999')
    FROM DUAL;
    
--문자열을 날짜 데이타 변환
SELECT TO_DATE('2024-06-05', 'YYYY-MM-DD') AS TODATE,
               TO_DATE('20240605', 'YYYY-MM-DD') AS TODATE2
  FROM DUAL;
  
--6-45
SELECT EMPNO, ENAME, SAL, COMM
              , SAL*12+NVL(COMM,0) AS ANNSAL
              , NVL2(COMM, '널아님', '널임') N2
                               -- 값이 있다면 , 없을 때
              , NVL2(COMM, SAL*12+COMM, SAL*12) ANN_SAL
   FROM EMP;
   
--6-47
SELECT EMPNO, ENAME, JOB, SAL,
               DECODE(JOB, 'MANAGER', SAL*1.1, 
                                           'SALESMAN', SAL*1.05,
                                           'ANALYSY', SAL,
                                           SAL*1.03) AS UPSAL
   FROM EMP;                                        
   
--CASE문
--6-48
SELECT EMPNO, ENAME, JOB, SAL,
               CASE JOB
                           WHEN 'MANAGER' THEN SAL*1.1
                           WHEN 'SALESMAN'THEN SAL*1.05
                            WHEN 'ANALYSY' THEN SAL
                            ELSE SAL*1.03
                            END AS UPSAL
   FROM EMP;                                       
   
--6-49
SELECT EMPNO, ENAME, COMM,
           CASE WHEN COMM IS NULL THEN '해당사항 없음'
                      WHEN COMM = 0 THEN '수당없음'
                      WHEN COMM > 0 THEN '수당 : ' || COMM
                    END AS COMM_TEXT
            FROM EMP;
            

--연습문제1
SELECT EMPNO,
       RPAD(SUBSTR(EMPNO, -LENGTH(EMPNO),2), LENGTH(EMPNO), '*') AS MASKING_EMPNO,
       SUBSTR(ENAME, 1, 5) AS ENAME,
       RPAD(SUBSTR(ENAME, -LENGTH(ENAME),1), LENGTH(ENAME), '*') AS MASKING_ENAME
  FROM EMP;
  
--연습문제1-2
SELECT EMPNO,
    RPAD(SUBSTR(EMPNO, 1, 2), 4, '*') AS MASKING_EMPNO,
    SUBSTR(ENAME, 1, 5) AS ENAME,
    RPAD(SUBSTR(ENAME, 1,1), LENGTH(ENAME), '*') AS MASKING_ENAME
  FROM EMP
WHERE LENGTH(ENAME) = 5;


--연습문제2
SELECT EMPNO, ENAME, SAL,
 TRUNC(SAL/21.5,2)AS DAY_PAY,
 ROUND(SAL/21.5/8,1) AS TIME_PAY
  FROM EMP;


--연습문제3
SELECT EMPNO,ENAME, HIREDATE,
       TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3),'월요일'), 'YYYY-MM-DD') AS R_JOB,
       NVL(TO_CHAR(COMM), 'N/A')AS COMM,
       -- NVL() : NULL 값을 특정한 값으로 치환하는 함수
       NVL2(COMM, '수당 존재함', '없음') AS COMM_YN,  -- ?         :       :
       -- NVL2() : NULL 값인 경우와 아닌 경우를 구분하여 특정한 값으로 치환하는 함수
       NVL2(COMM, TO_CHAR(COMM), 'N/A') AS COMM
  FROM EMP;


--연습문제4
SELECT EMPNO, ENAME, MGR,
--CASE() : 복잡한 논리 조건 처리 함수
    CASE
    WHEN MGR IS NULL THEN '0000'
    WHEN SUBSTR(MGR, 1, 2) = '75' THEN '5555'
    WHEN SUBSTR(MGR, 1, 2) = '76' THEN '6666'
    WHEN SUBSTR(MGR, 1, 2) = '77' THEN '7777'
    WHEN SUBSTR(MGR, 1, 2) = '78' THEN '8888'
    ELSE TO_CHAR(MGR)
   END AS CHG_MGR
  FROM EMP;
  
--연습문제4-1
SELECT EMPNO, ENAME, MGR,
--DECODE() : 데이터가 조건 값과 일치하면 치환값을 출력하고
--                    일치하지 않으면 기본값을 출력하는 조건 논리 처리 함수                    
    DECODE(SUBSTR(MGR, 1, 2) , NULL, '0000',
                                     75, '5555', 76, '6666',
                                     77, '7777', 78, '8888', TO_CHAR(MGR)) AS CHG_MGR
   FROM EMP;                                

--자동 형변환
SELECT 1+ '2' FROM DUAL;

--순위함수
SELECT FIRST_NAME, SALARY,
    RANK() OVER(ORDER BY SALARY DESC) AS RANL, -- 공통 순위는 건너띄어 다음 순위 출력
    DENSE_RANK() OVER(ORDER BY SALARY DESC) AS DENSE_RANL, -- 공통 순위는 건너띄지 않고 다음 순위 출력
    ROW_NUMBER() OVER(ORDER BY SALARY DESC) ROW_NUMBER
   FROM EMPLOYEES;

   

    
