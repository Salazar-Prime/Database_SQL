rem EE 562 Project 3
rem Varun Aggarwal		
rem aggarw82

set linesize 200;
set pagesize 70;
set SERVEROUTPUT ON;

@dropall
@createtable

-- creating extra tables
@beds
@flow
@table_qu1
@table_qu4
@coal
-- triggers, functions, procedures
@trg

-- Populate Doctor Schedule
EXEC populate_dr();
-- SELECT * FROM DR_Schedule ORDER BY Duty_Date;

-- Populate Surgeon Schedule
EXEC populate_sr();
-- SELECT * FROM Surgeon_Schedule ORDER BY Surgery_Date;




-- populate Paitent_CHART
-- EXEC pop_patient_chart();
-- EXEC pop_patient_input();
@stan_pop

-- populate ward tables
EXEC populate_db();
-- SELECT * FROM General_Ward WHERE ROWNUM=1;
-- SELECT * FROM Screening_Ward WHERE ROWNUM=1;
-- SELECT * FROM Pre_Surgery_Ward WHERE ROWNUM=1;
-- SELECT * FROM Post_Surgery_Ward WHERE ROWNUM=1;

SELECT * FROM Flow;
SELECT * FROM Beds;

-- call myexec
@myexec