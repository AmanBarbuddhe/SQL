--> What is DDL and DML in SQL

--> DDL : Data Defination Language  ,  DDL commands/statement are used to define something in databse
--> ex: using "CREATE" command we have created database , table , schema(columnns-attribute) , view
--> ex: using "DROP" dropped database , table , view
--> ALTER : changed datatypes , constraint , etc
--> RENAME
--> TRUNCATE

--> ***************************************************************************************************

--> DML : Data Manipulation Language
--> SELECT
--> INSERT
--> UPDATE
--> DELETE


-->   INSERT : To insert one or more records into the table
-->   ======

ajdb20=# CREATE TABLE student(
ajdb20(# rno int primary key,
ajdb20(# name varchar(20),
ajdb20(# city varchar(20)
ajdb20(# );
CREATE TABLE

ajdb20=# INSERT INTO student VALUES(101,'AAA','Pune');
INSERT 0 1     --> 0 means , insert operation performed succesfully and 1 means , 1 record affected/manipulated

ajdb20=# select * from student;

 rno | name | city
-----+------+------
 101 | AAA  | Pune
(1 row)

--> ****** GIVING MORE THAN ONE RECORDS IN SINGLE INSERT QUERY ******

ajdb20=# INSERT INTO student VALUES(102,'BBB','Mumbai') , (103,'CCC','Solapur') , (104,'DDD','Nagar');
INSERT 0 3   --> 3 means , 3 records affected

ajdb20=# select * from student;

 rno | name |  city
-----+------+---------
 101 | AAA  | Pune
 102 | BBB  | Mumbai
 103 | CCC  | Solapur
 104 | DDD  | Nagar
(4 rows)

--> Why there are two ways to use INSERT query?

            FRONTEND                           

----------------------------------
|     Registration Form          |
|                                |
|      Rno : __________          |
|                                |                BACKEND                                                            DATABASE
|     Name : __________          |        -----------------------                                               -----------------    
|                                |        |                     |                                               |               |
|     City : __________          |        |                     | INSERT INTO student VALUES(101,'AAA','Pune'); |               |               
|                                |        |                     |                                               |               |
|                                |------->|      JAVA(JDBC)     | --------------------------------------------> |               |
|                                |        |                     |                                               |               |
|  _______                       |        |                     |INSERT INTO student VALUES(102,'BBB','Mumbai'),|               |                               
|  | Save|    upload excel file  |        |                     | (103,'CCC','Solapur') , (104,'DDD','Nagar');  |               |                         
|  |_____|    _________________  |        -----------------------                                               -----------------
|                                |
|                                |
|                                |
|                                |
|                                |
|                                |
----------------------------------

--> When only one application comes it is easy to just save and send one entry to database
--> But when many applications comes for registration then its time consuming to save for each record and insert each entry one by one
--> instead we can save this applications in an excel file and upload it in the hyperlink (upload excel file) and then all record will be inserted into database at once
--> therefore insert can be done in two ways : 1) Single Insert , 2) Multiple Insert


--> ************** RETURNING KEYWORD (insert with returning id) **************

ajdb20=# CREATE TABLE student(
ajdb20(# rno serial primary key,   --> serial for auto-increment
ajdb20(# name varchar(20),
ajdb20(# city varchar(20)
ajdb20(# );
CREATE TABLE

ajdb20=# INSERT INTO student VALUES(1,'AAA','Pune');
INSERT 0 1

ajdb20=# INSERT INTO student VALUES(2,'BBB','Mumbai');
INSERT 0 1

ajdb20=# select * from student;

 rno | name |  city
-----+------+--------
   1 | AAA  | Pune
   2 | BBB  | Mumbai
(2 rows)

ajdb20=# INSERT INTO student (name,city) VALUES('CCC','Sangli') RETURNING rno;
 rno
-----
   3
(1 row)
INSERT 0 1

ajdb20=# select * from student;

 rno | name |  city
-----+------+--------
   1 | AAA  | Pune
   2 | BBB  | Mumbai
   3 | CCC  | Sangli
(3 rows)

ajdb20=# INSERT INTO student (name,city) VALUES('DDD','Amravati') , ('EEE' , 'Nagpur') , ('FFF' , 'Akola') RETURNING rno;  --> can return any columns rno,name,etc
 rno
-----
   4
   5
   6
(3 rows)
INSERT 0 3

ajdb20=# select * from student;

 rno | name |   city
-----+------+----------
   1 | AAA  | Pune
   2 | BBB  | Mumbai
   3 | CCC  | Sangli
   4 | DDD  | Amravati
   5 | EEE  | Nagpur
   6 | FFF  | Akola
(6 rows)

--> use case:
--> You are going in a restaurent and you ordered your food , and you have giving a receipt that has the order no.
--> lets say the order no. is 10 , so how do you get that no.?
--> the order no. is 10 that means there were already 9 orders present in the database and 10th one is your 
--> so that 10 is returned from the database 
--> (i.e.order no. is the primary key and it gets automatically incremented 
--> , then your order is entered at order id = 10 using insert query and order id is returned using "RETURNING" KEYWORD )
--> , and printed on the receipt.








