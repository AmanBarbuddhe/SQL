--***** TIME DATA TYPE *****--

postgres=# \c studentsdb;
You are now connected to database "studentsdb" as user "root".

studentsdb=# CREATE TABLE session(
studentsdb(# sid int PRIMARY KEY,
studentsdb(# session_name VARCHAR(20),
studentsdb(# start_at TIME NOT NULL,
studentsdb(# end_at TIME NOT NULL
studentsdb(# );
CREATE TABLE

studentsdb=# INSERT INTO session VALUES (101 , 'SQL-PLSQL' , '20:08:00' , '21:00:00');
INSERT 0 1

studentsdb=# INSERT INTO session VALUES (102 , 'Advance Java' , '19:00:00' , '20:05:00');
INSERT 0 1

studentsdb=# INSERT INTO session VALUES (103 , 'Hibernate' , '21:15:00' , '22:30:00');
INSERT 0 1

studentsdb=# SELECT * FROM session;

 sid | session_name | start_at |  end_at
-----+--------------+----------+----------
 101 | SQL-PLSQL    | 20:08:00 | 21:00:00
 102 | Advance Java | 19:00:00 | 20:05:00
 103 | Hibernate    | 21:15:00 | 22:30:00
(3 rows)

--> To get current time
studentsdb=# SELECT LOCALTIME;
    localtime
-----------------
 12:57:41.758891
(1 row)

--> To not include millisecond
studentsdb=# SELECT LOCALTIME(0);
 localtime
-----------
 12:57:49
(1 row)

studentsdb=# ALTER TABLE session ALTER COLUMN start_at SET DEFAULT LOCALTIME(0);
ALTER TABLE

studentsdb=# \d session;

                           Table "public.session"
    Column    |          Type          | Collation | Nullable |   Default
--------------+------------------------+-----------+----------+--------------
 sid          | integer                |           | not null |
 session_name | character varying(20)  |           |          |
 start_at     | time without time zone |           | not null | LOCALTIME(0)
 end_at       | time without time zone |           | not null |
Indexes:
    "session_pkey" PRIMARY KEY, btree (sid)


studentsdb=# INSERT INTO session (sid,session_name,end_at) VALUES (104,'Core-Java','22:30:00');
INSERT 0 1

studentsdb=# SELECT * FROM session;

 sid | session_name | start_at |  end_at
-----+--------------+----------+----------
 101 | SQL-PLSQL    | 20:08:00 | 21:00:00
 102 | Advance Java | 19:00:00 | 20:05:00
 103 | Hibernate    | 21:15:00 | 22:30:00
 104 | Core-Java    | 13:01:50 | 22:30:00
(4 rows)

--***** EXTRACT FUNCTION *****--

studentsdb=# SELECT EXTRACT(HOUR FROM LOCALTIME) as hours;
 hours
-------
    13
(1 row)


studentsdb=# SELECT EXTRACT(MINUTES FROM LOCALTIME) as min;
 min
-----
   6
(1 row)

studentsdb=# SELECT EXTRACT(SECONDS FROM LOCALTIME) as sec;
    sec
-----------
 44.135177
(1 row)


studentsdb=# SELECT EXTRACT(MILLISECONDS FROM LOCALTIME) as ms;
    ms
-----------
 57605.851
(1 row)


studentsdb=# SELECT EXTRACT(SECONDS FROM LOCALTIME(0)) as sec;
    sec
-----------
 14.000000
(1 row)

--***** To Calculate Time after 'x' hours *****--

studentsdb=# SELECT LOCALTIME(0);
 localtime
-----------
 13:09:36
(1 row)

studentsdb=# SELECT LOCALTIME(0) + INTERVAL '2 hours' as End_Time;
 end_time
----------
 15:09:26
(1 row)

--> ***** Extra Information *****

studentsdb=# CREATE TABLE session(
studentsdb(# sid int PRIMARY KEY,
studentsdb(# session_name VARCHAR(20),
studentsdb(# start_at TIME NOT NULL,
studentsdb(# end_at TIME -----------------> end time not specified as NOT NULL
studentsdb(# );

--> Take the scenario of Google Meet , Start time is specified as current time , but we dont know when to end session

--> INSERT INTO session(sid,session_name) VALUES (101,'ADV-JAVA');

-->   sid | session_name | start_at |  end_at
     -----+--------------+----------+----------
-->   101 | SQL-PLSQL    | 20:08:00 | null

--> Now lets say session has ended , therefore

--> UPDATE session SET end_at = LOCALTIME(0) WHERE sid = 101;  ---> this will tell current time at which session has ended

--> INSERT INTO session(sid,session_name) VALUES (101,'ADV-JAVA'); , UPDATE session SET end_at = LOCALTIME(0) WHERE sid = 101; , this is a transaction because one operation(ex: taking a google meet) is made up of multiple sql queries(two quries are reqired to decide start time and end time of same google meet)

--> **************** Time-Stamp *****************

ajdb20=# CREATE TABLE registration(
ajdb20(# ts TIMESTAMP PRIMARY KEY,      --> time stamp as primary key because no two registration will be at same time due to different values of milliseconds
ajdb20(# name VARCHAR(10),
ajdb20(# phno VARCHAR(10)
ajdb20(# );
CREATE TABLE

ajdb20=# INSERT INTO registration VALUES(now() , 'Aman' , 8446379034);
INSERT 0 1

ajdb20=# select * from registration;
             ts             | name |    phno
----------------------------+------+------------
 2026-03-27 15:46:51.672139 | Aman | 8446379034
(1 row)

--> ***** TIME-STAMP With Zone(ts "TIMESTAMP WITH TIME ZONE PRIMARY KEY") *****

ajdb20=# CREATE TABLE registration(
ajdb20(# ts TIMESTAMP WITH TIME ZONE PRIMARY KEY,      --> time stamp as primary key because no two registration will be at same time due to different values of milliseconds
ajdb20(# name VARCHAR(10),
ajdb20(# phno VARCHAR(10)
ajdb20(# );
CREATE TABLE

ajdb20=# INSERT INTO registration VALUES(now() , 'Aman' , 8446379034);
INSERT 0 1

ajdb20=# select * from registration;

                ts                | name |    phno
----------------------------------+------+------------
 2026-03-27 15:55:51.770975+05:30 | Aman | 8446379034
(1 row)












