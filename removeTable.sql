begin;
-- remove views
DROP VIEW IF EXISTS public.ListaJoaoFilipe;
DROP VIEW IF EXISTS public.BicicletaSemNumeros;

-- remove table by order
DROP TABLE IF EXISTS ClienteReserva;
DROP TABLE IF EXISTS Reserva CASCADE;
DROP TABLE IF EXISTS Eletrica;
DROP TABLE IF EXISTS Classica;
DROP TABLE IF EXISTS Bicicleta CASCADE;
DROP TABLE IF EXISTS Dispositivo CASCADE;
DROP TABLE IF EXISTS TelefoneLoja; 
DROP TABLE IF EXISTS Loja CASCADE;
DROP TABLE IF EXISTS Pessoa CASCADE;
commit;
