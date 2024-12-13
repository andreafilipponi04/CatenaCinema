######################### Tests #########################
<<<<<<< HEAD
<<<<<<< HEAD
-- Test procedura 1:
CALL RicercaTitolo('Titanic');

-- Test funzione 1:
SELECT ContaPosti('S1', 'CineStar') AS numPosti;

-- Test funzione 2:
SELECT ContaPostiDisponibili('S1', 'CineStar') AS numPostiDisponibili;


=======
>>>>>>> 6414b89e6e86a9b56fb050b8206b35ef228bccf2
=======
>>>>>>> 6414b89e6e86a9b56fb050b8206b35ef228bccf2
-- Test trigger 1
-- Biglietto non valido
INSERT INTO Biglietto (proiezione_sala, proiezione_cinema, proiezione_film, proiezione_data, posto_fila, posto_numero, posto_sala, posto_cinema, cliente, bigliettaio) VALUES
('S1', 'CineStar', '1', '2024-12-10 20:30:00', 'A', '1', 'S1', 'CineStar', 'CFCLI1234567007A', 'CFDPI1234567008B');

-- Test trigger 2
-- Ordine non valido
INSERT INTO Ordine (cliente, staff) VALUES
('CFCLI1234567007A', 'CFDPI1234567026U');

-- Test trigger 3
-- Proiezione non valida
INSERT INTO Proiezione (sala, cinema, film, data_inizio, prezzo_proiezione, proiezionista) VALUES
('S1', 'CineStar', '1', '2024-12-10 20:30:00', '8.00', 'CFDPI1234567008B');

-- Test trigger 4
-- Direttore non valido
INSERT INTO Staff (CF_staff, nome_staff, cognome_staff, data_nascita_staff, ruolo, cinema) VALUES
<<<<<<< HEAD
<<<<<<< HEAD
('CFDPI1264567007A', 'Luca', 'Rossi', '1985-05-12', 'Direttore', 'CineMin');

-- Test trigger 5
INSERT INTO Biglietto (proiezione_sala, proiezione_cinema, proiezione_film, proiezione_data, posto_fila, posto_numero, posto_sala, posto_cinema, cliente, bigliettaio) VALUES
('S2', 'CineStar', '5', '2024-12-12 21:00:00', 'A', '3', 'S2', 'CineStar', 'CFCLI1234567009C', 'CFDPI1234567022Q'),
('S2', 'CineStar', '5', '2024-12-12 21:00:00', 'A', '4', 'S2', 'CineStar', 'CFCLI1234567010D', 'CFDPI1234567022Q');
SELECT *
FROM Posto
WHERE cinema = 'CineStar';

-- Test trigger 6
INSERT INTO Biglietto (proiezione_sala, proiezione_cinema, proiezione_film, proiezione_data, posto_fila, posto_numero, posto_sala, posto_cinema, cliente, bigliettaio) VALUES
('S2', 'CineMax', '3', '2023-12-12 20:00:00', 'A', '3', 'S1', 'CineMax', 'CFCLI1234567009C', 'CFDPI1234567022Q');
=======
('CFDPI1264567007A', 'Luca', 'Rossi', '1985-05-12', 'Direttore', 'CineMin');
>>>>>>> 6414b89e6e86a9b56fb050b8206b35ef228bccf2
=======
('CFDPI1264567007A', 'Luca', 'Rossi', '1985-05-12', 'Direttore', 'CineMin');
>>>>>>> 6414b89e6e86a9b56fb050b8206b35ef228bccf2
