postgres=# CREATE DATABASE studentsdb;
CREATE DATABASE
postgres=# \c studentsdb;
You are now connected to database "studentsdb" as user "root".

studentsdb=# CREATE TABLE student( 
    rno INT PRIMARY KEY NOT NULL , 
    name VARCHAR(20) , 
    birth_date DATE , 
    reg_date DATE NOT NULL DEFAULT CURRENT_DATE --> CURRENT_DATE is a default value 
);
CREATE TABLE

studentsdb=# \d student;
                          Table "public.student"
   Column   |         Type          | Collation | Nullable |   Default
------------+-----------------------+-----------+----------+--------------
 rno        | integer               |           | not null |
 name       | character varying(20) |           |          |
 birth_date | date                  |           |          |
 reg_date   | date                  |           | not null | CURRENT_DATE
Indexes:
    "student_pkey" PRIMARY KEY, btree (rno)


studentsdb=# INSERT INTO student (rno,name,birth_date) VALUES (101,'AAA','1947-08-15');
INSERT 0 1
--> its okay if you dont give reg_date as it is default
--> Default date format year-month-day

studentsdb=# INSERT INTO student (rno,name,birth_date) VALUES (102,'AAA','1980-05-28');
INSERT 0 1

studentsdb=# INSERT INTO student VALUES (103,'AAA','1980-05-28','2023-09-04');
INSERT 0 1
--> we can also manually mention reg_date

studentsdb=# SELECT * FROM student;
 rno | name | birth_date |  reg_date
-----+------+------------+------------
 101 | AAA  | 1947-08-15 | 2026-03-25
 102 | AAA  | 1980-05-28 | 2026-03-25
 103 | AAA  | 1980-05-28 | 2023-09-04
(3 rows)

studentsdb=# SELECT CURRENT_DATE;

 current_date
--------------
 2026-03-25
(1 row)
--> gives current date

studentsdb=# SELECT NOW();

               now
----------------------------------
 2026-03-25 11:34:24.173783+05:30
(1 row)
--> NOW() is a default function 
--> gives current date , current time , country zone
--> where 2026(year)-03(month)-25(day) 11(hour):34(minutes):24(seconds).173783(miliseconds)+05:30(Time zone)

studentsdb=# SELECT NOW()::DATE;
    now
------------
 2026-03-25
(1 row)

--> NOW()::DATE "is equivalent" to CURRENT_DATE , CURRENT_DATE is easy to use

--***** TO CUSTOMIZE THE FORMAT *****

studentsdb=# SELECT rno , name , TO_CHAR(birth_date , 'dd-mm-yyyy') AS birth_day , TO_CHAR(reg_date , 'dd-mm-yyyy') AS reg_date from student;
--> TO_CHAR is a function in PSQL not in Mysql   
--> TO_CHAR(birth_date , 'dd-mm-yyyy') and TO_CHAR(reg_date , 'dd-mm-yyyy') , birth_date and reg_date in TO_CHAR are column name as per declared in our database       
--> TO_CHAR(birth_date , 'dd-mm-yyyy') AS birth_day , here AS birth_day temporarily renames column name as birth_day , and if we do like TO_CHAR(birth_date , 'dd-mm-yyyy') then in display column name will be TO_CHAR instead of birth_date to avoid this "AS" is used                        

 rno | name | birth_day  |  reg_date
-----+------+------------+------------
 101 | AAA  | 15-08-1947 | 25-03-2026
 102 | AAA  | 28-05-1980 | 25-03-2026
 103 | AAA  | 28-05-1980 | 04-09-2023
(3 rows)

---------------------------------------------------------------------

studentsdb=# SELECT 2 + 3 AS Addition , 2*3 , 5679*67;
 addition | ?column? | ?column?
----------+----------+----------
        5 |        6 |   380493
(1 row)

--> select query doesn't need column_name or table_name to execute

---------------------------------------------------------------------

---***** TO CALCULATE AGE *****---

studentsdb=# SELECT name , birth_date , (CURRENT_DATE - birth_date) AS Age FROM student;
 name | birth_date |  age
------+------------+-------
 AAA  | 1947-08-15 | 28712
 AAA  | 1980-05-28 | 16737
 AAA  | 1980-05-28 | 16737
(3 rows)

--> gives age in days

studentsdb=# SELECT name , birth_date , (CURRENT_DATE - birth_date)/365 AS Age FROM student;
 name | birth_date | age
------+------------+-----
 AAA  | 1947-08-15 |  78
 AAA  | 1980-05-28 |  45
 AAA  | 1980-05-28 |  45
(3 rows)

--> gives age in years

--> but dont do it manually because sometimes year is of 364 days also , months are of 31 , 30 amd february sometimes 28 or 29  
--> to avoid this , do it in following way

studentsdb=# SELECT name , birth_date , AGE(CURRENT_DATE,birth_date) AS Age FROM student;

--> AGE(CURRENT_DATE,birth_date) , AGE is a build-in function , that takes bigger date i.e. current date , smaller date from where we want to calculate the interval
--> can also be used as     AGE('1947-08-15','25-03-2026')

 name | birth_date |           age
------+------------+-------------------------
 AAA  | 1947-08-15 | 78 years 7 mons 10 days
 AAA  | 1980-05-28 | 45 years 9 mons 28 days
 AAA  | 1980-05-28 | 45 years 9 mons 28 days
(3 rows)

--***** EXTRACT FUNCTION *****--

--> EXTRACTS each day month year separately

studentsdb=# SELECT CURRENT_DATE;
 current_date
--------------
 2026-03-25
(1 row)


studentsdb=# SELECT EXTRACT(DAY FROM CURRENT_DATE);
 extract
---------
      25
(1 row)


studentsdb=# SELECT EXTRACT(MONTH FROM CURRENT_DATE);
 extract
---------
       3
(1 row)


studentsdb=# SELECT EXTRACT(YEAR FROM CURRENT_DATE);
 extract
---------
    2026
(1 row)


studentsdb=# SELECT name , birth_date , EXTRACT(DAY FROM birth_date) AS Birthday FROM student;
 name | birth_date | birthday
------+------------+----------
 AAA  | 1947-08-15 |       15
 AAA  | 1980-05-28 |       28
 AAA  | 1980-05-28 |       28
(3 rows)

studentsdb=# SELECT name , birth_date , EXTRACT(DAY FROM birth_date) AS Birthday , EXTRACT(MONTH FROM birth_date) AS Month , EXTRACT(YEAR FROM birth_date) AS Year FROM student;
 name | birth_date | birthday | month | year
------+------------+----------+-------+------
 AAA  | 1947-08-15 |       15 |     8 | 1947
 AAA  | 1980-05-28 |       28 |     5 | 1980
 AAA  | 1980-05-28 |       28 |     5 | 1980
(3 rows)

