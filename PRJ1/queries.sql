rem EE 562 Project 1
rem Varun Aggarwal
rem aggarw82

DBMS_OUTPUT.PUT_LINE('Query #1');
/* 1 - final */
Prompt Query 1;
SELECT DISTINCT MAX(S.age)
FROM CLASS C,
           Student S,           
           Enrolled E,
           Faculty F
WHERE S.sid = E.sid
    AND E.cnum = C.cnum
    AND C.fid=F.fid
    AND F.fname = 'Prof. Brown'
    OR S.major='CS';




DBMS_OUTPUT.PUT_LINE('Query #2');
/* 2 - final */
Prompt Query 2;
SELECT C.cnum
FROM CLASS C
WHERE C.room='115'
UNION
SELECT E.cnum
FROM Enrolled E
GROUP BY E.cnum
HAVING COUNT(*) >= 5;




DBMS_OUTPUT.PUT_LINE('Query #3');
/* 3 - final */
Prompt Query 3;
SELECT DISTINCT(S.sname)
FROM CLASS Cx,
           CLASS Cy,
                 Enrolled Ex,
                 Enrolled Ey,
                 Student S
WHERE Cx.meets_at = Cy.meets_at
    AND Cx.cnum != Cy.cnum
    AND Cy.cnum = Ey.cnum
    AND Cx.cnum = Ex.cnum
    AND Ex.sid = Ey.sid
    AND Ex.sid = S.sid;





DBMS_OUTPUT.PUT_LINE('Query #4');
/* 4 - final */
Prompt Query 4;
SELECT DISTINCT(F.fname)
FROM FACULTY F
WHERE NOT EXISTS (
    SELECT Cx.room
    FROM CLASS Cx WHERE Cx.room NOT IN
        (SELECT Cy.room
         FROM CLASS Cy
         WHERE Cy.fid=F.fid));         





DBMS_OUTPUT.PUT_LINE('Query #5');
/* 5 - final */
Prompt Query 5;
SELECT fname
FROM
    (SELECT Fx.fname,
            COUNT(*) AS stuforfac
     FROM FACULTY Fx
     JOIN CLASS Cx ON Cx.fid=Fx.fid
     JOIN ENROLLED Ex ON Ex.cnum=Cx.cnum
     JOIN STUDENT Sx ON Sx.sid=Ex.sid
     GROUP BY Fx.fname)
WHERE stuforfac > 8;





DBMS_OUTPUT.PUT_LINE('Query #6');
/* 6 - done! */
Prompt Query 6;
SELECT S.levels,
       avg(S.age)
FROM Student S
WHERE S.levels != 'JR'
GROUP BY S.levels;





DBMS_OUTPUT.PUT_LINE('Query #7');
/* 7 - final */
Prompt Query 7;
SELECT sname
FROM
    (SELECT Sx.sname,
            COUNT(*) AS num
     FROM ENROLLED Ex
     JOIN STUDENT Sx ON Sx.sid = Ex.sid
     GROUP BY Sx.sname)
WHERE num =
        (SELECT MAX(COUNT(*))
         FROM ENROLLED Ey
         JOIN STUDENT Sy ON Sy.sid = Ey.sid
         GROUP BY Sy.sname);



DBMS_OUTPUT.PUT_LINE('Query #8');
/* 8 - final*/
Prompt Query 8;
SELECT sname
FROM Student
WHERE sid IN
        (SELECT Sx.sid
         FROM Student Sx MINUS SELECT DISTINCT(Ex.sid)
         FROM ENROLLED Ex);





DBMS_OUTPUT.PUT_LINE('Query #9');
/* 9  - not submit */
Prompt Query 9;


DBMS_OUTPUT.PUT_LINE('Query #10');
/* 10 - not working*/
Prompt Query 10;



DBMS_OUTPUT.PUT_LINE('Query #11');
/* 11 - final*/
Prompt Query 11;
SELECT fname
FROM
    (SELECT Fx.fname,
            COUNT(*) AS stuforfac
     FROM FACULTY Fx
     JOIN CLASS Cx ON Fx.fid=Cx.fid
     JOIN ENROLLED Ex ON Cx.cnum=Ex.cnum
     JOIN STUDENT Sx ON Ex.sid=Sx.sid
     GROUP BY Fx.fname)
WHERE stuforfac >
        (SELECT AVG(COUNT(*))
         FROM FACULTY Fy
         JOIN CLASS Cy ON Fy.fid=Cy.fid
         JOIN ENROLLED Ey ON Cy.cnum=Ey.cnum
         JOIN STUDENT Sy ON Ey.sid=Sy.sid
         WHERE Fy.dept='EE'
         GROUP BY Fy.fname);





DBMS_OUTPUT.PUT_LINE('Query #12');
/* 12 - final*/
Prompt Query 12;
SELECT Fx.fname
FROM FACULTY Fx
WHERE NOT EXISTS
        (SELECT DISTINCT(Fz.fname)
         FROM CLASS Cx, CLASS Cy, FACULTY Fy, FACULTY Fz
         WHERE Cx.fid=Fy.fid
             AND Cy.fid=Fz.fid
             AND Cx.fid!=Cy.fid
             AND Cx.meets_at=Cy.meets_at
             AND Fy.fname='Prof. Wasfi'
             AND Fy.dept=Fz.dept
             AND Fz.fname!=Fy.fname); 




 DBMS_OUTPUT.PUT_LINE('Query #13');
/* 13- final */
Prompt Query 13
SELECT DISTINCT S.sname
FROM Student S
JOIN Enrolled E ON S.sid = E.sid
WHERE E.cnum IN
        (SELECT C.cnum
         FROM CLASS C MINUS SELECT P.cnum
         FROM Prerequisite P);





DBMS_OUTPUT.PUT_LINE('Query #14');
/* 14 - final */
Prompt Query 14;
SELECT Py.cnum,
       Py.prereq
FROM PREREQUISITE Py
WHERE Py.cnum IN
        (SELECT DISTINCT(Cx.cnum)
         FROM CLASS Cx,
                    CLASS Cy,
                          PREREQUISITE Px
         WHERE Cx.meets_at!=Cy.meets_at
             AND Cx.cnum!=Cy.cnum
             AND Cx.cnum=Px.cnum
             AND Cy.cnum=Px.prereq);





DBMS_OUTPUT.PUT_LINE('Query #15');
/* 15  - final*/
Prompt Query 15;
SELECT (Fx.fname)
FROM CLASS Cx,
           CLASS Cy,
                 PREREQUISITE Px,
                 FACULTY Fx
WHERE Cx.fid=Cy.fid
    AND Cx.fid=Fx.fid
    AND Cx.cnum!=Cy.cnum
    AND Cx.cnum=Px.cnum
    AND Cy.cnum=Px.prereq;



DBMS_OUTPUT.PUT_LINE('Query #16');
/* 16 - LOGIC: 3 U 2 U 1 U 0 */
Prompt Query 16;
SELECT DISTINCT Cx.cnum
FROM CLASS Cx
WHERE Cx.cnum IN
        (SELECT Px.cnum
         FROM PREREQUISITE Px
         WHERE EXISTS
                 (SELECT Px.cnum
                  FROM PREREQUISITE Py
                  WHERE Px.prereq=Py.cnum
                      AND EXISTS
                          (SELECT Py.cnum
                           FROM PREREQUISITE Pz
                           WHERE Py.prereq=Pz.cnum
                               AND NOT EXISTS
                                   (SELECT Pz.cnum
                                    FROM PREREQUISITE Pa
                                    WHERE Pz.prereq=Pa.cnum))))
UNION
SELECT DISTINCT Cx.cnum
FROM CLASS Cx
WHERE Cx.cnum IN
        (SELECT Px.cnum
         FROM PREREQUISITE Px
         WHERE EXISTS
                 (SELECT Px.cnum
                  FROM PREREQUISITE Py
                  WHERE Px.prereq=Py.cnum
                      AND NOT EXISTS
                          (SELECT Py.cnum
                           FROM PREREQUISITE Pz
                           WHERE Py.prereq=Pz.cnum)))
UNION
SELECT DISTINCT Cx.cnum
FROM CLASS Cx
WHERE Cx.cnum IN
        (SELECT Px.cnum
         FROM PREREQUISITE Px
         WHERE NOT EXISTS
                 (SELECT Px.cnum
                  FROM PREREQUISITE Py
                  WHERE Px.prereq=Py.cnum))
UNION
SELECT DISTINCT Cx.cnum
FROM CLASS Cx
WHERE Cx.cnum NOT IN
        (SELECT Px.cnum
         FROM PREREQUISITE Px);






DBMS_OUTPUT.PUT_LINE('Query #17');
/* 17 - logic: immidiate prereq != first extended prereq */
Prompt Query 17;
SELECT t.sname,
       t.cnum,
       Pa.prereq
FROM
    (SELECT DISTINCT Sx.sname,
                     Ex.cnum,
                     Px.prereq
     FROM STUDENT Sx,
          ENROLLED Ex,
          PREREQUISITE Px
     WHERE Ex.cnum = Px.cnum
         AND Sx.sid=Ex.sid
         AND Ex.cnum IN
             (SELECT Px.cnum
              FROM PREREQUISITE Px
              WHERE EXISTS
                      (SELECT Px.cnum
                       FROM PREREQUISITE Py
                       WHERE Px.prereq=Py.cnum
                           AND NOT EXISTS
                               (SELECT Py.cnum
                                FROM PREREQUISITE Pz
                                WHERE Py.prereq=Pz.cnum)))) t,
     PREREQUISITE Pa
WHERE Pa.cnum = t.prereq;

DBMS_OUTPUT.PUT_LINE('VIEW A');
SELECT * FROM view_a;

DBMS_OUTPUT.PUT_LINE('VIEW B');
SELECT * FROM view_b;