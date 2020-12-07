with sale as (
select sale_date, sum(case when fruit = 'apples' then sold_num else 0 end) as Apple, sum(case when fruit = 'oranges' then sold_num else 0 end) as Orange
    from sales
    group by 1
)
select sale_date,sum(apple-orange) as diff
from sale
group by 1