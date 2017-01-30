SELECT 
 *
  FROM (SELECT cust_id,
               SUM(amount) amt,
               'big spender' spending
          FROM biwa_sales_json_col_view
         GROUP BY cust_id
         ORDER BY SUM(amount) DESC FETCH FIRST 5 PERCENT ROW ONLY)
UNION ALL
SELECT 
 *
  FROM (SELECT
         cust_id,
         SUM(amount) amt,
         'low spender' spending
          FROM biwa_sales_json_col_view
         GROUP BY cust_id
         ORDER BY SUM(amount) FETCH FIRST 5 PERCENT ROW ONLY)
UNION ALL
SELECT cust_id,
       SUM(amount) amt,
       'med spender' spending
  FROM biwa_sales_json_col_view
 WHERE cust_id NOT IN
       (SELECT cust_id
          FROM (SELECT
                 cust_id,
                 SUM(amount) amt,
                 'low spender' spending
                  FROM biwa_sales_json_col_view
                 GROUP BY cust_id
                 ORDER BY SUM(amount) FETCH FIRST 5 PERCENT ROW ONLY)
        UNION ALL
        SELECT cust_id
          FROM (SELECT cust_id,
                       SUM(amount) amt,
                       'big spender' spending
                  FROM biwa_sales_json_col_view
                 GROUP BY cust_id
                 ORDER BY SUM(amount) DESC FETCH FIRST 5 PERCENT ROW ONLY))
 GROUP BY cust_id
