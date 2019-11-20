/* Query 10 */
TRUNCATE TABLE datum;
TRUNCATE TABLE interval;
DECLARE
	-- dates for surgeries (current and previous)
	Csur1_date date;
	Csur2_date date;
	Psur1_date date;
	Psur2_date date;
	PD_date date;
	-- surgeon name
	sur1_name varchar(30);
	sur2_name varchar(30);
	-- other varibles
	total_sur number;
	CURSOR pat IS SELECT UNIQUE(Pname) FROM Flow WHERE Scount = 2;
	cur pat%ROWTYPE;
BEGIN 
	
	FOR cur IN pat
	LOOP
		-- checking of paitent has only visited once
		SELECT COUNT(*) INTO total_sur FROM Flow WHERE Scount=2 AND Pname = cur.Pname
		IF total_sur = 1 THEN
			CONTINUE;
		END IF;

		FOR cur1 IN (SELECT * FROM Flow WHERE Scount=2 AND Pname = cur.Pname)
		LOOP
			Csur1_date := cur1.Post_Date;
			Csur2_date := Csur1_date + 2;

			-- skip calculation for first surgery
			IF Psur1_date IS NULL AND Psur2_date IS NULL THEN
				Psur1_date := Csur1_date;
				Psur2_date := Csur2_date;
				PD_date := cur1.D_Date;
				CONTINUE;
			END IF;

			-- skip if G_Date - Discharge is <=5 OR >=14
			IF (cur1.G_Date - PD_date) <= 5 AND (cur1.G_Date - PD_date) >= 14 THEN
				Psur1_date := Csur1_date;
				Psur2_date := Csur2_date;
				PD_date := cur1.D_Date;
				CONTINUE;
			END IF;


			SELECT Name INTO sur1_name FROM Surgeon_Schedule WHERE Surgery_Date = Csur1_date;
			SELECT Name INTO sur2_name FROM Surgeon_Schedule WHERE Surgery_Date = Csur2_date;

			-- skip if surgeon is different for the two surgeries
			IF sur1_name == sur2_name THEN
				CONTINUE;
			END IF;

			Psur1_date := Csur1_date;
			Psur2_date := Csur2_date;	
			PD_date := cur1.D_Date;
		END LOOP;
	END LOOP;
	
END;
/
EXEC coal;
DELETE interval WHERE S_Date = E_Date;
SELECT * FROM interval;