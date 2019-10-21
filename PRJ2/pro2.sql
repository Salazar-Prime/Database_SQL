/* Procedure 2 - pro_print_fine */
/* Working */ 
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

CREATE OR REPLACE PROCEDURE pro_print_fine (cur_date IN DATE)
AS
cursor cur_bor_id IS SELECT * FROM Issue;
bor_name varchar2(30);
date_diff number;	
cur cur_bor_id%ROWTYPE;
BEGIN

	DBMS_OUTPUT.PUT_LINE(rpad('Borrower Name',30)|| rpad('Book ID',30)
						 || rpad('Issue Date',15)|| rpad('Fine',15));	

	DBMS_OUTPUT.PUT_LINE(rpad('-------------',30)|| rpad('-------',30)
						 || rpad('----------',15)|| rpad('----',15));					 			
	FOR cur IN cur_bor_id
	LOOP
	
	/* fetching borrower name */ 
	SELECT name INTO bor_name FROM BORROWER WHERE borrower_id = cur.borrower_id;
	
	/* returned vs not returned book */
	IF cur.return_date IS NULL THEN
		date_diff := to_date(cur_date,'DD-MON-YY') - cur.issue_date - 5;
	ELSE
		date_diff := cur.return_date - cur.issue_date - 5;
	END IF;
	
	/* If no fine */
	IF date_diff < 0 THEN
		date_diff := 0;
	END IF;
	
	/* printing output */
	DBMS_OUTPUT.PUT_LINE(rpad(bor_name,30)|| rpad(cur.book_id,30)
						 || rpad(cur.issue_date,15)|| rpad(date_diff*5,15));
	END LOOP;
END;
/

/* testing trigger*/
EXEC pro_print_fine(to_date('13	-MAR-19','DD-MON-YY'));


/* print debugging tables*/ 
SELECT * FROM Logging;
SELECT * FROM Issue;
-- SELECT * FROM Borrower;
SHOW error;
