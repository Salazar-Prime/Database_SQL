rem EE 562 Project 2
rem Varun Aggarwal
rem aggarw82

/* Drop all tables*/
DROP TABLE Issue;
DROP TABLE Pending_request;
DROP TABLE Books;
DROP TABLE Author;
DROP TABLE Borrower;
DROP TABLE Logging;

/* Drop Triggers */ 
DROP TRIGGER trg_maxbooks;