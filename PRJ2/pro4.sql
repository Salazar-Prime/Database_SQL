/* Procedure 4 - pro_listborr */
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

CREATE OR REPLACE PROCEDURE pro_listborr
AS
cursor cur_bor_id IS SELECT * FROM Issue WHERE return_date IS null;
bor_name varchar2(30);
date_diff number;	
cur cur_bor_id%ROWTYPE;
BEGIN

	DBMS_OUTPUT.PUT_LINE(rpad('Borrower Name',30)|| rpad('Book ID',15)|| rpad('Issue Date',15));	

	DBMS_OUTPUT.PUT_LINE(rpad('-------------',30)|| rpad('-------',15)|| rpad('----------',15));					 			
	
	FOR cur IN cur_bor_id
	LOOP
	
	/* fetching borrower name */ 
	SELECT name INTO bor_name FROM BORROWER WHERE borrower_id = cur.borrower_id;
	/* printing output */
	DBMS_OUTPUT.PUT_LINE(rpad(bor_name,30)|| rpad(cur.book_id,15)|| rpad(cur.issue_date,15));	
	
	END LOOP;
END;
/

/* testing trigger*/
EXEC pro_listborr;


/* print debugging tables*/ 
SELECT * FROM Logging;
SELECT * FROM Issue;
-- SELECT * FROM Borrower;
SHOW error;
