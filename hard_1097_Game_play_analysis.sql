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


