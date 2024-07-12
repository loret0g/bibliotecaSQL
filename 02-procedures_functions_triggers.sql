-- Creo un nuevo usuario desde SYSTEM:
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER loreto IDENTIFIED BY desarrollo;
GRANT CREATE SESSION TO loreto;
GRANT ALL PRIVILEGES TO loreto;

-- Me conecto con mi usuario
CONN loreto / desarrollo;

/***** En el ficheroSe crean las tablas y hago los inserts *****/

-- Ejercicio 1
-- PROCEDIMIENTO 'ActualizarDevolucion'
CREATE OR REPLACE PROCEDURE ActualizarDevolucion(
  p_id_prestamo IN Prestamos.id_prestamo%TYPE,
  p_fecha_devolucion IN Prestamos.fecha_devolucion%TYPE,
  p_nombre_usuario OUT Usuarios.nombre_completo%TYPE,
  p_titulo_libro OUT Libros.titulo%TYPE,
  p_dias_prestado OUT INT
) AS
  v_fecha_prestamo Prestamos.fecha_prestamo%TYPE;

BEGIN
-- Actualizar la fecha de devoluci�n del pr�stamo
  UPDATE Prestamos
  SET fecha_devolucion = p_fecha_devolucion
  WHERE id_prestamo = p_id_prestamo;

-- Verificar si se ha actualizado alg�n registro
  IF SQL%ROWCOUNT = 0 THEN
    RAISE NO_DATA_FOUND;
  END IF;
  
  -- Obtener informaci�n adicional del pr�stamo
  SELECT u.nombre_completo, l.titulo, p.fecha_prestamo
  INTO p_nombre_usuario, p_titulo_libro, v_fecha_prestamo
  FROM Prestamos p
  JOIN Usuarios u ON p.id_usuario = u.id_usuario
  JOIN Libros l ON p.id_libro = l.id_libro
  WHERE p.id_prestamo = p_id_prestamo;
  
  -- Calcular los d�as prestados
  p_dias_prestado := p_fecha_devolucion - v_fecha_prestamo;

  -- Si todo es correcto, hacer commit
  COMMIT;
  
EXCEPTION
  WHEN NO_DATA_FOUND THEN
     RAISE_APPLICATION_ERROR(-20001, 'No se encontr� el pr�stamo con el ID ' || p_id_prestamo);
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20002, 'Error en tiempo de ejecuci�n: ' || SQLERRM);

END;
/

-- Ejercicio 2
-- FUNCI�N 'estado_prestamo'
CREATE OR REPLACE FUNCTION estado_prestamo(p_id_prestamo IN Prestamos.id_prestamo%TYPE)
RETURN VARCHAR2 AS
  v_fecha_prestamo Prestamos.fecha_prestamo%TYPE;
  v_fecha_devolucion Prestamos.fecha_devolucion%TYPE;
  v_estado VARCHAR2(100);

BEGIN
  -- Buscar la informaci�n del pr�stamo
  SELECT fecha_prestamo, fecha_devolucion
  INTO v_fecha_prestamo, v_fecha_devolucion
  FROM Prestamos
  WHERE id_prestamo = p_id_prestamo;

  -- Verificar si se ha encontrado el pr�stamo
  IF v_fecha_prestamo IS NULL THEN
    RAISE NO_DATA_FOUND;
  END IF;

  -- Determinar el estado del pr�stamo
  IF v_fecha_devolucion IS NULL THEN
    v_estado := 'Pr�stamo ACTIVO';

  ELSIF v_fecha_devolucion - v_fecha_prestamo <= 15 THEN
    v_estado := 'Pr�stamo devuelto a tiempo';

  ELSE
    v_estado := 'Pr�stamo devuelto con retraso';
  END IF;
  
  RETURN v_estado;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'No se encontr� el pr�stamo con el ID ' || p_id_prestamo);
    RETURN 'Pr�stamo No encontrado.';

  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20002, 'Error en estado_prestamo: ' || SQLERRM);
    RETURN 'Error en estado_prestamo: ' || SQLERRM;

END;
/

-- Ejercicio 3
-- TRIGGER 'limitar_prestamos_activos'
CREATE OR REPLACE TRIGGER limitar_prestamos_activos
BEFORE INSERT ON Prestamos
FOR EACH ROW
DECLARE
  v_prestamos_activos NUMBER;
  limite_excedido EXCEPTION;

BEGIN
  -- Contar el n�mero de pr�stamos activos para el usuario
  SELECT COUNT(*)
  INTO v_prestamos_activos
  FROM Prestamos
  WHERE id_usuario = :NEW.id_usuario
  AND fecha_devolucion IS NULL;

  -- Si el usuario ya tiene 2 pr�stamos activos, lanzar una excepci�n
  IF v_prestamos_activos >= 2 THEN
    RAISE limite_excedido;
  END IF;

EXCEPTION
  WHEN limite_excedido THEN
    RAISE_APPLICATION_ERROR(-20001, 'El usuario con id ' || :NEW.id_usuario || ' tiene ' || v_prestamos_activos || ' pr�stamos activos, que es el m�ximo ');

END;
/

-- Ejercicio 4
-- TRIGGER 'gestion_cantidad_stock'
CREATE OR REPLACE TRIGGER gestion_cantidad_stock
AFTER INSERT OR UPDATE OF fecha_devolucion ON Prestamos
FOR EACH ROW
DECLARE
  v_stock_actual Libros.cantidad%TYPE;
BEGIN
    -- Comprobar el stock actual del libro
  SELECT cantidad INTO v_stock_actual FROM Libros WHERE id_libro = :NEW.id_libro;

  -- Si estamos insertando un nuevo pr�stamo (fecha_devolucion es NULL)
  IF INSERTING AND :NEW.fecha_devolucion IS NULL THEN
    IF v_stock_actual > 0 THEN
      -- Disminuir el stock en 1 unidad
      UPDATE Libros SET cantidad = cantidad - 1 WHERE id_libro = :NEW.id_libro;
    ELSE
-- Si no hay stock, lanzar una excepci�n
      RAISE_APPLICATION_ERROR(-20002, 'No hay suficiente stock para realizar el pr�stamo.');
    END IF;
  END IF;
  
  -- Si estamos actualizando la fecha de devoluci�n (pasando de NULL a un valor)
  IF UPDATING AND :NEW.fecha_devolucion IS NULL AND :NEW.fecha_devolucion IS NOT NULL THEN
    -- Aumentar el stock en 1 unidad
    UPDATE Libros SET cantidad = cantidad + 1 WHERE id_libro = :NEW.id_libro;
  END IF;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'El libro no existe.');

END;
/

-- Ejercicio 5
-- NUEVO REGISTRO con mis datos:
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento)
VALUES (50019, 'Loreto Garde Navarro', 1990);

INSERT INTO Libros (id_libro, titulo, autor, cantidad)
VALUES (50019, 'El psicoanalista', 'John Katzenbach', 5);

INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion)
VALUES (50019, 50019, 50019, TO_DATE('2023-11-08', 'YYYY-MM-DD'), NULL);

-- BLOQUE AN�NIMO
SET SERVEROUTPUT ON;    -- Para permitir la visualizaci�n de datos por consola.

DECLARE
  v_id_prestamo Prestamos.id_prestamo%TYPE;
  v_fecha_devolucion DATE := TO_DATE('2023-11-20', 'YYYY-MM-DD');
  v_nombre_usuario Usuarios.nombre_completo%TYPE;
  v_titulo_libro Libros.titulo%TYPE;
  v_dias_prestado INT;

BEGIN
  v_id_prestamo := &ID_PRESTAMO;    -- Pedir el ID por pantalla:

  -- Muestra el estado actual del pr�stamo, llamando a la funci�n y pas�ndole como par�metro el id introducido por el usuario:
  DBMS_OUTPUT.PUT_LINE('Estado actual del pr�stamo ID ' || v_id_prestamo || ': ' || estado_prestamo(v_id_prestamo));

  -- Llamada al procedimiento para actualizar la fecha de devoluci�n del pr�stamo:
  ActualizarDevolucion(v_id_prestamo, v_fecha_devolucion, v_nombre_usuario, v_titulo_libro, v_dias_prestado);
  
  -- Salida por consola con la informaci�n del pr�stamo actualizado:
  DBMS_OUTPUT.PUT_LINE('Devoluci�n actualizada para el pr�stamo ID ' || v_id_prestamo);

  -- C�lculo de semanas y d�as prestados:
  DECLARE
    v_semanas INT;
    v_dias INT;
  BEGIN
    v_semanas := TRUNC(v_dias_prestado / 7);
    v_dias := MOD(v_dias_prestado, 7);

    -- Salida por consola con los detalles de la actualizaci�n:
    DBMS_OUTPUT.PUT_LINE('Usuario: ' || v_nombre_usuario || ', Libro: ' || v_titulo_libro || ', Prestado por: ' || v_semanas || ' semanas y ' || v_dias || ' d�as.');
  END;

  --Nuevo estado del pr�stamo, llamando a la funci�n y mostr�ndolo directamente por consola:
  DBMS_OUTPUT.PUT_LINE('Nuevo estado del pr�stamo ID ' || v_id_prestamo || ': ' || estado_prestamo(v_id_prestamo));

EXCEPTION
  WHEN NO_DATA_FOUND THEN                           -- Por si no se encuentran datos
    DBMS_OUTPUT.PUT_LINE('Error: No se encontr� el pr�stamo con el ID ' || v_id_prestamo);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);     -- Para mostrar los errores no contemplados
END;
/