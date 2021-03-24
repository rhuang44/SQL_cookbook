-- Basic syntax
-- Select statement: return a set of rows 

-- SELECT column_name AS column_alias
-- FROM table_name
-- WHERE condition
-- GROUP BY column_name
-- HAVING aggregate_function(column_name) operator value
-- ORDER BY column_name [ASC|DESC];


show databases;
use album;
show tables;
select * from album;
select * from track;

-- album released before year 2000
select *
from album 
where year(released) < 2000;

-- number of tracks for each album which was released before year 2000
-- method 1: inner join
select a.id as album_id, max(t.track_number) as track_cnt
from album as a
join track as t
on a.id = t.album_id
where year(a.released) < 2000
group by t.album_id
order by track_cnt desc, a.id;

-- method2: searching within a result set
select album_id, max(track_number) track_cnt
from track
where album_id in (
	select id
	from album 
	where year(released) < 2000
)
group by album_id
order by track_cnt desc, album_id;

-- method 3: use subquery
select tmp.id as album_id, max(t.track_number) as track_cnt
from track as t
join (
	select *
	from album 
	where year(released) < 2000
) as tmp
on t.album_id = tmp.id
group by t.album_id
order by track_cnt desc, album_id;
