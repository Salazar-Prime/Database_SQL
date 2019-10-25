/* Function 4 - fun_return_book */
/* Done part 1 of */
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
CREATE OR REPLACE FUNCTION fun_return_book
	(bk_id IN NUMBER,
	 ret_dt IN DATE)
	 RETURN NUMBER IS 
	 stat NUMBER := 0;
	 cursor cur_issue_id IS SELECT * FROM Issue WHERE book_id=bk_id;
	 cur cur_issue_id%ROWTYPE;
BEGIN
	/* Book return */
	INSERT INTO logging VALUES (bk_id, 'rd = ' || TO_CHAR(ret_dt), 'fun4');
	UPDATE Issue SET return_date = ret_dt WHERE return_date IS NULL AND book_id=bk_id; 
	stat := 1;
	
	-- /* Book issue from Pending requests */
	-- FOR cur IN cur_issue_id
	-- LOOP 
	-- 	IF cur.issue_date IS NULL THEN
	-- 		/* call fun_issue_anyedition or fun_issue and exit out of loop*/
	-- 	END IF;
	-- END LOOP;
	RETURN stat;
END;
/ 


/* testing trigger*/
EXEC DBMS_OUTPUT.PUT_LINE('outside '||fun_return_book(2, '05-APR-19'));

/* print debugging tables*/ 
SELECT * FROM Issue;
SELECT * FROM Logging;
SHOW ERROR