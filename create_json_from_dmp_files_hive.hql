create table biwa_sales_json as
select 
  CONCAT('{ ', 
  'sales_id: "', sales_id, '", ',
  'cust_id: "', cust_id, '", ',
  'amount: "', amount,
  '" }') as val
from biwa_sales;