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
(8 rows)

ajdb20=# UPDATE student SET per = 43 , city = 'PUNE' WHERE rno = 3;
UPDATE 1 --> 1 means only 1 record is affected
ajdb20=# select * from student;

 rno | name | per |   city
-----+------+-----+----------
   1 | AAA  |  70 | PUNE
   2 | BBB  |  29 | PANJI
   4 | DDD  |  64 | DELHI
   5 | EEE  |  87 | BANGLORE
   6 | FFF  |  95 | PUNE
   7 | GGG  |  45 | PUNE
   8 | BBB  |  73 | DELHI
   3 | CCC  |  43 | PUNE
(8 rows)
--> updated record comes at bottom

--> if we dont write where i.e.
ajdb20=# UPDATE student SET per = 43 , city = 'PUNE';
UPDATE 8 --> 8 means 8 record is affected 

ajdb20=# select * from student;

 rno | name | per |   city
-----+------+-----+----------
   1 | AAA  |  43 | PUNE
   2 | BBB  |  43 | PUNE
   4 | DDD  |  43 | PUNE
   5 | EEE  |  43 | PUNE
   6 | FFF  |  43 | PUNE
   7 | GGG  |  43 | PUNE
   8 | BBB  |  43 | PUNE
   3 | CCC  |  43 | PUNE
(8 rows)
--> all records per and city will be set to 43 and PUNE respectively


ajdb20=# UPDATE student SET per = 87 WHERE rno = 2 RETURNING *;

 rno | name | per | city
-----+------+-----+-------
   2 | BBB  |  87 | PANJI
(1 row)
--> RETURNING * means return all columns of rno = 2

--> Q.Student with name = CCC increase his marks by 5

ajdb20=# UPDATE student set per = per + 5 WHERE name = 'CCC';
UPDATE 1

ajdb20=# select * from student;

 rno | name | per |   city
-----+------+-----+----------
   1 | AAA  |  70 | PUNE
   4 | DDD  |  64 | DELHI
   5 | EEE  |  87 | BANGLORE
   6 | FFF  |  95 | PUNE
   7 | GGG  |  45 | PUNE
   8 | BBB  |  73 | DELHI
   2 | BBB  |  87 | PANJI
   3 | CCC  |  48 | PUNE
(8 rows)

--> Q. Increase marks of students by 5 those who have failed (marks<=50)

ajdb20=# UPDATE student set per = per + 5 WHERE per <= 50;
UPDATE 2

ajdb20=# select * from student;

 rno | name | per |   city
-----+------+-----+----------
   1 | AAA  |  70 | PUNE
   4 | DDD  |  64 | DELHI
   5 | EEE  |  87 | BANGLORE
   6 | FFF  |  95 | PUNE
   8 | BBB  |  73 | DELHI
   2 | BBB  |  87 | PANJI
   7 | GGG  |  50 | PUNE
   3 | CCC  |  53 | PUNE
(8 rows)


--> DELETE : This sql commands removes record from table
--> ------

ajdb20=# DELETE FROM student WHERE rno = 2;
DELETE 1 --> 1 record deleted

ajdb20=# select * from student;
 rno | name | per |   city
-----+------+-----+----------
   1 | AAA  |  70 | PUNE
   4 | DDD  |  64 | DELHI
   5 | EEE  |  87 | BANGLORE
   6 | FFF  |  95 | PUNE
   8 | BBB  |  73 | DELHI
   7 | GGG  |  50 | PUNE
   3 | CCC  |  53 | PUNE
(7 rows)

ajdb20=# DELETE FROM student WHERE rno = 6 RETURNING *;

 rno | name | per | city
-----+------+-----+------
   6 | FFF  |  95 | PUNE
(1 row)
DELETE 1

ajdb20=# select * from student;
 rno | name | per |   city
-----+------+-----+----------
   1 | AAA  |  70 | PUNE
   4 | DDD  |  64 | DELHI
   5 | EEE  |  87 | BANGLORE
   8 | BBB  |  73 | DELHI
   7 | GGG  |  50 | PUNE
   3 | CCC  |  53 | PUNE
  10 | XXX  |     | PUNE
(7 rows)

ajdb20=# DELETE FROM student WHERE per IS NULL;
DELETE 1

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

DELETE FROM  student --> deletes all record from student
--> but it is time consuming when we have to delete all records 
--> to delete all record from table , use "TRUNCATE"

TRUNCATE FROM student;

--> on doing DELETE FROM student ---> at background database perform logging operation or it deletes record one by one 
--> logging files helps when we are performing a transaction and till one point all delete operation are done
--> but then failure occurs , and you have to rollback at that time this logging files hepls to restore the deleted records

--> on doing TRUNCATE FROM student ---> at once the whole tables record are deleted and those record cannot be restored


















