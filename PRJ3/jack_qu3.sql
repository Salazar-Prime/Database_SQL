create or replace procedure query3 AS
	bob_discharge date;
	bob_admit date;
	pat_name varchar(20);
	pat_stay number;
	pat_count number := 0;
	final_count number;
	count_2 number;
	inc number;
	cursor match_table is select P.patient_name, P.general_ward_admission_date, S.discharge_date, S.patient_type from patient_input P JOIN post_surgery_ward S ON P.patient_name = S.patient_name AND P.patient_type = S.patient_type;
	jacq match_table%rowtype;
	cursor temp_check is select P.patient_name, P.general_ward_admission_date, S.discharge_date, S.patient_type from patient_input P JOIN post_surgery_ward S ON P.patient_name = S.patient_name AND P.patient_type = S.patient_type;
	temp_count temp_check%rowtype;
begin
	final_count := 0;
	inc := 0;
	select S.discharge_date, P.general_ward_admission_date into bob_discharge, bob_admit from post_surgery_ward S join patient_input P on P.patient_name = S.patient_name and P.patient_type= S.patient_type WHERE S.discharge_date > ( SELECT MIN(discharge_date) from post_surgery_ward where patient_name='Bob') AND ROWNUM=1;

	for jacq in match_table
	loop
		if jacq.discharge_date<=bob_discharge AND jacq.general_ward_admission_date=bob_admit
			then
					for temp_count in temp_check 
					loop 
						if temp_count.patient_name = jacq.patient_name AND temp_count.general_ward_admission_date = jacq.general_ward_admission_date then
							count_2 := temp_count.discharge_date - temp_count.general_ward_admission_date;
							final_count := final_count + count_2;
							inc := inc + 1;
						end if;	
					end loop;
			DBMS_OUTPUT.PUT_LINE('Patient name is  '|| jacq.patient_name);
			DBMS_OUTPUT.PUT_LINE('average stay is '|| round(final_count/inc));	
		end if;
	end loop;
end;
/
EXEC query3;
DROP procedure query3;
show error;

