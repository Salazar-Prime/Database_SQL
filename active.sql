SELECT a.object, a.type, a.sid,
s.serial#, s.username,
s.program, s.logon_time
FROM v$access a, v$session s
WHERE a.sid = s.sid
AND a.owner = '&owner';