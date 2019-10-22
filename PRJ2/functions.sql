/* ALL Trigger*/
rem EE 562 Project 2
rem Varun Aggarwal
rem aggarw82

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