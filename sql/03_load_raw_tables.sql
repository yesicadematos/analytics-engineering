/*==============================================================
Proyecto : Analytics Engineering Portfolio
Sprint   : 2 - RAW Layer
Archivo  : 03_load_raw_tables.sql

Objetivo:
Cargar los archivos almacenados en RAW_STAGE dentro de las
tablas del esquema RAW.
==============================================================*/

USE DATABASE AE_DB;
USE SCHEMA RAW;


/*--------------------------------------------------------------
Carga de clientes
--------------------------------------------------------------*/

COPY INTO OLIST_CUSTOMERS
FROM @RAW_STAGE/olist_customers_dataset.csv.gz
FILE_FORMAT = (
    FORMAT_NAME = CSV_FORMAT
)
ON_ERROR = 'ABORT_STATEMENT';


/*--------------------------------------------------------------
Carga de vendedores
--------------------------------------------------------------*/

COPY INTO OLIST_SELLERS
FROM @RAW_STAGE/olist_sellers_dataset.csv.gz
FILE_FORMAT = (
    FORMAT_NAME = CSV_FORMAT
)
ON_ERROR = 'ABORT_STATEMENT';


/*--------------------------------------------------------------
Carga de traducción de categorías
--------------------------------------------------------------*/

COPY INTO PRODUCT_CATEGORY_NAME_TRANSLATION
FROM @RAW_STAGE/product_category_name_translation.csv.gz
FILE_FORMAT = (
    FORMAT_NAME = CSV_FORMAT
)
ON_ERROR = 'ABORT_STATEMENT';