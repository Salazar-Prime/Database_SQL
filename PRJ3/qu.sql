/* Query 8 */
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