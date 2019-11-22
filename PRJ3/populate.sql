rem EE 562 Project 3
rem Varun Aggarwal		
rem aggarw82

/* populate patient input */

/* For Jan 1 */
INSERT INTO PATIENT_INPUT VALUES ('Aaaaa',to_date('01/01/05','MM/DD/YY'),'General');
INSERT INTO PATIENT_INPUT VALUES ('Bbbbb',to_date('01/01/05','MM/DD/YY'),'Neuro');
INSERT INTO PATIENT_INPUT VALUES ('Ccccc',to_date('01/01/05','MM/DD/YY'),'Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Ddddd',to_date('01/01/05','MM/DD/YY'),'Cardiac');

/* For Jan 2 - 31 */
INSERT INTO PATIENT_INPUT VALUES ('Eeeee',to_date('01/05/05','MM/DD/YY'),'General');
INSERT INTO PATIENT_INPUT VALUES ('Fffff',to_date('01/06/05','MM/DD/YY'),'Neuro');
INSERT INTO PATIENT_INPUT VALUES ('Ggggg',to_date('01/07/05','MM/DD/YY'),'Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Hhhhh',to_date('01/08/05','MM/DD/YY'),'General');
INSERT INTO PATIENT_INPUT VALUES ('Iiiii',to_date('01/15/05','MM/DD/YY'),'Neuro');
INSERT INTO PATIENT_INPUT VALUES ('Jjjjj',to_date('01/20/05','MM/DD/YY'),'Neuro');

/* For March */
INSERT INTO PATIENT_INPUT VALUES ('Kkkkk',to_date('03/01/05','MM/DD/YY'),'General');
INSERT INTO PATIENT_INPUT VALUES ('Lllll',to_date('03/22/05','MM/DD/YY'),'Cardiac');

/* For April */
INSERT INTO PATIENT_INPUT VALUES ('Mmmmm',to_date('04/03/05','MM/DD/YY'),'General');
INSERT INTO PATIENT_INPUT VALUES ('Iiiii',to_date('04/15/05','MM/DD/YY'),'Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Wwwww',to_date('04/06/05','MM/DD/YY'),'Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Xxxxx',to_date('04/07/05','MM/DD/YY'),'Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Yyyyy',to_date('04/08/05','MM/DD/YY'),'Cardiac');

/* For May */
INSERT INTO PATIENT_INPUT VALUES ('Nnnnn',to_date('05/05/05','MM/DD/YY'),'Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Ooooo',to_date('05/07/05','MM/DD/YY'),'Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Ppppp',to_date('05/03/05','MM/DD/YY'),'Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Qqqqq',to_date('05/20/05','MM/DD/YY'),'General');
INSERT INTO PATIENT_INPUT VALUES ('Rrrrr',to_date('05/20/05','MM/DD/YY'),'Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Sssss',to_date('05/20/05','MM/DD/YY'),'General');
INSERT INTO PATIENT_INPUT VALUES ('Ttttt',to_date('05/20/05','MM/DD/YY'),'Neuro');
INSERT INTO PATIENT_INPUT VALUES ('Uuuuu',to_date('05/20/05','MM/DD/YY'),'General');

/* For June */
INSERT INTO PATIENT_INPUT VALUES ('Vvvvv',to_date('06/10/05','MM/DD/YY'),'General');
INSERT INTO PATIENT_INPUT VALUES ('Wwwww',to_date('06/11/05','MM/DD/YY'),'Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Xxxxx',to_date('06/12/05','MM/DD/YY'),'Neuro');
INSERT INTO PATIENT_INPUT VALUES ('Yyyyy',to_date('06/13/05','MM/DD/YY'),'General');
INSERT INTO PATIENT_INPUT VALUES ('Zzzzz',to_date('06/14/05','MM/DD/YY'),'Neuro');
INSERT INTO PATIENT_INPUT VALUES ('Ooooo',to_date('06/15/05','MM/DD/YY'),'Cardiac');

/* populate Bob */ 
INSERT INTO PATIENT_INPUT VALUES ('Bob',to_date('01/02/05','MM/DD/YY'),'Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Bob',to_date('05/20/05','MM/DD/YY'),'Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Bob',to_date('06/07/05','MM/DD/YY'),'Cardiac'); 

/* populate Paitent_CHART */
EXEC populate_chart();

/* populate ward tables */
EXEC populate_db();

