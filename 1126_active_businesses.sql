----1126 active business 
create table events
(
business_id int,
event_type varchar,
occurences int
);

insert into events
values
(1,'reviews',7),
(3,'reviews',3),
(1,'ads',11),
(2,'ads',7),
(3,'ads',6),
(1,'pageviews',3),
(2,'pageviews',12);

with  average as
(
select event_type,avg(occurences) as avg
from events
group by 1
),
bus_id as (
select business_id, count(events.event_type ) over ( partition by business_id) as event_count from events
left join average
on events.event_type = average.event_type
where events.occurences > average.avg)
select distinct business_id
from bus_id
where event_count >1



