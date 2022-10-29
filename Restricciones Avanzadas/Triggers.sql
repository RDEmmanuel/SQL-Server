-----------------------------------------------------
--  CONSTRAINT DEFAULT + TRIGGER ACTUALIZACION
-----------------------------------------------------
-- DROP TABLE movim
CREATE TABLE movimiento(
	id_movimiento int IDENTITY NOT NULL PRIMARY KEY,
	cant int NULL,
	descripcion	varchar(50) NULL,
	fecha_ing datetime NULL
	CONSTRAINT [DF_mivimiento_fecha_ing] DEFAULT (getdate()), -- Fecha Ingreso Registro
	fecha_act datetime    NULL, -- Fecha Actualizacion Registro
	user_ing varchar (20) NULL -- Usuario Ingreso Registro
   --CONSTRAINT [DF_Movim_user_ing] DEFAULT (LOWER(SUBSTRING(SUSER_SNAME(),1,20))), -- Usuario Ingreso Registro
	CONSTRAINT [DF_Movim_user_ing] DEFAULT (SUSER_SNAME()), -- Usuario Ingreso Registro   
	user_act varchar (20) NULL -- Usuario Actualizacion Registro
)

-- =====================================================
-- Creo  Trigger Auditoria modificacion de registros 
-- =====================================================

-- DROP TRIGGER dbo.TG1_movimiento

CREATE TRIGGER dbo.TG1_movimiento
   ON   dbo.movimiento FOR UPDATE
AS 
BEGIN
-- Actualizo el usuario y la ultima fecha de modificacion del registro
UPDATE dbo.movimiento
SET user_act = suser_sname(),
  fecha_Act = getdate()
FROM inserted AS I 
INNER JOIN dbo.movimiento AS V 	ON I.id_movimiento = V.id_movimiento
END


INSERT INTO movimiento (cant, descripcion, fecha_ing, fecha_Act, user_ing, user_act)
VALUES (1,'PRUEBA 1',default, default, default, default)

SELECT * FROM movimiento

UPDATE movimiento 
SET descripcion = 'PRUEBA 2'
WHERE id_movimiento = 1

SELECT * FROM movimiento

--Drop table movimiento