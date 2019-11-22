rem EE 562 Project 3
rem Varun Aggarwal
rem aggarw82

/* Procedure to populate patient chart */
CREATE OR REPLACE PROCEDURE populate_chart
IS
BEGIN
	FOR cur IN (SELECT UNIQUE(Patient_Name) FROM PATIENT_INPUT)
	LOOP
		FOR i IN 0..364
		LOOP

			/* realistic */ 
			INSERT INTO Patient_Chart 
			VALUES ( cur.Patient_Name, 
				     to_date('01/01/05','mm/dd/yy') + i, 
				     round(dbms_random.value(95,102)), 
				     round(dbms_random.value(100,150))
				     );

			/* healthy */ 
			-- INSERT INTO Patient_Chart 
			-- VALUES ( cur.Patient_Name, 
			-- 	     to_date('01/01/05','mm/dd/yy') + i, 
			-- 	     round(dbms_random.value(97,100)), 
			-- 	     round(dbms_random.value(110,140))
			-- 	     );

		END LOOP;
	END LOOP;
END;
/

/* Procedure to populate patient table */
CREATE OR REPLACE PROCEDURE populate_db
IS
	Cursor Pat_inp IS SELECT * FROM PATIENT_INPUT ORDER BY General_Ward_admission_date, Patient_Name;
	cur Pat_inp%ROWTYPE;
BEGIN
	FOR cur IN Pat_inp
	LOOP
		INSERT INTO General_Ward Values(cur.Patient_Name, cur.General_Ward_admission_date, cur.Patient_Type);
	END LOOP;
END;
/



/* Procedure to populate doctor table */
CREATE OR REPLACE PROCEDURE populate_dr
IS
	from_date date;
	day_in_word varchar2(30);
BEGIN
	FOR i IN 0..364
	LOOP
	from_date := To_date('01/01/05','mm/dd/yy') + i;
	day_in_word := to_char(from_date,'DY');

		IF day_in_word='SUN' THEN
			INSERT INTO DR_Schedule Values('James','General_Ward',from_date);
			INSERT INTO DR_Schedule Values('Robert','SCREENING_WARD',from_date);
			INSERT INTO DR_Schedule Values('Mike','PRE_SURGERY_WARD',from_date);
			INSERT INTO DR_Schedule Values('Adams','POST_SURGERY_WARD',from_date);
			INSERT INTO DR_Schedule Values('Tracey','Surgery',from_date);
			INSERT INTO DR_Schedule Values('Rick','Surgery',from_date);
		ELSIF day_in_word='MON' THEN
			INSERT INTO DR_Schedule Values('Robert','General_Ward',from_date);
			INSERT INTO DR_Schedule Values('Mike','SCREENING_WARD',from_date);
			INSERT INTO DR_Schedule Values('Adams','PRE_SURGERY_WARD',from_date);
			INSERT INTO DR_Schedule Values('Tracey','POST_SURGERY_WARD',from_date);
			INSERT INTO DR_Schedule Values('Rick','Surgery',from_date);
		ELSIF day_in_word='TUE' THEN
			INSERT INTO DR_Schedule Values('Mike','General_Ward',from_date);
			INSERT INTO DR_Schedule Values('Adams','SCREENING_WARD',from_date);
			INSERT INTO DR_Schedule Values('Tracey','PRE_SURGERY_WARD',from_date);
			INSERT INTO DR_Schedule Values('Rick','POST_SURGERY_WARD',from_date);
			INSERT INTO DR_Schedule Values('James','Surgery',from_date);
		ELSIF day_in_word='WED' THEN
			INSERT INTO DR_Schedule Values('Adams','General_Ward',from_date);
			INSERT INTO DR_Schedule Values('Tracey','SCREENING_WARD',from_date);
			INSERT INTO DR_Schedule Values('Rick','PRE_SURGERY_WARD',from_date);
			INSERT INTO DR_Schedule Values('James','POST_SURGERY_WARD',from_date);
			INSERT INTO DR_Schedule Values('Robert','Surgery',from_date);
		ELSIF day_in_word='THU' THEN
			INSERT INTO DR_Schedule Values('Tracey','General_Ward',from_date);
			INSERT INTO DR_Schedule Values('Rick','SCREENING_WARD',from_date);
			INSERT INTO DR_Schedule Values('James','PRE_SURGERY_WARD',from_date);
			INSERT INTO DR_Schedule Values('Robert','POST_SURGERY_WARD',from_date);
			INSERT INTO DR_Schedule Values('Mike','Surgery',from_date);
		ELSIF day_in_word='FRI' THEN
			INSERT INTO DR_Schedule Values('Rick','General_Ward',from_date);
			INSERT INTO DR_Schedule Values('James','SCREENING_WARD',from_date);
			INSERT INTO DR_Schedule Values('Robert','PRE_SURGERY_WARD',from_date);
			INSERT INTO DR_Schedule Values('Mike','POST_SURGERY_WARD',from_date);
			INSERT INTO DR_Schedule Values('Adams','Surgery',from_date);
		ELSIF day_in_word='SAT' THEN
			INSERT INTO DR_Schedule Values('James','General_Ward',from_date);
			INSERT INTO DR_Schedule Values('Robert','SCREENING_WARD',from_date);
			INSERT INTO DR_Schedule Values('Mike','PRE_SURGERY_WARD',from_date);
			INSERT INTO DR_Schedule Values('Adams','POST_SURGERY_WARD',from_date);
			INSERT INTO DR_Schedule Values('Tracey','Surgery',from_date);	 
		END IF;
	END LOOP;
END;
/

/* Procedure to populate surgeon table */
CREATE OR REPLACE Procedure populate_sr
IS
	from_date date;
	day_in_word varchar2(30);
BEGIN
	For i IN 0..364
	LOOP
		from_date := To_date('01/01/2005','MM/DD/YYYY')+i;
		day_in_word := to_char(from_date,'DY');
		IF day_in_word='SUN' THEN
			 INSERT INTO Surgeon_Schedule Values('Dr. Smith',from_date); 
			 INSERT INTO Surgeon_Schedule Values('Dr. Charles',from_date);
			 INSERT INTO Surgeon_Schedule Values('Dr. Taylor',from_date);
		 
		 ELSIF day_in_word='MON' THEN
			 INSERT INTO Surgeon_Schedule Values('Dr. Smith',from_date);
			 INSERT INTO Surgeon_Schedule Values('Dr. Charles',from_date);
			 INSERT INTO Surgeon_Schedule Values('Dr. Taylor',from_date);
		 
		 ELSIF day_in_word='TUE' THEN
			 INSERT INTO Surgeon_Schedule Values('Dr. Richards',from_date);
			 INSERT INTO Surgeon_Schedule Values('Dr. Gower',from_date);
			 INSERT INTO Surgeon_Schedule Values('Dr. Rutherford',from_date);

		 ELSIF day_in_word='WED' THEN
			 INSERT INTO Surgeon_Schedule Values('Dr. Richards',from_date);
			 INSERT INTO Surgeon_Schedule Values('Dr. Gower',from_date);
			 INSERT INTO Surgeon_Schedule Values('Dr. Rutherford',from_date);
		 
		 ELSIF day_in_word='THU' THEN
			 INSERT INTO Surgeon_Schedule Values('Dr. Smith',from_date);
			 INSERT INTO Surgeon_Schedule Values('Dr. Charles',from_date);
			 INSERT INTO Surgeon_Schedule Values('Dr. Taylor',from_date);
		 
		 ELSIF day_in_word='FRI' THEN
			 INSERT INTO Surgeon_Schedule Values('Dr. Richards',from_date);
			 INSERT INTO Surgeon_Schedule Values('Dr. Gower',from_date);
			 INSERT INTO Surgeon_Schedule Values('Dr. Rutherford',from_date);
		 
		 ELSIF day_in_word='SAT' THEN
			 INSERT INTO Surgeon_Schedule Values('Dr. Richards',from_date);
			 INSERT INTO Surgeon_Schedule Values('Dr. Gower',from_date);
			 INSERT INTO Surgeon_Schedule Values('Dr. Rutherford',from_date);
		 END IF;
	 END LOOP;
 END;
 /
 
/* function to check surgeon/assistant doctor schedule */ 
CREATE OR REPLACE FUNCTION dr_sr_schedule_verify(switch IN number)
RETURN number
IS
	w_day  number :=0;
	neu   number :=0;
	car number :=0;
	
	no_week number :=0;
	cons  number :=0;
	name_dr   varchar2(30);
	error number := 1;
BEGIN
	IF switch=0 THEN
		-- DBMS_OUTPUT.PUT_LINE('Need to write check...');
		FOR i IN 0..51
		LOOP
			FOR name IN 0..5
			LOOP
				IF name=0 THEN name_dr:='James';
				ELSIF name=1 THEN name_dr:='Robert';
				ELSIF name=2 THEN name_dr:='Mike';
				ELSIF name=3 THEN name_dr:='Adams';
				ELSIF name=4 THEN name_dr:='Tracey';
				ELSIF name=5 THEN name_dr:='Rick';
				END IF;
				
				SELECT COUNT(Name) INTO no_week
				FROM DR_Schedule
				WHERE Duty_Date >= to_date('1/2/05','MM/DD/YY') + (7 * i) 
				and Duty_Date <= to_date('1/2/05','MM/DD/YY') + (7 * i) + 6
				and Name = name_dr
				GROUP BY Name;
				
				IF no_week != 6 THEN
					error := 0;
					EXIT;
				END IF;
			END LOOP;
		END LOOP;
		
		FOR i IN 0..363
		LOOP
			SELECT max(COUNT(Duty_Date)) INTO cons
			FROM DR_Schedule
			WHERE Duty_Date>=to_date('1/2/05','MM/DD/YY')+(i) 
			and Duty_Date<=to_date('1/2/05','MM/DD/YY')+(i+3)
			GROUP BY Name,Ward;
			
			IF cons = 3 THEN
				error := 0;
				EXIT;
			END IF;
		END LOOP;
		
		IF no_week = 6 and cons < 3 THEN
			error := 1;
		ELSE
			error := 0;
		END IF;
		RETURN error;
					
	ELSIF switch=1 THEN
		
		/* count wrong day */
		SELECT COUNT(*) INTO w_day
		FROM Surgeon_Schedule
		WHERE (to_char(Surgery_Date,'DY') IN ('SUN','MON','THU') 
			and Name IN ('Dr. Richards','Dr. Gower','Dr. Rutherford'))
			or (to_char(Surgery_Date,'DY') IN ('TUE','WED','FRI','SAT') 
			and Name IN ('Dr. Smith','Dr. Charles','Dr. Taylor'));
		
		/* for neuro */
		SELECT COUNT(*) INTO neu
		FROM (SELECT distinct Surgery_Date FROM Surgeon_Schedule) A
			 LEFT JOIN 
			 (SELECT Surgery_Date,COUNT(Name) as ct
			  FROM Surgeon_Schedule
			  GROUP BY Surgery_Date,Name
			  having Name IN ('Dr. Taylor','Dr. Rutherford')) B
			 on A.Surgery_Date=B.Surgery_Date
		WHERE (B.ct < 1 or (B.ct IS null));
		
		/* for cardiac */
		SELECT COUNT(*) INTO car
		FROM (SELECT distinct Surgery_Date FROM Surgeon_Schedule) A
			 LEFT JOIN 
			 (SELECT Surgery_Date,COUNT(Name) as ct
			  FROM Surgeon_Schedule
			  GROUP BY Surgery_Date,Name
			  having Name IN ('Dr. Charles','Dr. Gower')) B
			 on A.Surgery_Date=B.Surgery_Date
		WHERE (B.ct<1 OR (B.ct IS null));
		
		/* displaying error */
		IF w_day>0 OR neu > 0 OR car > 0 THEN
			error := 0;
		ELSIF neu+car+w_day = 0 THEN
			error := 1;
		END IF;

		RETURN error;
	
	END IF;

END;
/


/* Trigger 1 */
CREATE OR REPLACE Trigger trg_gen
AFTER INSERT on GENERAL_WARD
FOR EACH ROW
DECLARE
	needed date;
	soonest date;
	I_Bed_No number;
BEGIN
			
	needed:= :new.G_Admission_Date+3;

	SELECT min(Available_Date) INTO soonest
	FROM Beds WHERE Ward='SW';

	SELECT Bed_No INTO I_Bed_No
	FROM Beds
	WHERE Available_Date=soonest and ROWNUM = 1;

	IF needed>=soonest THEN
		-- create record IN flow table
		INSERT INTO FLOW (Pname, Ptype, G_Date, S_Date) VALUES (:new.Patient_Name, :new.Patient_Type, :new.G_Admission_Date, needed);	
		INSERT INTO SCREENING_WARD VALUES(:new.Patient_Name,needed,I_Bed_No,:new.Patient_Type);

	ELSE 
		-- create record IN flow table
		INSERT INTO FLOW (Pname, Ptype, G_Date, S_Date) VALUES (:new.Patient_Name, :new.Patient_Type, :new.G_Admission_Date, soonest);	
		INSERT INTO SCREENING_WARD VALUES(:new.Patient_Name,soonest,I_Bed_No,:new.Patient_Type);

	END IF;

END;
/






/* Trigger 2 */
CREATE OR REPLACE TRIGGER trg_scr
AFTER INSERT ON SCREENING_WARD
FOR EACH ROW
DECLARE
	i number;
	needed date;
	soonest date;
	I_Bed_No number;
	Healthy number;
	Wait_Time number;
	Check_Health number;
BEGIN

	-- update record IN flow table
	UPDATE FLOW SET S_Date = :new.S_Admission_Date
	WHERE Pname = :new.Patient_Name AND G_Date < :new.S_Admission_Date AND G_Date > :new.S_Admission_Date - 7;

	needed := :new.S_Admission_Date + 3;

	SELECT min(Available_Date) INTO soonest
	FROM Beds
	WHERE Ward = 'PW';

	SELECT Bed_No INTO I_Bed_No
	FROM Beds
	WHERE Available_Date=soonest and ROWNUM = 1;

	IF needed >= soonest THEN
		
		-- update record IN flow table
		UPDATE FLOW SET Pre_Date = needed, Post_Date = needed + 2
		WHERE Pname = :new.Patient_Name AND S_Date = :new.S_Admission_Date;

 		UPDATE Beds SET Available_Date = needed WHERE Bed_No=:new.Bed_No AND Ward = 'SW';
		INSERT INTO PRE_SURGERY_WARD VALUES (:new.Patient_Name, needed, I_Bed_No, :new.Patient_Type);

		UPDATE Beds SET Available_Date = needed + 2 WHERE Bed_No=:new.Bed_No AND Ward = 'PW';
		INSERT INTO POST_SURGERY_WARD VALUES (:new.Patient_Name, needed + 2, Null, 1, :new.Patient_Type);
	ELSE

		Wait_Time := soonest - needed;
		i := 2;
		FOR i IN 1..Wait_Time
		LOOP

			SELECT COUNT(*) INTO Check_Health
			FROM Patient_Chart
			WHERE Patient_Name = :new.Patient_Name AND Pdate >= :new.S_Admission_Date+(i-1) AND Pdate < needed+i AND Temperature >= 97 AND Temperature <= 100 AND BP <= 140 AND BP >= 110;

				IF Check_Health = 4 THEN
		           Healthy := 1;
		           Exit;
				END IF;

		END Loop;

		IF Healthy = 1 THEN

			-- update beds table
			UPDATE Beds SET Available_Date = needed + (i-1) WHERE Bed_No=:new.Bed_No AND Ward = 'SW';
			
			-- update record IN flow table	
			UPDATE FLOW SET Post_Date = needed + (i-1)
			WHERE Pname = :new.Patient_Name AND S_Date = :new.S_Admission_Date;

			-- transfer paitent to post surgery ward
			INSERT INTO POST_SURGERY_WARD values (:new.Patient_Name, needed+(i-1), Null, 1, :new.Patient_Type);

		ELSE

			-- update beds table
			UPDATE Beds SET Available_Date = soonest WHERE Bed_No=:new.Bed_No AND Ward = 'SW';
			UPDATE Beds SET Available_Date = soonest + 2 WHERE Bed_No=:new.Bed_No AND Ward = 'PW';	

			-- update record IN flow table	
			UPDATE FLOW SET Pre_Date = soonest, Post_Date = soonest + 2
			WHERE Pname = :new.Patient_Name AND S_Date = :new.S_Admission_Date;

			-- transfer paitent to post surgery ward
			INSERT INTO PRE_SURGERY_WARD values (:new.Patient_Name, soonest, I_BeD_No,:new.Patient_Type);				
			INSERT INTO POST_SURGERY_WARD VALUES (:new.Patient_Name, soonest + 2, Null, 1, :new.Patient_Type);

		END IF;		  
			  
	END IF;

END;
/




/* Trigger 3 */
CREATE OR REPLACE TRIGGER trg_post
BEFORE INSERT on POST_SURGERY_WARD
FOR EACH ROW
DECLARE
	Check_Health number;

BEGIN
	IF :new.Patient_Type='General' THEN

		:new.Discharge_Date := :new.Post_Admission_Date + 2;

	ELSIF :new.Patient_Type='Cardiac' THEN

		SELECT COUNT(*) INTO Check_Health
		FROM Patient_Chart
		WHERE Patient_Name = :new.Patient_Name AND BP >= 110 AND BP <= 140 AND Pdate >= :new.Post_Admission_Date AND Pdate < :new.Post_Admission_Date+2;
		-- DBMS_OUTPUT.PUT_LINE(to_char(Check_Health));
		IF Check_Health = 2 THEN
			:new.Discharge_Date := :new.Post_Admission_Date + 2;
		ELSE
			:new.Discharge_Date := :new.Post_Admission_Date + 4;
			:new.Scount := 2;
		END IF;

	ELSIF :new.Patient_Type='Neuro' THEN

		SELECT COUNT(*) INTO Check_Health
		FROM Patient_Chart
		WHERE Patient_Name = :new.Patient_Name AND BP >= 110 AND BP<=140 AND  Pdate>=:new.Post_Admission_Date AND Pdate<:new.Post_Admission_Date+2 AND Temperature>= 97 AND Temperature <= 100;
		
		IF Check_Health = 2 THEN
			:new.Discharge_Date := :new.Post_Admission_Date + 2;
		ELSE
			:new.Discharge_Date := :new.Post_Admission_Date + 4;
			:new.Scount := 2;
		END IF;

	END IF;

	-- update record IN flow table	
	UPDATE FLOW SET Scount = :new.Scount, D_Date = :new.Discharge_Date, Total_Days = :new.Discharge_Date - G_Date
	WHERE Pname = :new.Patient_Name AND  Post_Date = :new.Post_Admission_Date;

END;
/


 