-- Creaci�n de la tabla Usuarios
CREATE TABLE Usuarios (
  id_usuario NUMBER PRIMARY KEY, -- Identificador �nico para cada usuario, clave primaria de la tabla.
  nombre_completo VARCHAR2(200), -- Nombre completo del usuario, permite hasta 200 caracteres.
  anio_nacimiento INT  -- A�o de nacimiento del usuario
);

-- Creaci�n de la tabla Libros
CREATE TABLE Libros (
  id_libro NUMBER PRIMARY KEY, -- Identificador �nico para cada libro, clave primaria de la tabla.
  titulo VARCHAR2(100), -- T�tulo del libro, permite hasta 100 caracteres.
  autor VARCHAR2(100), -- Autor del libro, permite hasta 100 caracteres.
  cantidad NUMBER CHECK (cantidad >= 0) -- Cantidad de ejemplares del libro en la biblioteca, no puede ser negativa.
);

-- Creaci�n de la tabla Prestamos
CREATE TABLE Prestamos (
  id_prestamo NUMBER PRIMARY KEY, -- Identificador �nico para cada pr�stamo, clave primaria de la tabla.
  id_usuario NUMBER, -- Identificador del usuario que realiza el pr�stamo, clave for�nea que referencia a Usuarios.
  id_libro NUMBER, -- Identificador del libro prestado, clave for�nea que referencia a Libros.
  fecha_prestamo DATE NOT NULL, -- Fecha en la que se realiz� el pr�stamo, no pude ser NULL.
  fecha_devolucion DATE, -- Fecha en la que se devolvi� el libro, puede ser NULL si el libro a�n no se ha devuelto.
  FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario), -- Relaci�n de clave for�nea con la tabla Usuarios.
  FOREIGN KEY (id_libro) REFERENCES Libros(id_libro) -- Relaci�n de clave for�nea con la tabla Libros.
);

-- Inserciones para la tabla Usuarios
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (1, 'Ana Ruiz', 1985);
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (2, 'Carlos L�pez', 1972);
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (3, 'Marta Hern�ndez', 1990);
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (4, 'David Jim�nez', 2000);
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (5, 'Luc�a Gonz�lez', 1995);
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (6, 'Sergio Mart�nez', 1988);
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (7, 'Mar�a Fern�ndez', 1975);
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (8, 'Pablo Rodr�guez', 1965);
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (9, 'Sandra G�mez', 1982);
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (10, 'Ra�l Navarro', 1999);

-- Inserciones para la tabla Libros
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (1, 'Cien a�os de soledad', 'Gabriel Garc�a M�rquez', 3);
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (2, '1984', 'George Orwell', 5);
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (3, 'Don Quijote de la Mancha', 'Miguel de Cervantes', 2);
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (4, 'El principito', 'Antoine de Saint-Exup�ry', 4);
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (5, 'Sapiens: De animales a dioses', 'Yuval Noah Harari', 6);
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (6, 'La sombra del viento', 'Carlos Ruiz Zaf�n', 1);
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (7, 'El se�or de los anillos', 'J.R.R. Tolkien', 3);
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (8, 'Harry Potter y la piedra filosofal', 'J.K. Rowling', 7);
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (9, 'El c�digo Da Vinci', 'Dan Brown', 2);
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (10, 'El alquimista', 'Paulo Coelho', 5);

-- Inserciones para la tabla Pr�stamos
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (1, 1, 5, TO_DATE('2023-09-01', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (2, 2, 3, TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2023-09-19', 'YYYY-MM-DD'));
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (3, 3, 7, TO_DATE('2023-09-10', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (4, 4, 2, TO_DATE('2023-09-15', 'YYYY-MM-DD'), TO_DATE('2023-09-25', 'YYYY-MM-DD'));
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (5, 5, 1, TO_DATE('2023-09-20', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (6, 6, 4, TO_DATE('2023-09-25', 'YYYY-MM-DD'), TO_DATE('2023-10-15', 'YYYY-MM-DD'));
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (7, 7, 8, TO_DATE('2023-09-30', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (8, 8, 6, TO_DATE('2023-10-01', 'YYYY-MM-DD'), TO_DATE('2023-10-11', 'YYYY-MM-DD'));
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (9, 9, 10, TO_DATE('2023-10-03', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (10, 10, 9, TO_DATE('2023-10-07', 'YYYY-MM-DD'), TO_DATE('2023-10-19', 'YYYY-MM-DD'));
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (11, 1, 2, TO_DATE('2023-10-10', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (12, 2, 1, TO_DATE('2023-10-12', 'YYYY-MM-DD'), TO_DATE('2023-10-28', 'YYYY-MM-DD'));
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (13, 3, 4, TO_DATE('2023-10-14', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (14, 4, 7, TO_DATE('2023-10-16', 'YYYY-MM-DD'), TO_DATE('2023-10-26', 'YYYY-MM-DD'));
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (15, 5, 6, TO_DATE('2023-10-18', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (16, 6, 3, TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_DATE('2023-10-30', 'YYYY-MM-DD'));
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (17, 7, 5, TO_DATE('2023-10-22', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (18, 8, 9, TO_DATE('2023-10-24', 'YYYY-MM-DD'), TO_DATE('2023-11-09', 'YYYY-MM-DD'));
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (19, 9, 8, TO_DATE('2023-10-26', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (20, 10, 10, TO_DATE('2023-10-28', 'YYYY-MM-DD'), TO_DATE('2023-11-18', 'YYYY-MM-DD'));
