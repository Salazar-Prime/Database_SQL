/* Function 2 - fun_issue_anyedition */
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






/* Create function*/
CREATE OR REPLACE FUNCTION fun_issue_anyedition
	(bor_id IN NUMBER,
	 bk_name IN VARCHAR2,
	 aut_name IN VARCHAR2,
	 cur_dt IN DATE)
	 RETURN NUMBER IS
	 stat NUMBER := 0;
	 cursor cur_book_ed IS SELECT * FROM Books WHERE book_title=bk_name AND status='not charged' ORDER BY edition DESC;
	 cur cur_book_ed%ROWTYPE;
BEGIN
	/* Book Issue */
	INSERT INTO logging VALUES (bor_id, 'book name = ' || TO_CHAR(bk_name), 'fun2');
	FOR cur IN cur_book_ed
	LOOP
		/* call fun_issue */ 
		stat := 1;
		EXIT;
		
	END LOOP;

	IF stat = 0 THEN
		/* Add to Pending request */ 
		stat := 1;
	END IF;
	RETURN stat;
END;
/ 


/* testing trigger*/
EXEC DBMS_OUTPUT.PUT_LINE('outside '||fun_return_book(2, '05-APR-19'));

/* print debugging tables*/ 
SELECT * FROM Issue;
SELECT * FROM Logging;
SHOW ERROR
