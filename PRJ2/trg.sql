/* Trigger 4 - trg_renew*/
/* to complete */
rem EE 562 Project 2
rem Varun Aggarwal
rem aggarw82

/* clear history */
@dropall
@createtable
@populate
set linesize 200;
set pagesize 50;
set serveroutput ON;
clear screen
SELECT * FROM Author;

/* Create trigger*/
CREATE OR REPLACE TRIGGER trg_test
BEFORE UPDATE ON Author
-- FOR EACH ROW
DECLARE 
	funny NUMBER;
BEGIN
	SELECT author_id INTO funny FROM Author;
	dbms_output.put_line('working!!');
END;
/


/* testing trigger*/

update author set name='IE' where name='IEEE';
SELECT * FROM Author;
SHOW ERROR
/* print debugging tables*/ 
-- SELECT * FROM Issue;
-- SELECT * FROM Pending_request;
-- SELECT * FROM Logging;