---7�� ������ �Լ��� ������ �׷�ȭ
--7-1
SELECT SUM(SAL)
   FROM EMP;
   
--7-2 ���� �߻� GROUP BY �ʿ�
SELECT DEPTNO, SUM(SAL)
   FROM EMP;
 --GROUP BY DEPTNO;
 
 --7-3 ������ �Լ� : �ΰ� ���� ó��
 SELECT SUM(COMM) AS "�߰����� �հ�"
    FROM EMP;
    
--7-4 DISTINCT : �ߺ� ������ �����Ͽ� ���
SELECT SUM(DISTINCT SAL),
               SUM(ALL SAL),
               SUM(SAL)
   FROM EMP;
   
--7-5 EMP ���̺� �� ���� 
SELECT COUNT(COMM),
               COUNT(MGR),
               COUNT(EMPNO),
               COUNT(*), -- ��� ��
               COUNT(1) -- ù ��° �÷� , �ǹ�
   FROM EMP;
   
--7-6 �μ���ȭ�� 30�� ���� ��
SELECT COUNT(*)
   FROM EMP
WHERE DEPTNO = 30;


--7-7-- NULL �����ʹ� ��ȯ �������� ����
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

--7-10 10�� �μ����� �ִ�޿� ���
SELECT MAX(SAL)
   FROM EMP
WHERE DEPTNO = 10;

--7-11 10�� �μ����� �ּұ޿� ���
SELECT MIN(SAL)
   FROM EMP
WHERE DEPTNO = 10;

--7-12 20�� �μ����� ����� �Ի��� �� ���� �ֱ� �Ի��� ���
SELECT MAX(HIREDATE)
   FROM EMP
WHERE DEPTNO = 20;  --1980-07-13

--7-13 20�� �μ����� ����� �Ի��� �� ���� ������ �Ի��� ���
SELECT MIN(HIREDATE)
   FROM EMP
WHERE DEPTNO = 20;  --1980-12-17


--STDDEV ǥ������, VARIANCE�л�
SELECT CEIL(STDDEV(SAL)), CEIL( VARIANCE(SAL))
   FROM EMP;




--7-14 �μ� ��ȣ�� 30�� �������  ��� �޿� ���
SELECT  CEIL(AVG(SAL)) -- �ø���
             , FLOOR(AVG(COMM)) -- ������
             , SIGN(10-5)
             , SIGN(5-10) -- ������ ����� �� ���..? / ��� OR ����
             , SIGN(7-7)
   FROM EMP
WHERE DEPTNO = 30;

--7-15 DISTINCT�� �ߺ��� ������ �޿� ���� ��� �޿� ���
SELECT AVG(DISTINCT SAL)
   FROM EMP
WHERE DEPTNO = 30;

--07-2�� ������� ���ϴ� ���� ����ϴ� GROUP BY��
--7-16 ���� ������
SELECT CEIL( AVG(SAL)), '10' AS DEPTNO FROM EMP WHERE DEPTNO = 10
UNION
SELECT CEIL( AVG(SAL)), '20' AS DEPTNO FROM EMP WHERE DEPTNO = 20
UNION
SELECT CEIL( AVG(SAL)), '30' AS DEPTNO FROM EMP WHERE DEPTNO = 30;

--7-17
SELECT CEIL(AVG(SAL)), DEPTNO
   FROM EMP
GROUP BY DEPTNO;

--7-18 �μ� ��ȣ �� ��å�� ��� �޿��� ����
SELECT DEPTNO, JOB, AVG(SAL)
   FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

--7-19 GROUP BY���� ���� ���� SELECT���� �������� ��� ������
SELECT ENAME, DEPTNO, AVG(SAL)
   FROM EMP
GROUP BY DEPTNO; -- ENAME�� ���ԵǾ�� ��. / ORA-00979: not a GROUP BY expression ���� �߻�


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


--�߰�����1
SELECT COUNT(*)
   FROM EMPLOYEES
WHERE SALARY >= 8000;

--�߰�����2
SELECT COUNT(*)
   FROM EMPLOYEES
WHERE HIRE_DATE > '2007/01/01';

--�߰�����3
SELECT SUM(MAX_SALARY), CEIL(AVG(MAX_SALARY))
   FROM JOBS;
   
--�߰�����4
SELECT SUM(SALARY), AVG(SALARY)
   FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

--�߰�����5
SELECT FIRST_NAME, SALARY,
               AVG(NVL(COMMISSION_PCT , 0)) 
               OVER (ORDER BY FIRST_NAME) COM_AVG,
               NVL(COMMISSION_PCT, 0)
   FROM EMPLOYEES
 WHERE DEPARTMENT_ID BETWEEN 50 AND 80;
 
 --�߰�����6
 SELECT MIN(MAX_SALARY), MAX(MAX_SALARY)
    FROM JOBS;
    
--�߰�����7
 SELECT MIN(MAX_SALARY), MAX(MAX_SALARY)
    FROM JOBS
WHERE JOB_TITLE = 'Programmer';


--�߰�����8
SELECT MIN(HIRE_DATE), MAX(HIRE_DATE)
   FROM employees
WHERE DEPARTMENT_ID = 50;

--�߰�����9
SELECT FIRST_NAME, SALARY,
              VARIANCE(SALARY) OVER(ORDER BY HIRE_DATE)
   FROM EMPLOYEES
WHERE DEPARTMENT_ID = 100;

--07-4 �׷�ȭ�� ���õ� ���� �Լ� = ROLLUP, CUBE, GROUPING, SETS�Լ�
--7-24 ���� GROUP BY���� ����� �׷�ȭ
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
     1. A�׷캰 B�׷캰 �ش��ϴ� ��� ���
     2. A�׷쿡 �ش��ϴ� ��� ���
     3. ��ü ������ ��� ���
 */
 
--7-26 CUBE
SELECT  DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL))
   FROM EMP
 GROUP BY CUBE(DEPTNO, JOB)
 ORDER BY DEPTNO, JOB;
 /*  CUBE(A, B) - �ش� �׸� ��� ����� ���� ��� ���� ���
     1. A�׷캰 B�׷캰 �ش��ϴ� ��� ���
     2. A�׷쿡 �ش��ϴ� ��� ���
     3. B�׷쿡 �ش��ϴ� ��� ���
     4. ��ü ������ ��� ���
 */
 
 --7-27 DEPTNO�� ���� �׷�ȭ�� �� ROLLUP �Լ��� JOB �����ϱ�
 SELECT DEPTNO, JOB, COUNT(*)
    FROM EMP
 GROUP BY DEPTNO, ROLLUP(JOB);
 
  --7-28 JOB�� ���� �׷�ȭ�� �� ROLLUP �Լ��� DEPTNO �����ϱ�
 SELECT DEPTNO, JOB, COUNT(*)
    FROM EMP
 GROUP BY JOB, ROLLUP(DEPTNO);
 
 --7-29 GROUPING SETS �Լ�
 SELECT DEPTNO, JOB, COUNT(*)
    FROM EMP
GROUP BY GROUPING SETS(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

--7-30 DEPTNO, JOB ���� �׷�ȭ ��� ���θ� GROUPING �Լ��� Ȯ���ϱ�
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL)),
               GROUPING(DEPTNO),
               GROUPING(JOB)
   FROM EMP
 GROUP BY  CUBE(DEPTNO, JOB)
 ORDER BY DEPTNO, JOB;
 
 --7-31 DECODE������ GROUPING �Լ��� ��� ǥ���ϱ�
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

--11G ��������
--LISTAGG() : �μ��� ��� �̸��� ������ �����Ͽ� ���
--7-34
SELECT DEPTNO,
               LISTAGG(ENAME, ', ')
              WITHIN GROUP (ORDER BY SAL DESC) AS ENAMES
   FROM EMP
GROUP BY DEPTNO;

--7-38 DECODE���� Ȱ���Ͽ� PIVOT �Լ��� ���� ��� ����
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
 
 --7-37 �μ��� ��å �ְ� �޿� 2���� ǥ ���·� ���
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

--����1
SELECT DEPTNO,
              CEIL( AVG(SAL)) AS AVG_SAL,
              MAX(SAL) AS MAX_SAL,
              MIN(SAL) AS MIN_SAL,
              COUNT(*) AS CNT
   FROM EMP
GROUP  BY DEPTNO;

--����2
SELECT JOB,  COUNT(*)
   FROM  EMP
GROUP BY JOB
HAVING COUNT(JOB) >= 3;

--����3
SELECT SUBSTR(HIREDATE , 1, 4) AS HIRE_YEAR , 
               DEPTNO,
               COUNT(*) AS CNT
   FROM EMP
GROUP BY SUBSTR(HIREDATE , 1, 4) , DEPTNO
ORDER BY SUBSTR(HIREDATE , 1, 4) , DEPTNO ;

--����4
SELECT NVL2(COMM, '0', 'X') AS EXIST_COMM,
               COUNT(*) AS CNT
   FROM EMP
GROUP BY NVL2(COMM, '0', 'X')
ORDER BY NVL2(COMM, '0', 'X') DESC;

--����5
SELECT DEPTNO,
               SUBSTR(HIREDATE , 1, 4) AS HIRE_YEAR , 
               COUNT(*) AS CNT,
               MAX(SAL) AS MAX_SAL,
               SUM(SAL) AS SUM_SAL,
               AVG(SAL) AS AVG_SAL
   FROM EMP
GROUP BY ROLLUP(DEPTNO, SUBSTR(HIREDATE , 1, 4));

