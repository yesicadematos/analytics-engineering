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


/*--------------------------------------------------------------
Tabla: OLIST_SELLERS

Fuente:
    olist_sellers_dataset.csv

Descripción:
Contiene la identificación y ubicación geográfica de los
vendedores registrados en la plataforma.
--------------------------------------------------------------*/

CREATE OR REPLACE TABLE OLIST_SELLERS (
    SELLER_ID VARCHAR,
    SELLER_ZIP_CODE_PREFIX VARCHAR,
    SELLER_CITY VARCHAR,
    SELLER_STATE VARCHAR
);


/*--------------------------------------------------------------
Tabla: PRODUCT_CATEGORY_NAME_TRANSLATION

Fuente:
    product_category_name_translation.csv

Descripción:
Contiene la traducción de los nombres de categorías desde
portugués hacia inglés.
--------------------------------------------------------------*/

CREATE OR REPLACE TABLE PRODUCT_CATEGORY_NAME_TRANSLATION (
    PRODUCT_CATEGORY_NAME VARCHAR,
    PRODUCT_CATEGORY_NAME_ENGLISH VARCHAR
);