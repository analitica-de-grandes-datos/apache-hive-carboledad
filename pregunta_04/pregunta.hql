/* 
Pregunta
===========================================================================

Escriba una consulta que retorne los valores únicos de la columna `t0.c5` 
(ordenados). 

Apache Hive se ejecutará en modo local (sin HDFS).

Escriba el resultado a la carpeta `output` de directorio de trabajo.

*/
DROP TABLE IF EXISTS data;
DROP TABLE IF EXISTS datos;
CREATE TABLE data  
(
    c1 INT,
    c2 STRING,
    c3 INT,
    c4 DATE,
    c5 ARRAY<CHAR(1)>, 
    c6 STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
COLLECTION ITEMS TERMINATED BY ':'
LINES TERMINATED BY '\n';

LOAD DATA LOCAL INPATH "data0.csv" OVERWRITE INTO TABLE data; 
CREATE TABLE datos AS SELECT explode(c5) AS letra FROM data;
INSERT OVERWRITE LOCAL DIRECTORY './output' 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
SELECT * FROM datos GROUP BY letra ORDER BY letra ASC;
