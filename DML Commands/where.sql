--> WHERE
--> =====

--> What is condition?
--> -----------------
--> Condition are written using realtional operator
--> relational operator : < , > , <= , >= , = , != , <>
--> if we are getting TRUE/FALSE on executing some operators then those operators are called relational operators
--> Relational operators give boolean values i.e. { t(true) , f(false) }
--> Logical Operator : AND , OR , NOT
--> Logical operators are used to combine multiple conditions
--> Condition are written in "WHERE" clause as well as in "HAVING" clause

ajdb20=# select 3 > 5;
 ?column?
----------
 f
(1 row)

ajdb20=# select * from student;
 rno | name | per |   city
-----+------+-----+----------
   1 | AAA  | 70  | PUNE
   2 | BBB  | 29  | PANJI
   3 | CCC  | 50  | MUMBAI
   4 | DDD  | 64  | DELHI
   5 | EEE  | 87  | BANGLORE
   6 | FFF  | 95  | PUNE
   7 | GGG  | 45  | PUNE
   8 | BBB  | 73  | DELHI
(8 rows)

ajdb20=# SELECT * FROM student WHERE city = 'PUNE';

 rno | name | per | city
-----+------+-----+------
   1 | AAA  | 70  | PUNE
   6 | FFF  | 95  | PUNE
   7 | GGG  | 45  | PUNE
(3 rows)

--> 1st FROM is executed and we get overview of whole table
--> 2nd WHERE clause is executed , each record is checked that if it has PUNE? i.e. it runs record by record , means if 8 peoples are from pune then WHERE will get executed 8 times
--> this is the disadvantage of WHERE clause , but there are some situation in which you have no option but to use WHERE
--> and also some situation when this flaw can be solved using "HAVING" clause
--> so all records are filtered for city = 'PUNE'
--> 3rd SELECT * is executed 
--> and if it was SELECT name then output ---->| name |
                                               +------+
                                               | AAA  |
                                               | BBB  |
                                               | CCC  |

--> order of evaluation of query -->   SELECT * FROM student WHERE city = 'PUNE'; is,
-->                                      FROM ---> WHERE ---> SELECT 


ajdb20=# SELECT * FROM student WHERE city = 'PUNE' OR city = 'MUMBAI';

 rno | name | per |  city
-----+------+-----+--------
   1 | AAA  | 70  | PUNE
   3 | CCC  | 50  | MUMBAI
   6 | FFF  | 95  | PUNE
   7 | GGG  | 45  | PUNE
(4 rows)

ajdb20=# SELECT * FROM student WHERE city = 'PUNE' AND city = 'MUMBAI';

 rno | name | per | city
-----+------+-----+------
(0 rows)

ajdb20=# SELECT * FROM student WHERE city = 'PUNE' ORDER BY per DESC;

 rno | name | per | city
-----+------+-----+------
   6 | FFF  | 95  | PUNE
   1 | AAA  | 70  | PUNE
   7 | GGG  | 45  | PUNE
(3 rows)

--> order of evaluation of query --> SELECT * FROM student WHERE city = 'PUNE' ORDER BY per DESC;
-->                                       FROM --> WHERE --> SELECT --> ORDER BY

ajdb20=# SELECT * FROM student WHERE per>=65;

 rno | name | per |   city
-----+------+-----+----------
   1 | AAA  |  70 | PUNE
   5 | EEE  |  87 | BANGLORE
   6 | FFF  |  95 | PUNE
   8 | BBB  |  73 | DELHI

ajdb20=# SELECT * FROM student WHERE per>=60 AND per<70;

 rno | name | per | city
-----+------+-----+-------
   4 | DDD  |  64 | DELHI
(1 row)

--> same query using between clause 

ajdb20=# SELECT * FROM student WHERE per BETWEEN 60 AND 70;

 rno | name | per | city
-----+------+-----+-------
   1 | AAA  |  70 | PUNE
   4 | DDD  |  64 | DELHI
(2 rows)
--> it has a flaw that 70 is included 
--> Solution :

ajdb20=# SELECT * FROM student WHERE per BETWEEN 60 AND 69.99;

 rno | name | per | city
-----+------+-----+-------
   4 | DDD  |  64 | DELHI
(1 row)


ajdb20=# SELECT * FROM student WHERE city BETWEEN 'BANGLORE' AND 'MUMBAI' ;
--> BETWEEN 'BANGLORE' AND 'MUMBAI'; is city >= 'BANGLORE' AND city <= 'MUMBAI' i.e. greater than B and lesser than M , intersection exist here
 rno | name | per |   city
-----+------+-----+----------
   3 | CCC  |  50 | MUMBAI
   4 | DDD  |  64 | DELHI
   5 | EEE  |  87 | BANGLORE
   8 | BBB  |  73 | DELHI
(4 rows)
--> Gave all the cities starting from alphabet that comes between 'B'(of BANGLORE) and 'M'(of MUMBAI)

ajdb20=# SELECT * FROM student WHERE city BETWEEN 'MUMBAI' AND 'BANGLORE' ;

 rno | name | per | city
-----+------+-----+------
(0 rows)
--> Because BETWEEN 'MUMBAI' AND 'BANGLORE' ; is city >= 'MUMBAI' AND city <= 'BANGLORE' that means between greater than M and lesser than B , there is no intersection in it.

ajdb20=# SELECT * FROM student WHERE city = 'PUNE' OR city = 'MUMBAI' ;

 rno | name | per |  city
-----+------+-----+--------
   1 | AAA  |  70 | PUNE
   3 | CCC  |  50 | MUMBAI
   6 | FFF  |  95 | PUNE
   7 | GGG  |  45 | PUNE
(4 rows)

--> ALTERNATIVE OF THIS QUERY

ajdb20=# SELECT * FROM student WHERE city IN ('PUNE' , 'MUMBAI');
 rno | name | per |  city
-----+------+-----+--------
   1 | AAA  |  70 | PUNE
   3 | CCC  |  50 | MUMBAI
   6 | FFF  |  95 | PUNE
   7 | GGG  |  45 | PUNE
(4 rows)

--> Cities other tha Pune and Mumbai

ajdb20=# SELECT * FROM student WHERE city NOT IN ('PUNE' , 'MUMBAI');
 rno | name | per |   city
-----+------+-----+----------
   2 | BBB  |  29 | PANJI
   4 | DDD  |  64 | DELHI
   5 | EEE  |  87 | BANGLORE
   8 | BBB  |  73 | DELHI
(4 rows)

--> Cities other than pune

ajdb20=# SELECT * FROM student WHERE city != 'PUNE';
 rno | name | per |   city
-----+------+-----+----------
   2 | BBB  |  29 | PANJI
   3 | CCC  |  50 | MUMBAI
   4 | DDD  |  64 | DELHI
   5 | EEE  |  87 | BANGLORE
   8 | BBB  |  73 | DELHI
(5 rows)

--> alternative of NOT IN

ajdb20=# SELECT * FROM student WHERE city != 'PUNE' AND city != 'MUMBAI';
 rno | name | per |   city
-----+------+-----+----------
   2 | BBB  |  29 | PANJI
   4 | DDD  |  64 | DELHI
   5 | EEE  |  87 | BANGLORE
   8 | BBB  |  73 | DELHI
(4 rows)








