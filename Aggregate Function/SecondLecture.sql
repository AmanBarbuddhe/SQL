--> Q. Increase the marks of student who has max percentage , by 2

ajdb20=# SELECT * FROM student WHERE per = (SELECT MAX(per) FROM student);

 rno | name | per |   city
-----+------+-----+----------
   5 | EEE  |  87 | BANGLORE
(1 row)

ajdb20=# UPDATE student SET per = per + 2 WHERE per = (SELECT MAX(per) FROM student);
UPDATE 1

ajdb20=# SELECT * FROM student WHERE per = (SELECT MAX(per) FROM student);

 rno | name | per |   city
-----+------+-----+----------
   5 | EEE  |  89 | BANGLORE
(1 row)

--> Q. Delete student with min percentage

ajdb20=# SELECT * FROM student WHERE per = (SELECT MIN(per) FROM student);

 rno | name | per | city
-----+------+-----+------
   7 | GGG  |  50 | PUNE
(1 row)

ajdb20=# DELETE FROM student WHERE per = (SELECT MIN(per) FROM student);
DELETE 1

ajdb20=# select * from student;

 rno | name | per |   city
-----+------+-----+----------
   1 | AAA  |  70 | PUNE
   4 | DDD  |  64 | DELHI
   8 | BBB  |  73 | DELHI
   3 | CCC  |  53 | PUNE
   9 | CCC  |  53 | MUMBAI
  10 | LLL  |  75 | MUMBAI
  11 | LLL  |  73 | PUNE
   5 | EEE  |  89 | BANGLORE
(8 rows)

--> Q. Find n th topper without using limit and offset

--> Below query is finding 2nd topper

SELECT * FROM student WHERE per = (SELECT MAX(per) FROM student); --> This query means select all records with "maximum percentage"

 rno | name | per |   city
-----+------+-----+----------
   5 | EEE  |  89 | BANGLORE
(1 row)

ajdb20=# SELECT * FROM student WHERE per != (SELECT MAX(per) FROM student); --> This query means select all records execpt records with "maximum percentage"

 rno | name | per |  city
-----+------+-----+--------
   1 | AAA  |  70 | PUNE
   4 | DDD  |  64 | DELHI
   3 | CCC  |  53 | PUNE
   9 | CCC  |  53 | MUMBAI
  10 | LLL  |  75 | MUMBAI
  11 | LLL  |  73 | PUNE
   8 | BBB  |  87 | DELHI
(7 rows)

ajdb20=# SELECT * FROM student WHERE per != (SELECT MAX(per) FROM student) ORDER BY per DESC; --> this query gives Descending order of topper , vomiting the highest percentage(89) , and as we can see new topper is of 87 which is our 2nd topper

 rno | name | per |  city
-----+------+-----+--------
   8 | BBB  |  87 | DELHI
  10 | LLL  |  75 | MUMBAI
  11 | LLL  |  73 | PUNE
   1 | AAA  |  70 | PUNE
   4 | DDD  |  64 | DELHI
   9 | CCC  |  53 | MUMBAI
   3 | CCC  |  53 | PUNE
(7 rows)

ajdb20=# SELECT MAX(per) FROM student WHERE per != (SELECT MAX(per) FROM student);   --> this query gives me topper from the table , from where we have removed 1st topper with per = 89
                                                ---------------------------------- 
                                                             |
                                                             |
                                                    This query gives me table , removing 1st topper with per = 89
        -----------------------------------------------------------------------------
                                        |
                                        |
                                        |
                    This whole query gives me topper of the table , from where we have removed 1st topper with per = 89

and our next topper is with per = 87

 max
-----
  87
(1 row)


ajdb20=# SELECT * FROM student WHERE per = (SELECT MAX(per) FROM student WHERE per != (SELECT MAX(per) FROM student));

 rno | name | per | city
-----+------+-----+-------
   8 | BBB  |  87 | DELHI
(1 row)

 
--> Original table 
 
 rno | name | per |   city
-----+------+-----+----------
   1 | AAA  |  70 | PUNE
   4 | DDD  |  64 | DELHI
   3 | CCC  |  53 | PUNE
   9 | CCC  |  53 | MUMBAI
  10 | LLL  |  75 | MUMBAI
  11 | LLL  |  73 | PUNE
   5 | EEE  |  89 | BANGLORE
   8 | BBB  |  87 | DELHI
(8 rows)

SELECT * FROM student WHERE per = (SELECT MAX(per) FROM student WHERE per != (SELECT MAX(per) FROM student));
                                                                             --------------------------------
                                                                                             |
                                                                                             |
                                                                                             89


SELECT * FROM student WHERE per = (SELECT MAX(per) FROM student WHERE per != 89);
                                  ------------------------------------------------  
                                                        |
                                                        |
                                                        87


SELECT * FROM student WHERE per = 87;

Final Output -->  rno | name | per | city
                 -----+------+-----+-------
                    8 | BBB  |  87 | DELHI
                (1 row)


--> Q. Find 3rd topper  (HomeWork)
--> **********************************************************

 rno | name | per |   city
-----+------+-----+----------
   1 | AAA  |  70 | PUNE
   4 | DDD  |  64 | DELHI
   3 | CCC  |  53 | PUNE
   9 | CCC  |  53 | MUMBAI
  10 | LLL  |  75 | MUMBAI
  11 | LLL  |  73 | PUNE
   5 | EEE  |  89 | BANGLORE
   8 | BBB  |  87 | DELHI
(8 rows)

ajdb20=# SELECT city , COUNT(*) FROM student GROUP BY city; --> if using column name with aggregate function then you have to use GROUP BY on that same column which you are using with Aggregate function

   city   | count
----------+-------
 DELHI    |     2
 BANGLORE |     1
 MUMBAI   |     2
 PUNE     |     3
(4 rows)


--> Q. Give city wise topper

ajdb20=# SELECT city , MAX(per) FROM student GROUP BY city;

   city   | max
----------+-----
 DELHI    |  87
 BANGLORE |  89
 MUMBAI   |  75
 PUNE     |  73
(4 rows)

ajdb20=# SELECT city , MAX(per) AS Toppers FROM student GROUP BY city;
   city   | toppers                -------
----------+---------                 |
 DELHI    |      87                In SQL all uppercase letters declaration are converted into lowercase 
 BANGLORE |      89
 MUMBAI   |      75
 PUNE     |      73
(4 rows)


ajdb20=# SELECT city , MAX(per) AS Toppers FROM student GROUP BY city ORDER BY toppers DESC;

   city   | toppers
----------+---------
 BANGLORE |      89
 DELHI    |      87
 MUMBAI   |      75
 PUNE     |      73
(4 rows)




--> ********************************** HAVING CLAUSE **********************************

SELECT * FROM student WHERE per >= 50;
--> "WHERE" clause goes to each record and checks if condition is satisfying i.e. WHERE clause works record by record

SELECT city , MAX(per) AS Toppers FROM student GROUP BY city HAVING MAX(per) >=50 ORDER BY toppers DESC;
--> "HAVING" clause is applied on group always , It is always return infront of GROUP BY , and it always has condition
--> as Aggregate Function , The aggregate function in condition is same as aggregate function in SELECT

--> Above query execute in follwing way , 1st using GROUP BY city , Groups are made based on city 
--> and then HAVING takes MAX(per) , from each group and finally gives us a table like below,

   city   | toppers
----------+---------
 BANGLORE |      89
 DELHI    |      87
 MUMBAI   |      75
 PUNE     |      73
(4 rows)


--> All condition that we were able to write in WHERE , can also be written in HAVING
--> Difference is that WHERE works on records whereas HAVING works on groups

ajdb20=# SELECT city , COUNT(*) FROM student GROUP BY city HAVING city LIKE 'P%';  --> 1st groups are made , then checked using HAVING that is city starting from "P"

 city | count
------+-------
 PUNE |     3
(1 row)
















