USE base_consorcio

--Ejercicio 5
/*Mostrar los datos del administrador correspondiente al consorcio que tenga menor 
	gasto acumulado en el año (2015) en concepto de 'servicios'
*/
SELECT top (1) WITH TIES
	c.idadmin as 'ID Admin',
	MIN(a.apeynom) as 'Apellido y Nombre',
	MIN(a.tel) as 'Tel',
	MIN(a.sexo) as 'Sexo',
	MIN(c.nombre) as 'Consorcio',
	COUNT(*) as 'Cantidad Gastos'
FROM consorcio c
INNER JOIN administrador a
	ON c.idadmin = a.idadmin
INNER JOIN gasto g
	ON c.idconsorcio = g.idconsorcio
	AND c.idlocalidad = g.idlocalidad
	AND c.idprovincia = g.idprovincia
INNER JOIN tipogasto tg
	ON g.idtipogasto = tg.idtipogasto
	WHERE YEAR(g.fechapago) = 2015 AND tg.descripcion LIKE 'servicio%'
GROUP BY c.idadmin
ORDER BY COUNT(*) ASC


/*Cantidad de gastos que cumplen con la condición de: año 2015 y tipo de gasto 1(servicios)*/
SELECT count(*) as 'Cantidad' FROM consorcio c
INNER JOIN gasto g
	ON c.idconsorcio = g.idconsorcio
	AND c.idlocalidad = g.idlocalidad
	AND c.idprovincia = g.idprovincia
INNER JOIN tipogasto tg
	ON g.idtipogasto = tg.idtipogasto
	WHERE YEAR(g.fechapago) = 2015 and tg.descripcion LIKE 'servicio%'
