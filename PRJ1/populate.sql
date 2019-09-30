rem EE 562 Project 1
rem Varun Aggarwal
rem aggarw82

ALTER SESSION SET NLS_DATE_FORMAT = 'HH24:MI';

Insert Into Student(sid, Sname, Major, Levels, Age) Values ('1', 'John', 'EE', 'FR', '18');
Insert Into Student(sid, Sname, Major, Levels, Age) Values ('2', 'Tim', 'EE', 'FR', '19');
Insert Into Student(sid, Sname, Major, Levels, Age) Values ('3','Richard','EE','SO', '20');
Insert Into Student(sid, Sname, Major, Levels, Age) Values ('4','Edward', 'EE', 'SO', '21');
Insert Into Student(sid, Sname, Major, Levels, Age) Values ('5','Alber', 'CS', 'JR', '22');
Insert Into Student(sid, Sname, Major, Levels, Age) Values ('6','Mary', 'EE', 'JR', '22');
Insert Into Student(sid, Sname, Major, Levels, Age) Values ('7','Jack', 'EE', 'SR', '23');
Insert Into Student(sid, Sname, Major, Levels, Age) Values ('8','Julian', 'EE', 'SR', '22');
Insert Into Student(sid, Sname, Major, Levels, Age) Values ('9','Sam', 'CS', 'SR', '24');
Insert Into Student(sid, Sname, Major, Levels, Age) Values ('10', 'Ram', 'EE', 'SR', '23');
Insert Into Student(sid, Sname, Major, Levels, Age) Values ('11', 'Rick', 'EE', 'SR', '24');


Insert Into Class(cnum, meets_at, room, fid) Values ('EE101','9:00','117','1');
Insert Into Class(cnum, meets_at, room, fid) Values ('CS102','10:00','117','2');
Insert Into Class(cnum, meets_at, room, fid) Values ('EE104','13:00','117','3');
Insert Into Class(cnum, meets_at, room, fid) Values ('EE151','15:00','117','4');
Insert Into Class(cnum, meets_at, room, fid) Values ('EE261','9:00','118','4');
Insert Into Class(cnum, meets_at, room, fid) Values ('MA365','10:00','118','5');
Insert Into Class(cnum, meets_at, room, fid) Values ('EE347','13:00','118','1');
Insert Into Class(cnum, meets_at, room, fid) Values ('EE404','9:00','115','3');
Insert Into Class(cnum, meets_at, room, fid) Values ('MA448','12:00','115','5');
Insert Into Class(cnum, meets_at, room, fid) Values ('CS480','13:00','115','1');


Insert Into Faculty(fid, fname, dept) Values('1','Prof. James','EE');
Insert Into Faculty(fid, fname, dept) Values('2','Prof. Brown','CS');
Insert Into Faculty(fid, fname, dept) Values('3','Prof. Wasfi','EE');
Insert Into Faculty(fid, fname, dept) Values('4','Prof. Latif','EE');
Insert Into Faculty(fid, fname, dept) Values('5','Prof. Rutherford','MA');


Insert into Prerequisite(cnum,prereq) Values('EE104','EE101');
Insert into Prerequisite(cnum,prereq) Values('CS480','EE101');
Insert into Prerequisite(cnum,prereq) Values('EE261','EE151');
Insert into Prerequisite(cnum,prereq) Values('EE347','EE261');
Insert into Prerequisite(cnum,prereq) Values('EE404','EE347');
Insert into Prerequisite(cnum,prereq) Values('MA448','MA365');
Insert into Prerequisite(cnum,prereq) Values('CS480','CS102');

Insert into Enrolled(cnum,Sid) Values('EE101','1');
Insert into Enrolled(cnum,Sid) Values('EE101','2');
Insert into Enrolled(cnum,Sid) Values('EE101','3');
Insert into Enrolled(cnum,Sid) Values('EE101','4');
Insert into Enrolled(cnum,Sid) Values('CS102','1');
Insert into Enrolled(cnum,Sid) Values('CS102','2');
Insert into Enrolled(cnum,Sid) Values('CS102','4');
Insert into Enrolled(cnum,Sid) Values('EE104','1');
Insert into Enrolled(cnum,Sid) Values('EE104','2');
Insert into Enrolled(cnum,Sid) Values('EE104','3');
Insert into Enrolled(cnum,Sid) Values('EE151','4');
Insert into Enrolled(cnum,Sid) Values('EE151','5');
Insert into Enrolled(cnum,Sid) Values('EE151','6');
Insert into Enrolled(cnum,Sid) Values('EE261','1');
Insert into Enrolled(cnum,Sid) Values('EE261','2');
Insert into Enrolled(cnum,Sid) Values('EE261','3');
Insert into Enrolled(cnum,Sid) Values('EE261','4');
Insert into Enrolled(cnum,Sid) Values('EE261','5');
Insert into Enrolled(cnum,Sid) Values('EE261','7');
Insert into Enrolled(cnum,Sid) Values('MA365','5');
Insert into Enrolled(cnum,Sid) Values('MA365','6');
Insert into Enrolled(cnum,Sid) Values('MA365','7');
Insert into Enrolled(cnum,Sid) Values('MA365','8');
Insert into Enrolled(cnum,Sid) Values('EE347','5');
Insert into Enrolled(cnum,Sid) Values('EE347','7');
Insert into Enrolled(cnum,Sid) Values('EE347','8');
Insert into Enrolled(cnum,Sid) Values('EE347','9');
Insert into Enrolled(cnum,Sid) Values('EE404','9');
Insert into Enrolled(cnum,Sid) Values('EE404','10');
Insert into Enrolled(cnum,Sid) Values('EE404','7');
Insert into Enrolled(cnum,Sid) Values('MA448','7');
Insert into Enrolled(cnum,Sid) Values('MA448','8');
Insert into Enrolled(cnum,Sid) Values('MA448','9');
Insert into Enrolled(cnum,Sid) Values('MA448','10');
Insert into Enrolled(cnum,Sid) Values('CS480','6');
Insert into Enrolled(cnum,Sid) Values('CS480','7');
Insert into Enrolled(cnum,Sid) Values('CS480','8');
Insert into Enrolled(cnum,Sid) Values('CS480','9');