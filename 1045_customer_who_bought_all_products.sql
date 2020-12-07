SELECT DISTINCT customer_id FROM Customer WHERE customer_id NOT IN (
SELECT customer_id FROM (
SELECT DISTINCT * FROM 
(SELECT DISTINCT customer_id FROM Customer) C
CROSS JOIN Product P) C2
WHERE (customer_id,product_key) NOT IN (SELECT customer_id,product_key FROM Customer))