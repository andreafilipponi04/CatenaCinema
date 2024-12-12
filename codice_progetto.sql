############################################################################
################      Script per progetto BDSI 2024/2025     #################
############################################################################
#
# Matricola: 7137945       Cognome:     Filipponi         Nome:     Andrea
# Matricola: 7133734       Cognome:     Bartolucci        Nome:     William
#
######################### Creazione basi di dati #########################

set global local_infile = true;

DROP DATABASE IF EXISTS Catena_cinema_multisalaDB;
CREATE DATABASE Catena_cinema_multisalaDB;
USE Catena_cinema_multisalaDB;

########################## Creazione tabelle #############################
-- Cinema
DROP TABLE IF EXISTS Cinema;

CREATE TABLE IF NOT EXISTS Cinema (
    nome_cinema VARCHAR(26) PRIMARY KEY NOT NULL,
    via VARCHAR(26) NOT NULL,
    citta VARCHAR(26) NOT NULL,
    cap CHAR(5) NOT NULL,
    prov CHAR(2) NOT NULL
) ENGINE = INNODB;

-- Sala
DROP TABLE IF EXISTS Sala;

CREATE TABLE IF NOT EXISTS Sala (
    nome_sala VARCHAR(2) NOT NULL,
    cinema VARCHAR(26) NOT NULL,
    PRIMARY KEY (nome_sala, cinema),
    FOREIGN KEY (cinema) REFERENCES Cinema(nome_cinema)
) ENGINE = INNODB;

-- Posto

DROP TABLE IF EXISTS Posto;

CREATE TABLE IF NOT EXISTS Posto (
    fila CHAR(1) NOT NULL,
    numero_posto INT NOT NULL,
    sala VARCHAR(2) NOT NULL,
    cinema VARCHAR(26) NOT NULL,
    occupato BOOLEAN NOT NULL,
    PRIMARY KEY (fila, numero_posto, sala),
    FOREIGN KEY (sala, cinema) REFERENCES Sala(nome_sala, cinema)
) ENGINE = INNODB;

-- Staff
DROP TABLE IF EXISTS Staff;

CREATE TABLE IF NOT EXISTS Staff (
    CF_staff CHAR(16) PRIMARY KEY NOT NULL,
    nome_staff VARCHAR(26) NOT NULL,
    cognome_staff VARCHAR(26) NOT NULL,
    data_nascita_staff DATE NOT NULL,
    ruolo ENUM('Barista', 'Bigliettaio', 'Direttore','Proiezionista') NOT NULL,
    cinema VARCHAR(26) NOT NULL,
    FOREIGN KEY (cinema) REFERENCES Cinema(nome_cinema)
) ENGINE = INNODB;

-- Cliente
DROP TABLE IF EXISTS Cliente; 

CREATE TABLE IF NOT EXISTS Cliente (
    CF_cliente CHAR(16) PRIMARY KEY NOT NULL,
    nome_cliente VARCHAR(26) NOT NULL,
    cognome_cliente VARCHAR(26) NOT NULL,
    data_nascita_cliente DATE NOT NULL
) ENGINE = INNODB;

-- Ordine
DROP TABLE IF EXISTS Ordine;

CREATE TABLE IF NOT EXISTS Ordine (
    id_ordine INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    staff CHAR(16) NOT NULL,
    cliente CHAR(16) NOT NULL,
    FOREIGN KEY (staff) REFERENCES Staff(CF_staff),
    FOREIGN KEY (cliente) REFERENCES Cliente(CF_cliente)
) ENGINE = INNODB;

-- Snacks
DROP TABLE IF EXISTS Snacks;

CREATE TABLE IF NOT EXISTS Snacks (
    nome_snack VARCHAR(26) PRIMARY KEY NOT NULL,
    tipo_snack ENUM('Bevanda', 'Dolce', 'Salato') NOT NULL,
    prezzo_snack DECIMAL(4, 2) NOT NULL
) ENGINE = INNODB;

-- Genere
DROP TABLE IF EXISTS Genere;

CREATE TABLE IF NOT EXISTS Genere (
    tipologia_genere VARCHAR(26) PRIMARY KEY NOT NULL
) ENGINE = INNODB;

-- Regista
DROP TABLE IF EXISTS Regista;

CREATE TABLE IF NOT EXISTS Regista (
    CF_Regista CHAR(16) PRIMARY KEY NOT NULL,
    nome_Regista VARCHAR(26) NOT NULL,
    cognome_Regista VARCHAR(26) NOT NULL,
    nazionalita VARCHAR(26) NOT NULL,
    data_nascita_Regista DATE NOT NULL
) ENGINE = INNODB;

-- Film
DROP TABLE IF EXISTS Film;

CREATE TABLE IF NOT EXISTS Film (
    id_film INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    titolo VARCHAR(50) NOT NULL,
    data_pubblicazione DATE NOT NULL,
    durata TIME NOT NULL,
    trama VARCHAR(200) NOT NULL,
    genere VARCHAR(26) NOT NULL,
    regista CHAR(16) NOT NULL,
    FOREIGN KEY (genere) REFERENCES Genere(tipologia_genere),
    FOREIGN KEY (regista) REFERENCES Regista(CF_Regista)
) ENGINE = INNODB;

-- Proiezione
DROP TABLE IF EXISTS Proiezione;

CREATE TABLE IF NOT EXISTS Proiezione (
    sala VARCHAR(2) NOT NULL,
    cinema VARCHAR(26) NOT NULL,
    film INT NOT NULL,
    data_inizio DATETIME NOT NULL,
    prezzo_proiezione DECIMAL(4,2) NOT NULL,
    proiezionista CHAR(16) NOT NULL,
    PRIMARY KEY (sala, cinema, film, data_inizio),
	FOREIGN KEY (sala, cinema) REFERENCES Sala(nome_sala, cinema),
    FOREIGN KEY (film) REFERENCES Film(id_film),
	FOREIGN KEY (proiezionista) REFERENCES Staff(CF_staff)
) ENGINE = INNODB;

-- Abbonamento
DROP TABLE IF EXISTS Abbonamento;

CREATE TABLE IF NOT EXISTS Abbonamento (
    tipo_piano VARCHAR(26) PRIMARY KEY NOT NULL,
    prezzo DECIMAL(5,2) NOT NULL,
    durata ENUM('7', '30', '365') NOT NULL
) ENGINE = INNODB;

-- Biglietto
DROP TABLE IF EXISTS Biglietto;

CREATE TABLE IF NOT EXISTS Biglietto (
    id_biglietto INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    proiezione_sala VARCHAR(2) NOT NULL,
    proiezione_cinema VARCHAR(26) NOT NULL,
    proiezione_film INT NOT NULL,
    proiezione_data DATETIME NOT NULL,
    cliente CHAR(16) NOT NULL,
    bigliettaio CHAR(16) NOT NULL,
    FOREIGN KEY (proiezione_sala, proiezione_cinema, proiezione_film, proiezione_data) REFERENCES Proiezione(sala, cinema, film, data_inizio),
    FOREIGN KEY (cliente) REFERENCES Cliente(CF_cliente),
    FOREIGN KEY (bigliettaio) REFERENCES Staff(CF_staff)
) ENGINE = INNODB;

-- Composizione
DROP TABLE IF EXISTS Composizione;

CREATE TABLE IF NOT EXISTS Composizione (
    quantita INT NOT NULL,
    ordine INT NOT NULL,
    snacks VARCHAR(26) NOT NULL,
    PRIMARY KEY (ordine, snacks),
    FOREIGN KEY (ordine) REFERENCES Ordine(id_ordine),
    FOREIGN KEY (snacks) REFERENCES Snacks(nome_snack)
) ENGINE = INNODB;

-- Sottoscrizione
DROP TABLE IF EXISTS Sottoscrizione;

CREATE TABLE IF NOT EXISTS Sottoscrizione (
    abbonamento VARCHAR(26) NOT NULL,
    cliente CHAR(16) NOT NULL,
    data_inizio_abb DATE NOT NULL,
    data_fine_abb DATE NOT NULL,
    stato BOOLEAN NOT NULL,
    PRIMARY KEY (abbonamento, cliente, data_inizio_abb),
    FOREIGN KEY (abbonamento) REFERENCES Abbonamento(tipo_piano),
    FOREIGN KEY (cliente) REFERENCES Cliente(CF_cliente)
) ENGINE = INNODB;

######################### Popolamento tabelle ############################film
-- Popolamento della tabella Cinema da file

LOAD DATA LOCAL INFILE 'C:/Users/Andrea/Downloads/cinema.csv'
INTO TABLE Cinema
FIELDS TERMINATED BY ',';

-- Popolamento della tabella Sala
INSERT INTO Sala (nome_sala, cinema) VALUES
('S1', 'CineMax'),
('S2', 'CineMax'),
('S3', 'CineMax'),
('S4', 'CineMax'),
('S1', 'CineStar'),
('S2', 'CineStar'),
('S3', 'CineStar'),
('S4', 'CineStar'),
('S1', 'CineMin'),
('S2', 'CineMin'),
('S3', 'CineMin'),
('S4', 'CineMin'),
('S1', 'CineMoon'),
('S2', 'CineMoon'),
('S3', 'CineMoon'),
('S4', 'CineMoon'),
('S1', 'CineSun'),
('S2', 'CineSun'),
('S3', 'CineSun'),
('S4', 'CineSun');

-- Popolamento della tabella Posto
INSERT INTO Posto (fila, numero_posto, sala, cinema, occupato) VALUES
('A', 1, 'S1', 'CineStar', FALSE),
('A', 2, 'S1', 'CineStar', FALSE),
('B', 1, 'S1', 'CineStar', TRUE),
('B', 2, 'S1', 'CineStar', FALSE),
('A', 1, 'S2', 'CineMax', FALSE),
('A', 2, 'S2', 'CineMax', TRUE);

-- Popolamento della tabella Staff
INSERT INTO Staff (CF_staff, nome_staff, cognome_staff, data_nascita_staff, ruolo, cinema) VALUES
-- Dipendenti per CineMax
('CFDPI1234567007A', 'Luca', 'Rossi', '1985-05-12', 'Direttore', 'CineMax'),
('CFDPI1234567026U', 'Alessandro', 'Chiarelli', '1996-01-10', 'Proiezionista', 'CineMax'),
('CFDPI1234567008B', 'Marco', 'Bianchi', '1992-11-18', 'Barista', 'CineMax'),
('CFDPI1234567009C', 'Sara', 'Verdi', '1995-07-24', 'Bigliettaio', 'CineMax'),
-- Dipendenti per CineStar
('CFDPI1234567010D', 'Anna', 'Esposito', '1988-03-15', 'Direttore', 'CineStar'),
('CFDPI1234567011E', 'Giulia', 'Russo', '1993-06-21', 'Barista', 'CineStar'),
('CFDPI1234567012F', 'Davide', 'Conti', '1996-01-10', 'Proiezionista', 'CineStar'),
('CFDPI1234567022Q', 'Davide', 'Pirazzoli', '1996-01-10', 'Bigliettaio', 'CineStar'),
-- Dipendenti per CineMin
('CFDPI1234567013G', 'Federico', 'Neri', '1987-02-28', 'Direttore', 'CineMin'),
('CFDPI1234567014H', 'Claudia', 'Gallo', '1991-12-05', 'Barista', 'CineMin'),
('CFDPI1234567015I', 'Paolo', 'Fontana', '1994-09-09', 'Proiezionista', 'CineMin'),
('CFDPI1234567023R', 'Matteo', 'Piazzesi', '1996-01-10', 'Bigliettaio', 'CineMin'),
-- Dipendenti per CineMoon
('CFDPI1234567016J', 'Elena', 'Marini', '1989-04-14', 'Direttore', 'CineMoon'),
('CFDPI1234567017K', 'Francesca', 'Moretti', '1992-08-25', 'Barista', 'CineMoon'),
('CFDPI1234567024S', 'Alessandro', 'Russo', '1996-01-10', 'Proiezionista', 'CineMoon'),
('CFDPI1234567018L', 'Alessandro', 'Sani', '1997-10-03', 'Bigliettaio', 'CineMoon'),
-- Dipendenti per CineSun
('CFDPI1234567019M', 'Simone', 'De Luca', '1986-07-30', 'Direttore', 'CineSun'),
('CFDPI1234567020N', 'Marta', 'Pellegrini', '1990-05-19', 'Barista', 'CineSun'),
('CFDPI1234567025T', 'Leonardo', 'Masini', '1996-01-10', 'Bigliettaio', 'CineSun'),
('CFDPI1234567021P', 'Giovanni', 'Vitali', '1995-11-22', 'Proiezionista', 'CineSun');

-- Popolamento della tabella Cliente

INSERT INTO Cliente (CF_cliente, nome_cliente, cognome_cliente, data_nascita_cliente) VALUES
('CFCLI1234567007A', 'Francesca', 'Russo', '1991-02-08'),
('CFCLI1234567008B', 'Marta', 'De Luca', '1989-09-20'),
('CFCLI1234567009C', 'Paolo', 'Fontana', '1996-01-15'),
('CFCLI1234567010D', 'Elena', 'Marini', '1998-08-22'),
('CFCLI1234567011E', 'Simone', 'Moretti', '1994-10-10'),
('CFCLI1234567012F', 'Claudia', 'Ferrari', '1993-05-25'),
('CFCLI1234567013G', 'Federico', 'Romano', '1992-03-03'),
('CFCLI1234567014H', 'Giovanni', 'Pellegrini', '1987-11-11'),
('CFCLI1234567015I', 'Alessandra', 'Costa', '1990-07-07'),
('CFCLI1234567016J', 'Antonio', 'Gallo', '1995-12-05'),
('CFCLI1234567017K', 'Valentina', 'Barbieri', '1996-02-14'),
('CFCLI1234567018L', 'Stefano', 'Lombardi', '1985-04-17'),
('CFCLI1234567019M', 'Chiara', 'Battisti', '1999-01-01'),
('CFCLI1234567020N', 'Riccardo', 'Martini', '1994-06-16');

-- Popolamento della tabella Ordine
INSERT INTO Ordine (cliente, staff) VALUES
('CFCLI1234567007A', 'CFDPI1234567008B'),
('CFCLI1234567008B', 'CFDPI1234567008B'),
('CFCLI1234567009C', 'CFDPI1234567008B'),
('CFCLI1234567017K', 'CFDPI1234567011E'),
('CFCLI1234567019M', 'CFDPI1234567011E'),
('CFCLI1234567012F', 'CFDPI1234567014H'),
('CFCLI1234567010D', 'CFDPI1234567014H'),
('CFCLI1234567020N', 'CFDPI1234567017K'),
('CFCLI1234567012F', 'CFDPI1234567017K'),
('CFCLI1234567012F', 'CFDPI1234567020N');

-- Popolamento della tabella Snacks
INSERT INTO Snacks (nome_snack, tipo_snack, prezzo_snack) VALUES
('Popcorn', 'Salato', '5.00'),
('CocaCola', 'Bevanda', '3.00'),
('Nachos', 'Salato', 4.50),
('Fanta', 'Bevanda', 3.50),
('Hot Dog', 'Salato', 4.00),
('Acqua', 'Bevanda', 2.00),
('Caramelle', 'Dolce', 4.00),
('Sprite', 'Bevanda', 3.50);

-- Popolamento della tabella Genere
INSERT INTO Genere (tipologia_genere) VALUES
('Sci-fi'),
('Romance'),
('Action'),
('Comedy');

-- Popolamento della tabella Regista
INSERT INTO Regista (CF_Regista, nome_Regista, cognome_Regista, nazionalita, data_nascita_Regista) VALUES
('REG001', 'Christopher', 'Nolan', 'UK', '1970-07-30'),
('REG002', 'James', 'Cameron', 'Canada', '1954-08-16'),
('REG003', 'Steven', 'Spielberg', 'USA', '1946-12-18'),
('REG004', 'Quentin', 'Tarantino', 'USA', '1963-03-27');

-- Popolamento della tabella Film
INSERT INTO Film (titolo, data_pubblicazione, durata, trama, genere, regista) VALUES
('Inception', '2010-07-16', '02:28:00', 'A mind-bending thriller about dream manipulation', 'Sci-fi', 'REG001'),
('Titanic', '1997-12-19', '03:14:00', 'A tragic love story set on the ill-fated Titanic', 'Romance', 'REG002'),
('The Dark Knight', '2008-07-18', '02:32:00', 'Batman faces the Joker in Gotham City', 'Action', 'REG001'),
('E.T.', '1982-06-11', '01:55:00', 'An alien befriends a boy and finds a way home', 'Sci-fi', 'REG003'),
('Avatar', '2009-12-18', '02:42:00', 'Humans interact with a new alien species on Pandora', 'Sci-fi', 'REG002');


INSERT INTO Proiezione (sala, cinema, film, data_inizio, prezzo_proiezione, proiezionista) VALUES
-- Proiezioni per CineStar
('S1', 'CineStar', '1', '2024-12-10 20:30:00', '8.00', 'CFDPI1234567012F'),
('S1', 'CineStar', '2', '2024-12-11 18:00:00', '10.00', 'CFDPI1234567012F'),
('S2', 'CineStar', '4', '2024-12-12 15:00:00', '9.50', 'CFDPI1234567012F'),
('S2', 'CineStar', '5', '2024-12-12 21:00:00', '9.50', 'CFDPI1234567012F'),
-- Proiezioni per CineMax
('S2', 'CineMax', '3', '2024-12-12 20:00:00', '8.50', 'CFDPI1234567026U'),
('S2', 'CineMax', '4', '2024-12-13 21:30:00', '9.00', 'CFDPI1234567026U'),
('S1', 'CineMax', '2', '2024-12-14 19:00:00', '7.00', 'CFDPI1234567026U'),
-- Proiezioni per CineMin
('S1', 'CineMin', '5', '2024-12-15 18:00:00', '6.90', 'CFDPI1234567015I'),
('S2', 'CineMin', '3', '2024-12-16 20:00:00', '10.00', 'CFDPI1234567015I'),
('S1', 'CineMin', '1', '2024-12-17 21:30:00', '9.50', 'CFDPI1234567015I'),
-- Proiezioni per CineMoon
('S2', 'CineMoon', '4', '2024-12-18 19:00:00', '7.00', 'CFDPI1234567024S'),
('S1', 'CineMoon', '2', '2024-12-19 18:30:00', '8.00', 'CFDPI1234567024S'),
('S2', 'CineMoon', '5', '2024-12-20 20:30:00', '8.50', 'CFDPI1234567024S'),
-- Proiezioni per CineSun
('S1', 'CineSun', '1', '2024-12-21 20:00:00', '9.00', 'CFDPI1234567019M'),
('S2', 'CineSun', '3', '2024-12-22 21:00:00', '7.00', 'CFDPI1234567019M'),
('S1', 'CineSun', '2', '2024-12-23 19:30:00', '6.20', 'CFDPI1234567019M');

-- Popolamento della tabella Abbonamento
INSERT INTO Abbonamento (tipo_piano, prezzo, durata) VALUES
('Mensile', '50.00', '30'),
('Annuale', '300.00', '365'),
('Settimanale', '15.00', '7');

-- Popolamento della tabella Biglietto
INSERT INTO Biglietto (proiezione_sala, proiezione_cinema, proiezione_film, proiezione_data, cliente, bigliettaio) VALUES
-- Biglietti per CineStar
('S1', 'CineStar', '1', '2024-12-10 20:30:00', 'CFCLI1234567007A', 'CFDPI1234567022Q'),
('S1', 'CineStar', '2', '2024-12-11 18:00:00', 'CFCLI1234567008B', 'CFDPI1234567022Q'),
('S2', 'CineStar', '5', '2024-12-12 21:00:00', 'CFCLI1234567009C', 'CFDPI1234567022Q'),
('S2', 'CineStar', '5', '2024-12-12 21:00:00', 'CFCLI1234567010D', 'CFDPI1234567022Q'),
-- Biglietti per CineMax
('S2', 'CineMax', '3', '2024-12-12 20:00:00', 'CFCLI1234567010D', 'CFDPI1234567009C'),
('S2', 'CineMax', '4', '2024-12-13 21:30:00', 'CFCLI1234567011E', 'CFDPI1234567009C'),
('S1', 'CineMax', '2', '2024-12-14 19:00:00', 'CFCLI1234567012F', 'CFDPI1234567009C'),
-- Biglietti per CineMin
('S1', 'CineMin', '5', '2024-12-15 18:00:00', 'CFCLI1234567013G', 'CFDPI1234567023R'),
('S2', 'CineMin', '3', '2024-12-16 20:00:00', 'CFCLI1234567014H', 'CFDPI1234567023R'),
('S1', 'CineMin', '1', '2024-12-17 21:30:00', 'CFCLI1234567015I', 'CFDPI1234567023R'),
-- Biglietti per CineMoon
('S2', 'CineMoon', '4', '2024-12-18 19:00:00', 'CFCLI1234567016J', 'CFDPI1234567018L'),
('S1', 'CineMoon', '2', '2024-12-19 18:30:00', 'CFCLI1234567017K', 'CFDPI1234567018L'),
('S2', 'CineMoon', '5', '2024-12-20 20:30:00', 'CFCLI1234567018L', 'CFDPI1234567018L'),
-- Biglietti per CineSun
('S1', 'CineSun', '1', '2024-12-21 20:00:00', 'CFCLI1234567019M', 'CFDPI1234567025T'),
('S2', 'CineSun', '3', '2024-12-22 21:00:00', 'CFCLI1234567020N', 'CFDPI1234567025T'),
('S1', 'CineSun', '2', '2024-12-23 19:30:00', 'CFCLI1234567020N', 'CFDPI1234567025T');

-- Popolamento della tabella Composizione
INSERT INTO Composizione (quantita, ordine, snacks) VALUES
-- Composizione per ORD01
('2', '1', 'Popcorn'),
('1', '1', 'CocaCola'),
-- Composizione per ORD02
('3', '2', 'Nachos'),
('1', '2', 'Fanta'),
-- Composizione per ORD03
('1', '3', 'Hot Dog'),
('2', '3', 'Sprite'),
-- Composizione per ORD04
('4', '4', 'Popcorn'),
('1', '4', 'Acqua'),
-- Composizione per ORD05
('3', '5', 'Nachos'),
('2', '5', 'Sprite'),
-- Composizione per ORD06
('2', '6', 'Fanta'),
('1', '6', 'Caramelle'),
-- Composizione per ORD07
('2', '7', 'Popcorn'),
('3', '7', 'Acqua'),
-- Composizione per ORD08
('1', '8', 'Nachos'),
('1', '8', 'Sprite'),
-- Composizione per ORD09
('2', '9', 'CocaCola'),
('2', '9', 'Hot Dog'),
-- Composizione per ORD10
('1', '10', 'Popcorn'),
('3', '10', 'Fanta');

-- Popolamento della tabella Sottoscrizione
INSERT INTO Sottoscrizione (abbonamento, cliente, data_inizio_abb, data_fine_abb, stato) VALUES
-- Abbonamenti attivi
('Mensile', 'CFCLI1234567010D', '2024-11-01', '2024-11-30', TRUE),
('Settimanale', 'CFCLI1234567011E', '2024-12-01', '2024-12-07', TRUE),
('Annuale', 'CFCLI1234567012F', '2024-01-01', '2024-12-31', TRUE),
('Mensile', 'CFCLI1234567013G', '2024-12-01', '2024-12-31', TRUE),
('Mensile', 'CFCLI1234567014H', '2024-11-01', '2024-11-30', TRUE),
('Settimanale', 'CFCLI1234567015I', '2024-12-01', '2024-12-07', TRUE),
('Annuale', 'CFCLI1234567016J', '2024-01-01', '2024-12-31', TRUE),
('Mensile', 'CFCLI1234567017K', '2024-12-01', '2024-12-31', TRUE),
('Settimanale', 'CFCLI1234567018L', '2024-12-02', '2024-12-08', TRUE),
-- Abbonamenti scaduti
('Settimanale', 'CFCLI1234567014H', '2023-11-20', '2023-11-26', FALSE),
('Mensile', 'CFCLI1234567015I', '2023-09-01', '2023-09-30', FALSE),
('Annuale', 'CFCLI1234567016J', '2023-01-01', '2023-12-31', FALSE),
('Settimanale', 'CFCLI1234567017K', '2023-08-01', '2023-08-07', FALSE),
('Settimanale', 'CFCLI1234567014H', '2022-11-20', '2022-11-26', FALSE),
('Mensile', 'CFCLI1234567015I', '2022-09-01', '2022-09-30', FALSE),
('Annuale', 'CFCLI1234567016J', '2022-01-01', '2022-12-31', FALSE),
('Settimanale', 'CFCLI1234567017K', '2022-08-01', '2022-08-07', FALSE);