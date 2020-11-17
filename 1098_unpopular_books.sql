create table books 
(
book_id int,
name varchar,
available_from date
);

create table orders_1098
(
order_id int,
book_id int,
quantity int,
dispatch_date date
);

insert into books
values
(1,'KalilaAndDemna','2010-01-01'),
(2,'28Letters','2012-05-12'),
(3,'TheHobbit','2019-06-10'),
(4,'13ReasonsWhy','2019-06-01'),
(5,'TheHungerGames','2008-09-21');

insert into orders_1098
values
(1,1,2,'2018-07-26'),
(2,1,1,'2018-11-05'),
(3,3,8,'2019-06-11'),
(4,4,6,'2019-06-05'),
(5,4,5,'2019-06-20'),
(6,5,9,'2009-02-02'),
(7,5,8,'2010-04-13');

select book.book_id,book.name
from (select * from books 
where books.available_from < '2019-05-23') 
book
left join (select book_id,sum(quantity) as quantity
from
orders_1098 
where dispatch_date >= '2018-06-23'
group by 1
) a 
on book.book_id = a.book_id

and a.quantity > 10;