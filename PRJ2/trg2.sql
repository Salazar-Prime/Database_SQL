/* Trigger 2 - trg_charge*/
/* Working - yet to integrate with functions */
rem EE 562 Project 2
rem Varun Aggarwal
rem aggarw82

/* clear history */
-- DROP TRIGGER trg_maxbooks; // using 'or replace' instead
@dropall
@createtable
@populate
@trg1
set linesize 200;
set pagesize 50;
clear screen

/* Create trigger*/
CREATE OR REPLACE TRIGGER trg_charge
AFTER INSERT ON Issue
FOR EACH ROW
BEGIN
	INSERT INTO logging VALUES (:new.book_id, 'book_id');
	UPDATE Books SET status='charged' WHERE book_id=:new.book_id;
END;
/


/* testing trigger*/

-- tesing for student insertion
INSERT INTO Issue
VALUES (2, 2, '3-march-05', null);
INSERT INTO Issue
VALUES (3, 2, '4-march-05', null);
UPDATE Issue SET return_date = '7-march-05' WHERE borrower_id=2 AND book_id=2;
INSERT INTO Issue
VALUES (4, 2, '5-march-05', null);
INSERT INTO Issue
VALUES (5, 2, '5-march-05', null);
INSERT INTO Issue
VALUES (13, 3, '6-march-05', null);

-- testing for faculty insertion
INSERT INTO Issue
VALUES (6, 4, '7-march-05', null);
INSERT INTO Issue
VALUES (7, 4, '8-march-05', null);
INSERT INTO Issue
VALUES (8, 4, '9-march-05', null);
INSERT INTO Issue
VALUES (9, 4, '10-march-05', null);
INSERT INTO Issue
VALUES (10, 5, '11-march-05', null);

-- random testing
INSERT INTO Issue
VALUES (1, 4, '12-march-05', null);
INSERT INTO Issue
VALUES (11, 4, '13-march-05', null);
INSERT INTO Issue
VALUES (12, 2, '14-march-05', null);	

/* print debugging tables*/ 
SELECT * FROM Logging;
SELECT * FROM Issue;
SELECT * FROM Books;