-- Create Bed Table
CREATE TABLE Beds( Ward varchar2(30),
				   Bed_No Number,
				   Available_Date Date);

INSERT INTO Beds VALUES('PW', '1', to_date('01/01/2005', 'MM/DD/YYYY'));
INSERT INTO Beds VALUES('PW', '2', to_date('01/01/2005', 'MM/DD/YYYY'));
INSERT INTO Beds VALUES('PW', '3', to_date('01/01/2005', 'MM/DD/YYYY'));
INSERT INTO Beds VALUES('PW', '4', to_date('01/01/2005', 'MM/DD/YYYY'));
INSERT INTO Beds VALUES('SW', '1', to_date('01/01/2005', 'MM/DD/YYYY'));
INSERT INTO Beds VALUES('SW', '2', to_date('01/01/2005', 'MM/DD/YYYY'));
INSERT INTO Beds VALUES('SW', '3', to_date('01/01/2005', 'MM/DD/YYYY'));
INSERT INTO Beds VALUES('SW', '4', to_date('01/01/2005', 'MM/DD/YYYY'));
INSERT INTO Beds VALUES('SW', '5', to_date('01/01/2005', 'MM/DD/YYYY'));