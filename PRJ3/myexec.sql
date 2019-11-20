--1 

-- SELCT * FROM Flow;

--2

-- Select * from DR_Schedule;
--3

-- Select * from Surgeon_Schedule;

--4

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

CREATE OR REPLACE VIEW Patient_Surgery_View AS
SELECT * FROM Patient_Surgery_Table;

--5

Select * from Patient_Surgery_View;
