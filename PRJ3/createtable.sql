rem EE 562 Project 3
rem Varun Aggarwal		
rem aggarw82

CREATE TABLE General_Ward( Patient_Name varchar2(30),
                           G_Admission_Date date,
                           Patient_Type varchar2(10)
                           );

CREATE TABLE Screening_Ward( Patient_Name varchar2(30),
                             S_Admission_Date date,
                             Bed_No number,
                             Patient_Type varchar2(10)
                             );

Create Table Pre_Surgery_Ward( Patient_Name varchar2(30),
							   Pre_Admission_Date date,
							   Bed_No number,
							   Patient_Type varchar2(10)
							   );

Create Table Post_Surgery_Ward( Patient_Name varchar2(30),
								Post_Admission_Date date,
								Discharge_Date date,
								Scount number,
								Patient_Type varchar2(10)
								);

Create Table Patient_Chart( Patient_Name varchar2(30),
							PDate date,
							Temperature number,
							BP number,
							Primary Key(Patient_Name,PDate)
							);

Create Table Dr_Schedule( Name varchar2(30),
						  Ward varchar2(20),
						  Duty_Date date
						  );

Create Table Surgeon_Schedule( Name varchar2(30),
							   Surgery_Date date
							   );

Create Table Patient_Input ( Patient_Name varchar2(30),
							 General_Ward_admission_Date date,
							 Patient_Type varchar2(10)
							 );
