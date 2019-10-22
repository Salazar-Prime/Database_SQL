/* Procedure 1 - pro_print_borrower */
/*Working */ 
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

CREATE OR REPLACE PROCEDURE pro_print_borrower
AS
cursor cur_bor_id IS SELECT * FROM Issue WHERE return_date IS null;
bor_name varchar2(30);
bok_name varchar2(50);
date_diff number;
print_pos number;	
cur cur_bor_id%ROWTYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE(rpad('Borrower Name',30)|| rpad('Book Title',30)|| rpad('<=5days',15)
						 || rpad('<=10days',15)|| rpad('<=15days',15) || rpad('>15days',15));	

	DBMS_OUTPUT.PUT_LINE(rpad('-------------',30)|| rpad('----------',30)|| rpad('-------',15)
						 || rpad('--------',15)|| rpad('--------',15) || rpad('-------',15));					 			
	FOR cur IN cur_bor_id
	LOOP
		/* fetching borrower and book name */ 
		SELECT name INTO bor_name FROM BORROWER WHERE borrower_id = cur.borrower_id;
		SELECT book_title INTO bok_name FROM BOOKS WHERE book_id = cur.book_id;
		date_diff := to_date(SYSDATE,'DD-MON-YY') - cur.issue_date;
		
		/* printing output */
		DBMS_OUTPUT.PUT(rpad(bor_name,30)|| rpad(bok_name,30));
		FOR Lcntr IN 1..4
		LOOP
			/* categorize position to print */
			print_pos := CEIL(date_diff/5);
			IF print_pos > 4 THEN
				print_pos := 4;
			END IF;
			IF Lcntr = print_pos THEN
				DBMS_OUTPUT.PUT(rpad(date_diff,15));
			ELSE
				DBMS_OUTPUT.PUT(rpad(' ',15));
			END IF;
		END LOOP;
		DBMS_OUTPUT.NEW_LINE;
		
	END LOOP;
END;
/

/* testing trigger*/
EXEC pro_print_borrower;


/* print debugging tables*/ 
SELECT * FROM Logging;
SHOW error;
-- SELECT * FROM Issue;
