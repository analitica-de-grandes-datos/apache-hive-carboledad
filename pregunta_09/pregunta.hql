/*

Pregunta
===========================================================================

Escriba una consulta que retorne la columna tbl0.c1 y el valor 
correspondiente de la columna tbl1.c4 para la columna tbl0.c2.

Apache Hive se ejecutará en modo local (sin HDFS).

Escriba el resultado a la carpeta output de directorio de trabajo.

*/

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

/*
    >>> Escriba su respuesta a partir de este punto <<<
*/
DROP TABLE IF EXISTS tbl0; 
DROP TABLE IF EXISTS datos_0; 
DROP TABLE IF EXISTS tbl1; 
DROP TABLE IF EXISTS datos_1; 
 
CREATE TABLE tbl0 ( 
    c1 INT, 
    c2 STRING, 
    c3 INT, 
    c4 STRING, 
    c5 ARRAY<CHAR(1)>,  
    c6 MAP<STRING, INT> 
) 
 
 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
COLLECTION ITEMS TERMINATED BY ':' 
MAP KEYS TERMINATED BY '#' 
LINES TERMINATED BY '\n'; 
LOAD DATA LOCAL INPATH 'data0.csv' INTO TABLE tbl0; 
 
 
CREATE TABLE tbl1 ( 
    c1 INT, 
    c2 INT, 
    c3 STRING, 
    c4 MAP<STRING, INT> 
) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
COLLECTION ITEMS TERMINATED BY ':' 
MAP KEYS TERMINATED BY '#' 
LINES TERMINATED BY '\n'; 
LOAD DATA LOCAL INPATH 'data1.csv' INTO TABLE tbl1; 
 
 
 
CREATE TABLE datos_0 AS SELECT c1, c2 key FROM tbl0; 
 
CREATE TABLE datos_1 AS SELECT c1, key, value FROM tbl1 LATERAL VIEW explode(c4) letra_numer; 
 
INSERT OVERWRITE LOCAL DIRECTORY './output' 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
SELECT d1.* FROM datos_0 d0, datos_1 d1
WHERE d0.c1 = d1.c1 and d0.key = d1.key;
