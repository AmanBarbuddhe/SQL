--> ***** VARCHAR vs CHAR vs TEXT *****

--> fname varchar(5)
--> Student name can be of maximum length 5 i.e. "AAA" will take only 3 bytes of memory out of 5 , "A" will take only 1 bytes of memory out of 5 i.e. it takes only that much space which is needed to store the name from assigned memory
--> Ex: "AAA"  , "A" , "ABCDE"
--> "SACHIN" ==> Error , because maximum limit exceeded

-->***********************************************************************************

--> fname char(5)
--> Student name is always of length 5
--> "AAA"  , "A"  , "AAA" will take memory of 5 bytes , "A"  will take memory of 1 bytes
--> "SACHIN" ==> Error , because maximum limit exceeded

--> *** if written only "char" then it can store only one character 
--> Ex: grade char
--> grade variable can store --> "A" , "B" , "C" , etc.

--> ***********************************************************************************

--> **** text ****
--> You can store any no. of characters.
--> feedback or address will be of any length

ajdb20=# CREATE TABLE students(
ajdb20(# rno int primary key,
ajdb20(# fname varchar(5),
ajdb20(# lname char(5),
ajdb20(# feedback text
ajdb20(# );
CREATE TABLE

ajdb20=# insert into students values(101 , 'AAA' , 'aaa' , 'Very Good Class');
INSERT 0 1

ajdb20=# select * from students;

 rno | fname | lname |    feedback
-----+-------+-------+-----------------
 101 | AAA   | aaa   | Very Good Class
(1 row)

ajdb20=# insert into students values(102 , 'AAA' , 'aaa' , 'Very Gooooooooooooooooooooooooooooooood Class');
INSERT 0 1

ajdb20=# select * from students;

 rno | fname | lname |                   feedback
-----+-------+-------+-----------------------------------------------
 101 | AAA   | aaa   | Very Good Class
 102 | AAA   | aaa   | Very Gooooooooooooooooooooooooooooooood Class
(2 rows)

------> Here We can see feedback is having type "TEXT" therefore no limit on size

ajdb20=# insert into students values(103 , 'AAAAAA' , 'aaa' , 'Very Good Class');
ERROR:  value too long for type character varying(5)

-------> As Limit of fname VARCHAR(5) is exceeding we get an character varying(5)

ajdb20=# insert into students values(102 , 'AAA' , 'aaaaaa' , 'Very Good Class');
ERROR:  value too long for type character(5)

-------> As Limit of lname CHAR(5) is exceeding we get an character(5)

--> ***** NUMERIC DataType *****

--> NUMERIC( precision , scale )  --> precision gives spaces for the digit/amount and if amount/digit is more than the precision then it is ignored ,
--> scale gives how many no. to be shown after decimal

Why numeric should be used than float to store amount?
--> Float cannot be limited , i.e. we cannot limit it to show only specific no. of digit after decimal , but NUMERIC can
--> There is miss alignment if use float 
--> ex:               account(using FLOAT DataType)         |        account(using NUMERIC DataType)
                      -----------------------------         |      -------------------------------
                            1293.89                         |                1293.89
                            100.34                          |                 100.34
                            2.00                            |                   2.00


ajdb20=# CREATE TABLE customer(
ajdb20(# rno int primary key,
ajdb20(# name varchar(10),
ajdb20(# balance NUMERIC(7,2)
ajdb20(# );
CREATE TABLE

ajdb20=# insert into customer values(101 , 'AAA' , 1123.45);
INSERT 0 1

ajdb20=# insert into customer values(102 , 'BBB' , 11.4567);
INSERT 0 1

ajdb20=# select * from customer;

 rno | name | balance
-----+------+---------
 101 | AAA  | 1123.45
 102 | BBB  |   11.46
(2 rows)

ajdb20=# insert into customer values(104 , 'DDD' , 119567.4567);

ERROR:  numeric field overflow
DETAIL:  A field with precision 7, scale 2 must round to an absolute value less than 10^5.

--> so as amount is going above precision , this ammount cannot be entered 


--> ***** BOOLEAN *****
--> YES/NO

--> t can be : true , t , y , yes , 1
--> f can be : flase , f , n , no , 0

ajdb20=# CREATE TABLE person(
ajdb20(# pno int primary key,
ajdb20(# pname varchar(10),
ajdb20(# married boolean
ajdb20(# );
CREATE TABLE

ajdb20=# insert into person values(101 , 'Rohit' , true);
INSERT 0 1

ajdb20=# insert into person values(102 , 'Virat' , 't');
INSERT 0 1

ajdb20=# insert into person values(103 , 'Dhoni' , 'yes');
INSERT 0 1

ajdb20=# insert into person values(104 , 'Samson' , 'y');
INSERT 0 1

ajdb20=# insert into person values(105 , 'Hardik' , '1');
INSERT 0 1

ajdb20=# select * from person;

 pno | pname  | married
-----+--------+---------
 101 | Rohit  | t
 102 | Virat  | t
 103 | Dhoni  | t
 104 | Samson | t
 105 | Hardik | t
(5 rows)

--> all boolean trueiis converted to t 

--> similarly all boolean false(flase , f , n , no , 0) will be converted to f

ajdb20=# insert into person values(106 , 'Pandey' , '0');
INSERT 0 1

ajdb20=# insert into person values(107 , 'Chahal' , 'f');
INSERT 0 1

ajdb20=# select * from person;

 pno | pname  | married
-----+--------+---------
 101 | Rohit  | t
 102 | Virat  | t
 103 | Dhoni  | t
 104 | Samson | t
 105 | Hardik | t
 106 | Pandey | f
 107 | Chahal | f

ajdb20=# select * from person where married = 't';

 pno | pname  | married
-----+--------+---------
 101 | Rohit  | t
 102 | Virat  | t
 103 | Dhoni  | t
 104 | Samson | t
 105 | Hardik | t
(5 rows)

--> ****** IMPORTANT ******
ajdb20=# select * from person where married;   ---> no condition for where still query executes
 pno | pname  | married
-----+--------+---------
 101 | Rohit  | t
 102 | Virat  | t
 103 | Dhoni  | t
 104 | Samson | t
 105 | Hardik | t
(5 rows)

ajdb20=# select * from person where married = 'f';

 pno | pname  | married
-----+--------+---------
 106 | Pandey | f
 107 | Chahal | f
(2 rows)

--> ****** IMPORTANT ******

ajdb20=# select * from person where not married;   --->  ---> no condition for where still query executes
 pno | pname  | married
-----+--------+---------
 106 | Pandey | f
 107 | Chahal | f
(2 rows)






























