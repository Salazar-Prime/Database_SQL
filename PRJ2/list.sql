set linesize 200;
set pagesize 50;
clear screen

/* List all user tables */ 
SELECT table_name FROM all_tables WHERE owner='AGGARW82' ORDER BY table_name;

/* List all user functions */ 
SELECT rpad(OBJECT_NAME,15) AS FUN_NAME,
	   OBJECT_ID
FROM ALL_OBJECTS
WHERE OBJECT_TYPE IN ('FUNCTION') AND OWNER ='AGGARW82';

/* List all user procedures */ 
SELECT rpad(OBJECT_NAME,15) AS PRO_NAME,
	   OBJECT_ID
FROM ALL_OBJECTS 
WHERE OBJECT_TYPE IN ('PROCEDURE') AND OWNER ='AGGARW82';

/* List all user triggers */ 
SELECT rpad(trigger_name,15) as TRG_NAME,
       rpad(trigger_type,15) as TRG_TYPE,
       rpad(triggering_event,15) as TRGing_EVENT,
       -- table_owner as schema_name,
       rpad(table_name, 15) as object_name,
       rpad(base_object_type,15) as object_type,
       status
       -- trigger_body as script       
FROM sys.all_triggers
-- excluding some Oracle maintained schemas
WHERE owner='AGGARW82'  
ORDER BY trigger_name,
         table_owner,
         table_name,
         base_object_type;