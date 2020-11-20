----1635	 Hopper Company Queries I
create table drivers
(
driver_id int,
join_date date
);

create table rides
(
ride_id int,
user_id int,
requested_at date
);


create table acceptedrides
(
ride_id int,
driver_id int,
ride_distance int,
ride_duration int
);

insert into drivers 
values
(10,'2019-12-10'),
(8,'2020-1-13'),
(5,'2020-2-16'),
(7,'2020-3-8'),
(4,'2020-5-17'),
(1,'2020-10-24'),
(6,'2021-1-5');

insert into Rides 
values
(6,75,'2019-12-9'),
(1,54,'2020-2-9'),
(10,63,'2020-3-4'),
(19,39,'2020-4-6'),
(3,41,'2020-6-3'),
(13,52,'2020-6-22'),
(7,69,'2020-7-16'),
(17,70,'2020-8-25'),
(20,81,'2020-11-2'),
(5,57,'2020-11-9'),
(2,42,'2020-12-9'),
(11,68,'2021-1-11'),
(15,32,'2021-1-17'),
(12,11,'2021-1-19'),
(14,18,'2021-1-27');


insert into AcceptedRides
values
(10,10,63,38),
(13,10,73,96),
(7,8,100,28),
(17,7,119,68),
(20,1,121,92),
(5,7,42,101),
(2,4,6,38),
(11,8,37,43),
(15,8,108,82),
(12,8,38,34),
(14,1,90,74);

with driver as 
(
select EXTRACT(MONTH from join_date), count(driver_id)
from drivers
group by 1
)
select * from driver;

with driver_incre as 
(select EXTRACT(MONTH from join_date) as month,count(driver_id) OVER (
                         ORDER BY EXTRACT(MONTH from join_date)) AS cum_amt
from drivers
where join_date between '2020-01-01' and '2021-01-01'
)
,
driver_before_2020 as 
(
select count(driver_id)
from drivers
where join_date < '2020-01-01'
),
ac_ride as 
(
select EXTRACT(MONTH from requested_at) as month,count(distinct a.ride_id) numofride
from AcceptedRides a
left join rides
on a.ride_id =rides.ride_id
where  a.ride_id in (select driver_id from drivers )
group by 1
),
month as (SELECT generate_series(1,12) as m)
select month.m,coalesce(d.cum_amt,0), coalesce(ac_ride.numofride,0)
from month
left join driver_incre d
on month.m = d.month
left join ac_ride
on month.m = ac_ride.month
;

