start transaction;

CREATE TABLE Pessoa(
	id serial PRIMARY KEY,
	nome varchar(40) NOT NULL,
	morada varchar(150) NOT NULL,
	email varchar(40) NOT NULL CHECK (email ~ '.+@.+\.\w{1,}'),
	telefone varchar(30) NOT NULL CHECK (telefone ~ '^\d{4,15}$'),
	noident char(12) NOT NULL UNIQUE,
	nacionalidade varchar(20) NOT NULL,
	atrdisc char(2) NOT NULL CHECK (atrdisc IN('G', 'C'))
);

CREATE TABLE Loja(
	codigo integer PRIMARY KEY,
	email varchar(40) NOT NULL CHECK (email ~ '.+@.+\.\w{1,}'),
	endereco varchar(100) NOT NULL,
	localidade varchar(30) NOT NULL,
	gestor integer NOT NULL REFERENCES Pessoa(id)
);

CREATE TABLE TelefoneLoja(
	loja integer UNIQUE REFERENCES Loja(codigo),
	numero varchar(10) PRIMARY KEY CHECK (numero ~ '^\d{4,15}$')
);


CREATE TABLE Dispositivo(
	noserie integer PRIMARY KEY,
	latitude numeric(6,4) NOT NULL,
	longitude numeric(6,4) NOT NULL,
	bateria integer NOT NULL CHECK (integer BETWEEN 0 AND 100)
);

CREATE TABLE Bicicleta(
	id serial PRIMARY KEY,
	peso numeric(4,2) NOT NULL,
	raio integer NOT NULL CHECK (integer BETWEEN 13 AND 23),
	modelo varchar(20) NOT NULL,
	marca varchar(30) NOT NULL,
	mudanca integer CHECK (mudanca IN(1, 6, 18, 24)),
	estado varchar(30) NOT NULL CHECK (estado IN('livre', 'ocupado', 'em manutenção')),
	atrdisc char(2) NOT NULL CHECK (atrdisc IN('C', 'E')),
	dispositivo integer NOT NULL REFERENCES Dispositivo(noserie)
);

CREATE TABLE Classica(
	bicicleta integer PRIMARY KEY REFERENCES Bicicleta(id),
	nomudanca integer NOT NULL CHECK (integer BETWEEN 0 AND 5)
);

CREATE TABLE Eletrica(
	bicicleta integer PRIMARY KEY REFERENCES Bicicleta(id),
	autonomia integer NOT NULL,
	velocidade integer NOT NULL
);


CREATE TABLE Reserva(
	noreserva serial PRIMARY KEY,
	loja integer NOT NULL REFERENCES Loja(codigo),
	dtinicio timestamp NOT NULL CHECK (dtinicio < CURRENT_TIMESTAMP(0)), 
	dtfim timestamp CHECK (dtfim > dtinicio),
	valor numeric(4,2) NOT NULL,
	bicicleta integer NOT NULL REFERENCES Bicicleta(id)
);


CREATE TABLE ClienteReserva(
    cliente integer PRIMARY KEY REFERENCES Pessoa(id),
    reserva integer NOT NULL REFERENCES Reserva(noreserva),
    loja integer NOT NULL REFERENCES Loja(codigo)
);

commit;