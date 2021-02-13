-- THREE IN A ROW

-- The attendance table logs the number of people counted in a crowd each day an event is held. 
-- Write a query to return a table showing the date and visitor count of high-attendance periods, 
-- defined as three consecutive entries (not necessarily consecutive dates) with more than 100 visitors

create database if not exists practicedb;
use practicedb;

create table if not exists attendance_t (
event_date date, 
visitors integer
);
/*
insert into attendance_t (event_date, visitors) 
VALUES 
(CAST('20-01-01' AS date), 10), 
(CAST('20-01-04' AS date), 109), 
(CAST('20-01-05' AS date), 150), 
(CAST('20-01-06' AS date), 99), 
(CAST('20-01-07' AS date), 145), 
(CAST('20-01-08' AS date), 1455), 
(CAST('20-01-11' AS date), 199),
(CAST('20-01-12' AS date), 188);
*/
select * from attendance_t;

with t1 as(
-- select * , (case when visitors > 100 then 1 else 0 end) as large from )
select * ,row_number()over( order by event_date) row_att from attendance_t
),
t2 as (
select* from t1 where visitors > 100
),
t3 as (
select a.row_att as day1,b.row_att as day2,c.row_att as day3
from t2 a
join t2 b on a.row_att = b.row_att - 1
join t2 c on a.row_att = c.row_att - 2 
)
select event_date, visitors 
from t1 
where row_att in (select day1 from t3) 
or row_att in (select day2 from t3) 
or row_att in (select day3 from t3);

