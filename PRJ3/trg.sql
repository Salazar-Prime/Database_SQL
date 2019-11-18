rem EE 562 Project 3
rem Keertana Marella
rem kmarella

-- Procedure 2
Create or Replace PROCEDURE populate_db
IS
Cursor X is
SELECT Patient_Name, General_Ward_admission_date, Patient_Type FROM PATIENT_INPUT Order by  General_Ward_admission_date, Patient_Name;
X_Var X%ROWTYPE;
begin
For X_Var in X
loop
INSERT INTO General_Ward Values(X_Var.Patient_Name,X_Var.General_Ward_admission_date,X_Var.Patient_Type);
END loop;
END;
/

-- Procedure 3

Create or Replace Procedure populate_dr
IS
CUR_DATE Date;
days VARCHAR2(30);
BEGIN
	FOR i IN 0..364
	LOOP
	Cur_Date := To_date('01/01/2005','MM/DD/YYYY')+i;
	days := to_char(CUR_DATE,'DY');

		IF days='SUN' THEN
			INSERT INTO DR_Schedule Values('James','General_Ward',Cur_Date);
			INSERT INTO DR_Schedule Values('Robert','SCREENING_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Mike','PRE_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Adams','POST_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Tracey','Surgery',Cur_Date);
			INSERT INTO DR_Schedule Values('Rick','Surgery',Cur_Date);
		ELSIF days='MON' THEN
			INSERT INTO DR_Schedule Values('Robert','General_Ward',Cur_Date);
			INSERT INTO DR_Schedule Values('Mike','SCREENING_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Adams','PRE_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Tracey','POST_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Rick','Surgery',Cur_Date);
		ELSIF days='TUE' THEN
			INSERT INTO DR_Schedule Values('Mike','General_Ward',Cur_Date);
			INSERT INTO DR_Schedule Values('Adams','SCREENING_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Tracey','PRE_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Rick','POST_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('James','Surgery',Cur_Date);
		ELSIF days='WED' THEN
			INSERT INTO DR_Schedule Values('Adams','General_Ward',Cur_Date);
			INSERT INTO DR_Schedule Values('Tracey','SCREENING_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Rick','PRE_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('James','POST_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Robert','Surgery',Cur_Date);
		ELSIF days='THU' THEN
			INSERT INTO DR_Schedule Values('Tracey','General_Ward',Cur_Date);
			INSERT INTO DR_Schedule Values('Rick','SCREENING_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('James','PRE_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Robert','POST_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Mike','Surgery',Cur_Date);
		ELSIF days='FRI' THEN
			INSERT INTO DR_Schedule Values('Rick','General_Ward',Cur_Date);
			INSERT INTO DR_Schedule Values('James','SCREENING_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Robert','PRE_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Mike','POST_SURGERY_WARD',Cur_Date);
			INSERT INTO DR_Schedule Values('Adams','Surgery',Cur_Date);
		ELSIF days='SAT' THEN
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
Create or Replace Procedure populate_sr
IS
CUR_DATE Date;
days VARCHAR2(30);
BEGIN
For i in 0..364
loop
Cur_Date := To_date('01/01/2005','MM/DD/YYYY')+i;
days := to_char(CUR_DATE,'DY');
IF days='SUN' THEN
 INSERT INTO Surgeon_Schedule Values('Dr. Smith',Cur_Date); 
 INSERT INTO Surgeon_Schedule Values('Dr. Charles',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Taylor',Cur_Date);
 
 ELSIF days='MON' THEN
 INSERT INTO Surgeon_Schedule Values('Dr. Smith',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Charles',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Taylor',Cur_Date);
 
 
 ELSIF days='TUE' THEN
 INSERT INTO Surgeon_Schedule Values('Dr. Richards',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Gower',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('6',Cur_Date);


 ELSIF days='WED' THEN
 INSERT INTO Surgeon_Schedule Values('Dr. Richards',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Gower',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Rutherford',Cur_Date);
 
 
 ELSIF days='THU' THEN
 INSERT INTO Surgeon_Schedule Values('Dr. Smith',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Charles',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Taylor',Cur_Date);
 
 
 ELSIF days='FRI' THEN
 INSERT INTO Surgeon_Schedule Values('Dr. Richards',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Gower',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Rutherford',Cur_Date);
 
 ELSIF days='SAT' THEN
 INSERT INTO Surgeon_Schedule Values('Dr. Richards',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Gower',Cur_Date);
 INSERT INTO Surgeon_Schedule Values('Dr. Rutherford',Cur_Date);
 END IF;
 END loop;
 END;
 /
 

-- Trigger 1
Create or Replace Trigger trg_gen
After INSERT on GENERAL_WARD
For Each ROW
DECLARE
days date;
soonest date;
I_Bed_No number;
BEGIN
days:= :new.G_Admission_Date+3;

SELECT min(Available_Date) INTO soonest
FROM Beds WHERE Ward='SW';

SELECT Bed_No INTO I_Bed_No
FROM Beds
WHERE Available_Date=soonest and ROWNUM = 1;

IF days>=soonest THEN

INSERT INTO SCREENING_WARD VALUES(:New.Patient_Name,days,I_Bed_No,:New.Patient_Type);

Else 

INSERT INTO SCREENING_WARD VALUES(:New.Patient_Name,soonest,I_Bed_No,:New.Patient_Type);

END IF;

END;
/

-- Trigger 2

Create or Replace Trigger trg_scr
After INSERT on SCREENING_WARD
For Each Row
Declare
	days date;
	soonest date;
	I_Bed_No number;
	Healthy number;
	Wait_Time number;
	Check_Health number;
	i number;

BEGIN
	days := :new.S_Admission_Date + 3;

	SELECT min(Available_Date) INTO soonest
	FROM Beds
	WHERE Ward='SW';

	SELECT Bed_No INTO I_Bed_No
	FROM Beds
	WHERE Available_Date=soonest and ROWNUM = 1;

	IF days >= soonest THEN

 		UPDATE Beds SET Available_Date=days WHERE Bed_No=:new.Bed_No AND Ward = 'SW';
		INSERT INTO PRE_SURGERY_WARD VALUES (:new.Patient_Name, days, I_Bed_No, :new.Patient_Type);

		UPDATE Beds SET Available_Date=days+2 WHERE Bed_No=:new.Bed_No AND Ward = 'PW';
		INSERT INTO POST_SURGERY_WARD VALUES (:new.Patient_Name, days + 2, Null, 1, :new.Patient_Type);
	Else

		Wait_Time := soonest - days;

		FOR i IN 1..Wait_Time
		LOOP

		SELECT Count(*) INTO Check_Health
		FROM Patient_Chart
		WHERE Pdate >= :new.S_Admission_Date+(i-1) and Pdate < days+i and Temperature >= 97 and Temperature <= 100 and BP <= 140 and BP >= 110;

			IF Check_Health = 4 THEN
	           Healthy := 1;
	           Exit;
			END IF;

		END Loop;

		IF Healthy = 1 THEN
			UPDATE Beds SET Available_Date = days+(i-1) WHERE Bed_No=:new.Bed_No AND Ward = 'SW';
			INSERT INTO POST_SURGERY_WARD values (:New.Patient_Name, days+(i-1), Null, 1, :new.Patient_Type);
		ELSE
			UPDATE Beds SET Available_Date = soonest WHERE Bed_No=:new.Bed_No AND Ward = 'SW';
			INSERT INTO PRE_SURGERY_WARD values (:New.Patient_Name, soonest, I_BeD_No,:New.Patient_Type);	
			UPDATE Beds SET Available_Date = soonest+2 WHERE Bed_No=:new.Bed_No AND Ward = 'PW';		
			INSERT INTO POST_SURGERY_WARD VALUES (:new.Patient_Name, soonest + 2, Null, 1, :new.Patient_Type);
		END IF;		   
			  
	END IF;

END;
/


-- Trigger 3
Create or Replace Trigger trg_post
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

END;
/


 