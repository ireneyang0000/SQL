--twitch
drop table streamer;


create  table streamer
(
time_minute timestamptz,
streamer_username varchar,
category varchar,
concurrent_viewers numeric
);

insert into streamer
values 
('2020-03-19 13:00:00','aaa','TTBHGD',133),
('2020-03-19 13:01:00','aaa','TTBHGD',45),
('2020-03-20 21:01:00','bbb','VGDH',129),
('2020-03-30 22:15:00','bbb','CCVF',17);
insert into streamer
values 
('2020-04-19 13:01:00','aaa','TTBHGD',45);
insert into streamer
values 
('2020-05-19 13:01:00','aaa','TTBHGD',45);

with total as (select count(*) as t
from streamer),
ccvf as (select count(*) a
from streamer 
where category = 'CCVF')
select ((select a from ccvf)/(select t from total));


With cte as
(Select streamer_username, extract(month from time_minute) as month, count(*) ct
From streamer
Group by 1,2)
Select *
From cte a left join cte b on a.month=b.month+1 and a.streamer_username = b.streamer_username

；

create table viewed
(
time_minute timestamptz,
viewer_username varchar,
viewer_country varchar,
streamer_username varchar
);

insert into viewed
values
('2020-03-19 13:00:00','ccc','US','aaa'),
('2020-03-19 13:01:00','ccc','US','aaa'),
('2020-03-20 21:01:00','ddd','JP','aaa'),
('2020-03-30 22:15:00','ddd','JP','aaa');

with average_concurrent as 
(
select streamer_username,extract(month from time_minute) as month, avg(concurrent_viewers)
from streamer
where 
group by 1,2
),



