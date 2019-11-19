/* Query 3 */
DECLARE
	t_cost number;
	t_pat number;
	t_visit number;
	CURSOR pat IS SELECT * FROM Flow;
BEGIN 
	SELECT SUM(total_cost) INTO t_cost FROM table_qu1; 
	SELECT COUNT(*) INTO t_pat FROM table_qu1; 
	SELECT SUM(visits) INTO t_visit FROM table_qu1; 
	
	DBMS_OUTPUT.PUT_LINE(rpad('Total Cost',20)||rpad('Avg Cost per patient',30)||rpad('Avg Cost per visit', 30));
	DBMS_OUTPUT.PUT_LINE(rpad('----------',20)||rpad('--------------------',30)||rpad('------------------', 30));
	DBMS_OUTPUT.PUT_LINE(rpad(t_cost,20)||rpad(round(t_cost/t_pat,2),30)||rpad(round(t_cost/t_visit,2), 30));
END;
/
