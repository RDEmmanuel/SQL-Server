USE base_consorcio

--Ejercicio 5
/*Mostrar los datos del administrador correspondiente al consorcio que tenga menor 
	gasto acumulado en el año (2015) en concepto de 'servicios'
*/
SELECT TOP 1 WITH TIES
	MIN(a.idadmin) as 'ID Admin',
	MIN(a.apeynom) as 'Apellido y Nombre',
	MIN(a.tel) as 'Teléfono',
	MIN(a.sexo) as 'Sexo',
	MIN(c.nombre) as 'Consorcio',
	MIN(tg.descripcion) as 'Tipo Gasto',
	SUM(g.importe) as 'Total acumulado'
FROM consorcio c
INNER JOIN administrador a
	ON a.idadmin = c.idadmin
INNER JOIN gasto g
	ON c.idconsorcio = g.idconsorcio
	AND c.idprovincia = g.idprovincia
	AND c.idlocalidad = g.idlocalidad
INNER JOIN tipogasto tg
	ON g.idtipogasto = tg.idtipogasto
	WHERE YEAR(g.fechapago) = 2015 AND tg.descripcion LIKE 'servicio%'
GROUP BY a.idadmin
ORDER BY sum(g.importe) ASC


/*Cantidad de gastos que cumplen con la condición de: año 2015 y tipo de gasto 1(servicios)*/
SELECT count(*) as 'Cantidad' FROM consorcio c
INNER JOIN gasto g
	ON c.idconsorcio = g.idconsorcio
	AND c.idlocalidad = g.idlocalidad
	AND c.idprovincia = g.idprovincia
INNER JOIN tipogasto tg
	ON g.idtipogasto = tg.idtipogasto
	WHERE YEAR(g.fechapago) = 2015 and tg.descripcion LIKE 'servicio%'


/*Consulta que muestra el importe total acumulado por cada consorcio en concepto de 'Servicios'
y el admin corresponiente a cada consorcio.*/
SELECT
	min(c.nombre) as 'Consorcio',
	min(tg.descripcion) as 'Tipo Gasto',
	sum(g.importe) as 'Importe acumulado',
	min(a.idadmin) as 'ID Admin'
FROM consorcio c
INNER JOIN administrador a
	ON a.idadmin = c.idadmin
INNER JOIN gasto g
	ON c.idconsorcio = g.idconsorcio
	AND c.idprovincia = g.idprovincia
	AND c.idlocalidad = g.idlocalidad
INNER JOIN tipogasto tg
	ON g.idtipogasto = tg.idtipogasto
	WHERE YEAR(g.fechapago) = 2015 AND tg.descripcion LIKE 'servi%'
GROUP BY a.idadmin
ORDER BY sum(g.importe) ASC
 
