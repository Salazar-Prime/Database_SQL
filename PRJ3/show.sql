clear screen
set linesize 200;
set pagesize 50;

/* Show table*/
PROMPT ;
PROMPT --------------------------------------------------------------------------------;
PROMPT     Books;
PROMPT --------------------------------------------------------------------------------;
SELECT * FROM Books;

PROMPT ;
PROMPT --------------------------------------------------------------------------------;
PROMPT     Author;
PROMPT --------------------------------------------------------------------------------;
SELECT * FROM Author;

PROMPT ;
PROMPT --------------------------------------------------------------------------------;
PROMPT     Borrower;
PROMPT --------------------------------------------------------------------------------;
SELECT * FROM Borrower;

-- PROMPT ;
-- PROMPT --------------------------------------------------------------------------------;
-- PROMPT     Issue;
-- PROMPT --------------------------------------------------------------------------------;
-- SELECT * FROM Issue;

-- PROMPT ;
-- PROMPT --------------------------------------------------------------------------------;
-- PROMPT     Pending_request;
-- PROMPT --------------------------------------------------------------------------------;
-- SELECT * FROM Pending_request;
