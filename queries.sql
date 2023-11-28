/*
a) Implemente em PostgreSQL as interrogações pedidas na alínea 2 (Pode escolher uma das soluções que apresentou acima, desde que nesta fase consiga fazer uso de todos os operadores).
*/

/*
(a) Pretende-se obter informação (nome, morada e telefone) dos clientes e dos gestores (Nota: lembre-se que na BD os clientes poderão ser clientes, mas têm um valor único no atrdisc).
*/

SELECT nome, morada, telefone FROM Pessoa;

/*
(b) Liste, agora, informação (nome, morada e telefone) sobre os clientes que também são gestores.
*/

SELECT DISTINCT nome, morada, telefone FROM
(SELECT * FROM Pessoa WHERE atrdisc = 'C') AS Cliente
NATURAL JOIN 
(SELECT DISTINCT gestor AS id FROM Loja) AS Gestor;

/*
(c) Pretende-se saber que pessoas (nome, morada e telefone) não estão associadas a nenhuma reserva.
*/


SELECT DISTINCT nome, morada, telefone FROM Pessoa
LEFT JOIN ClienteReserva ON Pessoa.id = ClienteReserva.cliente
WHERE ClienteReserva.cliente IS NULL;

/*
(d) Apresente a lista de bicicletas (marca, modelo e estado) que não estão associadas a nenhuma reserva e não são eléctricas.
*/

SELECT marca, modelo, estado FROM Reserva
RIGHT JOIN Bicicleta ON Reserva.bicicleta = Bicicleta.id
WHERE Reserva.bicicleta IS NULL AND atrdisc = 'C';


/*
(e) O conjunto de dispositivos (noserie, latitude e longitude) de bicicletas cujo estado encontra-se em “em manutenção”.
*/


SELECT DISTINCT noserie, latitude, longitude
FROM (
    SELECT dispositivo
    FROM Bicicleta
    WHERE estado = 'em manutenção'
) AS R1
JOIN Dispositivo ON R1.dispositivo = Dispositivo.noserie;


-- Outra opção---
SELECT DISTINCT noserie, latitude, longitude FROM Dispositivo
JOIN Bicicleta ON Dispositivo.noserie = Bicicleta.dispositivo
WHERE estado = 'em manutenção';

/*
(f) O nome dos clientes que realizaram reservas com bicicletas eléctricas. Apresente informação sobre os clientes e o número de reservas.
*/

SELECT nome, COUNT(*) FROM Pessoa
JOIN ClienteReserva ON Pessoa.id = ClienteReserva.cliente
JOIN Reserva ON ClienteReserva.reserva = Reserva.noreserva
JOIN Bicicleta ON Reserva.bicicleta = Bicicleta.id
WHERE Bicicleta.atrdisc = 'E'
GROUP BY nome;

/*
(g) Pretende-se obter a lista de clientes que efectuaram reservas com um valor total superior a 100 (e.g.).
*/
SELECT nome, noident, SUM(valor) as total from Pessoa
JOIN ClienteReserva ON Pessoa.id = ClienteReserva.cliente
JOIN Reserva ON ClienteReserva.reserva = Reserva.noreserva
GROUP BY nome, noident
HAVING SUM(valor) > 100;

/*
(h) Liste informações (email, endereço e localidade) sobre lojas e respectivos números de telefone associados, incluindo lojas que podem não ter um número de telefone associado.
*/

SELECT email, endereco, localidade, numero FROM Loja
LEFT JOIN TelefoneLoja ON Loja.codigo = TelefoneLoja.loja;

/*
(i) Para o cliente de nome “José Manuel”, pretende-se a lista de reservas (noreserva e loja) que efectuou, nomeadamente a sua data e as horas de início e de fim, e o preço final desta.
*/

SELECT noreserva, Reserva.loja, dtinicio, dtfim, valor FROM Reserva
JOIN ClienteReserva ON Reserva.noreserva = ClienteReserva.reserva
JOIN Pessoa ON ClienteReserva.cliente = Pessoa.id
WHERE nome LIKE 'José Manuel';

/*
(j) Apresente a lista do(s) cliente(s) (nome, morada, telefone e nacionalidade), com mais reservas no ano de 2023.
*/

SELECT DISTINCT nome, morada, telefone, nacionalidade, COUNT(*) AS numreservas FROM Pessoa
JOIN ClienteReserva ON Pessoa.id = ClienteReserva.cliente
JOIN Reserva ON ClienteReserva.reserva = Reserva.noreserva
WHERE EXTRACT(YEAR FROM Reserva.dtinicio) = 2023
GROUP BY nome, morada, telefone, nacionalidade
HAVING COUNT(*) = (SELECT MAX(numreservas) FROM (
                            SELECT DISTINCT nome, morada, telefone, nacionalidade, COUNT(*) AS numreservas FROM Pessoa
							JOIN ClienteReserva ON Pessoa.id = ClienteReserva.cliente
							JOIN Reserva ON ClienteReserva.reserva = Reserva.noreserva
							WHERE EXTRACT(YEAR FROM Reserva.dtinicio) = 2023
							GROUP BY nome, morada, telefone, nacionalidade
							) AS maximum);

/*
(k) Apresente o número de clientes de nacionalidade portuguesa e outros. O resultado deve mostrar os atributos nacionalidade e o número de clientes.
*/

SELECT DISTINCT nacionalidade, COUNT(*) FROM Pessoa
WHERE NOT atrdisc = 'G' 
GROUP BY nacionalidade;


/*
(b) Obtenha os nomes de todos os clientes que fizeram pelo menos uma reserva numa loja
localizada em Lisboa.
*/

SELECT DISTINCT nome FROM Pessoa
JOIN ClienteReserva ON Pessoa.id = ClienteReserva.cliente
JOIN Loja ON ClienteReserva.loja = Loja.codigo
WHERE localidade = 'Lisboa';

/*
(c) Encontre os números de série dos dispositivos com uma percentagem de bateria superior
a 50%, e liste-os por ordem crescente da sua percentagem de bateria.
*/

SELECT noserie, bateria FROM Dispositivo
WHERE bateria > 50 ORDER BY bateria ASC;

/*
(d) Apresente a marca e o modelo da bicicleta com maior autonomia dentro das bicicletas
disponíveis.
*/

SELECT marca, modelo FROM Bicicleta
JOIN Eletrica ON Bicicleta.id = Eletrica.bicicleta
WHERE autonomia = (SELECT MAX(autonomia) FROM Eletrica);

/*
(e) Obter o número total de reservas para cada loja, bem como o seu código e o número
total de reservas.
*/

SELECT codigo, COUNT(*) AS numreservas FROM Loja
JOIN Reserva ON Loja.codigo = Reserva.loja
GROUP BY codigo;

/*
(f) Liste todas as lojas (codigo e email) que tenham efectuado mais de 5 reservas, até à
presente data, e enumere-as por ordem decrescente do número de reservas (Nota: Faça
uso dos operadores/funções de data e tempo). Nota: Poderão fazer uso da função YEAR(), por questões de simplificação.
*/

SELECT codigo, email, COUNT(*) AS numreservas FROM Loja
JOIN Reserva ON Loja.codigo = Reserva.loja
WHERE EXTRACT(YEAR FROM Reserva.dtinicio) = EXTRACT(YEAR FROM CURRENT_TIMESTAMP)
GROUP BY codigo, email
HAVING COUNT(*) > 5
ORDER BY numreservas DESC;

/*
(g) Apresente os nomes dos clientes que efectuaram reservas de bicicletas cujo estado tem como valor “em manutencao” no ano passado (Nota: Faça uso dos operadores/funções de data e tempo).
*/

SELECT nome FROM Pessoa
JOIN ClienteReserva ON Pessoa.id = ClienteReserva.cliente
JOIN Reserva ON ClienteReserva.reserva = Reserva.noreserva AND ClienteReserva.loja = Reserva.loja
JOIN Bicicleta ON Reserva.bicicleta = Bicicleta.id
WHERE estado = 'em manutenção'
AND EXTRACT(YEAR FROM Reserva.dtinicio) = EXTRACT(YEAR FROM CURRENT_TIMESTAMP) - 1;

/*
(h) Listar as informações (nome, morada, telefone) das pessoas que geriram uma loja
e efectuaram reservas.
*/

SELECT DISTINCT nome, morada, telefone FROM Pessoa
JOIN Loja ON Pessoa.id = Loja.gestor
JOIN ClienteReserva ON Pessoa.id = ClienteReserva.cliente;

/*
(i) Obter o(s) nome(s) do(s) cliente(s) que realizaram reservas numa loja gerida por uma
pessoa chamada “João”.
*/

SELECT DISTINCT Cliente.nome FROM ClienteReserva
JOIN Pessoa AS Cliente ON ClienteReserva.cliente = Cliente.id
JOIN Loja ON ClienteReserva.loja = Loja.codigo
JOIN Pessoa AS Manager ON Loja.gestor = Manager.id
WHERE Manager.nome LIKE 'João%';

/*
(j) Crie uma vista LISTAJOAOFILIPE que inclui informação sobre os clientes que efectuaram reservas num loja gerida pelo “João Filipe”. (Nota: O João Filipe é, ele também, cliente).
*/

CREATE VIEW LISTAJOAOFILIPE AS
SELECT DISTINCT Cliente.nome FROM ClienteReserva
JOIN Pessoa AS Cliente ON ClienteReserva.cliente = Cliente.id
JOIN Loja ON ClienteReserva.loja = Loja.codigo
JOIN Pessoa AS Manager ON Loja.gestor = Manager.id
WHERE Manager.nome LIKE 'João Filipe%'; 

/*
(k) Crie uma vista BICICLETASEMNUMEROS que inclui informação sobre as bicicletas e o seu número. A informação disponível deverá ser, o tipo de bicicleta (eléctrica e clássica), o seu estado (“em manutenção” e “outras”) e o número total.
*/

CREATE VIEW BICICLETASEMNUMEROS AS
SELECT atrdisc, estado, COUNT(*) AS numbicicletas FROM Bicicleta
GROUP BY atrdisc, estado;
