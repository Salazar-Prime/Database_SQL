/* Query 7
 */

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
-- SELECT * FROM Flow;
-- SELECT * FROM Flow WHERE Post_Date >= to_date('04/07/05','mm/dd/yy') AND Post_Date <= to_date('04/15/05','mm/dd/yy') AND Ptype = 'Cardiac';

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