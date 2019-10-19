/* Trigger 1 - trg_maxbooks*/
/* Working - yet to integrate with functions */
/* check return_date=null*/ 
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
CREATE OR REPLACE TRIGGER trg_maxbooks
BEFORE INSERT ON Issue
FOR EACH ROW
DECLARE
	issued number;
	position varchar2(20);
BEGIN
	SELECT status INTO position FROM Borrower WHERE borrower_id = :new.borrower_id;
	SELECT count(*) INTO issued FROM Issue WHERE (borrower_id = :new.borrower_id AND return_date IS null);
	INSERT INTO logging VALUES (issued ,'stat = ' || position, 'trg1');
	IF position = 'student' THEN
		IF issued >= 2 THEN
			INSERT INTO logging VALUES (issued ,'bor_id = ' || TO_CHAR(:new.borrower_id), 'trg1');
			raise_application_error(-20000, 'Student has already issued 2 Books!');
		END IF;
	END IF;
	IF position = 'faculty' THEN
		IF issued >= 3 THEN
			INSERT INTO logging VALUES (issued ,'bor_id = ' || TO_CHAR(:new.borrower_id), 'trg1');
			raise_application_error(-20001, 'Faculty has already issued 3 Books!');
		END IF;
	END IF;
END;
/


/* testing trigger*/


-- tesing for student insertion
-- INSERT INTO Issue
-- VALUES (2, 2, '3-march-05', null);
-- INSERT INTO Issue
-- VALUES (3, 2, '4-march-05', null);
-- UPDATE Issue SET return_date = '7-march-05' WHERE borrower_id=2 AND book_id=2;
-- INSERT INTO Issue
-- VALUES (4, 2, '5-march-05', null);
-- INSERT INTO Issue
-- VALUES (6, 2, '5-march-05', null);
-- INSERT INTO Issue
-- VALUES (5, 3, '6-march-05', null);

-- testing for faculty insertion
-- INSERT INTO Issue
-- VALUES (2, 4, '7-march-05', null);
-- INSERT INTO Issue
-- VALUES (2, 4, '8-march-05', null);
-- INSERT INTO Issue
-- VALUES (2, 4, '9-march-05', null);
-- INSERT INTO Issue
-- VALUES (2, 4, '10-march-05', null);
-- INSERT INTO Issue
-- VALUES (2, 5, '11-march-05', null);

-- random testing
-- INSERT INTO Issue
-- VALUES (2, 4, '12-march-05', null);
-- INSERT INTO Issue
-- VALUES (2, 4, '13-march-05', null);
-- INSERT INTO Issue
-- VALUES (2, 2, '14-march-05', null);	
-- SELECT * FROM Logging;
-- SELECT * FROM Issue;
