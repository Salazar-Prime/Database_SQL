rem EE 562 Project 2
rem Varun Aggarwal
rem aggarw82
/* Drop Functions*/
DROP FUNCTION fun_issue_book;
DROP FUNCTION fun_issue_anyedition;
DROP FUNCTION fun_most_popular;
DROP FUNCTION fun_return_book;

/* Drop Procedures */
DROP PROCEDURE pro_print_borrower;
DROP PROCEDURE pro_print_fine;
DROP PROCEDURE pro_listborr_mon;
DROP PROCEDURE pro_listborr;
DROP PROCEDURE pro_list_popular;

/* Drop Triggers */ 
DROP TRIGGER trg_maxbooks;
DROP TRIGGER trg_charge;
DROP TRIGGER trg_notcharge;
DROP TRIGGER trg_renew;

/* Drop all tables*/
DROP TABLE Issue;
DROP TABLE Pending_request;
DROP TABLE Books;
DROP TABLE Author;
DROP TABLE Borrower;
-- DROP TABLE Logging;