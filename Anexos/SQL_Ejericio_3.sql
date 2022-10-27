USE base_consorcio 

--Ejercicio 3
/* Mostrar los administradores que no est�n asignados a ning�n consorcio (variante con 
	combinaciones y con subconsulta)
*/
--Variante con combinaciones
SELECT 
	a.idadmin,a.apeynom
FROM administrador a
LEFT JOIN consorcio c
	ON a.idadmin = c.idadmin
	WHERE c.idadmin IS NULL

--Variante con subconsulta
SELECT * FROM administrador a
WHERE NOT EXISTS(
	SELECT c.idadmin FROM consorcio c
	WHERE c.idadmin = a.idadmin
)
