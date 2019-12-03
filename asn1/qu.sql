SELECT ssx.Sno
FROM
    (SELECT Sno,
            COUNT(*) AS cnt
     FROM SPJ
     GROUP BY Sno) ssx
GROUP BY ssx.Sno,
         ssx.cnt
HAVING ssx.cnt =
    (SELECT MIN(t.cnt)
     FROM
         (SELECT Sno,
                 COUNT(*) AS cnt
          FROM SPJ
          GROUP BY Sno) t);