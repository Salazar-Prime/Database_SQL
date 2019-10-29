/* Procedure 5 - pro_list_popular */
/*  */ 
rem EE 562 Project 2
rem Varun Aggarwal
rem aggarw82

/* clear history */
@triggers -- triggers clears all tables et. al.
TRUNCATE TABLE Logging;
set linesize 200;
set pagesize 50;
set serveroutput ON;
clear screen

--
--
--
--
--

CREATE OR REPLACE PROCEDURE pro_list_popular
AS
stat NUMBER;
BEGIN
	
	DBMS_OUTPUT.PUT_LINE(rpad('Month',30)|| rpad('Year',15)
						 || rpad('Author Name',30)|| rpad('# of Editions',15));	

	DBMS_OUTPUT.PUT_LINE(rpad('-----',30)|| rpad('----',15)
						 || rpad('-----------',30)|| rpad('-------------',15));		
	FOR mon IN 1..12
	LOOP
		stat := fun_most_popular(to_char(to_date(mon,'MM'),'MON')); 
	END LOOP;

END;
/

/* testing trigger*/
EXEC pro_list_popular;


/* print debugging tables*/ 
SELECT * FROM Logging;
SELECT * FROM Issue;
SHOW error;

