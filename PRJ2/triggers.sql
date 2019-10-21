/* ALL Trigger*/
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

/* TRIGGER 1 */
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

/* TRIGGER 2 */
CREATE OR REPLACE TRIGGER trg_charge
AFTER INSERT ON Issue
FOR EACH ROW
BEGIN
	INSERT INTO logging VALUES (:new.book_id, '=book_id', 'trg2');
	UPDATE Books SET status='charged' WHERE book_id=:new.book_id;
END;
/

/* TRIGGER 3 */
CREATE OR REPLACE TRIGGER trg_notcharge
AFTER UPDATE ON Issue
FOR EACH ROW
WHEN (old.return_date IS NULL AND new.return_date IS NOT NULL)
BEGIN
	INSERT INTO logging VALUES (:new.book_id, 'rd = ' || TO_CHAR(:old.return_date), 'trg3');
	INSERT INTO logging VALUES (:new.book_id, 'rd = ' || TO_CHAR(:new.return_date), 'trg3');
	UPDATE Books SET status='not charged' WHERE book_id=:new.book_id;
END;
/

-- tesing for student insertion
INSERT INTO Issue
VALUES (2, 2, '3-march-19', null);
INSERT INTO Issue
VALUES (3, 2, '4-march-19', null);
UPDATE Issue SET return_date = '7-march-19' WHERE borrower_id=2 AND book_id=2;
INSERT INTO Issue
VALUES (4, 2, '5-march-19', null);
INSERT INTO Issue
VALUES (5, 2, '5-march-19', null);
INSERT INTO Issue
VALUES (13, 3, '6-march-19', null);

-- testing for faculty insertion
INSERT INTO Issue
VALUES (6, 4, '7-march-19', null);
INSERT INTO Issue
VALUES (7, 4, '8-march-19', null);
INSERT INTO Issue
VALUES (8, 4, '9-march-19', null);
INSERT INTO Issue
VALUES (9, 4, '10-march-19', null);
INSERT INTO Issue
VALUES (10, 5, '11-march-19', null);

-- random testing
INSERT INTO Issue
VALUES (1, 4, '12-march-19', null);
INSERT INTO Issue
VALUES (11, 4, '13-march-19', null);
INSERT INTO Issue
VALUES (12, 2, '14-march-19', null);	