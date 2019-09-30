rem EE 562 Project 1
rem Varun Aggarwal
rem aggarw82

/* Create table*/
Create Table Student(sid number, sname varchar2(15), major varchar2(3), levels varchar2(2), age number, Primary key(sid)); 
Create Table Class(cnum varchar2(6), Meets_at date, room varchar2(6),fid number, Primary key(cnum));
Create Table Faculty(fid number, fname varchar2(20), dept varchar2(5), Primary key(fid));
Create Table Prerequisite(cnum varchar2(6), prereq varchar2(6), Primary key(cnum, prereq));
Create Table Enrolled(cnum varchar2(6), sid Number, Primary key(cnum, sid));

/* Create views*/
Create View view_A as Select Fx.Fid, Fx.Fname, Cx.Cnum from Faculty Fx, Class Cx where Fx.Fid=Cx.Fid ORDER BY fx.fid;
Create View view_B as Select Sx.Sid, Sx.Sname, Ex.Cnum from Student Sx, Enrolled Ex where Ex.sid=Sx.sid ORDER BY sx.sid;