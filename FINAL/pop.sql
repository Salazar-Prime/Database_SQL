rem populate exam1

INSERT INTO PATIENT VALUES(1,'FLU',1,10);
INSERT INTO PATIENT VALUES(2,'THROAT',1,8);
INSERT INTO PATIENT VALUES(3,'ENT',1,5);
INSERT INTO PATIENT VALUES(4,'SURGERY',1,4);
INSERT INTO PATIENT VALUES(5,'ANGINA',1,3);
INSERT INTO PATIENT VALUES(6,'STROKE',1,2);
INSERT INTO PATIENT VALUES(7,'FEVER',1,1);
INSERT INTO PATIENT VALUES(8,'FLU',1,0);
INSERT INTO PATIENT VALUES(9,'FEVER',1,1);
INSERT INTO PATIENT VALUES(1,'STROKE',2,10);
INSERT INTO PATIENT VALUES(1,'FEVER',3,10);
INSERT INTO PATIENT VALUES(1,'FLU',4,10);
INSERT INTO PATIENT VALUES(2,'FLU',2,3);
INSERT INTO PATIENT VALUES(11,'ANEMIA',7,10);
--test query c
INSERT INTO PATIENT VALUES(1,'FLU',5,10);
INSERT INTO PATIENT VALUES(1,'FLU',6,10);
INSERT INTO PATIENT VALUES(1,'FLU',7,10);
INSERT INTO PATIENT VALUES(1,'FLU',8,10);
INSERT INTO PATIENT VALUES(1,'ANEMIA',8,10);
--test query d
INSERT INTO PATIENT VALUES(12,'FLU',8,1);
INSERT INTO PATIENT VALUES(13,'FLU',8,1);
INSERT INTO PATIENT VALUES(14,'FLU',8,1);
INSERT INTO PATIENT VALUES(15,'FLU',8,1);
INSERT INTO PATIENT VALUES(16,'FLU',8,1);
INSERT INTO PATIENT VALUES(17,'FLU',8,1);
INSERT INTO PATIENT VALUES(18,'FLU',8,1);
INSERT INTO PATIENT VALUES(19,'FLU',8,1);

INSERT INTO DOCTOR VALUES('ADAM','STROKE');
INSERT INTO DOCTOR VALUES('BOB','SURGERY');
INSERT INTO DOCTOR VALUES('DAVID','ANGINA');
INSERT INTO DOCTOR VALUES('GEORGE','THROAT');
INSERT INTO DOCTOR VALUES('JAMES','ENT');
INSERT INTO DOCTOR VALUES('JOHN','FLU');
INSERT INTO DOCTOR VALUES('KUN','FEVER');
INSERT INTO DOCTOR VALUES('KUN','FLU');
INSERT INTO DOCTOR VALUES('KUN','THROAT');

INSERT INTO ASSIGNMENT VALUES(1,'JOHN',1);
INSERT INTO ASSIGNMENT VALUES(6,'ADAM',1);
INSERT INTO ASSIGNMENT VALUES(5,'DAVID',1);
INSERT INTO ASSIGNMENT VALUES(4,'BOB',1);
INSERT INTO ASSIGNMENT VALUES(3,'JAMES',1);
INSERT INTO ASSIGNMENT VALUES(2,'GEORGE',1);
INSERT INTO ASSIGNMENT VALUES(8,'JOHN',1);
INSERT INTO ASSIGNMENT VALUES(1,'ADAM',2);
INSERT INTO ASSIGNMENT VALUES(1,'KUN',3);
--test query d
INSERT INTO ASSIGNMENT VALUES(12,'JOHN',8);
INSERT INTO ASSIGNMENT VALUES(13,'JOHN',8);
INSERT INTO ASSIGNMENT VALUES(14,'JOHN',8);
INSERT INTO ASSIGNMENT VALUES(15,'JOHN',8);
INSERT INTO ASSIGNMENT VALUES(16,'JOHN',8);
INSERT INTO ASSIGNMENT VALUES(17,'JOHN',8);
INSERT INTO ASSIGNMENT VALUES(18,'JOHN',8);
INSERT INTO ASSIGNMENT VALUES(19,'JOHN',8);
