/* Function 3 - fun_most_popular */
/* working - yet to integrate with pro5 */
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
CREATE OR REPLACE FUNCTION fun_most_popular
	(mon IN VARCHAR2)
	 RETURN NUMBER IS
	 cursor cur_pend IS SELECT book_id, issue_date FROM Issue
	 								   WHERE to_char(issue_date, 'MON') = mon
	 								   GROUP BY book_id, issue_date
	 								   HAVING COUNT(*)=(SELECT MAX(COUNT(*)) 
	 												    FROM Issue
	 												    WHERE to_char(issue_date, 'MON') = mon
	 												    GROUP BY to_char(issue_date, 'MON')),book_id;
	 cur cur_pend%ROWTYPE;
	 at_name VARCHAR2(30);
	 editions NUMBER;
BEGIN						  
	FOR cur IN cur_pend
	LOOP
		/* Query author name */
		SELECT name INTO at_name FROM Author WHERE author_id = (SELECT author_id FROM Books WHERE book_id = cur.book_id); 
		/* Query number of editions */
		SELECT COUNT(book_title) INTO editions FROM Books WHERE book_title = (SELECT book_title FROM Books WHERE book_id = cur.book_id); 
		/* Print output */ 
		DBMS_OUTPUT.PUT_LINE(rpad(to_char(cur.issue_date,'MONTH'),30) || rpad(extract(year FROM cur.issue_date),15)
						  || rpad(at_name,30) || rpad(editions,15));
	END LOOP;
	RETURN 1;
END;
/ 


/* testing trigger*/
EXEC DBMS_OUTPUT.PUT_LINE(chr(10) ||'outside '||fun_most_popular('FEB'));

/* print debugging tables*/ 
SELECT * FROM Issue;
SELECT * FROM Pending_request;
SELECT * FROM Logging;
SHOW ERROR