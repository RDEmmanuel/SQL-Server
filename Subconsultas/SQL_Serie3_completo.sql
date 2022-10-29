USE base_consorcio

--Resolucion serie 3
--Ejercicio 1
/*Mostrar los datos de los consorcios (provincia, localidad, nombres, dirección y zona) que 
pertenezcan a las dos zonas con mayor cantidad de consorcios.
(INNER + SUBCONSULTA)
*/
SELECT 
	p.descripcion AS 'Provincia',
	l.descripcion AS 'Localidad',
	c.nombre AS 'Nombre',
	c.direccion AS 'Direccion',
	z.descripcion AS 'Zona'
FROM consorcio c
INNER JOIN zona z
	ON z.idzona = c.idzona
INNER JOIN provincia p
	ON p.idprovincia = c.idprovincia
INNER JOIN localidad l
	ON l.idlocalidad = c.idlocalidad AND l.idprovincia = c.idprovincia
WHERE c.idzona IN (	
	SELECT TOP 2
		idzona 
	FROM consorcio
	GROUP BY idzona
	ORDER BY COUNT(*) DESC
	)

--Cantidad de consorcios por Zona
SELECT
	idzona,
	COUNT(idconsorcio) as 'Cantidad'
FROM consorcio
GROUP BY idzona
ORDER BY COUNT(idconsorcio) DESC
 
--Ejercicio 2
/*Seleccionar los consorcios que pertenezcan a la provincia con mayor número de habitantes, y 
mostrar los datos de los conserjes mayores a 50 años (ordenados de mayor a menor por edad) 
que no estén asignados a estos consorcios
(SUBCONSULTA + FUNCION DE FECHAS)
*/
SELECT
	ce.idconserje AS 'ID Conserje',
	ce.apeynom AS 'Apellido y Nombre',
	dbo.Edad(ce.fechnac) AS [Edad],	
	co.nombre AS 'Consorcio'
FROM conserje ce
LEFT JOIN consorcio co
	ON ce.idconserje = co.idconserje
	WHERE 
		(dbo.Edad(ce.fechnac) > 50 AND
		co.idprovincia NOT IN (
			SELECT TOP 1
				idprovincia as 'Provincia'
			FROM provincia 
			ORDER BY poblacion DESC
		))
ORDER BY dbo.Edad(ce.fechnac) DESC

--Alternativa ejercicio 2
SELECT ce.idconserje,ce.apeynom,ce.tel,ce.fechnac,ce.estciv, dbo.Edad(ce.fechnac) AS [Edad]
FROM conserje ce
INNER JOIN consorcio co
ON ce.idconserje = co.idconserje
	WHERE (dbo.Edad(ce.fechnac) > 50 and
	co.idprovincia != 
		(
			SELECT TOP 1 idprovincia from provincia
			order by poblacion desc
		))
ORDER BY Edad desc

--Consulta Conserjes que no están asignados a ningún consorcio
SELECT 
	ce.apeynom AS 'Apellido y Nombre'
FROM conserje ce
LEFT JOIN consorcio co
	ON ce.idconserje = co.idconserje 
WHERE co.idconserje IS NULL


--Consulta Provincia con mayor población
SELECT TOP 1
	idprovincia as 'ID Provincia',
	descripcion as 'Nombre'
FROM provincia
ORDER BY poblacion DESC

--Ejercicio 3
/*Mostrar todos los tipos de gastos, y sus respectivas descripciones, que no fueron registrados 
en toda la provincia de Buenos Aires para el mes de febrero del año 2015
 (SUBCONSULTA + FUNCION DE FECHAS)
*/
SELECT DISTINCT
	tg.idtipogasto as 'ID Tipo Gasto',
	tg.descripcion as 'Tipo gasto'						
FROM gasto g
INNER JOIN tipogasto tg
	ON g.idtipogasto = tg.idtipogasto
INNER JOIN provincia p 
	ON g.idprovincia = p.idprovincia
	WHERE tg.idtipogasto NOT IN (
		SELECT 
			tg.idtipogasto AS 'Tipo Gasto'
		FROM gasto g
		INNER JOIN provincia p 
			ON g.idprovincia = p.idprovincia
		INNER JOIN tipogasto tg
			ON g.idtipogasto = tg.idtipogasto
		WHERE (YEAR(g.fechapago)=2015 AND MONTH(g.fechapago)=2 AND p.descripcion = 'Buenos Aires')
	)

--Ejercicio 4
/*Mostrar los nombres, en el caso que existan, de las provincias que no tengan localidades 
	cargadas. Verificar el resultado por medio de otras consultas*/

/*Con la siguiente consulta obtenemos la cantidad de provincias*/
SELECT idprovincia,descripcion FROM provincia p

/*Sabiendo que hay 24 provincias cargadas, con la siguiente consulta verificamos que las
	24 provincias estan incluidas en todas las localidades*/
SELECT 
	p.idprovincia, p.descripcion, l.idlocalidad, l.descripcion
FROM provincia p
INNER JOIN localidad l
	ON p.idprovincia = l.idprovincia
	WHERE l.idprovincia IN (p.idprovincia)

/*Modificando la condición del WHERE de la consulta anterior, obtenemos las provincias que 
	no tienen localidades cargadas, en este caso es 0, ya que todas las provincias tienen al menos
	una localidad cargada*/
SELECT 
	p.idprovincia, p.descripcion, l.idlocalidad, l.descripcion
FROM provincia p
INNER JOIN localidad l
	ON p.idprovincia = l.idprovincia
	WHERE l.idprovincia IS NULL
