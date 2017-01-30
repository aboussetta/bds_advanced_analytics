This is step by step instruction how to reproduce this usecase:
1) Using generate data.sql generate data
2) offload it to Hadoop by copy_data_from_db_to_hadoop.txt
3) Create metadata over just moved data by create_hive_dmp_table.hql
4) Convert to the JSON data by create_json_from_dmp_files_hive.hql
5) In the Data Miner import the BigSpender.xml workflow
