/* Function 1 - fun_issue_book*/
/*  */
rem EE 562 Project 2
rem Varun Aggarwal
rem aggarw82

/* clear history */
@triggers -- triggers clears all tables et. al.
clear screen

/* Create function*/
CREATE OR REPLACE FUNCTION fun_issue_book
	(bor_id IN NUMBER,
	 bk_id IN NUMBER,
	 cur_dt IN DATE)
	 RETURN NUMBER IS stat NUMBER;
BEGIN 
	stat := 0;
	IF stat = 0 THEN
		stat := 1;
	END IF;
	RETURN stat;
END;
/ 


/* testing trigger*/

	-- stat := 0;
	-- IF (SELECT status FROM Books WHERE book_id = bk_id) = 'not charged' THEN
		-- INSERT INTO Issue VALUES (bk_id, bor_id, cur_dt, null);
		-- stat := 1;
	-- ELSE 
		-- INSERT INTO Pending_request VALUES (bk_id, bor_id, cur_dt);
	-- END IF;


/* print debugging tables*/ 
SELECT * FROM Issue;
SELECT * FROM Pending_request;
SELECT * FROM Logging;