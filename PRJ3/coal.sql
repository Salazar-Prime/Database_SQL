CREATE TABLE datum(quanta date);
CREATE TABLE interval(s_date date,
					  e_date date);


CREATE OR REPLACE PROCEDURE coal
IS
	start_val date;
	prev_val date := to_date('01/01/55','mm/dd/yy');
	sf number := 0;
	CURSOR on_time IS SELECT * FROM datum;
	cur on_time%ROWTYPE;
BEGIN
	FOR cur IN on_time
	LOOP
		IF prev_val IS null  AND cur.quanta IS NULL THEN
			prev_val := cur.quanta;
			CONTINUE;
		END IF;

		IF cur.quanta IS null AND sf = 0 THEN
			sf := 1;
		END IF;

		IF sf = 1 AND cur.quanta IS NOT null THEN
			sf :=2 ;
			start_val := cur.quanta;
		END IF;

		IF cur.quanta IS null AND sf = 2 THEN
			sf := 1;
			INSERT INTO interval VALUES (start_val, prev_val);
		END IF;

		prev_val := cur.quanta;
	END LOOP;
END; 
/

-- @query