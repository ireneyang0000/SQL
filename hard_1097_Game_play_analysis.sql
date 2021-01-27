------	1097	 Game Play Analysis V
create table activity
(
player_id int,
device_id int,
event_date date,
games_played int

)
;

insert into activity
values
(1,2,'2016-03-01',5),
(1,2,'2016-03-02',6),
(2,3,'2017-06-25',1),
(3,1,'2016-03-01',0),
(3,4,'2016-07-03',5);


select a.day as install_dt,count(a.player_id) as installs,round((sum(case when b.games_played is not null then 1 else 0 end)/count(a.player_id)),2)  as Day1_retention
from
(select distinct player_id, min(event_date) as day
    from activity
    group by 1) a
left join activity b
on a.player_id = b.player_id
and a.day = b.event_date - 1
group by 1