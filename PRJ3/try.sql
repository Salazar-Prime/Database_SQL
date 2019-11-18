SET SERVEROUTPUT ON
DECLARE
	ses varchar2(30);
BEGIN
	ses := to_char(to_date('1/6/2005', 'mm/dd/yyyy'), 'DY');
	DBMS_OUTPUT.PUT_LINE(ses);
END;
/