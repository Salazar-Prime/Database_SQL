Create or REPLACE PROCEDURE Pro_Q6
AS

-- varibles
count_visit number;
sum_duration number;
Sur_type varchar(10);
Sur_count number;
-- days in each ward
G_stay number;
S_stay number;
Pre_stay number;
Post_stay number;
-- stay cost for each ward
G_cost number;
S_cost number;
Pre_cost number;
Post_cost number;
Sur_cost number;
T_cost number;
-- For Names
Var1 Date;
Var2 Date;
Var3 Date;
Var4 Date;
Cursor X is
Select * from Patient_Schedule;
X_var X%rowtype;
BEGIN
Select Pdate into Var1
from
(Select Post_Admission_Date+2 as Pdate, rownum as rn from Patient_Schedule where Patient_Name ='Bob' And Scount=2)
Where rn=3;

Var2:=Var1+1;
Var3:=Var1+2;
Var4:=Var1+3;
For X_var in X
loop

if(X_var.Discharge_Date = Var1 or X_var.Discharge_Date = Var2 or X_var.Discharge_Date = Var3 or X_var.Discharge_Date = Var1 ) then

IF (X_var.Patient_Name='Bob') THEN
	CONTINUE;
END IF; 
Select sum(Total_Days) into sum_duration From Patient_Schedule where Patient_Name = X_var.Patient_Name and Discharge_Date=X_var.Discharge_Date;
G_stay := X_var.S_Admission_Date - X_var.G_Admission_Date;
S_stay := X_var.Pre_Admission_Date-X_var.S_Admission_Date;
Pre_stay := X_var.Post_Admission_Date -X_var.Pre_Admission_Date;
post_stay := X_var.Discharge_Date - X_var.Post_Admission_Date;
if G_stay -3 > 0 then
G_cost := (G_stay - 3)*35 + 3*40;
ELSE G_cost := G_stay*40;
END IF;
IF S_stay - 3 > 0 THEN
S_cost := (S_stay - 2)*52.5 + 2*59.5;
ELSE S_cost := S_stay*59.5;
END IF;
Pre_cost := Pre_stay*85.5;
Post_cost := Post_stay*72;
IF X_var.Patient_Type = 'Cardiac' AND X_var.Scount = 2 THEN Sur_cost := 5075;
ELSIF X_var.Patient_Type = 'Cardiac' AND X_var.Scount =  1 THEN Sur_cost := 2625;
ELSIF X_var.Patient_Type = 'Neuro' AND X_var.Scount = 2 THEN Sur_cost := 8250;
ELSIF X_var.Patient_Type = 'Neuro' AND X_var.Scount = 1 THEN Sur_cost := 4250;
ELSE Sur_cost := 1625;
END IF;
T_cost := G_cost + S_cost + Pre_cost + Post_cost + Sur_cost;
DBMS_OUTPUT.PUT_Line('name is' || X_var.Patient_Name );
DBMS_OUTPUT.PUT_Line('total cost reimbursed is' || T_cost);
end if;
end loop;
end;
/
show error;
EXEC Pro_Q6;