USE base_consorcio 

--Ejercicio 26
/*Mostrar el importe total acumulado de gasto por tipo de gasto. Mostrar las descripciones de 
cada tipo de gasto de la tabla tipogasto*/

SELECT 
	MAX(tipogasto.descripcion) AS 'Descripción',
	SUM(importe) AS 'Importe acumulado'
FROM gasto
INNER JOIN tipogasto
ON tipogasto.idtipogasto = gasto.idtipogasto
GROUP BY gasto.idtipogasto

--Ejercicio 27
/*Mostrar los nombres de todos los consorcios y en que provincia y localidad esta cada uno. 
Ordenados por Provincia, localidad y consorcio*/SELECT 	provincia.descripcion AS 'Provincia',	localidad.descripcion AS 'Localidad',	nombre AS 'Nombre'FROM consorcioINNER JOIN provincia	ON provincia.idprovincia = consorcio.idprovinciaINNER JOIN localidad	ON localidad.idlocalidad = consorcio.idlocalidad		AND localidad.idprovincia = consorcio.idprovincia--Otra forma de resolver utilizando  aliasSELECT 	p.descripcion AS 'Provincia',	l.descripcion AS 'Localidad',	nombre AS 'Nombre'FROM consorcio cINNER JOIN provincia p	ON p.idprovincia = c.idprovinciaINNER JOIN localidad l	ON l.idlocalidad = c.idlocalidad		AND l.idprovincia = c.idprovincia--Ejercicio 28/*Mostrar los 10 (diez) consorcios donde se registraron mayores gastos y a qué provincia 
pertenecen.*/

SELECT top (10)	MAX(c.nombre) AS 'Consorcio',	MAX(p.descripcion) AS 'Provincia',	SUM(importe) AS 'Total Gasto'FROM gasto gINNER JOIN consorcio c	ON c.idprovincia = g.idprovincia	AND c.idlocalidad = g.idlocalidad	AND c.idconsorcio = g.idconsorcioINNER JOIN provincia p	ON p.idprovincia = g.idprovinciaGROUP BY c.idprovincia, c.idlocalidad, c.idconsorcioORDER BY SUM(importe) DESC--Ejercicio extra/*Mostrar los 10 (diez) consorcios donde se registraron MENORES gastos y a qué provincia 
pertenecen.*/

SELECT top (10)	MAX(c.nombre) AS 'Consorcio',	MAX(p.descripcion) AS 'Provincia',	SUM(importe) AS 'Total Gasto'FROM gasto gINNER JOIN consorcio c	ON c.idprovincia = g.idprovincia	AND c.idlocalidad = g.idlocalidad	AND c.idconsorcio = g.idconsorcioINNER JOIN provincia p	ON p.idprovincia = g.idprovinciaGROUP BY c.idprovincia, c.idlocalidad, c.idconsorcioORDER BY SUM(importe) ASC