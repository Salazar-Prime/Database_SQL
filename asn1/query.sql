/* Query 1 */
(SELECT Sno FROM SPJ WHERE Jno = 'J1')
INTERSECT
(SELECT Sno FROM SPJ WHERE Jno = 'J2');

/* Query 2 */
SELECT UNIQUE(SPJ.Sno)
FROM SPJ JOIN S ON S.Sno = SPJ.Sno JOIN P ON P.Pno = SPJ.Pno JOIN J ON J.Jno = SPJ.Jno
WHERE P.color = 'Red' AND J.city IN ('London','Paris'); 

/* Query 3 */
SELECT UNIQUE(SPJ.Pno)
FROM SPJ JOIN S ON S.Sno = SPJ.Sno JOIN P ON P.Pno = SPJ.Pno JOIN J ON J.Jno = SPJ.Jno
WHERE J.city = 'London' AND S.city IN ('London'); 

/* Query 4 */
SELECT S.city, J.city
FROM SPJ JOIN S ON S.Sno = SPJ.Sno JOIN J ON J.Jno = SPJ.Jno; 

/* Query 5 */
(SELECT Jno FROM SPJ WHERE Sno = 'S2')
MINUS
(SELECT Jno FROM SPJ WHERE Sno NOT IN ('S2') );

/* Query 6 */
SELECT (SPJ.Pno)
FROM SPJ JOIN P ON P.Pno = SPJ.Pno JOIN J ON J.Jno = SPJ.Jno
WHERE J.city = 'London'; 

/* Query 7 */
SELECT DISTINCT(Jno) 
FROM SPJ 
WHERE Pno IN (SELECT Pno FROM SPJ WHERE Sno = 'S1');