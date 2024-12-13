USE Catena_cinema_multisalaDB;
######################### Interrogazioni #########################

-- Query 1: Ottenere le generalità di tutti i clienti abbonati
SELECT CF_cliente, nome_cliente, cognome_cliente
FROM Sottoscrizione S JOIN Cliente C
ON S.cliente = C.CF_cliente
WHERE S.stato = TRUE;

-- Query 2: Ottenere il cliente che ha acquistato il maggior numero di biglietti
SELECT nome_cliente, cognome_cliente
FROM Cliente
WHERE CF_cliente = (
    SELECT cliente 
    FROM Biglietto
    GROUP BY cliente
    ORDER BY COUNT(id_biglietto) DESC
    LIMIT 1
);

-- Query 3: Ottenere il numero di film proiettati in un dato cinema
DROP VIEW IF EXISTS Dettagli_Proiezioni;

CREATE VIEW Dettagli_Proiezioni AS
SELECT F.titolo, P.cinema, P.sala, P.data_inizio
FROM Proiezione P
JOIN Film F ON P.film = F.id_Film;

SELECT COUNT(DISTINCT titolo) AS numero_film_proiettati
FROM Dettagli_Proiezioni
WHERE cinema = 'CineStar';

-- Query 4: Ottenere lo snack meno ordinato in assoluto
SELECT S.nome_snack, SUM(C.quantita) AS totale_quantita
FROM Snacks S
JOIN Composizione C ON S.nome_snack = C.snacks
GROUP BY S.nome_snack
ORDER BY totale_quantita ASC
LIMIT 1;

-- Query 5: Ottenere il numero di biglietti acquistati per ciascun cliente
SELECT C.nome_cliente, C.cognome_cliente,
	(SELECT COUNT(*)
     FROM Biglietto B 
     WHERE B.cliente = C.CF_cliente) AS numero_biglietti
<<<<<<< HEAD
FROM Cliente C;
=======
FROM Cliente C;

######################### Procedure #########################
DROP PROCEDURE IF EXISTS RicercaTitolo
DELIMITER $$
CREATE PROCEDURE RicercaTitolo(Titolo VARCHAR(50))
BEGIN
	SELECT F.id_film, F.titolo, P.data_inizio
    FROM Film F JOIN Proiezione P
    ON F.id_film = P.film
    WHERE F.titolo = Titolo;
END $$
DELIMITER ;

CALL RicercaTitolo('Titanic');

######################### Funzione #########################
DROP FUNCTION IF EXISTS CountaPosti
DELIMITER $$
CREATE FUNCTION CountaPosti(sala CHAR(2), cinema VARCHAR(26))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE numPosti INT;
	SELECT COUNT(*) INTO numPosti 
    FROM Posto
    Where Posto.sala = sala AND Posto.cinema=cinema;
    RETURN numPosti;
END$$
DELIMITER ;

SELECT CountaPosti('S1', 'CineStar') AS numPosti;
<<<<<<< HEAD
>>>>>>> 6414b89e6e86a9b56fb050b8206b35ef228bccf2
=======
>>>>>>> 6414b89e6e86a9b56fb050b8206b35ef228bccf2
