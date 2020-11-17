---	1421	 NPV Queries 
create table NPV(
id INTEGER,
year INTEGER,
npv INTEGER
);

create table Queries(
id INTEGER,
year INTEGER
);

insert into npv
values
(1,2018,100),
(7,2020,30),
(13,2019,40),
(1,2019,113),
(2,2008,121),
(3,2009,12),
(11,2020,99),
(7,2019,0);


insert into Queries
VALUES
(1,2019),
(2,2008),
(3,2009),
(7,2018),
(7,2019),
(7,2020),
(13,2019);


select 	q.id,q.year, coalesce(n.npv , 0)
from queries q
left join npv n
on n.id = q.id
and n.year = q.year
order by 1 ;

select * from npv;
drop table npv
;

