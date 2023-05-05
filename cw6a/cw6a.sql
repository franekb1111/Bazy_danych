CREATE DATABASE demo2

USE demo2

CREATE SCHEMA cw6;


CREATE TABLE cw6.zamowienia (
id_produktu INT PRIMARY KEY NOT NULL,
nazwa_produktu VARCHAR(50),
id_klienta INT,
nazwa_klienta VARCHAR(80),
data_zamowienia DATE,
cena_produktu MONEY,
iloœæ INT,
VAT FLOAT,
suma_brutto MONEY,
suma_netto MONEY,
);

INSERT INTO cw6.zamowienia
VALUES 
(1, 'ksi¹¿ki', 4, 'Bogdan Ma³y', '2023-03-01', 100, 200, 0.05, 100*(1+0.05)*200, 100*200),
(2, 'pieczywo', 6, 'Teresa Nowak', '2023-04-01', 2.99, 1000, 0.08, 2.99*(1+0.08)*1000, 2.99*1000),
(3, 'benzyna', 78, 'Kazimierz Suchodolski', '2023-05-01', 6.67, 300, 0.23, 6.67*(1+0.23)*300, 6.67*300);

SELECT *
FROM cw6.zamowienia;

--1. zale¿noœci funkcyjne:

--id_produktu -> nazwa_produktu, cena_produktu, VAT 
--nazwa_produktu -> id_produktu, cena_produktu, VAT 
--nazwa_klienta -> id_klienta
--id_klienta -> nazwa_klienta
--cena_produktu, iloœæ, VAT -> suma_brutto
--cena_produktu, iloœæ -> suma_netto

--2. klucze kandyduj¹ce

--id_produktu, id_klienta + data_zamowienia


--3. Dla tabeli pomieszczenia(id_pomieszczenia, numer_pomieszczenia, id_budynku, 
--powierzchnia, liczba_okien, liczba_drzwi, ulica, miasto, kod_pocztowy) okreœl wszystkie 
--zale¿noœci funkcyjne oraz klucze kandyduj¹ce.

--Przyjmij nastêpuj¹ce za³o¿enia:
--- id_pomieszczenia to autoinkrementowany, unikalny identyfikator pomieszczenia w tabeli

CREATE TABLE cw6.pomieszczenia (
id_pomieszczenia INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
numer_pomieszczenia INT,
id_budynku INT,
powierzchnia FLOAT,
liczba_okien INT,
liczba_drzwi INT,
ulica VARCHAR(60),
miasto VARCHAR(60),
kod_pocztowy VARCHAR(6),
);

INSERT INTO cw6.pomieszczenia (numer_pomieszczenia, id_budynku, powierzchnia, liczba_okien, liczba_drzwi, ulica, miasto, kod_pocztowy)
VALUES 
(23, 5, 230.6, 15, 6, 'Jaœminowa 5', 'Kraków', '20-230'),
(4, 87, 34.8, 6, 2, 'Opolska 5', 'Opole', '11-237'),
(5, 67, 100, 8, 3, '£adna 15', 'Racibórz', '16-297');

SELECT *
FROM cw6.pomieszczenia

--3. zale¿noœci funkcyjne

--id_pomieszczenia -> numer_pomieszczenia, id_budynku, powierzchnia, liczba_okien, liczba_drzwi, ulica, miasto, kod_pocztowy
--kod_pocztowy -> miasto
--miasto -> kod_pocztowy
--numer_pomieszczenia, id_budynku -> id_pomieszczenia, powierzchnnia, liczba_okien, liczba_drzwi, ulica, miasto, kod_pocztowy
--miasto, ulica -> id_budynku, kod_pocztowy
--kod_pocztowy, ulica -> id_budynku, miasto
--ulica, miasto, numer_pomieszczenia -> id_budynku, powierzchnia, liczba_okien, liczba_drzwi, kod_pocztowy, id_pomieszczenia
--ulica, kod_pocztowy, numer_pomieszczenia -> id_budynku, powierzchnia, liczba_okien, liczba_drzwi, miasto, id_pomieszczenia

--3. klucze kandyduj¹ce

--id_pomieszczenia, numer_pomieszczenia + id_budynku, ulica + miasto + numer_pomieszczenia, ulica + kod_pocztowy + numer_pomieszczenia
