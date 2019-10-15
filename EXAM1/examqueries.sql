rem EE 562 Exam 1
rem Varun Aggarwal
rem aggarw82

clear screen
SET SERVEROUTPUT ON
/* Create table*/
Create Table Patient(pid number, treatment varchar(20), p_visit_number number, Duration number, Primary key(pid, treatment, p_visit_number)); 
Create Table Doctor(D_name varchar(20), Speciality varchar(20), Primary key(D_name, Speciality));
Create Table Assignment(pid number, D_name varchar(20), p_visit_number number, Primary key(pid, D_name, p_visit_number));

/* Describe */
-- Describe Patient;
-- Describe Doctor;
-- Describe Assignment;

/* populate */
@populate

/* queires*/
EXEC DBMS_OUTPUT.PUT_LINE('Query 1');
SELECT Py.treatment
FROM Patient Py 
GROUP BY Py.treatment 
HAVING Count(*) > (SELECT Avg(tc) FROM (SELECT Px.pid, Count(*) AS tc FROM Patient Px GROUP BY Px.pid)); 

EXEC DBMS_OUTPUT.PUT_LINE('Query 2'); 	
SELECT D_name
FROM (SELECT D_name, MIN(vc) FROM (SELECT D_name, COUNT(p_visit_number) as vc FROM Assignment GROUP BY D_name) GROUP BY D_name);

EXEC DBMS_OUTPUT.PUT_LINE('Query 3'); 
SELECT Dy.D_name
FROM Doctor Dy
GROUP BY Dy.D_name
HAVING COUNT(*) > (SELECT AVG(cou) FROM (SELECT COUNT(*) as cou FROM Doctor Dx GROUP BY Dx.D_name));

EXEC DBMS_OUTPUT.PUT_LINE('Query 4'); 
SELECT DISTINCT Px.pid
FROM Patient Px
WHERE Px.Duration > (SELECT AVG(Py.Duration) FROM Patient Py);

EXEC DBMS_OUTPUT.PUT_LINE('Query 5'); 
SELECT pid
FROM (SELECT pid, MIN(tc) FROM (SELECT Px.pid, COUNT(DISTINCT px.treatment) AS tc FROM Patient Px GROUP BY Px.pid) GROUP BY pid);

EXEC DBMS_OUTPUT.PUT_LINE('Query 6'); 
SELECT Px.pid
FROM Patient Px
WHERE Px.treatment NOT IN (SELECT DISTINCT Dx.Speciality FROM Doctor Dx);

EXEC DBMS_OUTPUT.PUT_LINE('Query 7'); 
SELECT pid, p_visit_number
FROM Patient
WHERE p_visit_number < 5
ORDER BY pid;

EXEC DBMS_OUTPUT.PUT_LINE('Query 8'); 
SELECT Px.treatment, COUNT(*) * 50
FROM Patient Px
GROUP BY Px.treatment;

/* drop tables */
DROP TABLE Patient;
DROP TABLE Doctor;
DROP TABLE Assignment;
