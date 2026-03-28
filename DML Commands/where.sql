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



--> ==================================
--> Pattern Matching using LIKE clause
--> ==================================

--> when we want to match pattern LIKE clause is used

% --> Any no. of characters
_ --> Any single character


P% --> Your city name is starting from pune
P%E --> City starting with 'P' and End with 'E'
_A%E --> 1st character can be anything but only single character can be there , 2nd character should be 'A' , in middle any no. of any character , end should be with 'E'
--> ex : BANGLORE

ajdb20=# select * from student where city LIKE 'P%';

 rno | name | per | city
-----+------+-----+-------
   1 | AAA  |  70 | PUNE
   2 | BBB  |  29 | PANJI
   6 | FFF  |  95 | PUNE
   7 | GGG  |  45 | PUNE
(4 rows)


ajdb20=# select * from student where city LIKE '_A%E';

 rno | name | per |   city
-----+------+-----+----------
   5 | EEE  |  87 | BANGLORE
(1 row)

ajdb20=# select * from student where city LIKE '____'; --> any city made from 4 characters

 rno | name | per | city
-----+------+-----+------
   1 | AAA  |  70 | PUNE
   6 | FFF  |  95 | PUNE
   7 | GGG  |  45 | PUNE
(3 rows)

ajdb20=# select * from student where city LIKE '_____';  --> any city made from 4 characters
 rno | name | per | city
-----+------+-----+-------
   2 | BBB  |  29 | PANJI
   4 | DDD  |  64 | DELHI
   8 | BBB  |  73 | DELHI
(3 rows)

ajdb20=# select * from student where city LIKE '_A___';

 rno | name | per | city
-----+------+-----+-------
   2 | BBB  |  29 | PANJI
(1 row)

ajdb20=# select * from student where city NOT LIKE '_A___';

 rno | name | per |   city
-----+------+-----+----------
   1 | AAA  |  70 | PUNE
   3 | CCC  |  50 | MUMBAI
   4 | DDD  |  64 | DELHI
   5 | EEE  |  87 | BANGLORE
   6 | FFF  |  95 | PUNE
   7 | GGG  |  45 | PUNE
   8 | BBB  |  73 | DELHI
(7 rows)


--> **************** Pattern Matching using LIKE clause in Table creation(CHECK constraint)****************

CREATE TABLE Student(

   ph text CHECK ((ph LIKE '7%' OR ph LIKE '8%' OR ph LIKE '9%') AND (length(ph)=10))
                     (start with 7 or 8 or 9)
)
                                                      OR
CREATE TABLE Student(

   ph text CHECK ((ph LIKE '7_________' OR ph LIKE '8_________' OR ph LIKE '9_________'))
                     (start with 7 or 8 or 9)
)

--->  !=    and    <>    are both same 

--> How to display records where percentage is null? --> using IS keyword
                      
ajdb20=# select * from student;

 rno | name | per |   city
-----+------+-----+----------
   1 | AAA  |  70 | PUNE
   2 | BBB  |  29 | PANJI
   3 | CCC  |  50 | MUMBAI
   4 | DDD  |  64 | DELHI
   5 | EEE  |  87 | BANGLORE
   6 | FFF  |  95 | PUNE
   7 | GGG  |  45 | PUNE
   8 | BBB  |  73 | DELHI
   9 | HHH  |     | PUNE
(9 rows)

ajdb20=# select * from student WHERE per IS NULL;

 rno | name | per | city
-----+------+-----+------
   9 | HHH  |     | PUNE
(1 row)

ajdb20=# select * from student WHERE per IS NOT NULL;

 rno | name | per |   city
-----+------+-----+----------
   1 | AAA  |  70 | PUNE
   2 | BBB  |  29 | PANJI
   3 | CCC  |  50 | MUMBAI
   4 | DDD  |  64 | DELHI
   5 | EEE  |  87 | BANGLORE
   6 | FFF  |  95 | PUNE
   7 | GGG  |  45 | PUNE
   8 | BBB  |  73 | DELHI
(8 rows)

--> **************** To ignore case(uppercase/lowercase) use "ILIKE" ****************

ajdb20=# select * from student WHERE city ILIKE 'p%';
 rno | name | per | city
-----+------+-----+-------
   1 | AAA  |  70 | PUNE
   2 | BBB  |  29 | PANJI
   6 | FFF  |  95 | PUNE
   7 | GGG  |  45 | PUNE
   9 | HHH  |     | PUNE
(5 rows)


ajdb20=# select * from student WHERE city ILIKE 'P%';
 rno | name | per | city
-----+------+-----+-------
   1 | AAA  |  70 | PUNE
   2 | BBB  |  29 | PANJI
   6 | FFF  |  95 | PUNE
   7 | GGG  |  45 | PUNE
   9 | HHH  |     | PUNE
(5 rows)

--> LIKE : 1)It is case sensitive pattern matching clause , i.e 'P%' your string must start with 'P' , 'p' is not allowed 

--> ILIKE : 1)It is case in-sensitive pattern matching clause , and it works in psql not it MySql



















