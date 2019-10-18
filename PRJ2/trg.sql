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
AFTER INSERT ON Issue
FOR EACH ROW
DECLARE
	issued number;
	position varchar2(20);
BEGIN
	ALTER TABLE Books WHERE status
END;
/


/* testing trigger*/

-- tesing for student insertion
INSERT INTO Issue
VALUES (2, 2, '3-march-05', '8-march-05');


/* print debugging tables*/ 
SELECT * FROM Logging;
SELECT * FROM Issue;
SELECT * FROM Books;