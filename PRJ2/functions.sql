/* ALL Fucntions */
rem EE 562 Project 2
rem Varun Aggarwal
rem aggarw82

/* FUNCTION 1 */
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

/* FUNCTION 4 */
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
    	UPDATE Pending_request SET issue_date = ret_dt WHERE issue_date IS NULL AND book_id=bk_id;
    	stat := fun_issue_book(cur.requester_id,bk_id,ret_dt);
	END IF;
	CLOSE cur_pend;
	RETURN stat;
END;
/