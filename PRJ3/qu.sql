/* Query 5 */
-- SELECT * FROM table_qu4;
TRUNCATE TABLE datum;
TRUNCATE TABLE interval;
DECLARE
	-- dates for surgeries (start and end)
	i_date date;
	start_date date := to_date('04/01/05','mm/dd/yy');
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

-- SELECT s_date, e_date FROM table_qu4 WHERE surgeon_name != 'Dr. Gower' ;
-- DECLARE
-- 	-- dates for surgeries (start and end)
-- 	i_date date;
-- 	start_date date;
-- 	end_date date;
-- 	co number;
-- 	sur_name varchar(30);

-- BEGIN 

-- 	-- ############ first half: calculating the interval
-- 	SELECT psur_date INTO start_date FROM Patient_Surgery_Table WHERE ROWNUM = 1;
-- 	SELECT psur_date INTO end_date FROM (SELECT psur_date FROM Patient_Surgery_Table ORDER BY psur_date DESC) WHERE ROWNUM = 1;

-- 	INSERT INTO datum VALUES (null);
-- 	FOR i IN 0..end_date - start_date 
-- 	LOOP

-- 		i_date := start_date + i;
		
-- 		SELECT COUNT(*) INTO co FROM Patient_Surgery_Table WHERE psur_date = i_date;
-- 		IF co != 0 THEN
-- 			INSERT INTO datum VALUES (i_date);
-- 		ELSE
-- 			INSERT INTO datum VALUES (null);
-- 		END IF;

-- 	END LOOP;
-- 	INSERT INTO datum VALUES (null);
-- 	coal;

-- 	-- ############ second half: calculating surgeries in each interval per surgeon

-- 	FOR cur IN (SELECT * FROM interval)
-- 	LOOP
-- 		FOR cur1 IN (SELECT sname, COUNT(sname) AS a1 FROM Patient_Surgery_Table WHERE Psur_date >= cur.s_date AND Psur_date <= cur.e_date GROUP BY sname)
-- 		LOOP
-- 			INSERT INTO table_qu4 VALUES (cur.s_date, cur.e_date, cur1.a1, cur1.sname);
-- 		END LOOP;
		
-- 	END LOOP;

-- 	-- ############ third half: finding name of surgeon who performs max surgeries

-- 	FOR cur IN (SELECT * FROM interval)
-- 	LOOP

-- 		SELECT SUM(total_sur) INTO co FROM table_qu4 WHERE  s_date = cur.s_date AND e_date = cur.e_date;
		

-- 		FOR cur1 IN ( SELECT surgeon_name FROM table_qu4 
-- 					  WHERE s_date = cur.s_date AND e_date = cur.e_date AND total_sur = ( SELECT MAX(total_sur) 
-- 																							FROM table_qu4
-- 																							WHERE s_date = cur.s_date AND e_date = cur.e_date))
-- 		LOOP
-- 			INSERT INTO table_qu4_out VALUES (cur.s_date, cur.e_date, co, cur1.surgeon_name);
-- 		END LOOP;
-- 	END LOOP;

-- END;
-- /

-- SELECT * FROM table_qu4_out ORDER BY total_sur DESC;