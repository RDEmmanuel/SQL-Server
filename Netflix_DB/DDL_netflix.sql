
-- DROP DATABASE netflix_titles;
CREATE DATABASE netflix_titles;
GO
USE netflix_titles;
GO
-- DROP TABLE titles;
CREATE TABLE titles(
	id int NOT NULL,
	show_id varchar(50) NULL,
	title varchar(255) NULL,
	date_added datetime NULL,
	release_year INT NULL,
	duration varchar(255) NULL,
	[description] varchar(255) NULL,
	id_rating int NULL,
	id_type_movie int NULL,
 CONSTRAINT PK_titles PRIMARY KEY(id)
 );

GO
CREATE TABLE actor(
	id int NOT NULL,
	names varchar(250) NULL,
 CONSTRAINT PK_actor PRIMARY KEY (id)
);

GO

CREATE TABLE dbo.country(
	id int NOT NULL,
	[description] varchar(250) NULL,
 CONSTRAINT PK_country PRIMARY KEY (id)
 );
GO

CREATE TABLE dbo.director(
	id int NOT NULL,
	[description] varchar(50) NULL,
	CONSTRAINT PK_director PRIMARY KEY (id)
);

GO

CREATE TABLE dbo.genere(
	id int NOT NULL,
	[description] varchar(50) NULL,
 CONSTRAINT PK_genere PRIMARY KEY (id)
);

CREATE TABLE dbo.rating(
	id int NOT NULL,
	[description] varchar(50) NULL,
 CONSTRAINT PK_rating PRIMARY KEY (id)
);

CREATE TABLE dbo.type_movie(
	id int NOT NULL,
	[description] varchar(50) NULL,
 CONSTRAINT PK_type_movie PRIMARY KEY (id)
);

GO

CREATE TABLE dbo.title_actor(
	id_title int NOT NULL,
	id_actor int NOT NULL,
 CONSTRAINT PK_title_actor PRIMARY KEY (id_title,id_actor)
);

GO

CREATE TABLE dbo.title_country(
	id_title int NOT NULL,
	id_country int NOT NULL,
 CONSTRAINT PK_title_country PRIMARY KEY (id_title,id_country)
);

CREATE TABLE dbo.title_director(
	id_title int NOT NULL,
	id_director int NOT NULL,
 CONSTRAINT PK_title_director PRIMARY KEY (id_title,id_director)
);


GO

CREATE TABLE dbo.title_genere(
	id_title int NOT NULL,
	id_genere int NOT NULL,
 CONSTRAINT PK_title_genere PRIMARY KEY (id_title,id_genere)
);


ALTER TABLE titles
	ADD 
		CONSTRAINT FK_titles_rating FOREIGN KEY (id_rating) REFERENCES rating(id),
		CONSTRAINT FK_titles_type_movie FOREIGN KEY (id_type_movie) REFERENCES type_movie(id);

ALTER TABLE title_actor
	ADD 
		CONSTRAINT FK_title_actor_titles FOREIGN KEY (id_title) REFERENCES titles(id),
		CONSTRAINT FK_title_actor_actor FOREIGN KEY (id_actor) REFERENCES actor(id);

ALTER TABLE title_country
	ADD 
		CONSTRAINT FK_title_country_titles FOREIGN KEY (id_title) REFERENCES titles(id),
		CONSTRAINT FK_title_country_country FOREIGN KEY (id_country) REFERENCES country(id);
		
ALTER TABLE title_director
	ADD 
		CONSTRAINT FK_title_director_titles FOREIGN KEY (id_title) REFERENCES titles(id),
		CONSTRAINT FK_title_director_director FOREIGN KEY (id_director) REFERENCES director(id);	

ALTER TABLE title_genere
	ADD 
		CONSTRAINT FK_title_genere_titles FOREIGN KEY (id_title) REFERENCES titles(id),
		CONSTRAINT FK_title_genere_genere FOREIGN KEY (id_genere) REFERENCES genere(id);

