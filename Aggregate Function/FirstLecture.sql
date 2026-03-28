--> Aggregate Function : Functions that can be performed on set of values only
--> 1. COUNT()
--> 2. SUM()
--> 3. AVG()
--> 4. MAX()
--> 5. MIN()

ajdb20=# select * from student;
 rno | name | per |   city
-----+------+-----+----------
   1 | AAA  |  70 | PUNE
   4 | DDD  |  64 | DELHI
   5 | EEE  |  87 | BANGLORE
   8 | BBB  |  73 | DELHI
   7 | GGG  |  50 | PUNE
   3 | CCC  |  53 | PUNE
(6 rows)

--> ******************** COUNT ********************

ajdb20=# select COUNT(*) from student; --> Gives count of record in our table
 count
-------
     6
(1 row)

select COUNT(*) from student; --> gives no. of records in the table
select COUNT(rno/name/per/city) from student; --> gives no. of values in that respective column

--> ******************** SUM ********************

ajdb20=# select SUM(per) AS TOTAL from student;

 total
-------
   397
(1 row)

--> ******************** AVERAGE ********************

ajdb20=# select AVG(per) AS Average from student;
       average
---------------------
 66.1666666666666667
(1 row)
--> if there was 7th record with per column null in it , then that record will not get considered in calculating average means avg will be sum of 6 per values divided by 6

--> internally avg(per) = sum(per)/count(per)

--> ******************** MAX ********************

ajdb20=# select MAX(per) from student;

 max
-----
  87
(1 row)

ajdb20=# select * from student;

 rno | name | per |   city
-----+------+-----+----------
   1 | AAA  |  70 | PUNE
   4 | DDD  |  64 | DELHI
   5 | EEE  |  87 | BANGLORE
   8 | BBB  |  73 | DELHI
   7 | GGG  |  50 | PUNE
   3 | CCC  |  53 | PUNE
   9 | CCC  |  53 | MUMBAI
  10 | LLL  |  75 | MUMBAI

ajdb20=# select MAX(per) from student where city = 'MUMBAI';

 max
-----
  75
(1 row)

--> ******************** MIN ********************

ajdb20=# select MIN(per) from student;
 min
-----
  50
(1 row)


ajdb20=# select MAX(city) from student;
 max
------
 PUNE
(1 row)
--> Based on ASCII value , ascii value of P is greater than every other cities starting alphabet 

ajdb20=# select city from student where city in ('PUNE','MUMBAI');

  city
--------
 PUNE
 PUNE
 PUNE
 MUMBAI
 MUMBAI
(5 rows)


ajdb20=# select max(city) from student where city in ('PUNE','MUMBAI');

 max
------
 PUNE
(1 row)


--> ********************** NESTED QUERY *******************

Q. Find The topper

ajdb20=# SELECT * FROM student WHERE per = (SELECT MAX(per) FROM student);

 rno | name | per |   city
-----+------+-----+----------
   5 | EEE  |  87 | BANGLORE
(1 row)

--> SELECT * FROM student WHERE per = (SELECT MAX(per) FROM student); this query solves the flaw of ---> --> select * from student ORDER BY city DESC NULLS LAST LIMIT 1; , this query has a flaw because it gives only one record , but what if there are more students with per = 87;

Q. Find the topper from DELHI

ajdb20=# insert into student values(11,'LLL',73,'PUNE');
INSERT 0 1

ajdb20=# select * from student;

 rno | name | per |   city
-----+------+-----+----------
   1 | AAA  |  70 | PUNE
   4 | DDD  |  64 | DELHI
   5 | EEE  |  87 | BANGLORE
   8 | BBB  |  73 | DELHI
   7 | GGG  |  50 | PUNE
   3 | CCC  |  53 | PUNE
   9 | CCC  |  53 | MUMBAI
  10 | LLL  |  75 | MUMBAI
  11 | LLL  |  73 | PUNE
(9 rows)

ajdb20=# SELECT * FROM student WHERE per = (SELECT MAX(per) FROM student WHERE city = 'DELHI');
 rno | name | per | city
-----+------+-----+-------
   8 | BBB  |  73 | DELHI
  11 | LLL  |  73 | PUNE
(2 rows)
--> it should have given topper only from delhi but its giving a record of pune also with marks 73
--> because  SELECT * FROM student WHERE per = (SELECT MAX(per) FROM student WHERE city = 'DELHI');
--> (SELECT MAX(per) FROM student WHERE city = 'DELHI'); gives max per value from delhi i.e. 73
--> SELECT * FROM student WHERE per = 73; ---> select all record from table student where per = 73

--> CORRECT QUERY

ajdb20=# SELECT * FROM student WHERE per = (SELECT MAX(per) FROM student WHERE city = 'DELHI') AND city = 'DELHI';

 rno | name | per | city
-----+------+-----+-------
   8 | BBB  |  73 | DELHI
(1 row)

--> SELECT * FROM student WHERE per = (SELECT MAX(per) FROM student WHERE city = 'DELHI') AND city = 'DELHI'; it becomes
--> SELECT * FROM student WHERE per = 73 AND city = 'DELHI';


































