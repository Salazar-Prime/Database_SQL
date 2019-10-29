/* ALL Trigger*/
rem EE 562 Project 2
rem Varun Aggarwal
rem aggarw82

/* TRIGGER 1 */
CREATE OR REPLACE TRIGGER trg_maxbooks
BEFORE INSERT ON Issue
FOR EACH ROW
DECLARE
	issued number;
	position varchar2(20);
BEGIN
	SELECT status INTO position FROM Borrower WHERE borrower_id = :new.borrower_id;
	SELECT COUNT(*) INTO issued FROM Issue WHERE (borrower_id = :new.borrower_id AND return_date IS null);
	-- INSERT INTO Logging VALUES (issued ,'stat = ' || position, 'trg1');
	IF position = 'student' THEN
		IF issued >= 2 THEN
			-- INSERT INTO Logging VALUES (issued ,'bor_id = ' || TO_CHAR(:new.borrower_id), 'trg1');
			raise_application_error(-20000, 'Student has already issued 2 Books!');
		END IF;
	END IF;
	IF position = 'faculty' THEN
		IF issued >= 3 THEN
			-- INSERT INTO Logging VALUES (issued ,'bor_id = ' || TO_CHAR(:new.borrower_id), 'trg1');
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
	-- INSERT INTO Logging VALUES (:new.book_id, '=book_id', 'trg2');
	UPDATE Books SET status='charged' WHERE book_id=:new.book_id;
END;
/

/* TRIGGER 3 */
CREATE OR REPLACE TRIGGER trg_notcharge
AFTER UPDATE ON Issue
FOR EACH ROW
WHEN (old.return_date IS NULL AND new.return_date IS NOT NULL)
BEGIN
	-- INSERT INTO Logging VALUES (:new.book_id, 'rd = ' || TO_CHAR(:old.return_date), 'trg3');
	-- INSERT INTO Logging VALUES (:new.book_id, 'rd = ' || TO_CHAR(:new.return_date), 'trg3');
	UPDATE Books SET status='not charged' WHERE book_id=:new.book_id;
END;
/

/* TRIGGER 4 */
CREATE TRIGGER trg_renew
BEFORE INSERT ON Pending_request
FOR EACH ROW
DECLARE
	book_status varchar2(20);
	other_wait_pend number := 0;
	present_bor number := 0;
	requester_count number := 0;
	existing_request number := 0;
	error67 EXCEPTION;
BEGIN
	/* check status of book */
	SELECT status INTO book_status
	FROM Books
	WHERE book_id = :new.book_id;
    IF book_status='charged' THEN
    	/* store borrower ID for current borrower of book */
		SELECT borrower_id INTO present_bor
		FROM Issue
		WHERE book_id=:new.book_id
		AND return_date IS NULL;

		/* check if others are waiting already for the book in Pending request */
		SELECT COUNT(*) INTO other_wait_pend
		FROM Pending_request
		WHERE book_id=:new.book_id
		AND Issue_date IS NULL;
    END IF;

	IF book_status = 'charged' AND present_bor = :new.requester_id THEN
		RAISE error67;
	END IF;

	IF book_status = 'charged' AND present_bor = :new.requester_id AND other_wait_pend > 0 THEN
		RAISE error67;
	END IF;

	/* count existing number of request by requester - RULE 6 */
	SELECT COUNT(*) INTO requester_count
	FROM (
	      (SELECT book_id
	       FROM Issue
	       WHERE borrower_id=:new.requester_id
	           AND return_date IS NULL)
	   	  
	   	  UNION

	      (SELECT book_id
	       FROM Pending_request
	       WHERE requester_id=:new.requester_id
	           AND Issue_date IS NULL)
	      );
          
	IF book_status = 'charged' AND present_bor != :new.requester_id AND requester_count > 7 THEN
		RAISE error67;
	END IF;

	/* check if request already exists for cuurrent requester */
	SELECT COUNT(*) INTO existing_request
	FROM Pending_request
	WHERE requester_id=:new.requester_id
	    AND book_id=:new.book_id
	    AND Issue_date IS NULL;

	IF existing_request > 0 AND requester_count <= 7 THEN
		RAISE error67;
	END IF;

EXCEPTION
	WHEN error67 THEN
		raise_application_error(-20002, 'voilation of RULE 6/7');

END trg_renew;               
/
