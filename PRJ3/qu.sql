/* Query 3 */
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

	SELECT G_Date, D_Date INTO arrive_bob, discharge_bob FROM (SELECT G_Date, D_Date, ROWNUM AS rown FROM Flow WHERE Pname = 'Bob') WHERE rown = 2;
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
