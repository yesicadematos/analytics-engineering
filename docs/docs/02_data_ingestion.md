# Sprint 1 - Data Ingestion

## Objetivo

El objetivo de este sprint fue automatizar la ingesta de los archivos fuente del proyecto desde el entorno local hacia un **Internal Stage** de Snowflake.

En lugar de cargar los archivos manualmente desde la interfaz de Snowflake, se desarrolló un proceso automatizado utilizando Python y el Snowflake Connector. De esta manera, la carga de datos se vuelve reproducible, consistente y fácil de ejecutar nuevamente cuando los archivos de origen cambian.

Este enfoque permite construir un pipeline más cercano a un entorno de producción y reduce la intervención manual durante el proceso de ingestión.

---

## Arquitectura

Durante este sprint se implementó el siguiente flujo de carga:

```text
data/raw/*.csv
        │
        ▼
Python Script
(upload_files_to_stage.py)
        │
        ▼
Snowflake Internal Stage
(RAW_STAGE)
```

Los archivos CSV permanecen almacenados localmente dentro del proyecto y son cargados automáticamente al Internal Stage de Snowflake mediante el comando `PUT`.

En esta etapa los datos aún no existen como tablas dentro del Data Warehouse.

---

## Tecnologías utilizadas

- Python 3.11
- Snowflake Connector for Python
- Snowflake
- Git
- GitHub
- Visual Studio Code

---

## Decisiones de diseño

### Automatizar la carga mediante Python

Se decidió utilizar un script en Python para automatizar la carga de archivos hacia Snowflake.

Esto evita depender de cargas manuales desde la interfaz web y permite ejecutar el proceso tantas veces como sea necesario de forma consistente.

### Separar código y datos

Los archivos CSV permanecen dentro de la carpeta `data/raw`, pero no forman parte del repositorio Git gracias al uso de `.gitignore`.

Esta decisión evita versionar archivos de datos y mantiene el repositorio enfocado únicamente en el código fuente.

### Utilizar un Internal Stage

Antes de cargar los datos en tablas, los archivos son almacenados en un Internal Stage (`RAW_STAGE`).

Esta arquitectura desacopla la recepción de archivos del proceso de carga hacia las tablas RAW y facilita volver a ejecutar el proceso cuando sea necesario.

---

## Implementación

Durante este sprint se realizaron las siguientes tareas:

- Configuración del Internal Stage (`RAW_STAGE`).
- Desarrollo del script `upload_files_to_stage.py`.
- Automatización de la carga de todos los archivos CSV presentes en `data/raw`.
- Compresión automática de los archivos utilizando `AUTO_COMPRESS = TRUE`.
- Reemplazo automático de archivos existentes mediante `OVERWRITE = TRUE`.

---

## Validación

La carga fue validada ejecutando:

```sql
LIST @RAW_STAGE;
```

Como resultado, los nueve archivos del dataset fueron almacenados correctamente dentro del Internal Stage de Snowflake.

Esta validación confirmó que el proceso de ingestión funciona correctamente y que los archivos están disponibles para el siguiente paso del pipeline.

---

## Aprendizajes

Durante este sprint se trabajó con los siguientes conceptos:

- Internal Stage.
- Comando `PUT`.
- Snowflake Connector para Python.
- Automatización de procesos.
- Organización de proyectos de Analytics Engineering.
- Separación entre código y datos mediante `.gitignore`.

---

## Próximos pasos

En el siguiente sprint se crearán las tablas de la capa `RAW` dentro del Data Warehouse.

Una vez creadas las estructuras, los archivos almacenados en el Internal Stage serán cargados mediante el comando `COPY INTO`, permitiendo comenzar el modelado de datos con dbt.