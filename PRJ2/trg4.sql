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
clear screen

/* Create trigger*/
CREATE OR REPLACE TRIGGER trg_renew
AFTER/BEFORE UPDATE ON ()
STATEMENT/FOR EACH ROW
WHEN ()
BEGIN
	INSERT INTO logging VALUES ( , , 'trg4');
END;
/


/* testing trigger*/




/* print debugging tables*/ 
SELECT * FROM Issue;
SELECT * FROM Pending_request;
SELECT * FROM Logging;