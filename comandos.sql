CREATE DATABASE BD05042019

USE BD05042019

--Comandos de criação de tabelas

CREATE TABLE Pessoa(
RA INT PRIMARY KEY IDENTITY (111,1),
Nome VARCHAR(100) NOT NULL,
CPF Varchar(14) UNIQUE NOT NULL,  
Telefone VARCHAR(17) NOT NULL
)

CREATE TABLE Aluno(
RA_Aluno INT PRIMARY KEY FOREIGN KEY REFERENCES Pessoa(RA),
Ano INT DEFAULT 2019,
Curso VARCHAR(30),
Semestre INT NOT NULL CHECK(Semestre>0),
)

CREATE TABLE Professor(
RA_Professor INT PRIMARY KEY FOREIGN KEY REFERENCES Pessoa(RA),
Departamento VARCHAR(60) NOT NULL,
Salario FLOAT NOT NULL CHECK(Salario>0)
)

CREATE TABLE Disciplina(
ID INT PRIMARY KEY IDENTITY(1111,1),
Professor_RA INT FOREIGN KEY REFERENCES Professor(RA_Professor),
Nome Varchar(60) NOT NULL,
Carga INT NOT NULL
)


CREATE TABLE Cursa(
Disciplina_ID INT FOREIGN KEY REFERENCES Disciplina(ID) NOT NULL,
Aluno_RA INT FOREIGN KEY REFERENCES Aluno(RA_Aluno),
Nota FLOAT,
Faltas INT NOT NULL DEFAULT 0
)


--Comandos de inserção

INSERT INTO Pessoa(Nome, CPF, Telefone)
VALUES ('Chico Siqueira', '000.000.000-00', '0000-0000'),
		('Paula Matos', '111.111.111-11', '11111-1111'),
		('Belchior Silva', '000.000.000-22', '2222-2222'),
		('Felicia Aydar', '000.000.000-33', '3333-3333'),
		('Mariana Veloso', '000.000.000-44', '44444-4444'),
		('Caetano Gil', '000.000.000-55', '5555-5555')

INSERT INTO Aluno( RA_Aluno, Ano, Curso, Semestre)
VALUES (115, 2018, 'Letras', 3)

INSERT INTO Aluno( RA_Aluno, Curso, Semestre)
VALUES (112, 'Marketing', 1)

INSERT INTO Professor(RA_Professor, Departamento, Salario)
VALUES (111, 'Letras', 2000),
		(113,'Comunicação',2000),
		(114, 'Tecnologia',1900)

INSERT INTO Disciplina(Professor_RA, Nome, Carga)
VALUES (111, 'Português', 80),
		(111, 'Redação', 60),
		(113, 'História da Arte', 80),
		(114, 'Fundamentos de Marketing', 80),
		(114, 'Marketing de Varejo',60),
		(111, 'Literatura Portuguesa', 80)

INSERT INTO Cursa(Disciplina_ID, Aluno_RA,Nota,Faltas)
VALUES	(1111, 115, 8, 2),
		(1112, 115, 5, 0),
		(1116, 115, 9, 26)

INSERT INTO Cursa(Disciplina_ID, Aluno_RA,Nota,Faltas)
VALUES	(1111, 112, 9, 0),
		(1113, 112, 6, 24),
		(1114, 112, 5, 6)

--Comandos Update

UPDATE Pessoa SET Telefone = '1234-5678'
	WHERE RA = 111

--Comandos de seleção
SELECT * FROM Pessoa


SELECT * FROM Professor
RIGHT JOIN Pessoa ON Professor.RA_Professor = Pessoa.RA
WHERE Departamento != 'NULL'

SELECT * FROM Disciplina
LEFT JOIN Pessoa ON Disciplina.Professor_RA = Pessoa.RA
WHERE Professor_RA != 111

SELECT * FROM Pessoa
FULL JOIN Aluno ON Pessoa.RA = Aluno.RA_Aluno
FULL JOIN Professor ON Pessoa.RA = Professor.RA_Professor
FULL JOIN Disciplina ON Professor.RA_Professor = Disciplina.Professor_RA
FULL JOIN Cursa ON Aluno.RA_Aluno = Cursa.Aluno_RA

--Criação de View - Buscar os alunos que só cursam a disciplina de Português. Alterar nome de coluna repetida.

CREATE VIEW Portugues
AS
SELECT Pessoa.Nome, Aluno.RA_Aluno, Disciplina.Nome AS NomeDisciplina, Disciplina.ID FROM Cursa
INNER JOIN Disciplina ON Cursa.Disciplina_ID = Disciplina.ID
INNER JOIN Aluno ON Aluno.RA_Aluno = Cursa.Aluno_RA
INNER JOIN Pessoa ON Aluno.RA_Aluno = Pessoa.RA

SELECT * FROM Portugues

-- View para buscar alunos reprovados por nota ou falta

CREATE VIEW Reprovados
AS
SELECT Pessoa.Nome, Aluno.RA_Aluno, Disciplina.Nome AS NomeDisciplina, Disciplina.ID, Cursa.Nota, Cursa.Faltas FROM Cursa
INNER JOIN Disciplina ON Cursa.Disciplina_ID = Disciplina.ID
INNER JOIN Aluno ON Aluno.RA_Aluno = Cursa.Aluno_RA
INNER JOIN Pessoa ON Aluno.RA_Aluno = Pessoa.RA
WHERE Nota<6 or Faltas > 10  

SELECT * FROM Reprovados

-- Outros comandos

DROP TABLE Pessoa

DELETE FROM Disciplina
WHERE ID = 1115


