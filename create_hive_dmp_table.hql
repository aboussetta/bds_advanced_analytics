CREATE EXTERNAL TABLE BIWA_SALES 
ROW FORMAT
   SERDE 'oracle.hadoop.hive.datapump.DPSerDe'
STORED AS
   INPUTFORMAT  'oracle.hadoop.hive.datapump.DPInputFormat'
   OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION '/user/root/biwa_sales_hdp';