--funcion que calcula la edad 

CREATE FUNCTION Edad 
	(@fecha datetime)
	RETURNS INT
	BEGIN
	RETURN DATEDIFF(YEAR,@fecha,GETDATE())
		-(CASE
		WHEN DATEADD(YY,DATEDIFF(YEAR,@fecha,GETDATE()),@fecha)>GETDATE() THEN
		1
		ELSE
		0 
		END)
	END;