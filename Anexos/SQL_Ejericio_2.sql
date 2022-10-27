USE base_consorcio

--Ejercicio 2
/*Mostrar en un solo registro, la cantidad de consorcios que realizaron al menos un		
	gasto (variante con combinaciones y con subconsulta)
*/
--Variante con combinaciones
SELECT COUNT(*) as 'Cantidad' FROM(
	SELECT DISTINCT
		c.idprovincia,
		c.idlocalidad,
		c.idconsorcio
	FROM consorcio c
	INNER JOIN gasto g
		ON c.idconsorcio = g.idconsorcio
		AND c.idlocalidad = g.idlocalidad
		AND c.idprovincia = g.idprovincia
	) as t


---Variante con subconsulta
SELECT COUNT(*) as 'Cantidad' FROM consorcio c
WHERE EXISTS(
	SELECT g.idgasto FROM gasto g
	WHERE c.idconsorcio = g.idconsorcio
	AND c.idlocalidad = g.idlocalidad
	AND c.idprovincia = g.idprovincia
)