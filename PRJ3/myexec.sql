rem EE 562 Project 3
rem Varun Aggarwal
rem aggarw82

/* Output Configuration */
set linesize 200;
set pagesize 70;
set SERVEROUTPUT ON;

/* create table */
begin
dbms_output.put_line(chr(10));
dbms_output.put_line('==================================================');
dbms_output.put_line('Create Tables');
dbms_output.put_line('==================================================');
end;
/
@createtable


/* creating extra tables */
@beds
@flow
@table_qu1
@table_qu4
@coal


/* triggers, functions, procedures */ 
begin
dbms_output.put_line(chr(10));
dbms_output.put_line('==================================================');
dbms_output.put_line('Create Triggers and Procedures');
dbms_output.put_line('==================================================');
end;
/
@trg
SET FEEDBACK OFF;


/* populate table */
@populate


/* Populate Doctor Schedule */
EXEC populate_dr();


/* Populate Surgeon Schedule */
EXEC populate_sr();


/* Show Patient Schedule */
begin
dbms_output.put_line(chr(10));
dbms_output.put_line('==================================================');
dbms_output.put_line('Patient Schedule');
dbms_output.put_line('==================================================');
end;
/

SELECT * FROM Flow;


/* Show Assistant Doctor Schedule */
begin
dbms_output.put_line(chr(10));
dbms_output.put_line('==================================================');
dbms_output.put_line('Assistant Doctor Schedule');
dbms_output.put_line('==================================================');
end;
/

-- Select * from DR_Schedule;


/* Show Surgeon Schedule */
begin
dbms_output.put_line(chr(10));
dbms_output.put_line('==================================================');
dbms_output.put_line('Surgeon Schedule');
dbms_output.put_line('==================================================');
end;
/

-- Select * from Surgeon_Schedule;


---------------------------------------------------------------------------------
begin
dbms_output.put_line(chr(10));
dbms_output.put_line('==================================================');
dbms_output.put_line('Create AND Display Patient Surgery View');
dbms_output.put_line('==================================================');
end;
/

CREATE TABLE Patient_Surgery_Table( Pname varchar(30),
									Psur_date date,
									Sname varchar(30)
									);
TRUNCATE TABLE Patient_Surgery_Table;
DECLARE
	
	sur_name1 varchar2(30);
	sur_name2 varchar2(30);
	sur_name3 varchar2(30);
	sur_date date;
	CURSOR pat IS SELECT Pname, Ptype, Post_Date, Scount FROM Flow;
	cur pat%ROWTYPE;

BEGIN
	
	FOR cur IN pat
	LOOP
		IF cur.Ptype = 'Cardiac' THEN sur_name1 := 'Dr. Charles'; sur_name2 := 'Dr. Gower';
		ELSIF cur.Ptype = 'Neuro' THEN sur_name1 := 'Dr. Taylor'; sur_name2 := 'Dr. Rutherford';
		ELSE sur_name1 := 'Dr. Smith'; sur_name2 := 'Dr. Richards';
		END IF;

		sur_date := cur.Post_Date;

		SELECT Name INTO sur_name3 
		FROM ((SELECT Name FROM Surgeon_Schedule WHERE Surgery_Date = sur_date AND Name = sur_name1) 
			  UNION
			  (SELECT Name FROM Surgeon_Schedule WHERE Surgery_Date = sur_date AND Name = sur_name2));

		INSERT INTO Patient_Surgery_Table VALUES (cur.Pname, sur_date, sur_name3);

		-- adding surgeon for second patient
		IF cur.Scount = 2 THEN
			sur_date := sur_date + 2;
			SELECT Name INTO sur_name3 
			FROM ((SELECT Name FROM Surgeon_Schedule WHERE Surgery_Date = sur_date AND Name = sur_name1) 
				  UNION
				  (SELECT Name FROM Surgeon_Schedule WHERE Surgery_Date = sur_date AND Name = sur_name2));

			INSERT INTO Patient_Surgery_Table VALUES (cur.Pname, cur.Post_Date + 2, sur_name3);

		END IF;

	END LOOP;

END;
/

BEGIN
	IF dr_sr_schedule_verify(0) = 0 THEN
		DBMS_OUTPUT.PUT_LINE('Problem with assistant doctor schedule');
	END IF;

	IF dr_sr_schedule_verify(1) = 0 THEN
		DBMS_OUTPUT.PUT_LINE('Problem with Surgeon schedule');
	END IF;
END;
/

/* Create Patient Surgery View */
CREATE OR REPLACE VIEW Patient_Surgery_View AS
SELECT * FROM Patient_Surgery_Table;

/* Display Patient Surgery View */
Select * from Patient_Surgery_View;

SET FEEDBACK ON;


/* Run Queries */
@query

/* Drop Tables */
begin
dbms_output.put_line(chr(10));
dbms_output.put_line('==================================================');
dbms_output.put_line('Drop Everything');
dbms_output.put_line('==================================================');
end;
/

@dropall
