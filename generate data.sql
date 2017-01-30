DROP sequence biwa_customers_seq;
create sequence biwa_customers_seq
minvalue 1
maxvalue 9999999999999999999
start with 1
increment by 1;
------------------------------
DROP sequence biwa_sales_seq;
create sequence biwa_sales_seq
minvalue 1
maxvalue 9999999999999999999
start with 1
increment by 1;
------------------------------
-- Customers table -----------
------------------------------
DROP TABLE biwa_customers;
CREATE TABLE biwa_customers
(ID NUMBER DEFAULT biwa_customers_seq.nextval,
 gender Varchar2(1), 
 age NUMBER, 
 anual_income NUMBER, 
 state VARCHAR2(2),
 phone NUMBER,
 cell_phone NUMBER,
 ca_street_name VARCHAR2(64),
 ca_street_type VARCHAR2(64),
 ca_city VARCHAR2(64),
 ca_location_type VARCHAR2(64),
 m_status VARCHAR2(64) 
 );
------------------------------
-- Fact table sales ----------
------------------------------
DROP TABLE biwa_sales;
CREATE TABLE biwa_sales(sales_id NUMBER DEFAULT biwa_sales_seq.nextval, cust_ID NUMBER, amount NUMBER);
----- Dictonary table ----------------
DROP TABLE state;
create table state (
  code char(2) not null,
  name varchar(64) not null
);
------------------------------
----- List of the States -----
------------------------------
insert into state (code,name) values ('AL','Alabama');
insert into state (code,name) values ('AK','Alaska');
insert into state (code,name) values ('AS','American Samoa');
insert into state (code,name) values ('AZ','Arizona');
insert into state (code,name) values ('AR','Arkansas');
insert into state (code,name) values ('CA','California');
insert into state (code,name) values ('CO','Colorado');
insert into state (code,name) values ('CT','Connecticut');
insert into state (code,name) values ('DE','Delaware');
insert into state (code,name) values ('DC','District of Columbia');
insert into state (code,name) values ('FM','Federated States of Micronesia');
insert into state (code,name) values ('FL','Florida');
insert into state (code,name) values ('GA','Georgia');
insert into state (code,name) values ('GU','Guam');
insert into state (code,name) values ('HI','Hawaii');
insert into state (code,name) values ('ID','Idaho');
insert into state (code,name) values ('IL','Illinois');
insert into state (code,name) values ('IN','Indiana');
insert into state (code,name) values ('IA','Iowa');
insert into state (code,name) values ('KS','Kansas');
insert into state (code,name) values ('KY','Kentucky');
insert into state (code,name) values ('LA','Louisiana');
insert into state (code,name) values ('ME','Maine');
insert into state (code,name) values ('MH','Marshall Islands');
insert into state (code,name) values ('MD','Maryland');
insert into state (code,name) values ('MA','Massachusetts');
insert into state (code,name) values ('MI','Michigan');
insert into state (code,name) values ('MN','Minnesota');
insert into state (code,name) values ('MS','Mississippi');
insert into state (code,name) values ('MO','Missouri');
insert into state (code,name) values ('MT','Montana');
insert into state (code,name) values ('NE','Nebraska');
insert into state (code,name) values ('NV','Nevada');
insert into state (code,name) values ('NH','New Hampshire');
insert into state (code,name) values ('NJ','New Jersey');
insert into state (code,name) values ('NM','New Mexico');
insert into state (code,name) values ('NY','New York');
insert into state (code,name) values ('NC','North Carolina');
insert into state (code,name) values ('ND','North Dakota');
insert into state (code,name) values ('MP','Northern Mariana Islands');
insert into state (code,name) values ('OH','Ohio');
insert into state (code,name) values ('OK','Oklahoma');
insert into state (code,name) values ('OR','Oregon');
insert into state (code,name) values ('PW','Palau');
insert into state (code,name) values ('PA','Pennsylvania');
insert into state (code,name) values ('PR','Puerto Rico');
insert into state (code,name) values ('RI','Rhode Island');
insert into state (code,name) values ('SC','South Carolina');
insert into state (code,name) values ('SD','South Dakota');
insert into state (code,name) values ('TN','Tennessee');
insert into state (code,name) values ('TX','Texas');
insert into state (code,name) values ('UT','Utah');
insert into state (code,name) values ('VT','Vermont');
insert into state (code,name) values ('VI','Virgin Islands');
insert into state (code,name) values ('VA','Virginia');
insert into state (code,name) values ('WA','Washington');
insert into state (code,name) values ('WV','West Virginia');
insert into state (code,name) values ('WI','Wisconsin');
insert into state (code,name) values ('WY','Wyoming');
COMMIT;
------------------------------
---- Gender table ------------
------------------------------
CREATE TABLE gender_tab AS 
SELECT 'M' AS gender FROM dual UNION SELECT 'F' AS gender FROM dual;
------------------------------
----- Address table ----------
------------------------------
CREATE TABLE biwa_address AS
SELECT ca_street_name,ca_street_type, ca_city,ca_location_type FROM customer_address_csv;
------------------------------
---- Marital status ----------
------------------------------
CREATE TABLE biwa_marital_status AS 
SELECT 'Married' AS m_status
  FROM dual
UNION ALL
SELECT 'Widowed' AS m_status
  FROM dual
UNION ALL
SELECT 'Separated' AS m_status
  FROM dual
UNION ALL
SELECT 'Divorced' AS m_status
  FROM dual
UNION ALL
SELECT 'Single' AS m_status
  FROM dual;
--------------------------------------------------
----- Generator for the customers table ----------
--------------------------------------------------
DECLARE
   rand_gender  VARCHAR2(1);
   rand_age     NUMBER;
   rand_anual_income NUMBER;
   rand_state   VARCHAR2(2);
   rand_phone NUMBER;
   rand_cell_phone NUMBER;
   rand_ca_street_name VARCHAR2(64);
   rand_ca_street_type VARCHAR2(64);
   rand_ca_city VARCHAR2(64);
   rand_ca_location_type VARCHAR2(64);
   rand_m_status VARCHAR2(64);
BEGIN
   FOR i IN 1 .. 5000 LOOP
      --------------------------------------------------
      -- Phone number
      --------------------------------------------------
      rand_phone:=trunc(DBMS_RANDOM.value(low  => 1000000,
                                              high => 9999999));
      -- Cell_phone number ------------------------------
      rand_cell_phone:=trunc(DBMS_RANDOM.value(low  => 1000000,
                                              high => 9999999));
      ------ State --------------------------------------
      SELECT CODE
        INTO rand_state
        FROM (SELECT * FROM state ORDER BY dbms_random.value)
       WHERE ROWNUM = 1;
      ------- Income -----------------------------------
      rand_anual_income := trunc(DBMS_RANDOM.value(low  => 50000,
                                              high => 150000));
      ------- Age ---------------------------------------
      rand_age := trunc(DBMS_RANDOM.value(low  => 20,
                                          high => 60));
      ---- Genger ---------------------------------------
      SELECT gender
        INTO rand_gender
        FROM (SELECT * FROM gender_tab ORDER BY dbms_random.value)
       WHERE ROWNUM = 1;
      ----- Address ---------------------------------------
         SELECT 
             ca_street_name,
             ca_street_type,
             ca_city,
             ca_location_type
        INTO rand_ca_street_name,
             rand_ca_street_type,
             rand_ca_city,
             rand_ca_location_type
        FROM (SELECT * FROM biwa_address sample (0.01) ORDER BY dbms_random.value)
       WHERE ROWNUM = 1;
      ---- Marial status ---------------------------------------
      SELECT m_status
        INTO rand_m_status
        FROM (SELECT * FROM biwa_marital_status ORDER BY dbms_random.value)
       WHERE ROWNUM = 1; 
      ----------------------------------------------
      INSERT INTO biwa_customers
         (gender, 
          age, 
          anual_income, 
          state,
          phone,
          cell_phone,
          ca_street_name,
          ca_street_type,
          ca_city,
          ca_location_type,
          m_status)
      VALUES
         (
          rand_gender, 
          rand_age, 
          rand_anual_income, 
          rand_state,
          rand_phone,
          rand_cell_phone,
          rand_ca_street_name,
          rand_ca_street_type,
          rand_ca_city,
          rand_ca_location_type,
          rand_m_status
         );
   END LOOP;
   COMMIT;
END;
/
--------------------------------------------
----- Generate Fact table ------------------
--------------------------------------------
TRUNCATE TABLE biwa_sales;

DECLARE
   CURSOR cust_list_cursor IS
      SELECT * FROM biwa_customers;
   rand_amount NUMBER;
   single_coef NUMBER := 1;
   gender_coef NUMBER := 1;
   state_coef     NUMBER := 1;
BEGIN
   FOR cust_list IN cust_list_cursor LOOP
      FOR i IN 1 .. 1000 LOOP
         ---- Single coef ----
         IF cust_list.m_status = 'Single' THEN
            single_coef := 2;
         ELSE
            single_coef := 1;
         END IF;
         ---- Gender coef ----
         IF cust_list.gender = 'F' THEN
            gender_coef := 3;
         ELSE
            gender_coef := 1;
         END IF;
         ---- State coef ----
         IF cust_list.state IN ('CA','MD','NJ') THEN
            state_coef := 3;
         ELSE
            state_coef := 1;
         END IF;
      
         rand_amount := ((cust_list.anual_income * state_coef * single_coef * gender_coef) /
                        cust_list.age) *
                        trunc(DBMS_RANDOM.value(low  => 1,
                                                high => 10)) / 100;
         INSERT INTO biwa_sales
            (cust_ID,
             amount)
         VALUES
            (cust_list.id,
             rand_amount);
      END LOOP;
   END LOOP;
   COMMIT;
END;
/
--------------------------------------------
--------------------------------------------
