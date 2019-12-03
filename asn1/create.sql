CREATE TABLE S(Sno varchar2(10), Sname Varchar2(10),
                                 Status number, city Varchar2(10));


CREATE TABLE P(Pno varchar2(10), Pname Varchar2(10),
                                 color Varchar2(10),
                                       Weight number, city Varchar2(10));


CREATE TABLE J(Jno varchar2(10), Jname Varchar2(10),
                                 city Varchar2(10));

CREATE TABLE SPJ(Sno varchar2(10), Pno varchar2(10), Jno varchar2(10), Quantity number);