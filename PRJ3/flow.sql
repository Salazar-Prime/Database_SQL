rem EE 562 Project 3
rem Varun Aggarwal
rem aggarw82

-- Create Flow Table
CREATE TABLE Flow( Pname varchar2(30),
				   Ptype varchar2(10),
				   G_Date Date,
				   S_Date Date,
				   Pre_Date Date,
				   Post_Date Date,
				   D_Date Date,
				   Scount number,
				   Total_Days number);