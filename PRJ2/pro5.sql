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
/* declare varibles if needed */
BEGIN
	
	DBMS_OUTPUT.PUT_LINE(rpad('Month',15)|| rpad('Year',15)
						 || rpad('Author Name',30)|| rpad('# of Editions',15));	

	DBMS_OUTPUT.PUT_LINE(rpad('-----',15)|| rpad('----',15)
						 || rpad('-----------',30)|| rpad('-------------',15));		

						 
	/* fetching data -- funciton call: fun_most_popular -- */
	
	/* printing output */	

END;
/

/* testing trigger*/
EXEC pro_list_popular;


/* print debugging tables*/ 
SELECT * FROM Logging;
SELECT * FROM Issue;
SHOW error;

