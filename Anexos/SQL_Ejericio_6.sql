USE base_consorcio

--Ejercicio 6
/*Calcular el promedio de gasto anual (año 2015) por consorcio en concepto de 
	'sueldos', y mostrar los consorcios que superen ese monto en este ítem de gasto en el 
	mismo año.
*/
SELECT	
	min(c.nombre) as 'Consorcio',
	AVG(g.importe) as [Promedio anual],
	SUM(g.importe) as [Importe total]
FROM consorcio c
INNER JOIN gasto g
	ON c.idconsorcio = g.idconsorcio
	AND c.idlocalidad = g.idlocalidad
	AND c.idprovincia = g.idprovincia
INNER JOIN tipogasto tg
	ON g.idtipogasto = tg.idtipogasto
	WHERE YEAR(g.fechapago) = 2015 AND tg.descripcion LIKE 'sueldo%'
GROUP BY c.nombre
HAVING SUM(g.importe) > AVG(g.importe)
ORDER BY [Promedio anual] DESC