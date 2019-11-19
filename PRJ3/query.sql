/* Query 1 */
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

TRUNCATE TABLE table_qu1;
EXEC query1;
DROP PROCEDURE query1;
SELECT * FROM table_qu1;
-- SHOW ERROR;

/* Query 2*/
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