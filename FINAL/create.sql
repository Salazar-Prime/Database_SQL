CREATE TABLE PATIENT(pid number, treatment varchar2(30),
                                 p_visit_number number, Duration number);


CREATE TABLE DOCTOR(D_Name varchar2(30), Specialty varchar2(30));

CREATE TABLE ASSIGNMENT(pid number, D_Name varchar2(30), p_visit_number number);