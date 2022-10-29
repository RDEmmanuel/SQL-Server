/* SIMULAR FOREIGN KEY entre dos tablas en dos bases de datos distintas.
 Usar Instrucción CHECK entre dos tablas en distintas bases de datos.
*/

CREATE DATABASE DB1
USE DB1
Go
--Creo tabla "PADRE" en base de datos DB1
--DROP TABLE Pais
CREATE TABLE pais (
	id_pais int Identity, 
	nombre varchar(50)
	CONSTRAINT PK_pais PRIMARY KEY (id_pais)
)

INSERT INTO pais (Nombre) VALUES ('Argentina')

-- CREO UNA NUEVA BASE DE DATOS
CREATE DATABASE DB2
USE DB2

--CREO FUNCION QUE SIMULA FOREIGN KEY
--DROP FUNCTION CheckPais
CREATE FUNCTION CheckPais(@idP as int) RETURNS int
AS 
BEGIN
   DECLARE @cantidad int
   SELECT @cantidad = COUNT(*) FROM DB1.dbo.pais WHERE id_pais = @idP
   RETURN @cantidad
END

--DROP TABLE Provincia
CREATE TABLE provincia (	
	id_pais int,	
	id_provincia int Identity,
	nombre varchar(50),
	CONSTRAINT CK_CheckPais CHECK (dbo.CheckPais(id_pais) >= 1),
	CONSTRAINT PK_provincia PRIMARY KEY (id_pais, id_provincia)
)

--Cuando id_pais existe en la tabla pais permite insertar
INSERT INTO provincia (id_pais, nombre)	VALUES (1,'Corrientes')

SELECT * FROM DB1.dbo.pais

--Cuando id_pais no existe en la tabla pais no permite insertar
INSERT INTO provincia (id_pais, nombre) VALUES (2,'Formosa')

SELECT * FROM provincia

/*
USE master
DROP DATABASE DB1
DROP DATABASE DB2
*/