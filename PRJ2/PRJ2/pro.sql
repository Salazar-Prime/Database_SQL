/* ALL Procedures */
rem EE 562 Project 2
rem Varun Aggarwal
rem aggarw82

/* PROCEDURE 1 */
CREATE OR REPLACE PROCEDURE pro_print_borrower
AS
cursor cur_bor_id IS SELECT * FROM Issue WHERE return_date IS null;
bor_name varchar2(30);
bok_name varchar2(50);
date_diff number;
print_pos number;	
cur cur_bor_id%ROWTYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE(rpad('Borrower Name',30)|| rpad('Book Title',30)|| rpad('<=5days',15)
						 || rpad('<=10days',15)|| rpad('<=15days',15) || rpad('>15days',15));	

	DBMS_OUTPUT.PUT_LINE(rpad('-------------',30)|| rpad('----------',30)|| rpad('-------',15)
						 || rpad('--------',15)|| rpad('--------',15) || rpad('-------',15));					 			
	FOR cur IN cur_bor_id
	LOOP
		/* fetching borrower and book name */ 
		SELECT name INTO bor_name FROM BORROWER WHERE borrower_id = cur.borrower_id;
		SELECT book_title INTO bok_name FROM BOOKS WHERE book_id = cur.book_id;
		date_diff := to_date(SYSDATE,'DD-MON-YY') - cur.issue_date;
		
		/* printing output */
		DBMS_OUTPUT.PUT(rpad(bor_name,30)|| rpad(bok_name,30));
		FOR Lcntr IN 1..4
		LOOP
			/* categorize position to print */
			print_pos := CEIL(date_diff/5);
			IF print_pos > 4 THEN
				print_pos := 4;
			END IF;
			IF Lcntr = print_pos THEN
				DBMS_OUTPUT.PUT(rpad(date_diff,15));
			ELSE
				DBMS_OUTPUT.PUT(rpad(' ',15));
			END IF;
		END LOOP;
		DBMS_OUTPUT.NEW_LINE;
		
	END LOOP;
END;
/

/* PROCEDURE 2 */
CREATE OR REPLACE PROCEDURE pro_print_fine (cur_date IN DATE)
AS	
cursor cur_bor_id IS SELECT * FROM Issue;
bor_name varchar2(30);
date_diff number;	
cur cur_bor_id%ROWTYPE;
BEGIN

	DBMS_OUTPUT.PUT_LINE(rpad('Borrower Name',30)|| rpad('Book ID',30)
						 || rpad('Issue Date',15)|| rpad('Fine',15));	

	DBMS_OUTPUT.PUT_LINE(rpad('-------------',30)|| rpad('-------',30)
						 || rpad('----------',15)|| rpad('----',15));					 			
	FOR cur IN cur_bor_id
	LOOP
	
	/* fetching borrower name */ 
	SELECT name INTO bor_name FROM BORROWER WHERE borrower_id = cur.borrower_id;
	
	/* returned vs not returned book */
	IF cur.return_date IS NULL THEN
		date_diff := to_date(cur_date,'DD-MON-YY') - cur.issue_date - 5;
	ELSE
		date_diff := cur.return_date - cur.issue_date - 5;
	END IF;
	
	/* If no fine */
	IF date_diff < 0 THEN
		date_diff := 0;
	END IF;
	
	/* printing output */
	DBMS_OUTPUT.PUT_LINE(rpad(bor_name,30)|| rpad(cur.book_id,30)
						 || rpad(cur.issue_date,15)|| rpad(date_diff*5,15));
	END LOOP;
END;
/

/* PROCEDURE 3 */
CREATE OR REPLACE PROCEDURE pro_listborr_mon (bor_id IN NUMBER,
											  mon IN varchar2)
AS
cursor cur_bor_id IS SELECT * FROM Issue WHERE borrower_id = bor_id
											   AND to_char(issue_date, 'MONTH') LIKE (mon||'%');
bor_name varchar2(30);
bok_name varchar2(50);	
cur cur_bor_id%ROWTYPE;
BEGIN
	-- INSERT INTO Logging VALUES (bor_id,mon,'pro3');
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

/* PROCEDURE 4 */
CREATE OR REPLACE PROCEDURE pro_listborr
AS
cursor cur_bor_id IS SELECT * FROM Issue WHERE return_date IS null;
bor_name varchar2(30);
date_diff number;	
cur cur_bor_id%ROWTYPE;
BEGIN

	DBMS_OUTPUT.PUT_LINE(rpad('Borrower Name',30)|| rpad('Book ID',15)|| rpad('Issue Date',15));	

	DBMS_OUTPUT.PUT_LINE(rpad('-------------',30)|| rpad('-------',15)|| rpad('----------',15));					 			
	
	FOR cur IN cur_bor_id
	LOOP	
		/* fetching borrower name */ 
		SELECT name INTO bor_name FROM BORROWER WHERE borrower_id = cur.borrower_id;
		/* printing output */
		DBMS_OUTPUT.PUT_LINE(rpad(bor_name,30)|| rpad(cur.book_id,15)|| rpad(cur.issue_date,15));		
	END LOOP;
END;
/

/* PROCEDURE 5 */
CREATE OR REPLACE PROCEDURE pro_list_popular
AS
stat NUMBER;
BEGIN
	
	DBMS_OUTPUT.PUT_LINE(rpad('Month',30)|| rpad('Year',15)
						 || rpad('Author Name',30)|| rpad('# of Editions',15));	

	DBMS_OUTPUT.PUT_LINE(rpad('-----',30)|| rpad('----',15)
						 || rpad('-----------',30)|| rpad('-------------',15));		
	FOR mon IN 1..12
	LOOP
		stat := fun_most_popular(to_char(to_date(mon,'MM'),'MON')); 
	END LOOP;

END;
/
