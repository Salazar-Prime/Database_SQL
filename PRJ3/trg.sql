rem EE 562 Project 3
rem Keertana Marella
rem kmarella

-- Procedure 2
CREATE OR REPLACE PROCEDURE populate_db
IS
	debug1 varchar(100);
	debug2 varchar(100);
	Cursor Pinp IS SELECT * FROM PATIENT_INPUT ORDER BY General_Ward_admission_date, Patient_Name;
	cur Pinp%ROWTYPE;
BEGIN
	For cur in Pinp
	loop
		INSERT INTO General_Ward Values(cur.Patient_Name, cur.General_Ward_admission_date, cur.Patient_Type);
		-- debug1 := 'SELECT * FROM BEDS';
		-- debug2 := 'SELECT * FROM Flow WHERE Pname = ' || cur.Patient_Name;
		-- EXECUTE IMMEDIATE debug1;
		-- EXECUTE IMMEDIATE debug2;
	END loop;
END;
/
-- SHOW ERROR;


-- Procedure 3

CREATE OR REPLACE Procedure populate_dr
IS
CUR_DATE Date;
needed VARCHAR2(30);
BEGIN
	FOR i IN 0..364
	LOOP
	Cur_Date := To_date('01/01/2005','MM/DD/YYYY')+i;
	needed := to_char(CUR_DATE,'DY');

		IF needed='SUN' THEN
			INSERT INTO DR_Schedule Values('James','General_Ward',Cur_Date);
			INSERT INTO DR_Schedule Values('Robert','SCREENING_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Mike','PRE_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Adams','POST_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Tracey','Surgery',Cur_Date);
			INSERT INTO DR_Schedule Values('Rick','Surgery',Cur_Date);
		ELSIF needed='MON' THEN
			INSERT INTO DR_Schedule Values('Robert','General_Ward',Cur_Date);
			INSERT INTO DR_Schedule Values('Mike','SCREENING_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Adams','PRE_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Tracey','POST_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Rick','Surgery',Cur_Date);
		ELSIF needed='TUE' THEN
			INSERT INTO DR_Schedule Values('Mike','General_Ward',Cur_Date);
			INSERT INTO DR_Schedule Values('Adams','SCREENING_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Tracey','PRE_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Rick','POST_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('James','Surgery',Cur_Date);
		ELSIF needed='WED' THEN
			INSERT INTO DR_Schedule Values('Adams','General_Ward',Cur_Date);
			INSERT INTO DR_Schedule Values('Tracey','SCREENING_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Rick','PRE_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('James','POST_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Robert','Surgery',Cur_Date);
		ELSIF needed='THU' THEN
			INSERT INTO DR_Schedule Values('Tracey','General_Ward',Cur_Date);
			INSERT INTO DR_Schedule Values('Rick','SCREENING_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('James','PRE_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Robert','POST_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Mike','Surgery',Cur_Date);
		ELSIF needed='FRI' THEN
			INSERT INTO DR_Schedule Values('Rick','General_Ward',Cur_Date);
			INSERT INTO DR_Schedule Values('James','SCREENING_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Robert','PRE_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Mike','POST_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Adams','Surgery',Cur_Date);
		ELSIF needed='SAT' THEN
			INSERT INTO DR_Schedule Values('James','General_Ward',Cur_Date);
			INSERT INTO DR_Schedule Values('Robert','SCREENING_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Mike','PRE_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Adams','POST_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Tracey','Surgery',Cur_Date);	 
		END IF;
	END LOOP;
END;
/

-- Procedure 4
CREATE OR REPLACE Procedure populate_sr
IS
CUR_DATE Date;
needed VARCHAR2(30);
BEGIN
For i in 0..364
loop
Cur_Date := To_date('01/01/2005','MM/DD/YYYY')+i;
needed := to_char(CUR_DATE,'DY');
IF needed='SUN' THEN
 INSERT INTO Surgeon_Schedule Values('Dr. Smith',Cur_Date); 
 INSERT INTO Surgeon_Schedule Values('Dr. Charles',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Taylor',Cur_Date);
 
 ELSIF needed='MON' THEN
 INSERT INTO Surgeon_Schedule Values('Dr. Smith',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Charles',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Taylor',Cur_Date);
 
 
 ELSIF needed='TUE' THEN
 INSERT INTO Surgeon_Schedule Values('Dr. Richards',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Gower',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Rutherford',Cur_Date);


 ELSIF needed='WED' THEN
 INSERT INTO Surgeon_Schedule Values('Dr. Richards',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Gower',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Rutherford',Cur_Date);
 
 
 ELSIF needed='THU' THEN
 INSERT INTO Surgeon_Schedule Values('Dr. Smith',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Charles',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Taylor',Cur_Date);
 
 
 ELSIF needed='FRI' THEN
 INSERT INTO Surgeon_Schedule Values('Dr. Richards',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Gower',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Rutherford',Cur_Date);
 
 ELSIF needed='SAT' THEN
 INSERT INTO Surgeon_Schedule Values('Dr. Richards',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Gower',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Rutherford',Cur_Date);
 END IF;
 END loop;
 END;
 /
 








-- Trigger 1
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
		-- create record in flow table
		INSERT INTO FLOW (Pname, Ptype, G_Date, S_Date) VALUES (:new.Patient_Name, :new.Patient_Type, :new.G_Admission_Date, needed);	
		INSERT INTO SCREENING_WARD VALUES(:new.Patient_Name,needed,I_Bed_No,:new.Patient_Type);

	ELSE 
		-- create record in flow table
		INSERT INTO FLOW (Pname, Ptype, G_Date, S_Date) VALUES (:new.Patient_Name, :new.Patient_Type, :new.G_Admission_Date, soonest);	
		INSERT INTO SCREENING_WARD VALUES(:new.Patient_Name,soonest,I_Bed_No,:new.Patient_Type);

	END IF;

END;
/







-- Trigger 2
CREATE OR REPLACE TRIGGER trg_scr
AFTER INSERT ON SCREENING_WARD
FOR EACH ROW
DECLARE
	needed date;
	soonest date;
	I_Bed_No number;
	Healthy number;
	Wait_Time number;
	Check_Health number;
	i number;

BEGIN

	-- update record in flow table
	UPDATE FLOW SET S_Date = :new.S_Admission_Date
	WHERE Pname = :new.Patient_Name AND G_Date < :new.S_Admission_Date AND G_Date > :new.S_Admission_Date - 7;

	needed := :new.S_Admission_Date + 3;

	SELECT min(Available_Date) INTO soonest
	FROM Beds
	WHERE Ward='PW';

	SELECT Bed_No INTO I_Bed_No
	FROM Beds
	WHERE Available_Date=soonest and ROWNUM = 1;

	IF needed >= soonest THEN
		
		-- update record in flow table
		UPDATE FLOW SET Pre_Date = needed, Post_Date = needed + 2
		WHERE Pname = :new.Patient_Name AND S_Date = :new.S_Admission_Date;

 		UPDATE Beds SET Available_Date = needed WHERE Bed_No=:new.Bed_No AND Ward = 'SW';
		INSERT INTO PRE_SURGERY_WARD VALUES (:new.Patient_Name, needed, I_Bed_No, :new.Patient_Type);

		UPDATE Beds SET Available_Date = needed + 2 WHERE Bed_No=:new.Bed_No AND Ward = 'PW';
		INSERT INTO POST_SURGERY_WARD VALUES (:new.Patient_Name, needed + 2, Null, 1, :new.Patient_Type);
	ELSE

		Wait_Time := soonest - needed;

		FOR i IN 1..Wait_Time
		LOOP

			SELECT Count(*) INTO Check_Health
			FROM Patient_Chart
			WHERE Pdate >= :new.S_Admission_Date+(i-1) and Pdate < needed+i and Temperature >= 97 and Temperature <= 100 and BP <= 140 and BP >= 110;

				IF Check_Health = 4 THEN
		           Healthy := 1;
		           Exit;
				END IF;

		END Loop;

		IF Healthy = 1 THEN

			-- update beds table
			UPDATE Beds SET Available_Date = needed + (i-1) WHERE Bed_No=:new.Bed_No AND Ward = 'SW';
			
			-- update record in flow table	
			UPDATE FLOW SET Post_Date = needed + (i-1)
			WHERE Pname = :new.Patient_Name AND S_Date = :new.S_Admission_Date;

			-- transfer paitent to post surgery ward
			INSERT INTO POST_SURGERY_WARD values (:new.Patient_Name, needed+(i-1), Null, 1, :new.Patient_Type);

		ELSE

			-- update beds table
			UPDATE Beds SET Available_Date = soonest WHERE Bed_No=:new.Bed_No AND Ward = 'SW';
			UPDATE Beds SET Available_Date = soonest + 2 WHERE Bed_No=:new.Bed_No AND Ward = 'PW';	

			-- update record in flow table	
			UPDATE FLOW SET Pre_Date = soonest, Post_Date = soonest + 2
			WHERE Pname = :new.Patient_Name AND S_Date = :new.S_Admission_Date;

			-- transfer paitent to post surgery ward
			INSERT INTO PRE_SURGERY_WARD values (:new.Patient_Name, soonest, I_BeD_No,:new.Patient_Type);				
			INSERT INTO POST_SURGERY_WARD VALUES (:new.Patient_Name, soonest + 2, Null, 1, :new.Patient_Type);

		END IF;		  
			  
	END IF;

END;
/




-- Trigger 3
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
		WHERE BP >= 110 AND BP <= 140 AND Pdate >= :new.Post_Admission_Date and Pdate < :new.Post_Admission_Date+2;
		
		IF Check_Health = 2 THEN
			:new.Discharge_Date := :new.Post_Admission_Date + 2;
		ELSE
			:new.Discharge_Date := :new.Post_Admission_Date + 4;
			:new.Scount := 2;
		END IF;

	ELSIF :new.Patient_Type='Neuro' THEN

		SELECT COUNT(*) INTO Check_Health
		FROM Patient_Chart
		WHERE BP >= 110 AND BP<=140 AND  Pdate>=:new.Post_Admission_Date AND Pdate<:new.Post_Admission_Date+2 AND Temperature>= 97 AND Temperature <= 100;
		
		IF Check_Health = 2 THEN
			:new.Discharge_Date := :new.Post_Admission_Date + 2;
		ELSE
			:new.Discharge_Date := :new.Post_Admission_Date + 4;
			:new.Scount := 2;
		END IF;

	END IF;

	-- update record in flow table	
	UPDATE FLOW SET Scount = :new.Scount, D_Date = :new.Discharge_Date, Total_Days = :new.Discharge_Date - G_Date
	WHERE Pname = :new.Patient_Name AND  Post_Date = :new.Post_Admission_Date;

END;
/


 