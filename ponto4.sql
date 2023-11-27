BEGIN;

/*
4. Apresente o(s) comando(s) que permite(m): Devem garantir atomicidade nas alterações).
*/

/*
a) alterar o atributo mudanca em BICICLETA adicionando um novo valor, neste caso 40.
*/

ALTER TABLE Bicicleta DROP CONSTRAINT IF EXISTS mudanca_check;
ALTER TABLE Bicicleta ADD CONSTRAINT mudanca_check CHECK (mudanca IN (1, 6, 18, 24, 40)); 

/*
b) afectar este novo valor à(s) bicicleta(s) já registada(s) na BD com o modelo “Modelo-B” da marca “Marca-A”.
*/

UPDATE Bicicleta SET mudanca = 40 WHERE modelo = 'Mountain Roll 4000' and marca = 'Trek';

COMMIT;