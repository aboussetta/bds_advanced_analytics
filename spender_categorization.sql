WITH big_spenders AS
 (SELECT 
   cust_id,
   SUM(amount) amt,
   'big spender' spending
    FROM biwa_sales_json_col_view
   GROUP BY cust_id
   ORDER BY SUM(amount) DESC FETCH FIRST 5 PERCENT ROW ONLY),
low_spenders AS
 (SELECT 
   cust_id,
   SUM(amount) amt,
   'low spender' spending
    FROM biwa_sales_json_col_view
   GROUP BY cust_id
   ORDER BY SUM(amount) FETCH FIRST 5 PERCENT ROW ONLY)
SELECT
 *
  FROM big_spenders
UNION ALL
SELECT 
 *
  FROM low_spenders
UNION ALL
SELECT
 cust_id,
 SUM(amount) amt,
 'med spender' spending
  FROM biwa_sales_json_col_view
 WHERE cust_id NOT IN
 (SELECT cust_id FROM low_spenders UNION ALL SELECT cust_id FROM big_spenders)
 GROUP BY cust_id
