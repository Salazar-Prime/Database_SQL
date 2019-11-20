--1 

CREATE OR REPLACE VIEW Patient_Schedule AS
SELECT G.Patient_Name,
       G.Patient_Type,
       G.G_Admission_Date,
       S.S_Admission_Date,
       PR.Pre_Admission_Date,
       PO.Post_Admission_Date,
       PO.Discharge_Date,
       PO.Scount,
       Po.Discharge_Date - G.G_Admission_Date AS Total_Days
FROM GENERAL_WARD G
JOIN SCREENING_WARD S ON G.Patient_Name = S.Patient_Name
AND G.Patient_Type = S.Patient_Type
AND G.G_Admission_Date+2 < S.S_Admission_Date
AND S.S_Admission_Date < G.G_Admission_Date+10
JOIN POST_SURGERY_WARD PO ON G.Patient_Name = PO.Patient_Name
AND G.Patient_Type = PO.Patient_Type
AND S.S_Admission_Date+3 < PO.Post_Admission_Date
AND PO.Post_Admission_Date < S.S_Admission_Date+10
LEFT JOIN PRE_SURGERY_WARD PR ON G.Patient_Name = PR.Patient_Name
AND G.Patient_Type = PR.Patient_Type
AND S.S_Admission_Date+2 < PR.Pre_Admission_Date
AND PR.Pre_Admission_Date < S.S_Admission_Date+10;

--1.1

Select * from Patient_Schedule;

--2

-- Select * from DR_Schedule;
--3

-- Select * from Surgeon_Schedule;

--4

Create or Replace View Patient_Surgery_View AS
SELECT
G.Patient_Name,
PO.Post_Admission_Date,
SR.Name
FROM
GENERAL_WARD G
JOIN ((select * from POST_SURGERY_WARD)
 UNION
 (Select Patient_Name,(Post_Admission_Date+2),Discharge_Date,Scount,Patient_Type 
 from POST_SURGERY_WARD
 Where Scount=2))  PO ON 
G.Patient_Name = PO.Patient_Name and G.G_Admission_Date+9<PO.Discharge_Date and PO.Discharge_Date<G.G_Admission_Date+20
JOIN Surgeon_Schedule SR ON
SR.Surgery_Date = PO.Post_Admission_Date
where (PO.Patient_Type='Cardiac' and SR.Name in ('Dr. Charles','Dr. Gower'))
or (PO.Patient_Type='Neuro' and SR.Name in ('Dr. Taylor','Dr. Rutherford'))
or (PO.Patient_Type='General' and SR.Name in ('Dr. Smith','Dr. Richards'));

--5

Select * from Patient_Surgery_View;
