"""
Proyecto: Analytics Engineering con dbt y Snowflake
Objetivo: Subir los archivos CSV locales al internal stage RAW_STAGE.

Flujo:
    data/raw/*.csv
            ↓
    Snowflake RAW_STAGE

Autenticación:
- El script solicita la contraseña de Snowflake al ejecutarse.
- La contraseña no se guarda dentro del código.
- Todavía no se cargan datos en tablas; únicamente se suben archivos al stage.
"""

from getpass import getpass
from pathlib import Path

import snowflake.connector


# ------------------------------------------------------------------
# 1. Configuración de Snowflake
# ------------------------------------------------------------------

SNOWFLAKE_ACCOUNT = "obocmqd-qp20942"
SNOWFLAKE_USER = "DEMATOSYESICA"
SNOWFLAKE_ROLE = "ACCOUNTADMIN"
SNOWFLAKE_WAREHOUSE = "COMPUTE_WH"
SNOWFLAKE_DATABASE = "AE_DB"
SNOWFLAKE_SCHEMA = "RAW"
SNOWFLAKE_STAGE = "RAW_STAGE"


# ------------------------------------------------------------------
# 2. Localizar la carpeta data/raw
#
# __file__ representa la ubicación de este script.
# parent.parent permite volver a la raíz del repositorio.
# ------------------------------------------------------------------

PROJECT_ROOT = Path(__file__).resolve().parent.parent
RAW_DATA_DIRECTORY = PROJECT_ROOT / "data" / "raw"


def get_csv_files(directory: Path) -> list[Path]:
    """
    Obtiene todos los archivos CSV disponibles en data/raw.

    Los archivos se ordenan alfabéticamente para que la carga
    se realice siempre de manera predecible.
    """

    if not directory.exists():
        raise FileNotFoundError(
            f"No existe la carpeta de datos: {directory}"
        )

    csv_files = sorted(directory.glob("*.csv"))

    if not csv_files:
        raise FileNotFoundError(
            f"No se encontraron archivos CSV en: {directory}"
        )

    return csv_files


def upload_files() -> None:
    """
    Conecta con Snowflake y sube los archivos CSV al RAW_STAGE.

    PUT:
        Transfiere un archivo local hacia un internal stage.

    AUTO_COMPRESS = TRUE:
        Snowflake comprime los archivos durante la carga.

    OVERWRITE = TRUE:
        Reemplaza el archivo del stage cuando ya existe.
    """

    csv_files = get_csv_files(RAW_DATA_DIRECTORY)

    password = getpass("Contraseña de Snowflake: ")

    connection = None
    cursor = None

    try:
        print("\nConectando con Snowflake...")

        connection = snowflake.connector.connect(
            account=SNOWFLAKE_ACCOUNT,
            user=SNOWFLAKE_USER,
            password=password,
            authenticator="snowflake",
            role=SNOWFLAKE_ROLE,
            warehouse=SNOWFLAKE_WAREHOUSE,
            database=SNOWFLAKE_DATABASE,
            schema=SNOWFLAKE_SCHEMA,
        )

        cursor = connection.cursor()

        print("Conexión realizada correctamente.")
        print(f"Se encontraron {len(csv_files)} archivos CSV.\n")

        for csv_file in csv_files:
            # Convierte la ruta de Windows a un formato compatible
            # con Snowflake, por ejemplo:
            # C:/Users/Yesica/Desktop/archivo.csv
            local_file_uri = csv_file.resolve().as_posix()

            put_command = f"""
                PUT 'file://{local_file_uri}'
                @{SNOWFLAKE_STAGE}
                AUTO_COMPRESS = TRUE
                OVERWRITE = TRUE
            """

            print(f"Subiendo: {csv_file.name}")

            cursor.execute(put_command)
            result = cursor.fetchone()

            if result:
                print(f"  Resultado: {result}")

        print("\nTodos los archivos fueron procesados correctamente.")

    except FileNotFoundError as error:
        print("\nError al localizar los archivos:")
        print(error)
        raise

    except snowflake.connector.errors.DatabaseError as error:
        print("\nSnowflake rechazó la conexión o la operación.")
        print(f"Código: {error.errno}")
        print(f"Mensaje: {error.msg}")
        raise

    except snowflake.connector.Error as error:
        print("\nError del conector de Snowflake:")
        print(error)
        raise

    except Exception as error:
        print("\nOcurrió un error inesperado:")
        print(error)
        raise

    finally:
        if cursor is not None:
            cursor.close()

        if connection is not None:
            connection.close()

        print("\nConexión cerrada.")


if __name__ == "__main__":
    upload_files()