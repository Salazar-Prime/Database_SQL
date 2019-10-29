/* Function 2 - fun_issue_anyedition */
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
CREATE OR REPLACE FUNCTION fun_issue_anyedition
	(bor_id IN NUMBER,
	 bk_name IN VARCHAR2,
	 aut_name IN VARCHAR2,
	 cur_dt IN DATE)
	 RETURN NUMBER IS
	 bk_id NUMBER;
	 stat NUMBER := 0;
	 cursor cur_book_ed IS SELECT * FROM Books
									WHERE book_title=bk_name AND status='not charged'
									ORDER BY edition DESC;
	 cur cur_book_ed%ROWTYPE;
BEGIN	
	/* checking for charged books */ 
	OPEN cur_book_ed;
    FETCH cur_book_ed INTO cur;
	
    IF cur_book_ed%FOUND THEN
		/* for issue */
		bk_id := cur.book_id;
		
		INSERT INTO logging VALUES (bk_id, 'issued', 'fun2');
	ELSE 	
		/* for adding to pending request*/
		SELECT book_id INTO bk_id 
		FROM (SELECT * FROM Books WHERE book_title=bk_name ORDER BY edition DESC)
		WHERE ROWNUM = 1;
		
		INSERT INTO logging VALUES (bk_id, 'to pend', 'fun2');
	END IF;
	
	stat := fun_issue_book(bor_id, bk_id, cur_dt);
	CLOSE cur_book_ed;
	RETURN stat;
END;
/ 


/* testing trigger*/
EXEC DBMS_OUTPUT.PUT_LINE('outside '||fun_issue_anyedition(7,'CALCULUS III','blank','10-APR-19'));
EXEC DBMS_OUTPUT.PUT_LINE('outside '||fun_issue_anyedition(8,'CALCULUS III','blank','10-APR-19'));
EXEC DBMS_OUTPUT.PUT_LINE('outside '||fun_issue_anyedition(9,'CALCULUS III','blank','10-APR-19'));

/* print debugging tables*/ 
SELECT * FROM Issue;
SELECT * FROM Pending_request;
SELECT * FROM Books;
SELECT * FROM Logging;
SHOW ERROR
