USE base_consorcio

--Ejercicio 1
/*Variante del ejercicio 26 (serie 2). Agregar un nuevo tipo de gasto, y mostrar en el 
	listado final los tipos de gastos que no se registraron en la tabla gastos.
*/

/*Inserto nuevo tipo de gasto*/
INSERT INTO tipogasto(idtipogasto,descripcion) VALUES(6,'Nuevo tipo de Gasto')

/*Tipos de gasto que no se registraron en la tabla gasto*/
SELECT
	tg.idtipogasto,tg.descripcion
FROM tipogasto tg
LEFT JOIN gasto g
	ON tg.idtipogasto = g.idtipogasto
	WHERE g.idtipogasto IS NULL

/*tipos de gastos y el importe total acumulado*/
SELECT 
	MAX(tipogasto.descripcion) AS 'Descripción',
	SUM(importe) AS 'Importe acumulado'
FROM gasto
RIGHT JOIN tipogasto
ON tipogasto.idtipogasto = gasto.idtipogasto
GROUP BY gasto.idtipogasto