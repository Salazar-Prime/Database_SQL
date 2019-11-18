create or replace procedure query7 as 
	jay date;
	cursor traverse is select * from post_surgery_ward;
	jacq traverse%rowtype;
begin
	for jacq in traverse
	loop
	if (jacq.patient_type ='cardiac')
	then
		jay:=jacq.post_admission_date;
		if(jay = to_date('04/09/2005','mm/dd/yyyy'))
		then 
		DBMS_OUTPUT.PUT_LINE('PATIENT NAME IS' || jacq.patient_name);
		DBMS_OUTPUT.PUT_LINE('surgeon Name IS Dr. Gower');
		DBMS_OUTPUT.PUT_LINE('physician Name IS Tracey ');
		elsif(jay = to_date('04/10/2005','mm/dd/yyyy'))
		then
		DBMS_OUTPUT.PUT_LINE('PATIENT NAME IS' || jacq.patient_name);
		DBMS_OUTPUT.PUT_LINE('surgeon Name is Dr. Charles');
		DBMS_OUTPUT.PUT_LINE('physician Name IS Rick');
		elsif(jay = to_date('04/11/2005','mm/dd/yyyy'))
		then
		DBMS_OUTPUT.PUT_LINE('PATIENT NAME IS' || jacq.patient_name);
		DBMS_OUTPUT.PUT_LINE('surgeon Name is Dr. Charles');
		DBMS_OUTPUT.PUT_LINE('physician Name is James');
		elsif(jay = to_date('04/12/2005','mm/dd/yyyy'))
		then
		DBMS_OUTPUT.PUT_LINE('PATIENT NAME is' || jacq.patient_name);
		DBMS_OUTPUT.PUT_LINE('surgeon Name is Dr. Gower');
		DBMS_OUTPUT.PUT_LINE('physician Name is Robert');
		elsif(jay = to_date('04/13/2005','mm/dd/yyyy'))
		then
		DBMS_OUTPUT.PUT_LINE('PATIENT NAME is' || jacq.patient_name);
		DBMS_OUTPUT.PUT_LINE('surgeon Name is  Dr. Gower');
		DBMS_OUTPUT.PUT_LINE('physician Name is Mike');
		elsif(jay = to_date('04/14/2005','mm/dd/yyyy'))
		then
		DBMS_OUTPUT.PUT_LINE('PATIENT NAME is' || jacq.patient_name);
		DBMS_OUTPUT.PUT_LINE('surgeon Name is Dr. Charles');
		DBMS_OUTPUT.PUT_LINE('physician Name is Adams');
		else
		DBMS_OUTPUT.PUT_LINE('PATIENT NAME is' || jacq.patient_name);
		DBMS_OUTPUT.PUT_LINE('surgeon Name is Dr. Gower');
		DBMS_OUTPUT.PUT_LINE('physician Name is Tracey');
		end if;
	end if;
	end loop;
end;
/
SET SERVEROUTPUT ON;
exec query7;
drop procedure query7;
show error;