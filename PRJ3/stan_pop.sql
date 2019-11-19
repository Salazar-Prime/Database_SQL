rem EE 562 Project 3
rem Stanley Doerger
rem SDOERGER

-- Insert records into Patient_Chart
--insert into Patient_Chart values(Patient_Name varchar2(30),Pdate date,Temperature number,BP number);
BEGIN
	for i in 0..365
	loop
		--unhealty tom
		insert into Patient_Chart values('Tom',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(97,100)),round(dbms_random.value(105,140)));
		
		--Random
		-- insert into Patient_Chart values('Tom',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('Emma',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		-- insert into Patient_Chart values('Liam',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		-- insert into Patient_Chart values('Olivia',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('Ava',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('Elijah',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('Mickey',to_date('01/05/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('Minnnie',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		
		insert into Patient_Chart values('Alexandra',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('Billy',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('Caitlin',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('Devin',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('Eric',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('Frances',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('Gordon',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('Goofus',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('Herbert',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		
		insert into Patient_Chart values('Isaac',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('John',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('James',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		-- insert into Patient_Chart values('Kurt',to_date('01/06/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		-- insert into Patient_Chart values('Louis',to_date('01/06/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('Merlin',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('Norman',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('Orville',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('Persiphony',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		-- insert into Patient_Chart values('Bob',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(99,105)),round(dbms_random.value(130,150)));
		
		--Unhealthy
		insert into Patient_Chart values('Bob',to_date('01/01/05','MM/DD/YY')+i,101,141);
		
		--Healthy
		--insert into Patient_Chart values('Tom',to_date('01/01/05','MM/DD/YY')+i,98.5,120);
		--insert into Patient_Chart values('Emma',to_date('01/01/05','MM/DD/YY')+i,98.5,120);
		insert into Patient_Chart values('Liam',to_date('01/01/05','MM/DD/YY')+i,98.5,120);
		insert into Patient_Chart values('Olivia',to_date('01/01/05','MM/DD/YY')+i,98.5,120);
		--insert into Patient_Chart values('Ava',to_date('01/01/05','MM/DD/YY')+i,98.5,120);
		--insert into Patient_Chart values('Elijah',to_date('01/01/05','MM/DD/YY')+i,98.5,120);
		--insert into Patient_Chart values('Mickey',to_date('01/05/05','MM/DD/YY')+i,98.5,120);
		--insert into Patient_Chart values('Minnnie',to_date('01/06/05','MM/DD/YY')+i,98.5,120);
		
		--insert into Patient_Chart values('Alexandra',to_date('01/01/05','MM/DD/YY')+i,98.5,120);
		--insert into Patient_Chart values('Billy',to_date('01/01/05','MM/DD/YY')+i,98.5,120);
		--insert into Patient_Chart values('Caitlin',to_date('01/05/05','MM/DD/YY')+i,98.5,120);
		--insert into Patient_Chart values('Devin',to_date('01/06/05','MM/DD/YY')+i,98.5,120);
		--insert into Patient_Chart values('Eric',to_date('01/01/05','MM/DD/YY')+i,98.5,120);
		--insert into Patient_Chart values('Frances',to_date('01/01/05','MM/DD/YY')+i,98.5,120);
		--insert into Patient_Chart values('Gordon',to_date('01/05/05','MM/DD/YY')+i,98.5,120);
		--insert into Patient_Chart values('Goofus',to_date('01/05/05','MM/DD/YY')+i,98.5,120);
		--insert into Patient_Chart values('Herbert',to_date('01/06/05','MM/DD/YY')+i,98.5,120);
		
		--insert into Patient_Chart values('Isaac',to_date('01/06/05','MM/DD/YY')+i,98.5,120);
		-- insert into Patient_Chart values('John',to_date('01/06/05','MM/DD/YY')+i,98.5,120);
		--insert into Patient_Chart values('James',to_date('01/06/05','MM/DD/YY')+i,98.5,120);
		insert into Patient_Chart values('Kurt',to_date('01/01/05','MM/DD/YY')+i,98.5,120);
		insert into Patient_Chart values('Louis',to_date('01/01/05','MM/DD/YY')+i,98.5,120);
		-- insert into Patient_Chart values('Merlin',to_date('01/06/05','MM/DD/YY')+i,98.5,120);
		-- insert into Patient_Chart values('Norman',to_date('01/06/05','MM/DD/YY')+i,98.5,120);
		-- insert into Patient_Chart values('Orville',to_date('01/06/05','MM/DD/YY')+i,98.5,120);
		-- insert into Patient_Chart values('Persiphony',to_date('01/06/05','MM/DD/YY')+i,98.5,120);

		insert into Patient_Chart values('Darth',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('DarthMaul',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
		insert into Patient_Chart values('Emperor',to_date('01/01/05','MM/DD/YY')+i,round(dbms_random.value(95,102)),round(dbms_random.value(105,145)));
	end loop;
END;
/

-- Insert records into DR_Schedule
--insert into DR_Schedule values(Name varchar2(30),Ward varchar2(20),Duty_Date date);
--Populate with Procedure 3

-- Insert records into Surgeon_Schedule
--insert into Surgeon_Schedule values(Name varchar2(30),Surgery_Date date);
--Populate with Procedure 4

-- Insert records into PATIENT_INPUT

insert into PATIENT_INPUT values('Emma',to_date('01/01/05','MM/DD/YY'),'General');
insert into PATIENT_INPUT values('Liam',to_date('01/01/05','MM/DD/YY'),'Neuro');
insert into PATIENT_INPUT values('Olivia',to_date('01/01/05','MM/DD/YY'),'General');
insert into PATIENT_INPUT values('Ava',to_date('01/01/05','MM/DD/YY'),'General');
insert into PATIENT_INPUT values('Elijah',to_date('01/01/05','MM/DD/YY'),'General');
insert into PATIENT_INPUT values('Mickey',to_date('01/05/05','MM/DD/YY'),'General');
insert into PATIENT_INPUT values('Tom',to_date('01/01/05','MM/DD/YY'),'Cardiac');
insert into PATIENT_INPUT values('Minnie',to_date('01/06/05','MM/DD/YY'),'Neuro');

insert into PATIENT_INPUT values('Alexandra',to_date('01/07/05','MM/DD/YY'),'Cardiac');
insert into PATIENT_INPUT values('Billy',to_date('01/08/05','MM/DD/YY'),'General');
insert into PATIENT_INPUT values('Caitlin',to_date('01/15/05','MM/DD/YY'),'Neuro');
insert into PATIENT_INPUT values('Devin',to_date('01/20/05','MM/DD/YY'),'Neuro');
insert into PATIENT_INPUT values('Eric',to_date('02/01/05','MM/DD/YY'),'General');
insert into PATIENT_INPUT values('Frances',to_date('02/22/05','MM/DD/YY'),'Cardiac');
insert into PATIENT_INPUT values('Gordon',to_date('03/13/05','MM/DD/YY'),'General');

insert into PATIENT_INPUT values('Darth',to_date('04/05/05','MM/DD/YY'),'Cardiac');
insert into PATIENT_INPUT values('Darth Maul',to_date('04/07/05','MM/DD/YY'),'Cardiac');
insert into PATIENT_INPUT values('Emperor',to_date('04/03/05','MM/DD/YY'),'Cardiac');


insert into PATIENT_INPUT values('Isaac',to_date('04/19/05','MM/DD/YY'),'General');
insert into PATIENT_INPUT values('John',to_date('04/19/05','MM/DD/YY'),'Cardiac');
insert into PATIENT_INPUT values('James',to_date('04/19/05','MM/DD/YY'),'General');
insert into PATIENT_INPUT values('Kurt',to_date('04/19/05','MM/DD/YY'),'Neuro');
insert into PATIENT_INPUT values('Louis',to_date('04/19/05','MM/DD/YY'),'General');

-- insert into PATIENT_INPUT values('Darth Maul',to_date('04/19/05','MM/DD/YY'),'Cardiac');
-- insert into PATIENT_INPUT values('Darth',to_date('04/19/05','MM/DD/YY'),'Cardiac');
-- insert into PATIENT_INPUT values('Emperor',to_date('04/19/05','MM/DD/YY'),'Cardiac');
-- insert into PATIENT_INPUT values('Gordon',to_date('04/19/05','MM/DD/YY'),'General');

insert into PATIENT_INPUT values('Goofus',to_date('05/05/05','MM/DD/YY'),'General');
insert into PATIENT_INPUT values('Merlin',to_date('05/06/05','MM/DD/YY'),'Cardiac');
insert into PATIENT_INPUT values('Norman',to_date('05/07/05','MM/DD/YY'),'Neuro');
insert into PATIENT_INPUT values('Orville',to_date('05/07/05','MM/DD/YY'),'General');
insert into PATIENT_INPUT values('Persiphony',to_date('05/08/05','MM/DD/YY'),'General');

insert into PATIENT_INPUT values('Bob',to_date('01/02/05','MM/DD/YY'),'Cardiac');
insert into PATIENT_INPUT values('Bob',to_date('04/19/05','MM/DD/YY'),'Cardiac');
insert into PATIENT_INPUT values('Bob',to_date('05/07/05','MM/DD/YY'),'Cardiac');

