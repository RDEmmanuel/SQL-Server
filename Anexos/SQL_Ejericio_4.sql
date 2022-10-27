USE base_consorcio

/*Cantidad de administradores que estan relacionados a un consorcio 
	y promedio de edades de esos administradores. Se utiliza la funcion edad defininda
	previamente*/
SELECT 
	COUNT(a.idadmin) as 'Cantidad',
	AVG(dbo.Edad(a.fechnac)) as 'Promedio'
FROM administrador a
INNER JOIN consorcio c
	ON c.idadmin = a.idadmin

	  
--Ejercicio 4
/*Mostrar los administradores con consorcios que estén por debajo del promedio de 
	edad solo de los administradores asignados a estos consorcios..
	Se utiliza la funcion edad definida previamente.
*/
SELECT 
	a.idadmin as 'ID Admin',
	a.apeynom as 'Apellido y Nombre',
	dbo.Edad(a.fechnac) as 'Edad',
	a.tel as 'Teléfono',
	a.sexo as 'Sexo'
FROM administrador a
INNER JOIN consorcio c
	ON a.idadmin = c.idadmin
	WHERE dbo.Edad(a.fechnac) < 
	(
		SELECT AVG(dbo.Edad(a.fechnac)) FROM administrador a		
		INNER JOIN consorcio c
			ON c.idadmin = a.idadmin
	)
ORDER BY Edad DESC