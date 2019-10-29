/* Function 4 - fun_return_book */
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
CREATE OR REPLACE FUNCTION fun_return_book
	(bk_id IN NUMBER,
	 ret_dt IN DATE)
	 RETURN NUMBER IS 
	 stat NUMBER := 0;
	 cursor cur_pend IS SELECT * FROM Pending_request WHERE book_id=bk_id AND issue_date IS NULL ORDER BY request_date;
	 cur cur_pend%ROWTYPE;
BEGIN
	/* Book return */
	INSERT INTO logging VALUES (bk_id, 'rd = ' || TO_CHAR(ret_dt), 'fun4-a');
	UPDATE Issue SET return_date = ret_dt WHERE return_date IS NULL AND book_id=bk_id; 
	stat := 1;
	
	/* Serving Pending Requests */
	OPEN cur_pend;
    FETCH cur_pend INTO cur;
    IF cur_pend%NOTFOUND THEN
		INSERT INTO logging VALUES (bk_id, 'no pend', 'fun4-b');
    ELSE
		INSERT INTO logging VALUES (bk_id, 'yes pend', 'fun4-b');
    	UPDATE Pending_request SET issue_date = ret_dt WHERE issue_date IS NULL AND book_id=bk_id AND requester_id = cur.requester_id;
    	stat := fun_issue_book(cur.requester_id,bk_id,ret_dt);
	END IF;
	CLOSE cur_pend;
	RETURN stat;
END;
/ 


/* testing trigger*/
EXEC DBMS_OUTPUT.PUT_LINE('outside '||fun_return_book(1, '05-APR-19'));

/* print debugging tables*/ 
SELECT * FROM Issue;
SELECT * FROM Pending_request;
SELECT * FROM Logging;
SHOW ERROR