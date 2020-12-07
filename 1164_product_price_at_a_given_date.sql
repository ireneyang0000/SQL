----solution1
with max_price as (select a.product_id,b.new_price
from
(select product_id,max(change_date) as change_date
from products
where change_date <= '2019-08-16'
group by 1) a
left join products b
on a.product_id = b.product_id
and a.change_date = b.change_date),
initial as (
select distinct product_id, 10 as price
    from products
)
select b.product_id,coalesce(a.new_price,b.price) as price
from max_price a
right join initial b
on a.product_id = b.product_id

 
---solution2 use rank instead of 
select distinct a.product_id, coalesce(b.new_price, 10) as price from Products as a
left join
(select product_id, rank() over(partition by product_id order by change_date DESC) as xrank, new_price from Products
where change_date<='2019-08-16') as b
on a.product_id=b.product_id and b.xrank=1
order by 2 DESC
