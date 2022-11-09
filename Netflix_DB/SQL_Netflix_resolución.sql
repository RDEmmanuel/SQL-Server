USE netflix_titles

/* Actividades	1)
	Mostrar el listado de series o pel�culas cuya duraci�n est�n organizadas en 1 o m�s 
	temporadas (seasons) , con la descripci�n del tipo de producto (type_movie)		*/

SELECT	
	t.title, t.duration, tm.description
FROM titles t
INNER JOIN type_movie tm
	ON t.id_type_movie = tm.id
WHERE t.duration LIKE '%season%'


/*	2) Netflix quiere dar de baja de su plataforma a todos aquellos t�tulos que a junio (inclusive) 
del 2023 tengan 15 a�os (180 meses) de antig�edad o m�s. Mostrar todos los t�tulos que 
pueden llegar a cumplir con esta condici�n	*/

SELECT 
	title,
	DATEDIFF(MONTH,date_added,'20230630') as 'Meses Antiguedad', 
	(2023 - YEAR(date_added)) as 'A�os Antiguedad'
FROM titles
WHERE (YEAR(date_added) + 15) <= 2023


/*	3) Mostrar un listado de todos los actores que participaron en 20 o m�s pel�culas (solo para 
este tipo de formato)	*/


/*Esta consulta devuelve la cantidad de actores por cada title*/
SELECT
	min(ta.id_title), count(ta.id_actor)
FROM titles t
INNER JOIN title_actor ta
	ON ta.id_title = t.id
INNER JOIN actor a
	ON a.id = ta.id_actor
GROUP BY ta.id_title


-- Esta consulta devuelve todos los actores que participaron en 20 o m�s titles, sin importar el type_movie
SELECT 
	ta.id_actor, COUNT(ta.id_title)
FROM title_actor ta
GROUP BY ta.id_actor
HAVING COUNT(ta.id_title) >= 20


--solucion ejercicio 3
SELECT 
	ta.id_actor,
	a.names, 
	COUNT(ta.id_title) as [Cantidad de pel�culas]
FROM title_actor ta
INNER JOIN titles t
	ON ta.id_title = t.id
INNER JOIN actor a
	ON ta.id_actor = a.id
WHERE t.id_type_movie = 1 --en este caso sabemos que el id_type_movie = 1 corresponde a 'movie'
GROUP BY ta.id_actor,a.names
HAVING COUNT(ta.id_title) >= 20
ORDER BY COUNT(ta.id_title) DESC


/* Otra forma de resolver es haciendo un INNER JOIN con type_movie y cambiar la condici�n del WHERE para 
 que solo tenga en cuenta los titles que tengan type_movie descripcion = 'movie'.
 Esto sirve en el caso de no saber con exactitud el id de los type_movie */
SELECT 
	ta.id_actor,
	a.names, 
	COUNT(ta.id_title) as [Cantidad de pel�culas]
FROM title_actor ta
INNER JOIN titles t
	ON ta.id_title = t.id
INNER JOIN actor a
	ON ta.id_actor = a.id
INNER JOIN type_movie tm
	ON t.id_type_movie = tm.id
WHERE tm.description LIKE 'movie'
GROUP BY ta.id_actor,a.names
HAVING COUNT(ta.id_title) >= 20
ORDER BY COUNT(ta.id_title) DESC


/*	4) Variante del punto 3. A partir del ejercicio anterior, calcular tambi�n el promedio en 
minutos de las pel�culas en las que trabaj� cada actor.	*/

SELECT 
	ta.id_actor,
	a.names, 
	COUNT(ta.id_title) AS [Cantidad de pel�culas],
	AVG(CONVERT(BIGINT, LEFT(t.duration, PATINDEX('%[^0-9]%',t.duration +' ')-1))) AS [Promedio en minutos]
FROM title_actor ta
INNER JOIN titles t
	ON ta.id_title = t.id
INNER JOIN actor a
	ON ta.id_actor = a.id
WHERE t.id_type_movie = 1
GROUP BY ta.id_actor,a.names
HAVING COUNT(ta.id_title) >= 20
ORDER BY COUNT(ta.id_title) DESC


/* 5) Mostrar el listado de directores que nunca dirigieron una pel�cula (movie). Se requiere 
identificar la o las soluciones posibles. */

SELECT
	d.id as 'ID director',
	d.description as 'Nombre y Apellido'
FROM title_director td
INNER JOIN director d
	ON td.id_director = d.id
WHERE td.id_director NOT IN (
							SELECT DISTINCT 
								id_director
							FROM title_director td
							INNER JOIN titles t 
								ON t.id = td.id_title
							WHERE t.id_type_movie = 1)
ORDER BY 1


--directores que tienen peliculas (type_movie = 1)
SELECT DISTINCT
	td.id_director
FROM title_director td
INNER JOIN titles t 
	ON td.id_title = t.id
WHERE t.id_type_movie = 1




/*	Devuelve los primeros 3 car�cteres de la cadena que recibe como par�metro	*/
SELECT LEFT(duration,3) FROM titles WHERE titles.id_type_movie = 1

----------------------------------------------------------------------------------------------------------------
/*	Devuelve la posici�n del caracter pasado como par�metro en el CHARINDEX
	En este caso se le pasa el espacio como par�metro, devuelve la posici�n del espacio encontrado por ejemplo:
	title id = 1 duration = '91 min' 
	el espacio se encuentra en la posici�n 3	*/
SELECT id, CHARINDEX(' ', duration) FROM titles
----------------------------------------------------------------------------------------------------------------

/*	Devuelve los car�cteres que se encuentran despu�s del espacio, en este caso se le indica que devuelva los 3
	car�cteres desp�es del espacio. El +1 es para que no incluya el espacio.*/
SELECT SUBSTRING(duration, CHARINDEX(' ', duration)+1,3) FROM titles

----------------------------------------------------------------------------------------------------------------
/*	PATINDEX (Transact-SQL) Devuelve la posici�n inicial de la primera repetici�n de un patr�n 
	en la expresi�n especificada, o ceros si el patr�n no se encuentra, en todos los tipos 
	de datos de texto�y�caracteres.	*/
SELECT CONVERT(BIGINT, LEFT(duration, PATINDEX('%[^0-9]%',duration +' ')-1)) FROM titles


