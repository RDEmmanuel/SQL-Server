USE base_consorcio

--Ej 8
/*Crear una consulta que muestre el Nombre y la dirección de los consorcios de la provincia de 
“Buenos Aires”. Tabla a utilizar: consorcio y idprovincia = 2*/SELECT	nombre as 'Nombre Consorcio',	direccion as 'Dirección'FROM consorcioWHERE idprovincia = 2---------------------------------------------------------------------Consulta por idprovincia = 2 en la tabla ProvinciaSELECT * FROM provincia	WHERE idprovincia = 2 ---------------------------------------------------------------------Consulta por nombre(descripcion) de la provincia = 'Buenos Aires'SELECT * FROM provincia	WHERE descripcion like 'Buenos Aires'---------------------------------------------------------------------Ej 9/*Escribir y ejecutar una sentencia SELECT que devuelva los consorcios cuyo nombre comience 
con EDIFICIO-3. Tabla a utilizar: consorcio, columna: nombre*/
SELECT nombre,direccion FROM consorcio WHERE nombre like 'EDIFICIO-3%'

--Ej 10
/*Crear una consulta que muestre el nombre y apellido, teléfono y fecha de nacimiento en una 
sola columna, separados por un guión para todos los administradores mujeres (Sexo =F). Poner 
alias “Datos personales” en la primera columna:*/
SELECT concat(apeynom,' - ',tel,' - ',fechnac) as 'Datos Personales' FROM administrador WHERE sexo = 'F'

--Ej 11
/*Crear una consulta que muestre los gastos cuyos importes estén entre 10,00 y 100,00*/
SELECT * FROM gasto WHERE (importe >= 10.00 AND importe <= 100.00)

--Ej 12 
/*Crear una consulta que muestre los administradores que hayan nacido en la década del 60, 
ordenar el resultado por dicha fecha en forma descendente: */
SELECT * FROM administrador WHERE (YEAR(fechnac) > '1960' AND YEAR(fechnac) < '1971')

--Ej 13
/*Crear una consulta que muestre las localidades de las provincias de capital federal y buenos 
aires (1 y 2), ordenado alfabéticamente dentro de cada provincia. */
SELECT
	* 
FROM localidad 
WHERE (idprovincia = 1 or idprovincia = 2) 
ORDER BY idprovincia, descripcion

--Ej 14
/*Crear una consulta que muestre los datos de los consorcios cuya dirección contenga la letra ‘N’ 
en la Posición 5 */
SELECT * FROM consorcio WHERE direccion like '____N%'

--Ej 15
/*Crear una consulta para mostrar los 697 gastos más costosos*/
SELECT TOP 697 * FROM gasto ORDER BY importe DESC

--Ej 16
/*Sobre la consulta anterior mostrar los importes repetidos*/
SELECT top 697 WITH TIES * FROM gasto ORDER BY importe DESC

--Ej 17 
/*Crear una consulta que permita calcular un incremento de 15% para los gastos menores a 
10000, 10% para los que están entre 10000 y 20000 y un 5 % para el resto. Muestre la salida 
ordenada en forma decreciente por el importe.*/
SELECT 
	*,
	'Importe actualizado' =
		CASE
			WHEN importe < 10000 THEN (importe * 1.15)
			WHEN (importe > 10000 and importe < 20000) THEN (importe * 1.1)
		ELSE (importe * 1.05)
		END
FROM gasto
ORDER BY importe

--Ej 18
/*Informar la cantidad de administradores masculinos y femeninos (sexo = ‘M’ y sexo = ‘F’)*/
SELECT
	SUM(IIF(sexo='M',1,0)) as 'Masculino',
	SUM(IIF(sexo='F',1,0)) as 'Femenino'
FROM administrador

--Ej 19
/*Informar la suma total de gastos, la cantidad de gastos y el promedio del mismo. Utilizar Sum, 
Count y Avg */
SELECT 
	SUM(importe) as 'Sumatoria',
	COUNT(*) as 'Cantidad',
	AVG(importe) as 'Promedio'
FROM gasto

--Ej 20
/*
	a) Mostrar el importe total acumulado de gasto por tipo de gasto 
*/
SELECT 
	idtipogasto,
	SUM(importe) as 'Importe Acumulado'
FROM gasto
GROUP BY idtipogasto
ORDER BY idtipogasto

/*
	b) Sobre la consulta anterior, listar solo aquellos gastos cuyos importes sean superior a 
	2.000.000
*/
SELECT 
	idtipogasto,
	SUM(importe) as 'Importe Acumulado'
FROM gasto
GROUP BY idtipogasto
HAVING SUM(importe) > 2000000
ORDER BY idtipogasto

/*
	c) Listar solamente los dos (2) tipos de gastos con menor importe acumulado.
*/
SELECT TOP 2
	idtipogasto,
	SUM(importe) as 'Importe Acumulado'
FROM gasto
GROUP BY idtipogasto
ORDER BY idtipogasto ASC