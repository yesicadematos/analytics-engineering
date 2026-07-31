/*==============================================================
Proyecto : Analytics Engineering Portfolio
Sprint   : 2 - RAW Layer
Archivo  : 02_create_raw_tables.sql

Objetivo:
Crear las tablas de la capa RAW.

La capa RAW almacena una copia de los datos originales
sin aplicar transformaciones de negocio.
==============================================================*/
USE DATABASE AE_DB;
USE SCHEMA RAW;



/*--------------------------------------------------------------
Tabla: OLIST_CUSTOMERS

Fuente:
    olist_customers_dataset.csv
--------------------------------------------------------------*/

CREATE OR REPLACE TABLE OLIST_CUSTOMERS (
    CUSTOMER_ID VARCHAR,
    CUSTOMER_UNIQUE_ID VARCHAR,
    CUSTOMER_ZIP_CODE_PREFIX VARCHAR,
    CUSTOMER_CITY VARCHAR,
    CUSTOMER_STATE VARCHAR
);