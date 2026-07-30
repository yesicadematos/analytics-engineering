/*==============================================================
 Proyecto : Analytics Engineering Portfolio
 Autor    : Yesica De Matos
 Objetivo : Crear la estructura inicial del proyecto en Snowflake
===============================================================*/


/*--------------------------------------------------------------
Paso 1
Seleccionar la base de datos donde trabajaremos.

Si la base no existe, primero debemos crearla.
--------------------------------------------------------------*/

USE DATABASE AE_DB;


/*--------------------------------------------------------------
Paso 2
Seleccionar el esquema RAW.

Aquí se almacenarán los datos exactamente como llegan
desde la fuente, sin ninguna transformación.

En Analytics Engineering esta capa representa la zona
de ingestión de datos.
--------------------------------------------------------------*/

USE SCHEMA RAW;


/*--------------------------------------------------------------
Paso 3
Crear un File Format.

¿Qué es?

Es un objeto de Snowflake que almacena la configuración
necesaria para interpretar archivos CSV.

Gracias a esto evitamos repetir la configuración
cada vez que cargamos un archivo.
--------------------------------------------------------------*/

CREATE OR REPLACE FILE FORMAT csv_format

TYPE = CSV

FIELD_OPTIONALLY_ENCLOSED_BY = '"'

SKIP_HEADER = 1

NULL_IF = ('NULL','');


/*--------------------------------------------------------------
Explicación de cada parámetro

TYPE = CSV

Indica que el archivo tiene formato CSV.


FIELD_OPTIONALLY_ENCLOSED_BY = '"'

Las columnas pueden venir encerradas entre comillas.


Ejemplo:

"123","Laptop","1500"


SKIP_HEADER = 1

Ignora la primera fila del archivo.

Es decir:

customer_id,name,email

No será cargada como datos.


NULL_IF = ('NULL','')

Si encuentra

NULL

o una cadena vacía

la convertirá automáticamente en NULL.
--------------------------------------------------------------*/


/*--------------------------------------------------------------
Paso 4
Crear un Stage.

¿Qué es un Stage?

Es una ubicación temporal donde Snowflake almacena
los archivos antes de cargarlos a una tabla.

Flujo:

PC
 ↓
Stage
 ↓
Tabla
--------------------------------------------------------------*/

CREATE OR REPLACE STAGE raw_stage

FILE_FORMAT = csv_format;


/*--------------------------------------------------------------
Paso 5
Verificar que el Stage fue creado correctamente.
--------------------------------------------------------------*/

SHOW STAGES;


/*--------------------------------------------------------------
Paso 6
Verificar que el File Format existe.
--------------------------------------------------------------*/

SHOW FILE FORMATS;