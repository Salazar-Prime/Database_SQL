/* Trigger 1 - trg_maxbooks*/
/* Working - yet to integrate with functions */
rem EE 562 Project 2
rem Varun Aggarwal
rem aggarw82

/* clear history */
-- DROP TRIGGER trg_maxbooks; // using 'or replace' instead
TRUNCATE TABLE Issue;
TRUNCATE TABLE Logging;

/* Create trigger*/
CREATE OR REPLACE TRIGGER trg_maxbooks
BEFORE INSERT ON Issue
FOR EACH ROW
DECLARE
	issued number;
	position varchar2(20);
BEGIN
	SELECT status INTO position FROM Borrower WHERE borrower_id = :new.borrower_id;
	SELECT count(*) INTO issued FROM Issue WHERE borrower_id = :new.borrower_id;
	INSERT INTO logging VALUES (issued ,position);
	IF position = 'student' THEN
		IF issued >= 2 THEN
			INSERT INTO logging VALUES (issued ,TO_CHAR(:new.borrower_id));
			raise_application_error(-20000, 'Student has already issued 2 Books!');
		END IF;
	END IF;
	IF position = 'faculty' THEN
		IF issued >= 3 THEN
			INSERT INTO logging VALUES (issued ,TO_CHAR(:new.borrower_id));
			raise_application_error(-20001, 'Faculty has already issued 3 Books!');
		END IF;
	END IF;
END;
/


/* testing trigger*/

-- tesing for student insertion
INSERT INTO Issue
VALUES (2, 2, '3-march-05', '8-march-05');
INSERT INTO Issue
VALUES (2, 2, '3-march-05', '8-march-05');
INSERT INTO Issue
VALUES (2, 2, '3-march-05', '8-march-05');
INSERT INTO Issue
VALUES (2, 3, '3-march-05', '8-march-05');

-- testing for faculty insertion
INSERT INTO Issue
VALUES (2, 4, '4-march-05', '8-march-05');
INSERT INTO Issue
VALUES (2, 4, '4-march-05', '8-march-05');
INSERT INTO Issue
VALUES (2, 4, '4-march-05', '8-march-05');
INSERT INTO Issue
VALUES (2, 4, '4-march-05', '8-march-05');
INSERT INTO Issue
VALUES (2, 5, '4-march-05', '8-march-05');

-- random testing
INSERT INTO Issue
VALUES (2, 4, '4-march-05', '8-march-05');
INSERT INTO Issue
VALUES (2, 4, '4-march-05', '8-march-05');
INSERT INTO Issue
VALUES (2, 2, '3-march-05', '8-march-05');	
SELECT * FROM Logging;
SELECT * FROM Issue;