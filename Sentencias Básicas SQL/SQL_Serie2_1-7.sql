USE base_consorcio

--Resolucion serie 2
--Ej 1
/*Escribir una consulta que muestre todos los datos de todos los conserjes*/
SELECT * FROM conserje

--Ej 2
/*Mostrar solamente el nro. de conserje (idconserje) y el nombre (apeynom)*/
SELECT idconserje as 'ID Conserje', apeynom as 'Apellido y Nombre' FROM conserje

--Ej 4
/*Escribir una consulta que muestre el gasto de los edificios, y un incremento del 20% en 3 
formatos diferentes, con las siguientes cabeceras “Sin formato”, “Redondeado a 1 digito 
decimal”, “Truncado a 1 digito”. Usar función ROUND.*/SELECT	*,	'Sin formato' = (importe * 1.2),
	'Redondeado a 1 digito decimal' = ROUND((importe * 1.2),1),
	'Truncado' = ROUND((importe * 1.2),1,1)FROM gasto--Ej 5/*Listar el nombre (descripcion) y la población (poblacion) de cada Provincia.
Salida Esperada: 24*/
SELECT descripcion as 'Nombre Provincia', poblacion as 'Poblacion' FROM provincia

--Ej 6
/*Listar sin repetir, todos los códigos de provincia de la tabla “consorcio”. Usar Clausula DISTINCT*/
SELECT DISTINCT idprovincia as 'Código Provincia' FROM consorcio

--Ej 7
/*Listar los 15 primeros conserjes de la respectiva tabla. Usar cláusula Top*/
SELECT TOP 15
	idconserje as 'Código Conserje',
	apeynom as 'Apellido y Nombre',
	tel as 'Teléfono',
	fechnac as 'Fecha Nacimiento',
	estciv as 'Estado Civil'
FROM conserje
