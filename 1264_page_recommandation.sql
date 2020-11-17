--1264 Page Recommendations
create table friendship
(
user1_id int,
user2_id int
);

create table likes
(
user_id int,
page_id int
);

insert into friendship 
values
(1,2),
(1,3),
(1,4),
(2,3),
(2,4),
(2,5),
(6,1);

insert into likes
values
(1,88),
(2,23),
(3,24),
(4,56),
(5,11),
(6,33),
(2,77),
(3,77),
(6,88);


with friends as (select distinct user2_id from friendship
where user1_id = 1 
union
select distinct user1_id from friendship
where user2_id = 1)
select distinct page_id 
from likes
where page_id <> (select page_id from likes where user_id = 1)
and user_id in (
select * from friends
);

