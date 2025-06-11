CREATE DATABASE IF NOT EXISTS conflictos;
USE conflictos;

CREATE TABLE grupoArmado (
  idGrupo INT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  bajas INT
);

CREATE TABLE territorial (
  idConflicto INT PRIMARY KEY,
  regionAfec VARCHAR(60)
);

CREATE TABLE racial (
  idConflicto INT PRIMARY KEY,
  etniaAfec VARCHAR(60) NOT NULL
);

CREATE TABLE religioso (
  idConflicto INT PRIMARY KEY,
  religionAfec VARCHAR(60) NOT NULL
);

CREATE TABLE economico (
  idConflicto INT PRIMARY KEY,
  mPrima VARCHAR(60) NOT NULL
);

CREATE TABLE conflicto (
  idConflicto INT PRIMARY KEY,
  nombre VARCHAR(65),
  tipo ENUM('territorial','racial','religioso','economico'),
  muertos INT,
  heridos INT,
  FOREIGN KEY (idConflicto) REFERENCES territorial(idConflicto),
  FOREIGN KEY (idConflicto) REFERENCES racial(idConflicto),
  FOREIGN KEY (idConflicto) REFERENCES religioso(idConflicto),
  FOREIGN KEY (idConflicto) REFERENCES economico(idConflicto)
);

CREATE TABLE intervencion (
  idGrupo INT,
  idConflicto INT,
  PRIMARY KEY (idGrupo, idConflicto),
  FOREIGN KEY (idGrupo) REFERENCES grupoArmado(idGrupo),
  FOREIGN KEY (idConflicto) REFERENCES conflicto(idConflicto)
);

CREATE TABLE division (
  idDivision INT AUTO_INCREMENT PRIMARY KEY,
  idGrupo INT,
  numBarcos INT,
  numTanques INT,
  numAviones INT,
  numHombre INT,
  bajas INT,
  FOREIGN KEY (idGrupo) REFERENCES grupoArmado(idGrupo)
);

CREATE TABLE jefeMilitar (
  idJefe INT PRIMARY KEY,
  rango VARCHAR(45)
);

CREATE TABLE dirigido (
  idDivision INT,
  idJefe INT,
  PRIMARY KEY (idDivision, idJefe),
  FOREIGN KEY (idDivision) REFERENCES division(idDivision),
  FOREIGN KEY (idJefe) REFERENCES jefeMilitar(idJefe)
);

CREATE TABLE liderPolitico (
  idLider INT PRIMARY KEY,
  nombre VARCHAR(60) NOT NULL,
  apoyos VARCHAR(100),
  idGrupo INT,
  FOREIGN KEY (idGrupo) REFERENCES grupoArmado(idGrupo)
);

CREATE TABLE organizacion (
  idOrg INT PRIMARY KEY,
  nombre VARCHAR(60) NOT NULL,
  tipo VARCHAR(45),
  idOrgPadre INT,
  FOREIGN KEY (idOrgPadre) REFERENCES organizacion(idOrg)
);

CREATE TABLE gestion (
  idLider INT,
  idOrg INT,
  PRIMARY KEY (idLider, idOrg),
  FOREIGN KEY (idLider) REFERENCES liderPolitico(idLider),
  FOREIGN KEY (idOrg) REFERENCES organizacion(idOrg)
);

CREATE TABLE arma (
  nombre VARCHAR(30) PRIMARY KEY,
  indicador VARCHAR(45) NOT NULL
);

CREATE TABLE traficante (
  nombre VARCHAR(60) PRIMARY KEY
);

CREATE TABLE suministro (
  nombreArma VARCHAR(30),
  nombreTraficante VARCHAR(60),
  PRIMARY KEY (nombreArma, nombreTraficante),
  FOREIGN KEY (nombreArma) REFERENCES arma(nombre),
  FOREIGN KEY (nombreTraficante) REFERENCES traficante(nombre)
);

CREATE TABLE suministra (
  idGrupo INT,
  nombreTraficante VARCHAR(60),
  nombreArma VARCHAR(30),
  numArmas INT NOT NULL,
  PRIMARY KEY (idGrupo, nombreTraficante, nombreArma),
  FOREIGN KEY (idGrupo) REFERENCES grupoArmado(idGrupo),
  FOREIGN KEY (nombreTraficante) REFERENCES traficante(nombre),
  FOREIGN KEY (nombreArma) REFERENCES arma(nombre)
);
