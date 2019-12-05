rem EE 562 Final
rem Varun Aggarwal
rem aggarw82

SET SERVEROUTPUT ON;
SET PAGESIZE 80;
SET LINESIZE 200;
SET FEEDBACK OFF;

/* Query 1 */
begin
DBMS_OUTPUT.PUT_LINE(chr(10));
DBMS_OUTPUT.PUT_LINE('==================================================');
DBMS_OUTPUT.PUT_LINE('Query 1');
DBMS_OUTPUT.PUT_LINE('==================================================');
end;
/
SELECT treatment, pid
FROM Patient
GROUP BY treatment, pid
ORDER BY treatment;

/* Query 2 */
begin
DBMS_OUTPUT.PUT_LINE(chr(10));
DBMS_OUTPUT.PUT_LINE('==================================================');
DBMS_OUTPUT.PUT_LINE('Query 2');
DBMS_OUTPUT.PUT_LINE('==================================================');
end;
/

SELECT UNIQUE(Dx.D_Name)
FROM ( SELECT D_Name, COUNT(*) AS cnt
	   FROM DOCTOR
	   GROUP BY D_Name) Dx,
	 ( SELECT D_Name, COUNT(*) AS cn
	   FROM DOCTOR
	   GROUP BY D_Name) Dy
GROUP BY Dx.D_Name, Dx.cnt
HAVING Dx.cnt = MIN(Dy.cn)
ORDER BY Dx.D_Name;

/* Query 3 */
begin
DBMS_OUTPUT.PUT_LINE(chr(10));
DBMS_OUTPUT.PUT_LINE('==================================================');
DBMS_OUTPUT.PUT_LINE('Query 3');
DBMS_OUTPUT.PUT_LINE('==================================================');
DBMS_OUTPUT.PUT_LINE(chr(10));
end;
/

DECLARE
    max_trt number := -1;
    CURSOR pat IS SELECT UNIQUE(pid) FROM PATIENT;
    cur pat%ROWTYPE;
    count_trt number;
    Avg_trt number;
BEGIN
    DBMS_OUTPUT.PUT_LINE(rpad('PID',10)||rpad('Avg Trt',10));
    DBMS_OUTPUT.PUT_LINE(rpad('---',10)||rpad('-------',10));
    FOR cur IN pat
    LOOP
        SELECT COUNT(UNIQUE(treatment)) INTO count_trt FROM PATIENT WHERE pid = cur.pid;
        IF count_trt > max_trt THEN
            max_trt := count_trt;
        END IF;
    END LOOP;

    FOR cur IN pat
    LOOP
        SELECT COUNT(UNIQUE(treatment)) INTO count_trt FROM PATIENT WHERE pid = cur.pid;
        IF count_trt = max_trt THEN
            SELECT AVG(TRI) INTO Avg_trt
            FROM ( SELECT pid, p_visit_number, COUNT(*) AS TRI
                   FROM PATIENT
                   WHERE pid = cur.pid
                   GROUP BY pid, p_visit_number );
            DBMS_OUTPUT.PUT_LINE(rpad(cur.pid,10)||rpad(Avg_trt,10));

        END IF;
    END LOOP;
END;
/

/* Query 4 */
begin
DBMS_OUTPUT.PUT_LINE(chr(10));
DBMS_OUTPUT.PUT_LINE('==================================================');
DBMS_OUTPUT.PUT_LINE('Query 4');
DBMS_OUTPUT.PUT_LINE('==================================================');
end;
/
SELECT DRI AS Doc_Name, SPI AS Treatment
FROM ( SELECT Dr.D_Name AS DRI, Dr.specialty AS SPI, PT.pid AS PID
       FROM DOCTOR DR JOIN ASSIGNMENT ASS ON DR.D_Name = ASS.D_Name
                      JOIN PATIENT PT ON PT.pid = ASS.pid
       WHERE DR.specialty = PT.treatment
       GROUP BY DR.D_Name, DR.specialty, PT.pid)  
GROUP BY DRI, SPI
HAVING COUNT(*) = 10;

SET FEEDBACK ON;
