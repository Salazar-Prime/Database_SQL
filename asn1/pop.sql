insert into S values('S1','Smith',20,'London');
insert into S values('S2','Jones',10,'Paris');
insert into S values('S3','Blake',30,'Paris');
insert into S values('S4','Clark',20,'London');
insert into S values('S5','Adams',30,'Athens');


insert into P values('P1','Nut','Red',12,'London');
insert into P values('P2','Bolt','Green',17,'Paris');
insert into P values('P3','Screw','Blue',17,'Rome');
insert into P values('P4','Screw','Red',14,'London');
insert into P values('P5','Cam','Blue',12,'Paris');
insert into P values('P6','Cog','Red',19,'London');


insert into J values('J1','Sorter','Paris');
insert into J values('J2','Display','Rome');
insert into J values('J3','OCR','Athens');
insert into J values('J4','Console','Athens');
insert into J values('J5','Raid','London');
insert into J values('J6','EDS','Oslo');
insert into J values('J7','Tape','London');

Insert into SPJ Values('S1','P1','J1',200);
Insert into SPJ Values('S1','P1','J4',700);
Insert into SPJ Values('S2','P3','J1',400);
Insert into SPJ Values('S2','P3','J2',200);
Insert into SPJ Values('S2','P3','J3',200);
Insert into SPJ Values('S2','P3','J4',500);
Insert into SPJ Values('S2','P3','J5',600);
Insert into SPJ Values('S2','P3','J6',400);
Insert into SPJ Values('S2','P3','J7',800);
Insert into SPJ Values('S2','P5','J2',100);
Insert into SPJ Values('S3','P3','J1',200);
Insert into SPJ Values('S3','P4','J2',500);
Insert into SPJ Values('S4','P6','J3',300);
Insert into SPJ Values('S4','P6','J7',300);
Insert into SPJ Values('S5','P2','J2',200);
Insert into SPJ Values('S5','P2','J4',100);
Insert into SPJ Values('S5','P5','J5',500);
Insert into SPJ Values('S5','P5','J7',100);
Insert into SPJ Values('S5','P6','J2',200);
Insert into SPJ Values('S5','P1','J4',100);
Insert into SPJ Values('S5','P3','J4',200);
Insert into SPJ Values('S5','P4','J4',800);
Insert into SPJ Values('S5','P5','J4',400);
Insert into SPJ Values('S5','P6','J4',500);