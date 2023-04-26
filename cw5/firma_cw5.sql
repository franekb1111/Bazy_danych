CREATE DATABASE firma;

USE firma;

CREATE SCHEMA ksiegowosc;

CREATE TABLE ksiegowosc.pracownicy (	--tabela z danymi pracowników
id_pracownika INT PRIMARY KEY NOT NULL,
imie VARCHAR(50) NOT NULL,
nazwisko VARCHAR(70) NOT NULL,
adres VARCHAR(100),
telefon VARCHAR(18),
);

CREATE TABLE ksiegowosc.godziny (	--tabela z liczb¹ godzin przepracowan¹ przez danego pracownika w danym miesi¹cu
id_godziny INT PRIMARY KEY NOT NULL,
data DATE,
liczba_godzin INT,
id_pracownika INT NOT NULL,
);

CREATE TABLE ksiegowosc.premia (	--tabela z rodzajami premii
id_premii INT PRIMARY KEY NOT NULL,
rodzaj VARCHAR(20),
kwota MONEY,
);


CREATE TABLE ksiegowosc.pensja (	--tabela z wysokosciami pensji 
id_pensji INT PRIMARY KEY NOT NULL,
stanowisko VARCHAR(30),
kwota MONEY,
);

CREATE TABLE ksiegowosc.wynagrodzenie (	--tabela przyznanymi wynagrodzeniami w danym miesi¹cu
id_wynagrodzenia INT PRIMARY KEY NOT NULL,
data DATE,
id_pracownika INT NOT NULL,
id_godziny INT NOT NULL,
id_pensji INT NOT NULL,
id_premii INT,
);

ALTER TABLE ksiegowosc.godziny
ADD CONSTRAINT empfk FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy (id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD CONSTRAINT empfk_w FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy (id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD CONSTRAINT hfk FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny (id_godziny);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD CONSTRAINT salfk FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensja (id_pensji);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD CONSTRAINT prefk FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia (id_premii);

EXEC sp_addextendedproperty 
@name = 'Opis',
@value = 'Tabela z danymi pracowników',
@level0type = 'Schema',
@level0name = 'ksiegowosc',
@level1type = 'Table',
@level1name = 'pracownicy';

EXEC sp_addextendedproperty 
@name = 'Opis',
@value = 'Tabela z liczb¹ godzin przepracowan¹ przez danego pracownika w danym miesi¹cu',
@level0type = 'Schema',
@level0name = 'ksiegowosc',
@level1type = 'Table',
@level1name = 'godziny';

EXEC sp_addextendedproperty 
@name = 'Opis',
@value = 'Tabela z rodzajami premii',
@level0type = 'Schema',
@level0name = 'ksiegowosc',
@level1type = 'Table',
@level1name = 'premia';

EXEC sp_addextendedproperty 
@name = 'Opis',
@value = 'Tabela z wysokosciami pensji',
@level0type = 'Schema',
@level0name = 'ksiegowosc',
@level1type = 'Table',
@level1name = 'pensja';

EXEC sp_addextendedproperty
@name = 'Opis',
@value = 'Tabela przyznanymi wynagrodzeniami w danym miesi¹cu',
@level0type = 'Schema',
@level0name = 'ksiegowosc',
@level1type = 'Table',
@level1name = 'wynagrodzenie';

INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
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

INSERT INTO ksiegowosc.godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES 
(1, '2023-03-01', 160, 1),
(2, '2023-04-01', 155, 3),
(3, '2023-02-01', 161, 8),
(4, '2023-01-02', 170, 1),
(5, '2022-12-01', 140, 4),
(6, '2022-11-02', 100, 6),
(7, '2022-10-02', 155, 3),
(8, '2022-02-04', 200, 9),
(9, '2022-08-07', 130, 10),
(10, '2022-08-07', 180, 4);

INSERT INTO ksiegowosc.premia (id_premii, rodzaj, kwota)
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

INSERT INTO ksiegowosc.pensja (id_pensji, stanowisko, kwota)
VALUES 
(1, 'Asystent biura', 2500),
(2, 'Dyrektor', 20000),
(3, 'Wicedyrektor', 18000),
(4, 'Sprz¹tacz', 1000),
(5, 'Ksiêgowy', 3000),
(6, 'HR manager', 7000),
(7, 'Rekruter', 5000),
(8, 'Software engineer', 15000),
(9, 'QA engineer', 14000),
(10, 'DevOps', 17000);

INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES 
(1, '2023-03-01', 1, 1, 1, 4),
(2, '2023-04-01', 3, 3, 2, 6),
(3, '2023-02-01', 8, 4, 3, NULL),
(4, '2023-01-02', 4, 4, 4, NULL),
(5, '2022-12-01', 4, 4, 5, NULL),
(6, '2022-11-02', 6, 7, 6, 9),
(7, '2022-10-02', 3, 3, 7, 8),
(8, '2022-02-04', 9, 10, 8, 2),
(9, '2022-08-07', 10, 8, 9, 1),
(10, '2022-08-07', 4, 7, 10, 5);


-- a)

SELECT id_pracownika, nazwisko 
FROM ksiegowosc.pracownicy;

-- b)

SELECT DISTINCT id_pracownika 
FROM (ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji)
WHERE kwota > 1000;

-- c)

SELECT id_pracownika 
FROM (ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji)
WHERE (kwota > 1000 AND id_premii IS NULL);

-- d)

SELECT * 
FROM ksiegowosc.pracownicy
WHERE nazwisko LIKE 'J%';

-- e)

SELECT * 
FROM ksiegowosc.pracownicy
WHERE nazwisko LIKE '%n%' AND  imie LIKE '%a';

-- f)

SELECT DISTINCT imie, nazwisko, (liczba_godzin-160) AS nadgodziny 
FROM (ksiegowosc.godziny INNER JOIN ksiegowosc.pracownicy ON godziny.id_pracownika = pracownicy.id_pracownika);

-- g)

SELECT imie, nazwisko
FROM ((ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika) INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji)
WHERE kwota > 1500 AND kwota < 3000;

-- h)

SELECT DISTINCT imie, nazwisko, (liczba_godzin-160) AS nadgodziny 
FROM ((ksiegowosc.godziny INNER JOIN ksiegowosc.pracownicy ON godziny.id_pracownika = pracownicy.id_pracownika) INNER JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika = godziny.id_pracownika)
WHERE id_premii IS NULL AND (liczba_godzin-160) > 0;

-- i)

SELECT pracownicy.id_pracownika, imie, nazwisko, adres, telefon, pensja.id_pensji, kwota
FROM ((ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pracownicy  ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika) INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji)
ORDER BY kwota ASC;

-- j)

SELECT pracownicy.id_pracownika, imie, nazwisko, adres, telefon, pensja.kwota AS kwota_pensji, premia.kwota AS kwota_premii
FROM (((ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pracownicy  ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika) INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji) INNER JOIN ksiegowosc.premia ON wynagrodzenie.id_premii = premia.id_premii)
ORDER BY pensja.kwota DESC, premia.kwota DESC;

-- k)

SELECT COUNT(id_pracownika) AS liczba_pracownikow_na_stanowisku, stanowisko
FROM  (ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji)
GROUP BY stanowisko;

-- l)

SELECT AVG(kwota) AS srednia_pensja, MIN(kwota) AS min_pensja, MAX(kwota) AS max_pensja
FROM  (ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji)
WHERE stanowisko = 'Dyrektor';

-- m)

SELECT (SUM(premia.kwota) + SUM(pensja.kwota)) AS suma_wynagrodzeñ
FROM (((ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pracownicy  ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika) INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji) LEFT OUTER JOIN ksiegowosc.premia ON wynagrodzenie.id_premii = premia.id_premii)

-- f)



