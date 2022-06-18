/*

Pregunta
===========================================================================

Realice una consulta que compute la cantidad de veces que aparece cada valor 
de la columna t0.c5  por ano.

Apache Hive se ejecutara en modo local (sin HDFS).

Escriba el resultado a la carpeta output de directorio de trabajo.

*/
/*
DROP TABLE IF EXISTS tbl0;
CREATE TABLE tbl0 (
    c1 INT,
    c2 STRING,
    c3 INT,
    c4 DATE,
    c5 ARRAY<CHAR(1)>, 
    c6 MAP<STRING, INT>
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY ':'
MAP KEYS TERMINATED BY '#'
LINES TERMINATED BY '\n';
LOAD DATA LOCAL INPATH 'data0.csv' INTO TABLE tbl0;

DROP TABLE IF EXISTS tbl1;
CREATE TABLE tbl1 (
    c1 INT,
    c2 INT,
    c3 STRING,
    c4 MAP<STRING, INT>
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY ':'
MAP KEYS TERMINATED BY '#'
LINES TERMINATED BY '\n';
LOAD DATA LOCAL INPATH 'data1.csv' INTO TABLE tbl1;
*/
/*
    >>> Escriba su respuesta a partir de este punto <<<
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
CREATE TABLE datos AS SELECT YEAR(c4) ano, letra FROM data LATERAL VIEW explode(c5) edata AS letra;
INSERT OVERWRITE LOCAL DIRECTORY './output' 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
SELECT ano, letra, count(1) cant FROM datos GROUP BY ano, letra ORDER BY ano, letra ASC;
