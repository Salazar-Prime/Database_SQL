rem EE 562 Project 2
rem Varun Aggarwal
rem aggarw82
/* Drop Functions*/
DROP FUNCTION fun_return_book;

/* Drop Triggers */ 
DROP TRIGGER trg_maxbooks;
DROP TRIGGER trg_charge;
DROP TRIGGER trg_notcharge;

/* Drop all tables*/
DROP TABLE Issue;
DROP TABLE Pending_request;
DROP TABLE Books;
DROP TABLE Author;
DROP TABLE Borrower;
DROP TABLE Logging;
