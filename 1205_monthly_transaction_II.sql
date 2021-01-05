with approved as 
(
select substring(trans_date,1,7) as month,country,count(*) as approved_count,sum(amount) as approved_amount
from Transactions
where state = 'approved'
group by 1,2
)
,
chargebacks as 
(
select substring(c.trans_date,1,7) as month,t.country,count(*) as chargeback_count,sum(amount) as chargeback_amount 
    from transactions t
    left join chargebacks c
    on t.id = c.trans_id
    group by 1,2
)
select b.month,b.country,coalesce(a.approved_count,0) as approved_count,coalesce(a.approved_amount,0) as approved_amount,coalesce(b.chargeback_count,0) as chargeback_count,coalesce(b.chargeback_amount,0) as chargeback_amount
from chargebacks b 
left join  approved a
on a.month = b.month
and a.country = b.country 
where b.month is not null
order by 1


---correct solution
SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month,
       country,
       SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
       SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_amount,
       SUM(CASE WHEN state = 'bc' THEN 1 ELSE 0 END) AS chargeback_count,
       SUM(CASE WHEN state = 'bc' THEN amount ELSE 0 END) AS chargeback_amount
FROM
(
    SELECT id, country, 'bc' AS state, amount, c.trans_date
    FROM Transactions t
    RIGHT JOIN Chargebacks c
    ON t.id = c.trans_id
UNION ALL
    SELECT id, country, state, amount, trans_date 
    FROM Transactions
) tem
GROUP BY country, DATE_FORMAT(trans_date, '%Y-%m')
HAVING approved_count + approved_amount + chargeback_count + chargeback_amount <> 0