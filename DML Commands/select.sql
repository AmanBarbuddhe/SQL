--> SELECT : used to display result
--> ======

--> select * from student;
--> select now();
--> select now()::date;
--> select 2 + 3 ;
--> select length('tca');
--> select fname , length(fname) from student;


--> AS : To temporary rename an column/table (Temporary alias for column name or table name)
--> ==
--> select 2+3 AS sum;

--> AS is optional i.e. select rno rollnum from student; , the space between rno and rollnum is considered "AS" by-default
--> select rno , fname lname , per from student;  --> fname is temporary renamed as lname
--> select rno , fname ||' '|| lname AS full_name, per from student;  ||--> for concatenation ' ' to add space between fname and lname

--> rno | full_name | per
--> ----+-----------+----
-->  101|Virat Kohli| 18

--> without AS full_name , instead of column name --> full_name        ?column? will be dispalyed if As full_name not written

--> select rno , fname ||' '|| lname AS "full name", per from student;  ||--> for concatenation ' ' to add space between fname and lname

--> rno | full name | per
--> ----+-----------+----
-->  101|Virat Kohli| 18



--> DISTINCT : If from a column we want only unique values , avoiding duplicate values then we use DISTINCT keyword
--> ========

ajdb20=# select city from student;
   city
----------
 Pune
 Mumbai
 Sangli
 Amravati
 Nagpur
 Akola
 Sangli
 Pune
(8 rows)

ajdb20=# select DISTINCT city from student;
   city
----------
 Sangli
 Amravati
 Mumbai
 Pune
 Nagpur
 Akola
(6 rows)



--> ORDER BY : Used to get result of select query in sorted form 
--> ========
--> i.e. ASC : Ascending order , DESC : Descending , by default Ascending 
--> LIMIT
--> OFFSET

ajdb20=# select * from student;

 rno | name  | per
-----+-------+------
 101 | Virat | 60
 102 | Rohit | 80
 103 | Msd   | 70
 104 | Surya |
 105 | Ishan | 75
 106 | Sanju |
(6 rows)

ajdb20=# select * from student ORDER BY per ;

 rno | name  | per
-----+-------+------
 101 | Virat | 60
 103 | Msd   | 70
 105 | Ishan | 75
 102 | Rohit | 80
 104 | Surya |
 106 | Sanju |
(6 rows)

ajdb20=# select * from student ORDER BY per ASC ;

 rno | name  | per
-----+-------+------
 101 | Virat | 60
 103 | Msd   | 70
 105 | Ishan | 75
 102 | Rohit | 80
 104 | Surya |
 106 | Sanju |
(6 rows)

ajdb20=# select * from student ORDER BY per DESC ;

 rno | name  | per
-----+-------+------
 104 | Surya |
 106 | Sanju |
 102 | Rohit | 80
 105 | Ishan | 75
 103 | Msd   | 70
 101 | Virat | 60
(6 rows)

--> it is like we want to find topper according to above table surya is the topper , but actually Rohit is topper

--> ************ REMOVING NULL TO LAST ************

ajdb20=# select * from student ORDER BY per DESC NULLS LAST;

 rno | name  | per
-----+-------+------
 102 | Rohit | 80
 105 | Ishan | 75
 103 | Msd   | 70
 101 | Virat | 60
 104 | Surya |
 106 | Sanju |
(6 rows)

--> **************** LIMIT keyword ****************

ajdb20=# select * from student ORDER BY per LIMIT 2;
 rno | name  | per
-----+-------+------
 101 | Virat | 60
 103 | Msd   | 70
(2 rows)

--> ******************* How will you find topper from a table *******************

--> STEP 1 : Order by decreasing value
ajdb20=# select * from student ORDER BY per DESC ;

 rno | name  | per
-----+-------+------
 104 | Surya |
 106 | Sanju |
 102 | Rohit | 80
 105 | Ishan | 75
 103 | Msd   | 70
 101 | Virat | 60
(6 rows)

--> STEP 2 : Pushing null values to Last
ajdb20=# select * from student ORDER BY per DESC NULLS LAST;

 rno | name  | per
-----+-------+------
 102 | Rohit | 80
 105 | Ishan | 75
 103 | Msd   | 70
 101 | Virat | 60
 104 | Surya |
 106 | Sanju |
(6 rows)

--> STEP 3 : Getting Rohit only as he is the topper
ajdb20=# select * from student ORDER BY city DESC NULLS LAST LIMIT 1;
 rno | name  | city
-----+-------+------
 102 | Rohit | 80
(1 row)

--> so final answer is the query : select * from student ORDER BY city DESC NULLS LAST LIMIT 1;
--> select * from student ORDER BY city DESC NULLS LAST LIMIT 1; , this query has a flaw because it gives only one record , but what there are more students with per = 80;


--> **************** OFFSET keyword ****************
--> Q. Ignore 1st topper and display 3rd topper

ajdb20=# select * from student ORDER BY per DESC NULLS LAST;

 index   rno | name  | per
        -----+-------+------
 0 --->  102 | Rohit | 80
 1 --->  105 | Ishan | 75
 2 --->  103 | Msd   | 70
         101 | Virat | 60
         104 | Surya |
         106 | Sanju |
(6 rows)

ajdb20=# select * from student ORDER BY city DESC NULLS LAST LIMIT 1 OFFSET 2;  --> OFFSET 2 means , index 2 i.e. pickup the record/records from index 2
 rno | name | city
-----+------+------
 103 | Msd  | 70


ajdb20=# select * from student ORDER BY city DESC NULLS LAST OFFSET 2;
 rno | name  | city
-----+-------+------
 103 | Msd   | 70
 101 | Virat | 60
 104 | Surya |
 106 | Sanju |
(4 rows)
















