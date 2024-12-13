######################### Tests #########################
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
('CFDPI1264567007A', 'Luca', 'Rossi', '1985-05-12', 'Direttore', 'CineMin');