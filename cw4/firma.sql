CREATE DATABASE firma;

USE firma;

CREATE SCHEMA rozliczenia;

CREATE TABLE rozliczenia.pracownicy (
id_pracownika INT PRIMARY KEY NOT NULL,
imie VARCHAR(50) NOT NULL,
nazwisko VARCHAR(70) NOT NULL,
adres VARCHAR(100),
telefon VARCHAR(18),
);

CREATE TABLE rozliczenia.godziny (
id_godziny INT PRIMARY KEY NOT NULL,
data DATE,
liczba_godzin INT,
id_pracownika INT NOT NULL,
);

CREATE TABLE rozliczenia.premie (
id_premii INT PRIMARY KEY NOT NULL,
rodzaj VARCHAR(20),
kwota MONEY,
);

CREATE TABLE rozliczenia.pensje (
id_pensji INT PRIMARY KEY NOT NULL,
stanowisko VARCHAR(30),
kwota MONEY,
id_premii INT NOT NULL,
);

ALTER TABLE rozliczenia.godziny
ADD CONSTRAINT empfk FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy (id_pracownika);

ALTER TABLE rozliczenia.pensje
ADD CONSTRAINT salfk FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie (id_premii);

INSERT INTO rozliczenia.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES 
(1, 'Jacek', 'Kowalski', 'Zbo¿owa 5 Warszawa', '501 879 009'),
(2, 'Katarzyna', 'Monitor', 'Zbo¿owa 7 Warszawa', '901 899 009'),
(3, 'Tatiana', 'Kowalewska', 'Urojona 97A Warszawa', '781 423 353'),
(4, 'Maja', 'Nowak', 'Polna 9 Warszawa', '322 673 678'),
(5, 'Adam', 'Stó³', 'Ochocka 785B Mys³owice', '324 764 896'),
(6, 'Dominika', 'Ig³a', 'Ptasia 8 Legionowo', '135 564 356'),
(7, 'Janusz', 'Tracz', 'Tajna 8 Sosnowiec', '666 666 666'),
(8, 'Rafa³', 'Rowerowy', 'B³êdna 21 Myszków', '367 245 785'),
(9, 'Stanis³aw', 'Stanis³awowy', 'Stanis³awów 6 Stanis³awowo', '234 378 797'),
(10, 'Piotr', 'Piotrkowy', 'Œw. Piotra 4 Piotrków Trybunalski', '543 790 324');

INSERT INTO rozliczenia.godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES 
(1, '2023-03-12', 5, 1),
(2, '2023-03-18', 7, 3),
(3, '2023-01-06', 6, 8),
(4, '2023-06-23', 4, 1),
(5, '2023-03-18', 5, 4),
(6, '2017-03-18', 3, 6),
(7, '2021-12-28', 8, 3),
(8, '2023-02-07', 6, 9),
(9, '2018-08-07', 3, 10),
(10, '2022-08-21', 1, 4);

INSERT INTO rozliczenia.premie (id_premii, rodzaj, kwota)
VALUES 
(1, 'regulaminowa', 200),
(2, 'uznaniowa', 400),
(3, 'motywacyjna', 100),
(4, 'zadaniowa', 1000),
(5, 'prowizyjna', 50),
(6, 'indywidualna', 600),
(7, 'zespo³owa', 300),
(8, 'frekwencyjna', 90),
(9, 'wynikowa', 100),
(10, 'okolicznoœciowa', 400);

INSERT INTO rozliczenia.pensje (id_pensji, stanowisko, kwota, id_premii)
VALUES 
(1, 'Asystent biura', 2500, 1),
(2, 'Dyrektor', 20000, 2),
(3, 'Wicedyrektor', 18000, 2),
(4, 'Sprz¹tacz', 1000, 8),
(5, 'Ksiêgowy', 3000, 4),
(6, 'HR manager', 7000, 6),
(7, 'Rekruter', 5000, 4),
(8, 'Software engineer', 15000, 4),
(9, 'QA engineer', 14000, 4),
(10, 'DevOps', 17000, 3);

--SELECT * FROM rozliczenia.pensje;

--SELECT * FROM rozliczenia.premie;

--SELECT * FROM rozliczenia.godziny;

--SELECT * FROM rozliczenia.pracownicy;

SELECT nazwisko, adres
FROM rozliczenia.pracownicy;

SELECT data, DATEPART(month, data) AS Mies, DATEPART(weekday, data) AS DzienTyg
FROM rozliczenia.godziny;

EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';

ALTER TABLE rozliczenia.pensje
ADD kwota_netto AS CAST((kwota_brutto*0.88) AS MONEY);





