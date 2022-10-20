USE base_consorcio 

--Ejercicio 26
/*Mostrar el importe total acumulado de gasto por tipo de gasto. Mostrar las descripciones de 
cada tipo de gasto de la tabla tipogasto*/

SELECT 
	MAX(tipogasto.descripcion) AS 'Descripci�n',
	SUM(importe) AS 'Importe acumulado'
FROM gasto
INNER JOIN tipogasto
ON tipogasto.idtipogasto = gasto.idtipogasto
GROUP BY gasto.idtipogasto

--Ejercicio 27
/*Mostrar los nombres de todos los consorcios y en que provincia y localidad esta cada uno. 
Ordenados por Provincia, localidad y consorcio
pertenecen.*/

SELECT top (10)
pertenecen.*/

SELECT top (10)