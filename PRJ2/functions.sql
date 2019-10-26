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
	 RETURN NUMBER IS stat NUMBER := 0;
BEGIN
	UPDATE Issue SET return_date = ret_dt WHERE return_date IS NULL AND book_id=bk_id; 
	stat := 1;
	
	
	RETURN stat;
END;
/ 
/ 