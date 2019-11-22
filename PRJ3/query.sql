rem EE 562 Project 3
rem Varun Aggarwal
rem aggarw82

SET FEEDBACK OFF;
/* Query 1 */
begin
dbms_output.put_line(chr(10));
dbms_output.put_line('==================================================');
dbms_output.put_line('Query 1');
dbms_output.put_line('==================================================');
end;
/

CREATE OR REPLACE PROCEDURE query1
IS
	CURSOR Name IS SELECT UNIQUE(Pname) FROM Flow ORDER BY Pname;
	cur_name Name%ROWTYPE;

	-- varibles
	count_visit number;
	sum_duration number;
	Sur_type varchar(10);
	Sur_count number;

	-- days in each ward
	G_stay number;
	S_stay number;
	Pre_stay number;
	Post_stay number;

	-- stay cost for each ward
	G_cost number;
	S_cost number;
	Pre_cost number;
	Post_cost number;
	Sur_cost number;
	T_cost number;
BEGIN
	
	-- DBMS_OUTPUT.PUT_LINE(rpad('Name', 30)||rpad('Visits', 15)||rpad('Avg Stay', 15)||rpad('Reimburse $', 30));
	-- DBMS_OUTPUT.PUT_LINE(rpad('----', 30)||rpad('------', 15)||rpad('--------', 15)||rpad('-----------', 30));
	FOR cur_name IN Name
	LOOP		
		SELECT COUNT(*) INTO count_visit FROM Flow WHERE Pname = cur_name.Pname;
		SELECT SUM(Total_Days) INTO sum_duration FROM Flow WHERE Pname = cur_name.Pname;
		T_cost := 0;
		FOR cur IN (SELECT * FROM Flow WHERE Pname = cur_name.Pname)
		LOOP
			G_stay := 0;
			S_stay := 0;
			Pre_stay := 0;
			Post_stay := 0;
			SELECT Ptype, Scount INTO Sur_type, Sur_count FROM Flow WHERE Pname = cur.Pname AND G_Date=cur.G_Date;
			
			-- calc days in each ward
			IF to_char(cur.G_Date,'YYYY') = '2005' THEN G_stay := cur.S_Date - cur.G_Date; END IF;
			IF to_char(cur.S_Date,'YYYY') = '2005' THEN S_stay := cur.Pre_Date - cur.S_Date; END IF;
			IF to_char(cur.Pre_Date,'YYYY') = '2005' THEN Pre_stay := cur.Post_Date - cur.Pre_Date; END IF;
			IF to_char(cur.Post_Date,'YYYY') = '2005' THEN Post_stay := cur.D_Date - cur.Post_Date; END IF;

			-- calc cost for each ward
			IF G_stay - 3 > 0 THEN G_cost := (G_stay - 3)*35 + 3*40; ELSE G_cost := G_stay*40; END IF;
			IF S_stay - 3 > 0 THEN S_cost := (S_stay - 2)*52.5 + 2*59.5; ELSE S_cost := S_stay*59.5; END IF;
			Pre_cost := Pre_stay*85.5;
			Post_cost := Post_stay*72;

			-- calc cost of surgery
			IF Sur_type = 'Cardiac' AND Sur_count = 2 THEN Sur_cost := 5075;
			ELSIF Sur_type = 'Cardiac' AND Sur_count = 1 THEN Sur_cost := 2625;
			ELSIF Sur_type = 'Neuro' AND Sur_count = 2 THEN Sur_cost := 8250;
			ELSIF Sur_type = 'Neuro' AND Sur_count = 1 THEN Sur_cost := 4250;
			ELSE Sur_cost := 1625;
			END IF;

			-- calc total cost
			T_cost := T_cost + G_cost + S_cost + Pre_cost + Post_cost + Sur_cost;
		END LOOP;
		INSERT INTO table_qu1 VALUES (cur_name.Pname, count_visit, round(sum_duration/count_visit,2), T_cost);
	END LOOP;

END;
/

EXEC query1;
DROP PROCEDURE query1;
SELECT * FROM table_qu1;
-- SHOW ERROR;







/* Query 2*/
begin
dbms_output.put_line(chr(10));
dbms_output.put_line('==================================================');
dbms_output.put_line('Query 2');
dbms_output.put_line('==================================================');
dbms_output.put_line(chr(10));
end;
/

DECLARE
	t_cost number;
	t_pat number;
	t_visit number;
BEGIN 
	SELECT SUM(total_cost) INTO t_cost FROM table_qu1; 
	SELECT COUNT(*) INTO t_pat FROM table_qu1; 
	SELECT SUM(visits) INTO t_visit FROM table_qu1; 
	
	DBMS_OUTPUT.PUT_LINE(rpad('Total Cost',20)||rpad('Avg Cost per patient',30)||rpad('Avg Cost per visit', 30));
	DBMS_OUTPUT.PUT_LINE(rpad('----------',20)||rpad('--------------------',30)||rpad('------------------', 30));
	DBMS_OUTPUT.PUT_LINE(rpad(t_cost,20)||rpad(round(t_cost/t_pat,2),30)||rpad(round(t_cost/t_visit,2), 30));
END;
/






/* Query 3 */
begin
dbms_output.put_line(chr(10));
dbms_output.put_line('==================================================');
dbms_output.put_line('Query 3');
dbms_output.put_line('==================================================');
dbms_output.put_line(chr(10));
end;
/
DECLARE
	arrive_bob date;
	discharge_bob date;
	t_duration number := 0;
	t_pat number := 0;
	CURSOR pat IS SELECT * FROM Flow;
	cur pat%ROWTYPE;
BEGIN 
	

	DBMS_OUTPUT.PUT_LINE(rpad('Patient Name',30)||rpad('Avg Stay',20));
	DBMS_OUTPUT.PUT_LINE(rpad('------------',30)||rpad('--------',20));

	SELECT G_Date, D_Date INTO arrive_bob, discharge_bob 
	FROM (SELECT G_Date, D_Date, ROWNUM AS rown 
		  FROM Flow 
		  WHERE Pname = 'Bob' 
		  ORDER BY G_Date) 
	WHERE rown = 2;
	-- DBMS_OUTPUT.PUT_LINE(rpad(to_char(arrive_bob),20)||rpad(to_char(discharge_bob),30));
	FOR cur IN pat
	LOOP
		IF cur.Pname != 'Bob' AND cur.G_Date = arrive_bob AND cur.D_Date < discharge_bob THEN
			t_pat := t_pat + 1;
			t_duration := t_duration + cur.Total_Days;
		END IF;
	END LOOP;


	FOR cur IN pat
	LOOP
		IF cur.Pname != 'Bob' AND cur.G_Date = arrive_bob AND cur.D_Date < discharge_bob THEN
				DBMS_OUTPUT.PUT_LINE(rpad(cur.Pname,30)||rpad(round(t_duration/t_pat,2),20));
		END IF;
	END LOOP;

END;
/






/* Query 4 */
begin
dbms_output.put_line(chr(10));
dbms_output.put_line('==================================================');
dbms_output.put_line('Query 4');
dbms_output.put_line('==================================================');
end;
/
TRUNCATE TABLE datum;
TRUNCATE TABLE interval;
TRUNCATE TABLE table_qu4;
TRUNCATE TABLE table_qu4_out;
DECLARE
	-- dates for surgeries (start and end)
	i_date date;
	start_date date;
	end_date date;
	co number;
	sur_name varchar(30);

BEGIN 

	-- ############ first half: calculating the interval
	SELECT psur_date INTO start_date FROM Patient_Surgery_Table WHERE ROWNUM = 1;
	SELECT psur_date INTO end_date FROM (SELECT psur_date FROM Patient_Surgery_Table ORDER BY psur_date DESC) WHERE ROWNUM = 1;

	INSERT INTO datum VALUES (null);
	FOR i IN 0..end_date - start_date 
	LOOP

		i_date := start_date + i;
		
		SELECT COUNT(*) INTO co FROM Patient_Surgery_Table WHERE psur_date = i_date;
		IF co != 0 THEN
			INSERT INTO datum VALUES (i_date);
		ELSE
			INSERT INTO datum VALUES (null);
		END IF;

	END LOOP;
	INSERT INTO datum VALUES (null);
	coal;

	-- ############ second half: calculating surgeries in each interval per surgeon

	FOR cur IN (SELECT * FROM interval)
	LOOP
		FOR cur1 IN (SELECT sname, COUNT(sname) AS a1 FROM Patient_Surgery_Table WHERE Psur_date >= cur.s_date AND Psur_date <= cur.e_date GROUP BY sname)
		LOOP
			INSERT INTO table_qu4 VALUES (cur.s_date, cur.e_date, cur1.a1, cur1.sname);
		END LOOP;
		
	END LOOP;

	-- ############ third half: finding name of surgeon who performs max surgeries

	FOR cur IN (SELECT * FROM interval)
	LOOP

		SELECT SUM(total_sur) INTO co FROM table_qu4 WHERE  s_date = cur.s_date AND e_date = cur.e_date;
		

		FOR cur1 IN ( SELECT surgeon_name FROM table_qu4 
					  WHERE s_date = cur.s_date AND e_date = cur.e_date AND total_sur = ( SELECT MAX(total_sur) 
																							FROM table_qu4
																							WHERE s_date = cur.s_date AND e_date = cur.e_date))
		LOOP
			INSERT INTO table_qu4_out VALUES (cur.s_date, cur.e_date, co, cur1.surgeon_name);
		END LOOP;
	END LOOP;

END;
/
SELECT * FROM table_qu4_out ORDER BY total_sur DESC;







/* Query 5 */
begin
dbms_output.put_line(chr(10));
dbms_output.put_line('==================================================');
dbms_output.put_line('Query 5');
dbms_output.put_line('==================================================');
end;
/
TRUNCATE TABLE datum;
TRUNCATE TABLE interval;
DECLARE
	-- dates for surgeries (start and end)
	i_date date;
	start_date date := to_date('04/01/05','mm/dd/yy');
	co number;
BEGIN
	
	INSERT INTO datum VALUES (null);
	FOR i IN 0..29 
	LOOP

		i_date := start_date + i;		
		SELECT COUNT(*) INTO co FROM Patient_Surgery_Table WHERE psur_date = i_date AND sname != 'Dr. Gower' AND sname != 'Dr. Taylor';
		IF co != 0 THEN
			INSERT INTO datum VALUES (i_date);
		ELSE
			INSERT INTO datum VALUES (null);
		END IF;

	END LOOP;
	INSERT INTO datum VALUES (null);
	coal;
END;
/
SELECT * FROM interval;





/* Query 7 */
begin
dbms_output.put_line(chr(10));
dbms_output.put_line('==================================================');
dbms_output.put_line('Query 7');
dbms_output.put_line('==================================================');
end;
/
DECLARE
	-- dates for surgeries
	sur1_date date;
	sur2_date date;

	sur_name varchar2(30);
	ass_name varchar2(30);
BEGIN
	
	DBMS_OUTPUT.PUT_LINE(rpad('Surgery No',15)||rpad('Patient Name',30)||rpad('Surgeon Name',30)||rpad('Assistant Name',30));
	DBMS_OUTPUT.PUT_LINE(rpad('----------',15)||rpad('------------',30)||rpad('------------',30)||rpad('--------------',30));
	
	FOR cur IN (SELECT * FROM Flow WHERE Post_Date >= to_date('04/07/05','mm/dd/yy') AND Post_Date <= to_date('04/16/05','mm/dd/yy')  AND Ptype = 'Cardiac')
	LOOP
		sur1_date := cur.Post_Date;
		sur2_date := sur1_date + 2;

		IF sur1_date >= to_date('04/09/05','mm/dd/yy') THEN

			SELECT name INTO sur_name FROM ((SELECT name FROM Surgeon_Schedule WHERE Surgery_Date = sur1_date AND name ='Dr. Gower') 
				  							 UNION 
				  							(SELECT name FROM Surgeon_Schedule WHERE Surgery_Date = sur1_date AND name='Dr. Charles'));
			
			SELECT name INTO ass_name FROM Dr_Schedule WHERE Duty_Date = sur1_date AND ROWNUM = 1;

			DBMS_OUTPUT.PUT_LINE(rpad(to_char(1),15)||rpad(cur.Pname,30)||rpad(sur_name,30)||rpad(ass_name,30));

		END IF;

		IF cur.scount = 2 THEN
			IF sur2_date <= to_date('04/16/05','mm/dd/yy') THEN

				SELECT name INTO sur_name FROM ((SELECT name FROM Surgeon_Schedule WHERE Surgery_Date = sur1_date AND name ='Dr. Gower') 
				 UNION 
				(SELECT name FROM Surgeon_Schedule WHERE Surgery_Date = sur1_date AND name='Dr. Charles'));

				SELECT name INTO ass_name FROM Dr_Schedule WHERE Duty_Date = sur1_date AND ROWNUM = 1;

				DBMS_OUTPUT.PUT_LINE(rpad(to_char(2),15)||rpad(cur.Pname,30)||rpad(sur_name,30)||rpad(ass_name,30));
			END IF;
		END IF;

	END LOOP;

END;
/






/* Query 8 */
begin
dbms_output.put_line(chr(10));
dbms_output.put_line('==================================================');
dbms_output.put_line('Query 8');
dbms_output.put_line('==================================================');
end;
/

TRUNCATE TABLE datum;
TRUNCATE TABLE interval;
DECLARE
	-- dates for bob
	G_bob date;
	S_bob date;
	Pre_bob date;
	Post_bob date;
	D_bob date;
	Duration_bob number;
	-- other varibles
	ward_dr varchar2(20);
	doc_name varchar2(30);
	i_date date;
BEGIN 
	
	-- Bob's visits
	SELECT G_Date, S_Date, Pre_Date, Post_Date, D_Date, Total_Days INTO G_bob, S_bob, Pre_bob, Post_bob, D_bob, Duration_bob
	FROM (SELECT G_Date, S_Date, Pre_Date, Post_Date, D_Date, Total_Days, ROWNUM AS rown 
		  FROM Flow 
		  WHERE Pname = 'Bob' 
		  ORDER BY G_Date) 
	WHERE rown = 3;	
	
	INSERT INTO datum VALUES (null);
	FOR i IN 0..Duration_bob-1
	LOOP
		i_date := G_bob + i;
		-- DBMS_OUTPUT.PUT_LINE(to_char(G_bob + i));
		IF i_date < S_bob THEN ward_dr := 'General_Ward';
		ELSIF i_date < Pre_bob THEN ward_dr := 'SCREENING_WARD';
		ELSIF i_date < Post_bob THEN ward_dr := 'PRE_SURGERY_WARD';
		ELSE ward_dr := 'POST_SURGERY_WARD';
		END IF;

		-- checking doctor name for a particular date
		SELECT name INTO doc_name FROM dr_schedule WHERE Duty_Date = i_date AND Ward = ward_dr;


		IF doc_name != 'Adams' THEN 
			INSERT INTO datum VALUES (i_date);
		ELSE 
			INSERT INTO datum VALUES (null);
		END IF;
		
	END LOOP;
	INSERT INTO datum VALUES (null);
END;
/
EXEC coal;
-- SELECT * FROM datum;
SELECT * FROM interval;






/* Query 9 */
begin
dbms_output.put_line(chr(10));
dbms_output.put_line('==================================================');
dbms_output.put_line('Query 9');
dbms_output.put_line('==================================================');
end;
/

TRUNCATE TABLE datum;
TRUNCATE TABLE interval;
DECLARE
	-- dates for bob
	BP_date number;
	i_date date;
	-- other varibles
	CURSOR bob_visits IS SELECT * FROM Flow WHERE Pname='Bob';
	cur bob_visits%ROWTYPE;
BEGIN 
	INSERT INTO datum VALUES (null);
	FOR cur IN bob_visits
	LOOP

		FOR i IN 0..cur.total_days-1
		LOOP
			i_date := cur.G_Date + i;
			SELECT BP INTO BP_date
			FROM Patient_Chart
			WHERE Patient_Name = 'Bob' AND PDate = i_date;

			IF BP_date <= 140 AND BP_date >= 110 THEN
				INSERT INTO datum VALUES (i_date);
			ELSE
				INSERT INTO datum VALUES (null);
			END IF;
		END LOOP;
	INSERT INTO datum VALUES (null);
	END LOOP;
	INSERT INTO datum VALUES (null);
END;
/
EXEC coal;
DELETE interval WHERE S_Date = E_Date;
SELECT * FROM interval;

SET FEEDBACK ON;

/* Query 10 */
begin
dbms_output.put_line(chr(10));
dbms_output.put_line('==================================================');
dbms_output.put_line('Query 10');
dbms_output.put_line('==================================================');
end;
/
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