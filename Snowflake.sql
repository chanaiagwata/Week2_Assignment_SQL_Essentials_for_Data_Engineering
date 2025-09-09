--CREATE WAREHOUSE, DATABASE, AND SCHEMA

---DATEWAREHOUSE
CREATE WAREHOUSE mpox_wh
with WAREHOUSE_SIZE = 'XSMALL'
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE
--CREATE DATABASE
CREATE DATABASE health_records;

use health_records;
---CREATE SCHEMA
CREATE SCHEMA mpox_schema;

---CREATE TABLE
CREATE TABLE mpox(
Case_ID	string primary key,
Date_Onset string,
County string,
Sex	string,
Age string,
Occupation string,
Case_Status string,
Clinical_Presentation string,
Lab_Diagnosis string,
Travel_History string,
Travel_Destination string
);
--create table2
CREATE TABLE mpox2(
Case_ID	string primary key,
Date_Onset string,
County string,
Sex	string,
Age string,
Occupation string,
Case_Status string,
Clinical_Presentation string,
Lab_Diagnosis string,
Travel_History string,
Travel_Destination string
);
DROP TABLE mpox2;

create file format csv_format
type  = 'csv'
skip_header = 1;
--Create a stage
CREATE STAGE mpox_stage
file_format = csv_format;
COPY INTO mpox_schema.mpox
from @MPOX_STAGE/mpox.csv
on error = continue;

SELECT * FROM MPOX2


--Identify how many PCR Positive cases exist.
SELECT COUNT(CASE_ID) PCR_POSITIVE_COUNT FROM MPOX2
WHERE LAB_DIAGNOSIS = 'PCR Positive';
 
 Select * FROM MPOX2