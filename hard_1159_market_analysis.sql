with sales_history as (select orders.order_id,orders.order_date,
                       orders.item_id,items.item_brand ,seller_id,
                       favorite_brand,
                       row_number()  over (partition by orders.seller_id order by order_date) as cnt
from orders 
left join items
on items.item_id = orders.item_id
left join users
on users.user_id = orders.seller_id
 ) ,
 quilified_seller as
(select distinct seller_id from sales_history
where cnt = 2 and favorite_brand = item_brand )
select seller_id, 'yes' as 2nd_item_fav_brand
from quilified_seller
union 
select user_id as seller_id, 'no' as 2nd_item_fav_brand
from Users
where user_id not in (select distinct seller_id from quilified_seller
)
order by 1 