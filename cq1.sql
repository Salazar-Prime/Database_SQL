Create View view_A as Select Fx.Fid, Fx.Fname, Cx.Cnum from Faculty Fx, Class Cx where Fx.Fid=Cx.Fid ORDER BY fx.fid;
select * from view_a;
Create View view_B as Select Sx.Sid, Sx.Sname, Ex.Cnum from Student Sx, Enrolled Ex where Ex.sid=Sx.sid ORDER BY sx.sid;
select * from view_b;