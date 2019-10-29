/* ALL Trigger*/
rem EE 562 Project 2
rem Varun Aggarwal
rem aggarw82

/* step 1 */
@dropall
@createtable
@populate
@functions
@procedures
set linesize 200;
set pagesize 50;
set SERVEROUTPUT ON;

/* step 2 */
begin
dbms_output.put_line('==================================================');
dbms_output.put_line('2 - Insert records with fun_issue_books');
dbms_output.put_line('==================================================');
end;
/
@trg

/* step 3 */
begin
dbms_output.put_line('==================================================');
dbms_output.put_line('3 - Insert records with fun_issue_books');
dbms_output.put_line('==================================================');
end;
/
@mydata

/* step 4 */
begin
dbms_output.put_line('==================================================');
dbms_output.put_line('4 - Insert records with fun_issue_anyedition');
dbms_output.put_line('==================================================');
end;
/
EXEC DBMS_OUTPUT.PUT_LINE(fun_issue_anyedition(2,'DATA MANAGEMENT','C.J. DATES',to_date('3/3/2003','MM/DD/YY')));
EXEC DBMS_OUTPUT.PUT_LINE(fun_issue_anyedition(4,'CALCULUS','H. ANTON',to_date('3/4/2003','MM/DD/YY')));
EXEC DBMS_OUTPUT.PUT_LINE(fun_issue_anyedition(5,'ORACLE','ORACLE PRESS',to_date('3/4/2003','MM/DD/YY')));
EXEC DBMS_OUTPUT.PUT_LINE(fun_issue_anyedition(10,'IEEE MULTIMEDIA','IEEE',to_date('2/27/2003','MM/DD/YY')));
EXEC DBMS_OUTPUT.PUT_LINE(fun_issue_anyedition(2,'MIS MANAGEMENT','C.J. CATES',to_date('5/3/2003','MM/DD/YY')));
EXEC DBMS_OUTPUT.PUT_LINE(fun_issue_anyedition(4,'CALCULUS II','H. ANTON',to_date('3/4/2003','MM/DD/YY')));
EXEC DBMS_OUTPUT.PUT_LINE(fun_issue_anyedition(10,'ORACLE','ORACLE PRESS',to_date('3/4/2003','MM/DD/YY')));
EXEC DBMS_OUTPUT.PUT_LINE(fun_issue_anyedition(5,'IEEE MULTIMEDIA','IEEE',to_date('2/26/2003','MM/DD/YY')));
EXEC DBMS_OUTPUT.PUT_LINE(fun_issue_anyedition(2,'DATA STRUCTURE','W. GATES',to_date('3/3/2003','MM/DD/YY')));
EXEC DBMS_OUTPUT.PUT_LINE(fun_issue_anyedition(4,'CALCULUS III','H. ANTON',to_date('4/4/2003','MM/DD/YY')));
EXEC DBMS_OUTPUT.PUT_LINE(fun_issue_anyedition(11,'ORACLE','ORACLE PRESS',to_date('3/8/2003','MM/DD/YY')));
EXEC DBMS_OUTPUT.PUT_LINE(fun_issue_anyedition(6,'IEEE MULTIMEDIA','IEEE',to_date('2/17/2003','MM/DD/YY')));
/

/* step 5 */ 
begin
dbms_output.put_line('==================================================');
dbms_output.put_line('5 - Execute pro_print_borrower');
dbms_output.put_line('==================================================');
end;
/
EXEC pro_print_borrower;


/* step 6 */ 
begin
dbms_output.put_line('==================================================');
dbms_output.put_line('6 - Execute pro_print_fine');
dbms_output.put_line('==================================================');
end;
/
EXEC pro_print_fine(to_date('02/28/03','MM/DD/YY'));

/* step 7 */
begin
dbms_output.put_line('==================================================');
dbms_output.put_line('7 - Return books 1, 2, 4 and 10');
dbms_output.put_line('==================================================');
end;
/
EXEC DBMS_OUTPUT.PUT_LINE(fun_return_book(1,to_date('2/28/03','MM/DD/YY')));
EXEC DBMS_OUTPUT.PUT_LINE(fun_return_book(2,to_date('2/28/03','MM/DD/YY')));
EXEC DBMS_OUTPUT.PUT_LINE(fun_return_book(4,to_date('2/28/03','MM/DD/YY')));
EXEC DBMS_OUTPUT.PUT_LINE(fun_return_book(10,to_date('2/28/03','MM/DD/YY')));
/

/* step 8 */
begin
dbms_output.put_line('==================================================');
dbms_output.put_line('8 - Print the pending_request and issue tables');
dbms_output.put_line('==================================================');
end;
 /
SELECT * FROM Pending_request;
SELECT * FROM Issue;

/* step 9 */
begin
dbms_output.put_line('==================================================');
dbms_output.put_line('9 - Execute pro_listborr_mon for the month of February and March');
dbms_output.put_line('==================================================');
end;
 /
EXEC pro_listborr_mon(1,'FEB');
EXEC pro_listborr_mon(1,'MAR');


/* step 10 */
begin
dbms_output.put_line('==================================================');
dbms_output.put_line('10 - Execute pro_listborr');
dbms_output.put_line('==================================================');
end;
/
EXEC pro_listborr;

/* step 11 */
begin
dbms_output.put_line('==================================================');
dbms_output.put_line('11 - Execute pro_list_popular');
dbms_output.put_line('==================================================');
end;
/
EXEC pro_list_popular;

/* step 12 */
begin
dbms_output.put_line('==================================================');
dbms_output.put_line('12 - Print the average time a requester waits in the Pending_request table');
dbms_output.put_line('==================================================');
end;
/
SELECT AVG(issue_date-request_date) AS AVERAGE_WAIT
FROM Pending_request
WHERE issue_date IS NOT NULL;

/* step 13 */
begin
dbms_output.put_line('==================================================');
dbms_output.put_line('13 - Print the name and the borrower_id of the person who has waited the longest amount of time for any book.');
dbms_output.put_line('==================================================');
end;
/
SELECT name,
       borrower_id
FROM Borrower
WHERE borrower_id=
        (SELECT P2.requester_id
         FROM Pending_request P2 WHERE(P2.issue_date - P2.request_date)=
             (SELECT max(P1.issue_date-P1.request_date)
              FROM Pending_request P1
              WHERE P1.issue_date IS NOT NULL));