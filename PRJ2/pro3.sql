/* Procedure 3 - pro_listborr_mon */
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

CREATE OR REPLACE PROCEDURE pro_listborr_mon (bor_id IN NUMBER,
											  mon IN varchar2)
AS
cursor cur_bor_id IS SELECT * FROM Issue WHERE borrower_id = bor_id
											   AND to_char(issue_date, 'MONTH') LIKE (mon||'%');
bor_name varchar2(30);
bok_name varchar2(50);	
cur cur_bor_id%ROWTYPE;
BEGIN
	INSERT INTO Logging VALUES (bor_id,mon,'pro3');
	DBMS_OUTPUT.PUT_LINE(rpad('Borrower ID',15)|| rpad('Borrower Name',30)|| rpad('Book ID',15)
						|| rpad('Book Title',30)|| rpad('Issue Date',15) || rpad('Return Date',15));	

	DBMS_OUTPUT.PUT_LINE(rpad('-----------',15)|| rpad('-------------',30)|| rpad('-------',15)
						|| rpad('----------',30)|| rpad('----------',15) || rpad('-----------',15));
	FOR cur IN cur_bor_id
	LOOP

	/* fetching borrower and book name */ 
	SELECT name INTO bor_name FROM BORROWER WHERE borrower_id = bor_id;
	SELECT book_title INTO bok_name FROM BOOKS WHERE book_id = cur.book_id;
	/* printing output */
	DBMS_OUTPUT.PUT_LINE(rpad(cur.borrower_id,15)|| rpad(bor_name,30)|| rpad(cur.book_id,15)
						|| rpad(bok_name,30)|| rpad(cur.issue_date,15) || rpad(cur.return_date,15));	
	
	END LOOP;
END;
/

/* testing trigger*/
INSERT INTO Issue
VALUES (11, 3, '4-april-19', null);
EXEC pro_listborr_mon(3,'APR');


/* print debugging tables*/ 
SELECT * FROM Logging;
SELECT * FROM Issue;
-- SELECT * FROM Borrower;
SHOW error;
