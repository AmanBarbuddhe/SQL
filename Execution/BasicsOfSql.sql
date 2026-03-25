mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| ajb20              |
| information_schema |
| librarydb          |
| mysql              |
| performance_schema |
| sys                |
| xyz                |
+--------------------+

mysql> CREATE DATABASE studentdb;
Query OK, 1 row affected (0.01 sec)
    
mysql> use studentdb;
Database changed

mysql> CREATE TABLE students(
    -> rno int ,
    -> name varchar(10),
    -> per float
    -> );

Query OK, 0 rows affected (0.04 sec)

mysql> DESCRIBE students;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| rno   | int         | YES  |     | NULL    |       |
| name  | varchar(10) | YES  |     | NULL    |       |
| per   | float       | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
3 rows in set (0.02 sec)

mysql> INSERT INTO students VALUES (101 , 'AAA' , 89.43) , (102 , 'BBB' , 74.87) , (103 , 'CCC' , 63.45) , (104 , 'DDD' , 97.23);
Query OK, 4 rows affected (0.03 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM students;
+------+------+-------+
| rno  | name | per   |
+------+------+-------+
|  101 | AAA  | 89.43 |
|  102 | BBB  | 74.87 |
|  103 | CCC  | 63.45 |
|  104 | DDD  | 97.23 |
+------+------+-------+
4 rows in set (0.00 sec)

--****** IF WE WANT TO ADD SPECIFIC COLUMNS RECORD ******

mysql> INSERT INTO students (rno , per) VALUES (101  , 89.43);
Query OK, 1 row affected (0.00 sec)

mysql> SELECT * FROM students;
+------+------+-------+
| rno  | name | per   |
+------+------+-------+
|  101 | AAA  | 89.43 |
|  102 | BBB  | 74.87 |
|  103 | CCC  | 63.45 |
|  104 | DDD  | 97.23 |
|  101 | NULL | 89.43 |
+------+------+-------+
5 rows in set (0.00 sec)

mysql> INSERT INTO students (rno , name) VALUES (101  , 'FFF');
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * FROM students;
+------+------+-------+
| rno  | name | per   |
+------+------+-------+
|  101 | AAA  | 89.43 |
|  102 | BBB  | 74.87 |
|  103 | CCC  | 63.45 |
|  104 | DDD  | 97.23 |
|  101 | NULL | 89.43 |
|  101 | FFF  |  NULL |
+------+------+-------+
6 rows in set (0.00 sec)

--****** IF WE WANT TO SEE SPECIFIC COLUMNS RECORD ******


mysql> SELECT rno , name  FROM students;
+------+------+
| rno  | name |
+------+------+
| 101  | AAA  |
| 102  | BBB  |
| 103  | CCC  |
| 104  | DDD  |
| 101  | NULL |
| 101  | FFF  |
+------+------+
6 rows in set (0.00 sec)

mysql> DROP TABLE students;
Query OK, 0 rows affected (0.02 sec)

mysql> DROP DATABASE studentdb;
Query OK, 0 rows affected (0.01 sec)

----> DROP TABLE REMOVES TABLE FROM DATABASE
----> DELETE TABLE REMOVES RECORDS FROM TABLE

