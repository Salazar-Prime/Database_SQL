/* Function 1 - fun_issue_book */
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






/* Create function*/
CREATE OR REPLACE FUNCTION fun_issue_book
	(bor_id IN NUMBER,
	 bk_id IN NUMBER,
	 cur_dt IN DATE)
	 RETURN NUMBER IS

	 stat NUMBER := 0;
	 bor_stat VARCHAR2(20);
BEGIN
	
	
	/* fetch book status */ 
	SELECT status INTO bor_stat FROM Books WHERE book_id = bk_id; 
	
	/* Book Issue or Pending */
	IF bor_stat = 'not charged' THEN
		INSERT INTO Issue VALUES (bk_id, bor_id, cur_dt, null);
		stat := 1;
	ELSE
		INSERT INTO Pending_request VALUES (bk_id, bor_id, cur_dt, null);
		stat := 0;
	END IF;
	INSERT INTO logging VALUES (bor_id, 'STAT = ' || TO_CHAR(bk_id), 'fun1');
	RETURN stat;
END;
/ 


/* testing trigger*/
-- EXEC DBMS_OUTPUT.PUT_LINE('outside '|| fun_issue_book(6, 10, '13-march-19'));
@mydata

/* print debugging tables*/ 
SELECT * FROM Issue;
SELECT * FROM Pending_request;
SELECT * FROM Logging;
SHOW ERROR