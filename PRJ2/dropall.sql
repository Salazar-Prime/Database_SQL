rem EE 562 Project 2
rem Varun Aggarwal
rem aggarw82
/* Drop Functions*/
DROP FUNCTION fun_issue_book;
DROP FUNCTION fun_issue_anyedition;
-- fun3
DROP FUNCTION fun_return_book;

/* Drop Procedures */
DROP PROCEDURE pro_print_borrower;
DROP PROCEDURE pro_print_fine;
DROP PROCEDURE pro_listborr_mon;
DROP PROCEDURE pro_listborr;
-- pro5

/* Drop Triggers */ 
DROP TRIGGER trg_maxbooks;
DROP TRIGGER trg_charge;
DROP TRIGGER trg_notcharge;
-- trg4

/* Drop all tables*/
DROP TABLE Issue;
DROP TABLE Pending_request;
DROP TABLE Books;
DROP TABLE Author;
DROP TABLE Borrower;
DROP TABLE Logging;