/* Procedure 2 - pro_print_borrower */
/* Basic logic and structure ready */ 
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
--	

CREATE OR REPLACE PROCEDURE pro_print_borrower
AS
cursor cur_bor_id IS SELECT * FROM Issue WHERE return_date IS null;
bor_name varchar2(30);
bok_name varchar2(50);
date_diff number;	
cur cur_bor_id%ROWTYPE;
BEGIN

	DBMS_OUTPUT.PUT_LINE(rpad('Borrower Name',30)|| rpad('Book Title',30)|| rpad('<=5days',15)
						 || rpad('<=10days',15)|| rpad('<=15days',15) || rpad('>15days',15));	

	DBMS_OUTPUT.PUT_LINE(rpad('-------------',30)|| rpad('----------',30)|| rpad('-------',15)
						 || rpad('--------',15)|| rpad('--------',15) || rpad('-------',15));					 			
	FOR cur IN cur_bor_id
	LOOP
	date_diff := to_date(SYSDATE,'DD-MON-YY') - cur.issue_date;
		DBMS_OUTPUT.PUT_LINE(rpad('Salazar',30)|| rpad('Alice in Wonderland',30)|| rpad(date_diff,15)
							 || rpad(0,15)|| rpad(0,15) || rpad(0,15));
	END LOOP;
END;
/

/* testing trigger*/
EXEC pro_print_borrower;


/* print debugging tables*/ 
SELECT * FROM Logging;
SHOW error;
-- SELECT * FROM Issue;
