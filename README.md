loret0g/bibliotecaSQL# Biblioteca - Gestión de Usuarios, Libros y Préstamos

## Descripción

Este proyecto contiene los scripts SQL necesarios para crear y gestionar una base de datos de una biblioteca. La base de datos incluye tablas para usuarios, libros y préstamos, y contiene procedimientos almacenados, funciones y triggers para manejar la lógica del negocio.

## Estructura del Proyecto

El proyecto está dividido en dos archivos principales:

1. **`create_tables_inserts.sql`**: Este archivo contiene los scripts para la creación de las tablas `Usuarios`, `Libros` y `Prestamos`, así como las inserciones de datos de ejemplo para estas tablas.
2. **`procedures_functions_triggers.sql`**: Este archivo incluye la definición de procedimientos almacenados, funciones y triggers para gestionar la lógica de los préstamos de libros.

## Contenido de los Archivos

### `create_tables_inserts.sql`

Este script incluye:
- **Creación de la tabla Usuarios**.
- **Creación de la tabla Libros**.
- **Creación de la tabla Prestamos**.
- **Inserciones de datos de ejemplo** para las tablas `Usuarios`, `Libros` y `Prestamos`.

### `procedures_functions_triggers.sql`

Este script incluye:

- **Procedimiento `ActualizarDevolucion`**.
- **Función `estado_prestamo`**.
- **Trigger `limitar_prestamos_activos`**.
- **Trigger `gestion_cantidad_stock`**.
- **Inserción de un nuevo registro** con los datos del autor.
- **Bloque anónimo para la actualización de préstamos** y visualización de resultados.

