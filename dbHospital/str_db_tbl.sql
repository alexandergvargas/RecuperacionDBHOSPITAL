create database dbHospital



<---Creando esquemas---->

create Schema Paciente
go

create Schema Medico
go

create Schema Historia
go


<---Creando tabla Paciente---->

use dbHospital


CREATE TABLE Paciente.Paciente
(
	CODPAC INT NOT NULL IDENTITY(1,1),
	NOMPAC VARCHAR(120) NOT NULL,
	APEPATPAC VARCHAR(120) NOT NULL,
	APEMATPAC VARCHAR(120) NOT NULL,
	FECNACPAC DATE NOT NULL, 
	SEXPAC CHAR(1) NOT NULL,
	DNIPAC CHAR(8) NOT NULL,
	TELEFPAC VARCHAR(9),
	EMAILPAC VARCHAR(100),
	DOMPAC VARCHAR(120) NOT NULL,
	UBIGEOPAC CHAR(6) NOT NULL,
	FECREGPAC DATETIME,
	OBSERPAC VARCHAR(250),
	CONSTRAINT PK_CODPAC PRIMARY KEY(CODPAC)
)
GO

<---Creando tabla Historia---->

CREATE TABLE Paciente.Historia_Paciente
(
	CODHIST INT NOT NULL,
	CODPAC INT NOT NULL, 
	CODMED INT NOT NULL, 
	CONSTRAINT PK_HISTORIA_PACIENTE PRIMARY KEY(CODHIST, CODPAC, CODMED)
)
GO

<---Creando tabla Historia_Paciente---->



CREATE TABLE Paciente.Ubigeo
(
	CODUB CHAR(6) NOT NULL,
	DISTUB VARCHAR(60),
	PROVUB VARCHAR(60),
	DEPUB VARCHAR(60),
	CONSTRAINT PK_CODUB PRIMARY KEY(CODUB)
)
GO

<---Creando tabla Turno---->


CREATE TABLE Paciente.Turno_Paciente
(
	CODTUR INT NOT NULL,
	CODPAC INT,
	CODMED INT,
	CONSTRAINT PK_TURNO_PACIENTE PRIMARY KEY(CODTUR, CODPAC, CODMED)
)
GO


<---Creando tabla Turno Paciente---->

CREATE TABLE Medico.Medico
(
	CODMED INT NOT NULL	 IDENTITY(1,1),
	NOMMED VARCHAR(120) NOT NULL,
	APEPATMED VARCHAR(120) NOT NULL,
	APEMATMED VARCHAR(120) NOT NULL,
	FECNACMED DATE NOT NULL, 
	SEXMED CHAR(1) NOT NULL,
	DNIMED CHAR(8) NOT NULL,
	TELEFMED VARCHAR(9),
	EMAILMED VARCHAR(120),
	DOMMED VARCHAR(120) NOT NULL,
	UBIGEOMED CHAR(6) NOT NULL,
	FECREGMED DATETIME,
	OBSERMED VARCHAR(180),
	CONSTRAINT PK_CODMED PRIMARY KEY(CODMED)
)
GO

<---Creando Tabla Ubigeo---->


CREATE TABLE Medico.Especialidad
(
	CODESP INT NOT NULL IDENTITY(1,1),
	NOMESP VARCHAR(80) NOT NULL,
	OBSESP VARCHAR(100),
	CONSTRAINT PK_CODESP PRIMARY KEY(CODESP)
)
GO
<---Creando Tabla Especialidad---->

CREATE TABLE Medico.Medico_Especialidad
(
	CODMED INT NOT NULL,
	CODESP INT NOT NULL,
	DESESP VARCHAR(1000),
	CONSTRAINT PK_MEDICO_ESPECIALIDAD PRIMARY KEY(CODMED,CODESP)
)
GO
<---Creando Tabla Medico---->

CREATE TABLE Historia.Historia
(
	CODHIST INT NOT NULL IDENTITY(1,1),
	FECHIST DATETIME NOT NULL,
	OBSHIST VARCHAR(1800) NOT NULL,
	CONSTRAINT PK_CODHIST PRIMARY KEY(CODHIST)
)
GO

<---Creando Tabla Medico_Especialista---->

CREATE TABLE Historia.Turno
(
	CODTUR INT NOT NULL IDENTITY(1,1),
	FECTUR DATETIME,
	ESTTUR SMALLINT,
	OBSTUR VARCHAR(500),
	CONSTRAINT PK_CODTUR PRIMARY KEY(CODTUR)
)
GO
<---Creando las relaciones---->

ALTER TABLE Paciente.Paciente
	ADD CONSTRAINT FK_PACIENTE_UBIGEO FOREIGN KEY (UBIGEOPAC)
	REFERENCES Paciente.Ubigeo(CODUB)

ALTER TABLE Medico.Medico_Especialidad
	ADD CONSTRAINT FK_MEDICO_ESPECIALIDAD_MEDICO FOREIGN KEY (CODMED)
	REFERENCES Medico.Medico(CODMED)

ALTER TABLE Medico.Medico_Especialidad
	ADD CONSTRAINT FK_MEDICO_ESPECIALIDAD_ESPECIALIDAD FOREIGN KEY (CODESP)
	REFERENCES Medico.Especialidad(CODESP)

ALTER TABLE Paciente.Turno_Paciente
	ADD CONSTRAINT FK_TURNO_PACIENTE_TURNO FOREIGN KEY(CODTUR)
	REFERENCES Historia.Turno(CODTUR)

ALTER TABLE Paciente.Turno_Paciente
	ADD CONSTRAINT FK_TURNO_PACIENTE_PACIENTE FOREIGN KEY(CODPAC)
	REFERENCES Paciente.Paciente(CODPAC)

ALTER TABLE Paciente.Turno_Paciente
	ADD CONSTRAINT FK_TURNO_PACIENTE_MEDICO FOREIGN KEY(CODMED)
	REFERENCES Medico.Medico(CODMED)

ALTER TABLE Paciente.Historia_Paciente
	ADD CONSTRAINT FK_HISTORIA_PACIENTE_PACIENTE  FOREIGN KEY(CODPAC)
	REFERENCES Paciente.Paciente(CODPAC)

ALTER TABLE Paciente.Historia_Paciente
	ADD CONSTRAINT FK_HISTORIA_PACIENTE_MEDICO FOREIGN KEY(CODMED)
	REFERENCES Medico.Medico(CODMED)

ALTER TABLE Paciente.Historia_Paciente
	ADD CONSTRAINT FK_HISTORIA_PACIENTE_HISTORIA FOREIGN KEY(CODHIST)
	REFERENCES Historia.Historia(CODHIST)

ALTER TABLE Medico.Medico
	ADD CONSTRAINT FK_MEDICO_UBIGEO FOREIGN KEY(UBIGEOMED)
	REFERENCES Paciente.Ubigeo


<---Insertamos datos en la tabla Historia---->
INSERT INTO Historia.Historia
(FECHIST, OBSHIST)
VALUES
	('2000-03-01 00:00:00.000', 'El paciente se atendió sin problemas'),
	('2002-04-05 00:00:00.000', 'El paciente tiene que llevar controles semanales'),
	('2007-10-04 00:00:00.000', 'El paciente debe tomar los medicamentos indicados en la consulta'),
	('2010-12-10 00:00:00.000', 'El paciente debe ser transferido a Lima');
GO



<---Insertamos datos en la tabla Turno---->
INSERT INTO Historia.Turno
	(FECTUR, ESTTUR, OBSTUR)
VALUES
	('1979-11-07 10:30:20.000', '1', 'Primer turno del día'),
	('1979-11-07 11:00:20.000', '1', 'Segundo turno del día'),
	('1979-11-07 10:30:20.000', '1', 'Tercer turno del día'),
	('1979-11-07 00:00:20.000', '1', 'Cuarto turno del día'),
	('1979-11-07 13:00:20.000', '1', 'Quinto turno del día'),
	('1979-11-07 13:30:20.000', '1', 'Sexto turno del día');
GO

<---Insertamos datos en la tabla Especialidad---->
INSERT INTO Medico.Medico
	(NOMMED, APEPATMED, APEMATMED, FECNACMED, SEXMED, DNIMED, TELEFMED, EMAILMED, DOMMED, UBIGEOMED, FECREGMED, OBSERMED)
VALUES
	('Esperanza', 'Ramírez', 'Tadeo', '1979-07-11', 'F', '43650976', 'null', 'esperanza@yahoo.com', 'Av. Los Laureles', '150512', '2019-04-30 07:09:07.713', 'Médico de la ciudad de Lima'),
	('Alberto', 'Ramírez', 'Pasache', '1976-06-06', 'M', '56782955', '998765123', 'alberto@gmail.com', 'Av. Los Trigales', '150508', '2019-04-30 07:09:16.117', 'Médico muy trabajador'),
	('Rosa', 'Martínez', 'Osorio', '1980-10-05', 'F', '58122656', '998877654', 'rosa@outlook.com', 'Av. Los Laureles', '150510', '2019-04-30 07:09:16.117', 'Médico muy responsable'),
	('Gloria', 'Zevallos', 'Pachas', '1974-12-25', 'F', '67450988', '998877432', 'gloria@hotmail.com', 'Av. Los Laureles', '150514', '2019-04-30 07:09:16.117', 'Médico local muy proactivo');
GO


INSERT INTO Medico.Especialidad
	(NOMESP, OBSESP)
VALUES
	('Medicina General', 'Es para atención de enfermedades en general'),
	('Odontología', 'Atención dental'),
	('Pediatría', 'Atención para niños'),
	('Oftamología', 'Atención de la vista'),
	('Nutrición', 'Relacionado con temas de alimentación');
GO


INSERT INTO Medico.Medico_Especialidad
	(CODMED, CODESP, DESESP)
VALUES
	(1, 2, 'Atiende todo el día, los días L-M-V'),
	(1, 4, 'Atiende todo el día, los días M-J'),
	(2, 3, 'Atiende todo el día, solo los jueves'),
	(2, 4, 'Atención los días sábados de 8am a 1pm'),
	(3, 3, 'Atención Martes y Jueves sólo por la mañana');
GO

INSERT INTO Paciente.Historia_Paciente
	(CODHIST, CODPAC, CODMED)
VALUES
	('1', '1',' 3'),
	('2',' 7', '4'),
	('3', '2', '1'),
	('4', '3', '2');
GO


INSERT INTO Paciente.Turno_Paciente
	(CODTUR, CODPAC, CODMED)
VALUES
	('2', '1', '4'),
	('4', '4', '3');
GO


INSERT INTO Paciente.Turno_Paciente
	(CODTUR, CODPAC, CODMED)
VALUES
	('1', '1', '4'),
	('6', '2',' 1'),
	('5', '3', '3')
GO