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