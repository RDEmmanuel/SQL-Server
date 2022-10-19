USE base_consorcio

--ejercicio 22
/*Mostrar el promedio de gasto por tipo de gasto, solo para aquellos pertenecientes al 1er 
semestre (períod del 1 al 6)*/

select 
	idTipoGasto as 'Tipo de Gasto', 
	AVG(importe) as 'Promedio de gasto - 1er semestre'
from gasto 
where periodo IN (1,2,3,4,5,6)
group by idtipogasto
order by idtipogasto
	
--ejercicio 23
/*Mostrar la cantidad de consorcios concentrados por zonas. 
Solo para las zonas 2 (NORTE), 3 (SUR) y 4 (ESTE)*/

select 
	idzona as 'Zona',
	COUNT(idconsorcio) as 'Cantidad consorcios por zona'
from consorcio
where idzona IN (2,3,4)
group by idzona

--ejercicio 24
/*Mostrar la cantidad de consorcios existentes por localidad. Visualizar la lista en forma 
descendente por cantidad*/

select
	idprovincia,idlocalidad,
	count(idconsorcio) as 'Cantidad consorcios por localidad'
from consorcio
group by idprovincia, idlocalidad
order by count(idconsorcio) desc

--ejercicio 25
/*Mostrar la cantidad de conserjes agrupados por estado civil y edad. Mostrar un listado 
ordenado*/

select 
	estciv as 'Estado civil',
	Edad = DATEDIFF(YEAR,fechnac,GETDATE()),	
	COUNT(idconserje) as 'Cantidad'
from conserje
group by estciv,DATEDIFF(YEAR,fechnac,getdate())
order by estciv
