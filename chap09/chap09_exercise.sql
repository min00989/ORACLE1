--9�� ��������
--9-1 JONES�� ����� �޿� ���
SELECT SAL
  FROM EMP
WHERE ENAME = 'JONES';

--9-2 �޿��� 2975���� ���� ��� ���� ���
SELECT *
 FROM EMP
WHERE SAL > 2975;

--9-3 ���������� JONES�� �޿����� ���� �޿� �޴� ��� ���� ���
SELECT *
 FROM EMP
WHERE SAL > (SELECT SAL
                       FROM EMP
                     WHERE ENAME = 'JONES'); -- 2975, ������ ��������
                     
--�������� Ư¡
-- 1. ��ȣ ( )�� ��� ���.
-- 2. Ư���� ��츦 ������ ��κ��� ������������ ORDER BY�� ����� �� ����.
-- 3. ���������� SELECT���� ����� ���� ���������� �� ���� ���� �ڷ����� ���� ������ �����ؾ� ��.
-- 4. ���������� �ִ� SELECT���� ��� �� ���� �Բ� ����ϴ� ���������� ������ ������ ȣȯ �����ؾ� ��. (EX �������̶�� ������ �����ڸ� ���)

-- 1�� ���� -- ��� ���� �߿��� ��� �̸��� 'ALLEN'�� ����� �߰� ���纸�� ���� ��� ���ϱ�
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
                           
--������ ���������� �Լ�
--9-5 ����������� ��� �޿����� ���� �޴� ��� ���
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL,
           D.DEPTNO, D.DNAME, D.LOC
 FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND E.DEPTNO = 20
    AND E.SAL > (SELECT AVG(SAL)
                          FROM EMP);
                                 
--1�� ����
-- ��ü ����� ��ձ޿����� �۰ų� ���� �޿��� �ް� �ִ� 
-- 20�� �μ��� ��� �� �μ������� ���ϵ��� ���� �ۼ�
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL,
           D.DEPTNO, D.DNAME, D.LOC
 FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND E.DEPTNO = 20
    AND E.SAL <= (SELECT AVG(SAL)
                            FROM EMP);
                            
--������ �������� ������ : IN, ANY/SOME, ALL, EXISTS
--9-6
SELECT *
 FROM EMP
WHERE DEPTNO IN (20, 30);

--9-7 �� �μ��� �ְ� �޿��� ������ �޿��� �޴� ��� ���� ���
SELECT *
 FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
                        FROM EMP
                      GROUP BY DEPTNO);
                      
--ANY / SOME ������
-- (���ǽ��� ����� ����� �ϳ��� TRUE ��� �������� ���ǽ��� TRUE�� ��ȯ�� �ִ� ������)
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
                              
--30�� �μ� ������� �ִ� �޿����� ���� �޿��� �޴� ������� ����ϱ�
SELECT *
 FROM EMP
WHERE SAL < ANY (SELECT SAL
                              FROM EMP
                            WHERE DEPTNO = 30)
ORDER BY SAL, EMPNO; -- 2850���� �۰� �޴� ���             

-- < ANY�� ���������� MAX �Լ��� ����� ���
SELECT *
 FROM EMP
WHERE SAL <  (SELECT MAX(SAL)
                              FROM EMP
                            WHERE DEPTNO = 30)
ORDER BY SAL, EMPNO;

--30�� �μ� ������� �ּ� �޿����� ���� �޿��� �޴� ������� - ������ ������ ���
SELECT *
 FROM EMP
WHERE SAL > ANY (SELECT SAL
                              FROM EMP
                            WHERE DEPTNO = 30);
                            
--ALL : ���������� ��� ����� ���ǽĿ� �¾ƾ� TRUE
--9-14 �μ���ȣ�� 30���� ������� �ּ� �޿����� �� ���� �޿��� �޴� ��� ���
SELECT *
 FROM EMP
WHERE SAL < ALL(SELECT SAL
                           FROM EMP
                          WHERE DEPTNO = 30);
                          
 --9-15 �μ���ȣ�� 30���� ������� �ִ� �޿����� �� ���� �޿��� �޴� ��� ���
SELECT *
 FROM EMP
WHERE SAL > ALL(SELECT SAL
                           FROM EMP
                          WHERE DEPTNO = 30);
                          
--EXISTS ������ : �������� ��� ���� �����ϴ� ���
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
                      
--1�� ���� : ������ ������ ���
-- EMP ���̺��� ��� �߿� 10�� �μ��� ���� ��� ����麸�� ���� �Ի��� ��� ������ ���
SELECT *
 FROM EMP
WHERE HIREDATE < ALL (SELECT HIREDATE
                                     FROM EMP
                                   WHERE DEPTNO = 10);
                                   
--��� ����
-- : ���������� �������� ���� ���� ��� �����ϴ� ����
--EX) ����� �� ���̶� �ִ� �μ��� ���
SELECT DNAME
 FROM DEPT D
WHERE EXISTS (SELECT 1 FROM EMP WHERE DEPTNO = D.DEPTNO);

SELECT EMPNO FROM EMP WHERE DEPTNO = 10; -- ACCOUNTING
SELECT EMPNO FROM EMP WHERE DEPTNO = 20; -- RESEARCH
SELECT EMPNO FROM EMP WHERE DEPTNO = 30; -- SALES
SELECT EMPNO FROM EMP WHERE DEPTNO = 40; -- OPERATIONS // ����� ����

SELECT * FROM EMP;

--���� ���� ���� ���� ���߿� ��������

--9-18 : ���߿� �������� ����ϱ�
SELECT *
 FROM EMP
 WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                                        FROM EMP
                                        GROUP BY DEPTNO);
                                        
-- �� �μ��� �ִ�޿��� �޴� ����� �μ��ڵ�, �̸�, �޿��� ����ϴµ�,
-- �μ��ڵ� ������ �������� �����Ͽ� ����ϴ� ���� �ۼ�
SELECT DEPTNO, ENAME, SAL
 FROM EMP E
WHERE SAL = (SELECT MAX(SAL)
                     FROM EMP
                     WHERE DEPTNO = E.DEPTNO)
ORDER BY DEPTNO;                     
                                        
-- SELECT���� �������� : ��Į������ , ���Ŀ��
SELECT E.EMPNO, E.ENAME, E.DEPTNO,
           (SELECT DNAME FROM DEPT WHERE DEPTNO = E.DEPTNO) DNAME
 FROM EMP E;        
 
 SELECT E.EMPNO, E.ENAME, E.DEPTNO,
            D.DNAME
 FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
 
 
 -- FROM ���� ����ϴ� ���������� WITH��
 SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
  FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10,
            (SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;            

--WITH�� ����ϱ�
WITH
E10 AS (SELECT * FROM EMP WHERE DEPTNO = 10),
D    AS (SELECT * FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
  FROM E10, D
WHERE E10.DEPTNO = D.DEPTNO;

-- �� �� �� ���ư��� / ��ȣ ���� ��������
SELECT *
 FROM EMP E1
WHERE SAL > (SELECT MIN(SAL)
                      FROM EMP E2
                      WHERE E2.DEPTNO = E1.DEPTNO)
ORDER BY DEPTNO, SAL;              

--9-21 SELECT���� �������� ����ϱ� ��Į�� ��������
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
  
--����1
SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME
 FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND E.JOB = (SELECT JOB
                        FROM EMP
                        WHERE ENAME = 'ALLEN');
                        
--����2
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC, E.SAL,
           (SELECT GRADE
             FROM SALGRADE
             WHERE E.SAL BETWEEN LOSAL AND HISAL) AS GRADE
 FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND SAL > (SELECT AVG(SAL)
                      FROM EMP)
ORDER BY E.SAL DESC, EMPNO ASC;                  

--����3
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
                       
--����4
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
  

  