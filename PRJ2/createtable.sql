rem EE 562 Project 2
rem Varun Aggarwal
rem aggarw82

/* temp thing - delete finally */ 						
CREATE TABLE logging(for_int number, for_string varchar(50), from_ varchar2(10));

/* Create table*/
CREATE TABLE Books( book_id number,
					book_title varchar2(50),
					author_id number,
					year_of_publication number,
					edition number, 
					status varchar2(20),
					PRIMARY KEY (book_id)
					);
					
CREATE TABLE Author( author_id number,
					 Name varchar2(30),
					 PRIMARY KEY (author_id)
					 );
					 
CREATE TABLE Borrower( borrower_id number, 
					   name varchar2(30),
					   status varchar2(20),
					   PRIMARY KEY (borrower_id)
					   );
					   
CREATE TABLE Issue( book_id number,
					borrower_id number,
					issue_date date,
					return_date date,
					PRIMARY KEY (book_id, borrower_id, issue_date),
					FOREIGN KEY (book_id) REFERENCES Books(book_id),
					FOREIGN KEY (borrower_id) REFERENCES Borrower(borrower_id)
					);
					
CREATE TABLE Pending_request( book_id number,
							  requester_id number,
							  request_date date,
							  Issue_date date,
							  PRIMARY KEY (book_id, requester_id, request_date),
							  FOREIGN KEY (book_id) REFERENCES Books(book_id)
							  );



/* contraint 1 */
ALTER TABLE Books
ADD CONSTRAINT constraint1 check (status = 'charged' or status = 'not charged');
/* contraint 2 */
ALTER TABLE Borrower
ADD CONSTRAINT constraint2 check (status = 'student' or status = 'faculty');