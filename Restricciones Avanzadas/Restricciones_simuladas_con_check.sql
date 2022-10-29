--CREATE DATABASE restricciones
USE restricciones
--**********************************************************************************************************
-- EJEMPLOS COMPLEMENTARIOS DEL USO AVANZADO DE LAS RESTRICCIONES
--**********************************************************************************************************
--  CHECK 
--**********************************************************************************************************
/*
	Escenario: Simular FOREING KEY con Instruccion CHECK entre 2 tablas.
	Existe más de un registro por DNI. No se puede definir columna UNIQUE. 
	Se necesita mantener los registros como estan.
*/

-- Creo tabla profesor
CREATE TABLE profesor(
	id_profesor INT IDENTITY,
	dni INT NOT NULL,
	apellido VARCHAR(30) NOT NULL,
	nombre VARCHAR(30) NOT NULL
)
-- Inserto más de un registro por DNI. No se puede definir columna UNIQUE.
INSERT INTO profesor(dni, apellido, nombre)
VALUES (10000001,'Perez','Juan')

INSERT INTO profesor(dni, apellido, nombre)
VALUES (10000001,'Perez','Juan')

SELECT * FROM profesor

-- Drop function dbo.CheckReg
-- Creo función que devuelve la cantidad de registros encontrados para el DNI pasado como parámetro
-- FUNCIONES EN TRANSAC SQL 
CREATE FUNCTION CheckReg(@dni AS INT) RETURNS INT
AS 
BEGIN
   DECLARE @cantidad INT
   SELECT @cantidad = COUNT(*) FROM profesor WHERE dni = @dni
   RETURN @cantidad
END
GO

-- Prueba de la función creada.
SELECT COUNT(*) FROM profesor WHERE dni = 10000001

-- Se crea tabla curso relacionada con profesor por DNI a través de la funcién creada anteriormente.
CREATE TABLE curso (
	id_curso INT IDENTITY, 
	nombre VARCHAR(50) NOT NULL, 
	descripcion VARCHAR(50) NOT NULL,
	dni INT NOT NULL
	CONSTRAINT CK_CheckReg CHECK (dbo.CheckReg(dni) >= 1)
)

-- Si no existe DNI en profesor no permite insertar
INSERT INTO curso (nombre,descripcion,dni)
VALUES ('Programacion 1','HTML,CSS,JS',13242345)
-- Si existe DNI en profesor permite insertar
INSERT INTO curso (nombre,descripcion,dni)
VALUES ('Programacion 1','HTML,CSS,JS',10000001)

SELECT * FROM curso

------------------------------------------------------------------
/* Escenario: Simular IDENTITY en una tabla.
 Necesito más de una columna tipo IDENTITY en una misma tabla.
 NOT NULL + UNIQUE + DEFAULT
 Funcion manual identity. */
------------------------------------------------------------------

-- Creo funcion que simula IDENTITY. Lee el ultimo numero y suma 1.
-- DROP FUNCTION 
CREATE FUNCTION F_id_prof()	RETURNS int
AS 
BEGIN
   DECLARE @cantidad int
   SELECT @cantidad =isNull(Max(id_profesor),0) + 1 FROM profesor
   RETURN @cantidad
END


-- Creo tabla afiliado. Donde el valor por defecto de la columna IdAfiliado lo provee la funcion creada anteriormente.
--DROP TABLE profesor
CREATE TABLE profesor (
	id_auto int identity,
	id_profesor int NOT NULL UNIQUE DEFAULT dbo.F_id_prof(),
	dni int NOT NULL,
	apellido VARCHAR(30) NOT NULL,
	nombre VARCHAR(30) NOT NULL
)


INSERT INTO profesor (dni,apellido,nombre)
VALUES (11001001,'Messi','Lionel 10')

INSERT INTO profesor (dni,apellido,nombre)
VALUES (11001001,'Messi','Lionel 30')

-- Salta numeros en el automatico
begin tran
INSERT INTO profesor (dni,apellido,nombre)
VALUES (11001001,'Messi','Lionel 10')
rollback

INSERT INTO profesor (dni,apellido,nombre)
VALUES (11001001,'Messi','Lionel 10')


SELECT * FROM profesor

-- Creo una tabla relacionada con columna id_profesor (NO ES Primary Key, es Unique), se carga con la función.
--DROP TABLE aula
CREATE TABLE aula(
	id_aula int IDENTITY,
	id_profesor int NOT NULL, 
	descripcion varchar(50) NOT NULL
	CONSTRAINT PK_aula PRIMARY KEY (id_aula),
	CONSTRAINT FK_aula_profesor FOREIGN KEY (id_profesor) REFERENCES profesor(id_profesor)	
)

-- Error de constraint
INSERT INTO aula (id_profesor, descripcion)
VALUES (9,'Descripcion1') 
-- Insert Ok
INSERT INTO aula (id_profesor, descripcion)
VALUES (1,'Descripcion2')
-- Insert Ok
INSERT INTO aula (id_profesor, descripcion)
VALUES (2,'Descripcion3')


SELECT * FROM aula

