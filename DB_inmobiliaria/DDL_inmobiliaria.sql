--CREATE DATABASE inmobiliaria
--USE inmobiliaria

--contiene los datos de los encargados de las distintas oficinas
CREATE TABLE encargados(
	dni_encargado INT NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	telefono VARCHAR(100) NOT NULL

	CONSTRAINT PK_encargados PRIMARY KEY (dni_encargado)
)

--insert into encargados(dni_encargado,apellido,nombre,telefono) VALUES (11222333,'Perez','Juan','+5411234234')

--contiene datos de los clientes de la inmobiliaria
CREATE TABLE clientes(
	dni_cliente INT NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	telefono VARCHAR(100) NOT NULL

	CONSTRAINT PK_clientes PRIMARY KEY (dni_cliente)
)

--contiene datos sobre los propietarios de los inmuebles
CREATE TABLE propietarios(
	cuit_propietario INT NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	telefono VARCHAR(100) NOT NULL, 
	email VARCHAR(100) NOT NULL

	CONSTRAINT PK_propietarios PRIMARY KEY (cuit_propietario)
)

--contiene información sobre los distintos tipos de ambientes que pueden tener los inmuebles
CREATE TABLE tipos_ambientes(
	cod_ambiente INT IDENTITY NOT NULL,
	ambiente VARCHAR(100) NOT NULL,

	CONSTRAINT PK_tipos_ambientes PRIMARY KEY (cod_ambiente),
	CONSTRAINT UQ_tipos_ambientes_ambiente UNIQUE (ambiente)
)

--contiene los distintos tipos de inmuebles que pueden haber (casa,departamento,edificio,etc)
CREATE TABLE tipos_inmuebles(
	cod_tipo_inmueble INT IDENTITY NOT NULL,
	inmueble VARCHAR(100) NOT NULL

	CONSTRAINT PK_tipos_inmuebles PRIMARY KEY (cod_tipo_inmueble),
	CONSTRAINT UQ_tipos_inmuebles_inmueble UNIQUE (inmueble)
)


--contiene los distintos tipos de operaciones que pueden tener los inmuebles (venta,alquiler,etc)
CREATE TABLE tipos_operaciones(
	cod_operacion INT IDENTITY NOT NULL,
	operacion VARCHAR(100) NOT NULL

	CONSTRAINT PK_tipos_operaciones PRIMARY KEY (cod_operacion),
	CONSTRAINT UQ_tipos_operaciones_operacion UNIQUE (operacion)
)

--contiene los distintos tipos de recursos con respecto a las galerias que contendran imagenes,videos,etc
CREATE TABLE tipos_recursos(
	cod_tipo_recurso INT IDENTITY NOT NULL,
	recurso VARCHAR(100) NOT NULL

	CONSTRAINT PK_tipos_recursos PRIMARY KEY (cod_tipo_recurso),
	CONSTRAINT UQ_tipos_recursos_recurso UNIQUE (recurso)
)

/*contiene los distintos formatos con respecto a los tipos de recursos
--el tipo de formato tiene que estar asociado al tipo de recurso, por ejemplo si el tipo de recurso es IMAGENES, el tipo de formato puede ser JPG,JPEG,etc
--si el tipo de recurso es VIDEOS, el tipo de formato puede ser MP4,MVK,etc	*/
CREATE TABLE tipos_formatos(
	cod_tipo_recurso INT NOT NULL,
	cod_tipo_formato INT IDENTITY NOT NULL,
	formato VARCHAR(100) NOT NULL

	CONSTRAINT PK_tipos_formatos PRIMARY KEY (cod_tipo_recurso,cod_tipo_formato),
	CONSTRAINT FK_tipos_formatos_tipos_recursos FOREIGN KEY (cod_tipo_recurso) REFERENCES tipos_recursos(cod_tipo_recurso),
	CONSTRAINT UQ_tipos_formatos_formato UNIQUE (formato)
)

--contiene las distintas oficinas de la inmobiliaria
CREATE TABLE oficinas(
	nro_oficina INT IDENTITY NOT NULL,
	domicilio VARCHAR(100) NOT NULL,
	dni_encargado INT NOT NULL

	CONSTRAINT PK_oficinas PRIMARY KEY (nro_oficina),
	CONSTRAINT FK_oficinas_encargados FOREIGN KEY (dni_encargado) REFERENCES encargados(dni_encargado)
)

--contiene los distintos inmuebles relacionados con las oficinas
CREATE TABLE inmuebles(
	nro_oficina INT NOT NULL,
	nro_inmueble INT IDENTITY NOT NULL,
	superficie VARCHAR(100) NOT NULL,
	domicilio VARCHAR(100) NOT NULL,
	cod_tipo_inmueble INT NOT NULL

	CONSTRAINT PK_inmuebles PRIMARY KEY (nro_oficina,nro_inmueble),
	CONSTRAINT FK_inmuebles_oficinas FOREIGN KEY (cod_tipo_inmueble) REFERENCES tipos_inmuebles(cod_tipo_inmueble)
)

ALTER TABLE inmuebles
	ADD CONSTRAINT FK_inmuebles_oficinas_oficinas FOREIGN KEY (nro_oficina) REFERENCES oficinas(nro_oficina)


/*debido a que un inmueble puede tener uno o varios propietarios, se crea una tabla intermedia entre inmuebles y propietarios.*/
CREATE TABLE inmuebles_propietarios(
	nro_oficina INT NOT NULL,
	nro_inmueble INT NOT NULL,
	cuit_propietario INT NOT NULL

	CONSTRAINT PK_inmuebles_propietarios PRIMARY KEY (nro_oficina,nro_inmueble,cuit_propietario),
	CONSTRAINT FK_inmuebles_propietarios_inmuebles FOREIGN KEY (nro_oficina,nro_inmueble) REFERENCES inmuebles(nro_oficina,nro_inmueble),
	CONSTRAINT FK_inmuebles_propietarios_propietarios FOREIGN KEY (cuit_propietario) REFERENCES propietarios(cuit_propietario)
)

/*debido a que un inmueble puede tener varios tipos de ambientes, se crea una tabla intermedia entre inmuebles y tipos_ambientes.*/
CREATE TABLE inmuebles_tipos_ambientes(
	nro_oficina INT NOT NULL,
	nro_inmueble INT NOT NULL,
	cod_tipo_ambiente INT NOT NULL,
	cantidad INT NOT NULL

	CONSTRAINT PK_inmuebles_tipos_ambientes PRIMARY KEY (nro_oficina,nro_inmueble,cod_tipo_ambiente),
	CONSTRAINT FK_inmuebles_tipos_ambientes_inmuebles FOREIGN KEY (nro_oficina,nro_inmueble) REFERENCES inmuebles(nro_oficina,nro_inmueble),
	CONSTRAINT FK_inmuebles_tipos_ambientes_tipos_ambientes FOREIGN KEY (cod_tipo_ambiente) REFERENCES tipos_ambientes(cod_ambiente),
	CONSTRAINT CK_inmuebles_tipos_ambientes_cantidad CHECK (cantidad > 0)
)

/*debido a que un inmueble puede estar en venta o alquiler, o ambas, se crea una tabla intermedia entre inmuebles y tipos_operaciones*/
CREATE TABLE inmuebles_tipos_operaciones(
	nro_oficina INT NOT NULL,
	nro_inmueble INT NOT NULL,
	cod_operacion INT NOT NULL,
	precio FLOAT NOT NULL

	CONSTRAINT PK_inmuebles_tipos_operaciones PRIMARY KEY (nro_oficina,nro_inmueble,cod_operacion),
	CONSTRAINT FK_inmuebles_tipos_operaciones_inmuebles FOREIGN KEY (nro_oficina,nro_inmueble) REFERENCES inmuebles(nro_oficina,nro_inmueble),
	CONSTRAINT FK_inmuebles_tipos_operaciones_tipos_operaciones FOREIGN KEY (cod_operacion) REFERENCES tipos_operaciones(cod_operacion),
	CONSTRAINT CK_inmuebles_tipos_operaciones_precio CHECK (precio > 0)
)

--galeria contiene las imagenes, videos, etc de los inmuebles
CREATE TABLE galeria(
	nro_oficina INT NOT NULL,
	nro_inmueble INT NOT NULL,
	nro_galeria INT IDENTITY NOT NULL,
	descripcion VARCHAR(100) NOT NULL,
	enlace VARCHAR(200) NOT NULL,
	cod_tipo_recurso INT NOT NULL,
	cod_tipo_formato INT NOT NULL

	CONSTRAINT PK_galeria PRIMARY KEY (nro_oficina,nro_inmueble,nro_galeria),
	CONSTRAINT FK_galeria_inmueble FOREIGN KEY (nro_oficina,nro_inmueble) REFERENCES inmuebles(nro_oficina,nro_inmueble),
	CONSTRAINT FK_galeria_tipo_formato FOREIGN KEY (cod_tipo_recurso,cod_tipo_formato) REFERENCES tipos_formatos(cod_tipo_recurso,cod_tipo_formato)
)

--visitas contiene las visitas realizadas en los inmuebles, cada visita corresponde a un solo cliente
CREATE TABLE visitas(
	nro_oficina INT NOT NULL,
	nro_inmueble INT NOT NULL,
	nro_visita INT IDENTITY NOT NULL,
	fecha DATE NOT NULL,
	comentario VARCHAR(100) NOT NULL,
	dni_cliente INT NOT NULL

	CONSTRAINT PK_visitas PRIMARY KEY (nro_oficina,nro_inmueble,nro_visita),
	CONSTRAINT FK_visitas_inmuebles FOREIGN KEY (nro_oficina,nro_inmueble) REFERENCES inmuebles(nro_oficina,nro_inmueble),
	CONSTRAINT FK_visitas_clientes FOREIGN KEY (dni_cliente) REFERENCES clientes(dni_cliente)
)

ALTER TABLE visitas 
	ADD CONSTRAINT DF_visitas_fecha DEFAULT GETDATE() FOR fecha






