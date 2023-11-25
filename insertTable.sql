start transaction;

INSERT INTO Pessoa (id, nome, morada, email, telefone, noident, nacionalidade, atrdisc) VALUES
    (1, 'Peter Pan', 'Terra do Nunca', 'peter@gmail.com', '919821731', '15223370', 'Inglêsa','C'),
    (2, 'Mulan', 'Rua do Sol-posto', 'mulan@gmail.com', '919821732', '15223371', 'Chinesa', 'G'),
    (3, 'Pocahontas', 'Floresta Encantada', 'pocahontas@gmail.com', '919821733', '15223372', 'Nativa Americana', 'C'),
    (4, 'Hércules', 'Praça Central de Atenas','hercules@gmail.com', '919821734', '15223373', 'Grega', 'C'),
	(5, 'João Filipe', 'Avenida da República','joaofilipe@gmail.com', '919821735', '15223374', 'Portuguesa', 'C'),
	(6, 'Alice', 'País das Maravilhas','alice@gmail.com', '919821736', '15223375', 'Alemã', 'C'),
	(7, 'José Manuel', 'Avenida de Roma','zemanel@gmail.com', '919821737', '15223376', 'Portuguesa', 'C'),
	(8, 'Christopher Robin', 'Bosque dos Cem Acres','christopher@gmail.com', '919821738', '15223377', 'Inglêsa', 'G');


INSERT INTO Loja (codigo, email, endereco, localidade, gestor) VALUES
	(
		123, 'magic-store@gmail.com', 'Diagon Alley', 'Londres', 
		(SELECT id FROM Pessoa WHERE noident = '15223371')
	),
	(
		456, 'theportugueseshire@gmail.com', 'The Mediterranean Shire Avenue', 'Lisboa', 
		(SELECT id FROM Pessoa WHERE noident = '15223374')
	),
	(
		789, 'ghoststore@gmail.com', 'Graveyard USA', 'Lisboa', 
		(SELECT id FROM Pessoa WHERE noident = '15223376')
	)
	;
		

INSERT INTO TelefoneLoja (loja, numero) VALUES
	(
		(SELECT codigo FROM Loja WHERE endereco = 'Diagon Alley'),
		'212166476'
	),
	(
		(SELECT codigo FROM Loja WHERE endereco = 'The Mediterranean Shire Avenue'),
		'212166477'
	);
	

INSERT INTO Dispositivo (noserie, latitude, longitude, bateria) VALUES
	(777, 39.74, -8.81, 80),
	(778, 39.74, -8.81, 40),
	(779, 39.74, -8.81, 100);


INSERT INTO Bicicleta (id, peso, raio, modelo, marca, mudanca, estado, atrdisc, dispositivo) VALUES
	(	1, 61.01,  15, 'Mountain 3000', 'Trek', 18, 'livre', 'C', 
		(SELECT noserie FROM Dispositivo WHERE noserie = 777)
	),
	(	2, 82.01,  20, 'Supreme FX', 'Trek', 24, 'em manutenção', 'E', 
		(SELECT noserie FROM Dispositivo WHERE noserie = 777)
	),
	(	3, 73.01,  13, 'Speedy Kids', 'Trek', 6, 'livre', 'C', 
		(SELECT noserie FROM Dispositivo WHERE noserie = 779)
	),
	(	4, 61.01,  20, 'Mountain Roll 4000', 'Trek', 24, 'livre', 'E', 
		(SELECT noserie FROM Dispositivo WHERE noserie = 777)
	),
	(	5, 82.01,  20, 'Radical Trip', 'Trek', 24, 'livre', 'E', 
		(SELECT noserie FROM Dispositivo WHERE noserie = 778)
	),
	(	6, 73.01,  14, 'Dutch Treasure', 'Trek', 1, 'livre', 'C', 
		(SELECT noserie FROM Dispositivo WHERE noserie = 779)
	),
	(	7, 78.01,  14, 'Black Pearl', 'Trek', 6, 'em manutenção', 'C', 
		(SELECT noserie FROM Dispositivo WHERE noserie = 778)
	),
	(	8, 78.20,  15, 'Pegasus', 'Trek', 18, 'em manutenção', 'C', 
		(SELECT noserie FROM Dispositivo WHERE noserie = 777)
	);

INSERT INTO Classica (bicicleta, nomudanca) VALUES
	((SELECT id FROM Bicicleta WHERE modelo = 'Mountain 3000'), 5),
	((SELECT id FROM Bicicleta WHERE modelo = 'Speedy Kids'), 3),
	((SELECT id FROM Bicicleta WHERE modelo = 'Dutch Treasure'), 2)
;

INSERT INTO Eletrica (bicicleta, autonomia, velocidade) VALUES
	((SELECT id FROM Bicicleta WHERE modelo = 'Supreme FX'), 200, 150),
	((SELECT id FROM Bicicleta WHERE modelo = 'Mountain Roll 4000'), 220, 150),
	((SELECT id FROM Bicicleta WHERE modelo = 'Radical Trip'), 170, 120)
;

INSERT INTO Reserva (noreserva, loja, dtinicio, dtfim, valor, bicicleta) VALUES
	(
		1, 
		(SELECT codigo FROM Loja WHERE endereco = 'Diagon Alley'),
		'2022-11-21 10:05:34',
		'2022-11-28 10:05:34',
		22.75,
		(SELECT id FROM Bicicleta WHERE modelo = 'Mountain 3000')
	),
	(
		2, 
		(SELECT codigo FROM Loja WHERE endereco = 'Diagon Alley'),
		'2022-11-22 10:05:34',
		'2022-11-28 10:05:34',
		30.75,
		(SELECT id FROM Bicicleta WHERE modelo = 'Supreme FX')
	),
	(
		3, 
		(SELECT codigo FROM Loja WHERE endereco = 'The Mediterranean Shire Avenue'),
		'2023-11-21 10:05:34',
		'2023-12-10 10:05:34',
		26.55,
		(SELECT id FROM Bicicleta WHERE modelo = 'Dutch Treasure')
	),
	(
		4, 
		(SELECT codigo FROM Loja WHERE endereco = 'The Mediterranean Shire Avenue'),
		'2023-11-22 10:05:34',
		'2023-11-30 10:05:34',
		20.65,
		(SELECT id FROM Bicicleta WHERE modelo = 'Mountain Roll 4000')
	),
	(
		5, 
		(SELECT codigo FROM Loja WHERE endereco = 'The Mediterranean Shire Avenue'),
		'2024-11-22 10:05:34',
		'2024-11-29 16:05:34',
		20.65,
		(SELECT id FROM Bicicleta WHERE modelo = 'Radical Trip')
	),
	(
		6, 
		(SELECT codigo FROM Loja WHERE endereco = 'The Mediterranean Shire Avenue'),
		'2023-11-16 12:05:34',
		'2023-11-18 10:05:34',
		20.65,
		(SELECT id FROM Bicicleta WHERE modelo = 'Speedy Kids')
	),
	(
		7, 
		(SELECT codigo FROM Loja WHERE endereco = 'The Mediterranean Shire Avenue'),
		'2023-11-20 19:05:34',
		'2023-11-30 10:05:34',
		20.65,
		(SELECT id FROM Bicicleta WHERE modelo = 'Radical Trip')
	),
	(
		8, 
		(SELECT codigo FROM Loja WHERE endereco = 'The Mediterranean Shire Avenue'),
		'2025-11-22 11:05:34',
		'2025-11-30 10:05:34',
		20.65,
		(SELECT id FROM Bicicleta WHERE modelo = 'Mountain 3000')
	),
	(
		9, 
		(SELECT codigo FROM Loja WHERE endereco = 'The Mediterranean Shire Avenue'),
		'2023-11-22 11:05:34',
		'2023-11-30 10:05:34',
		30.75,
		(SELECT id FROM Bicicleta WHERE modelo = 'Supreme FX')
	),
	(
		10, 
		(SELECT codigo FROM Loja WHERE endereco = 'The Mediterranean Shire Avenue'),
		'2023-11-22 11:05:34',
		'2023-11-30 10:05:34',
		30.75,
		(SELECT id FROM Bicicleta WHERE modelo = 'Supreme FX')
	)
	;
	


INSERT INTO ClienteReserva (cliente, reserva, loja) VALUES
	(
		(SELECT id FROM Pessoa WHERE noident = '15223370'),
		1,
		123
	),
	(
		(SELECT id FROM Pessoa WHERE noident = '15223374'),
		2,
		123
	),
	(
		(SELECT id FROM Pessoa WHERE noident = '15223373'),
		3,
		456
	),
	(
		(SELECT id FROM Pessoa WHERE noident = '15223373'),
		4,
		456
	),
	(
		(SELECT id FROM Pessoa WHERE noident = '15223375'),
		5,
		456
	),
	(
		(SELECT id FROM Pessoa WHERE noident = '15223372'),
		6,
		456
	),
	(
		(SELECT id FROM Pessoa WHERE noident = '15223370'),
		7,
		456
	),
	(
		(SELECT id FROM Pessoa WHERE noident = '15223374'),
		8,
		456
	),
	(
		(SELECT id FROM Pessoa WHERE noident = '15223370'),
		9,
		456
	),
	(
		(SELECT id FROM Pessoa WHERE noident = '15223373'),
		10,
		456
	)
	;

commit;
