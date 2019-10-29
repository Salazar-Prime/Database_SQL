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

/* FUNCTION 2 */
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
		stat := 1;
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

/* FUNCTION 3 */
CREATE OR REPLACE FUNCTION fun_most_popular
	(in_mon IN VARCHAR2)
	 RETURN NUMBER IS

	/* join on max_count_table with count_table so that count = max(count) */ 
	CURSOR cur_popular IS
	SELECT max_count_table.yyyy, max_count_table.MMMMM, count_table.book_id
	FROM
	    (SELECT yyyy,MMMMM,max(cb) AS mcb
	     FROM
	         (SELECT TO_CHAR(issue_date,'MONTH') AS MMMMM, EXTRACT(YEAR FROM issue_date) AS yyyy, book_id, count(book_id) AS cb
	          FROM Issue
	          WHERE TO_CHAR(issue_date,'MON')=in_mon
	          GROUP BY TO_CHAR(issue_date,'MONTH'),EXTRACT(YEAR FROM issue_date),book_id)
	     GROUP BY yyyy,MMMMM) max_count_table
	JOIN
	    (SELECT TO_CHAR(issue_date,'MONTH') AS MMMMM ,EXTRACT(YEAR FROM issue_date) AS yyyy, book_id, count(book_id) AS cb
	     FROM Issue
	     WHERE TO_CHAR(issue_date,'MON')=in_mon
	     GROUP BY TO_CHAR(issue_date,'MONTH'), EXTRACT(YEAR FROM issue_date), book_id) count_table
	ON max_count_table.yyyy=count_table.yyyy AND max_count_table.MMMMM=count_table.MMMMM AND max_count_table.mcb=count_table.cb;

	cur cur_popular%ROWTYPE;
	at_name VARCHAR2(30);
	editions NUMBER;
	stat NUMBER := 0;
BEGIN
	OPEN cur_popular;
    FETCH cur_popular INTO cur;
    IF cur_popular%NOTFOUND THEN
		DBMS_OUTPUT.PUT_LINE(rpad(to_char(to_date(in_mon,'MON'),'MONTH'),30));
	END IF;
	CLOSE cur_popular;					  
	FOR cur IN cur_popular
	LOOP
		stat := cur.book_id;
		/* Query author name */
		SELECT name INTO at_name FROM Author WHERE author_id = (SELECT author_id FROM Books WHERE book_id = cur.book_id); 
		/* Query number of editions */
		SELECT COUNT(book_title) INTO editions FROM Books WHERE book_title = (SELECT book_title FROM Books WHERE book_id = cur.book_id); 
		/* Print output */ 
		DBMS_OUTPUT.PUT_LINE(rpad(cur.MMMMM,30) || rpad(cur.yyyy,15)
						  || rpad(at_name,30) || rpad(editions,15));
	END LOOP;
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
    	UPDATE Pending_request SET issue_date = ret_dt WHERE issue_date IS NULL AND book_id=bk_id AND requester_id = cur.requester_id;
    	stat := fun_issue_book(cur.requester_id,bk_id,ret_dt);
	END IF;
	CLOSE cur_pend;
	RETURN stat;
END;
/ 
