USE base_consorcio

--Group by
select 
	idprovincia as 'Provincia',
	SUM(importe) as 'Total',
	count(importe) as 'Cantidad',
	AVG(importe) as 'Promedio'	
from gasto
group by idprovincia
order by idprovincia

select 
	idprovincia as 'Provincia',
	idlocalidad as 'Localidad',
	SUM(importe) as 'Total',
	count(importe) as 'Cantidad',
	AVG(importe) as 'Promedio'	
from gasto
group by idprovincia, idlocalidad
order by idprovincia

---------------------------------------
--group by y having

select 
	idprovincia as 'Provincia',
	SUM(importe) as 'Total',
	count(importe) as 'Cantidad',
	AVG(importe) as 'Promedio'	
from gasto
group by idprovincia
having AVG(importe) > 14000.0
order by idprovincia
---------------------------------------------------------------------------------

--ejercicio 20 a
--Mostrar el importe total acumulado de gasto por tipo de gasto

select 
	idtipogasto,
	SUM(importe) as 'Total'
from gasto
group by idtipogasto
order by idtipogasto

--b
/*Sobre la consulta anterior, listar solo aquellos gastos cuyos importes sean superior a 
2.000.000*/

select 
	idtipogasto as 'Tipo de gasto',
	SUM(importe) as 'Total'
from gasto
group by idtipogasto
having SUM(importe) > 2000000
order by idtipogasto

--c
/* Listar solamente los dos (2) tipos de gastos con menor importe acumulado*/

select top 2 with ties
	idtipogasto as 'Tipo de Gasto',
	SUM(importe) as 'Total'
from gasto
group by idtipogasto
order by SUM(importe) asc

-------------------------------------------------------------------------------
--ejercicio 21
--Mostrar por cada tipo de gasto, el importe del mayor gasto realizado

select
	idtipogasto as 'Tipo de Gasto',
	MAX(importe) as 'Maximo'
from gasto
group by idtipogasto