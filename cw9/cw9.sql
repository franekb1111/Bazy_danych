CREATE DATABASE geochronological;

CREATE SCHEMA normalizedtable;

CREATE SCHEMA denormalizedtable;

CREATE TABLE normalizedtable.GeoEon (
	id_eon INT PRIMARY KEY,
	nazwa_eon VARCHAR(30)
);

CREATE TABLE normalizedtable.GeoEra (
	id_era INT PRIMARY KEY,
	id_eon INT,
	nazwa_era VARCHAR(30),
	
	CONSTRAINT eonfk FOREIGN KEY (id_eon) REFERENCES normalizedtable.GeoEon (id_eon)
);

CREATE TABLE normalizedtable.GeoOkres (
	id_okres INT PRIMARY KEY,
	id_era INT,
	nazwa_okres VARCHAR(30),
	
	CONSTRAINT erafk FOREIGN KEY (id_era) REFERENCES normalizedtable.GeoEra (id_era)
);

CREATE TABLE normalizedtable.GeoEpoka (
	id_epoka INT PRIMARY KEY,
	id_okres INT,
	nazwa_epoka VARCHAR(30),
	
	CONSTRAINT okresfk FOREIGN KEY (id_okres) REFERENCES normalizedtable.GeoOkres (id_okres)
);

CREATE TABLE normalizedtable.GeoPietro (
	id_pietro INT PRIMARY KEY,
	id_epoka INT,
	nazwa_pietro VARCHAR(30),
	
	CONSTRAINT epokafk FOREIGN KEY (id_epoka) REFERENCES normalizedtable.GeoEpoka (id_epoka)
);

INSERT INTO normalizedtable.GeoEon (id_eon, nazwa_eon) VALUES
(1, 'Fanerozoik');

INSERT INTO normalizedtable.GeoEra (id_era, nazwa_era, id_eon) VALUES
(1, 'Paleozoik', 1),
(2, 'Mezozoik', 1),
(3, 'Kenozoik', 1);

INSERT INTO normalizedtable.GeoOkres (id_okres, nazwa_okres, id_era) VALUES
(1, 'Dewon', 1),
(2, 'Karbon', 1),
(3, 'Perm', 1),
(4, 'Trias', 2),
(5, 'Jura', 2),
(6, 'Kreda', 2),
(7, 'Paleogen', 3),
(8, 'Neogen', 3),
(9, 'Czwartorzęd', 3);

INSERT INTO normalizedtable.GeoEpoka (id_epoka, nazwa_epoka, id_okres) VALUES
(1, 'Dolny', 1),
(2, 'Środkowy', 1),
(3, 'Górny', 1),
(4, 'Dolny', 2),
(5, 'Górny', 2),
(6, 'Dolny', 3),
(7, 'Górny', 3),
(8, 'Dolny', 4),
(9, 'Środkowy', 4),
(10, 'Górny', 4),
(11, 'Dolna', 5),
(12, 'Środkowa', 5),
(13, 'Górna', 5),
(14, 'Dolna', 6),
(15, 'Górna', 6),
(16, 'Paleocen', 7),
(17, 'Eocen', 7),
(18, 'Oligocen', 7),
(19, 'Miocen', 8),
(20, 'Pliocen', 8),
(21, 'Plejstocen', 9),
(22, 'Halocen', 9);

INSERT INTO normalizedtable.GeoPietro (id_pietro, nazwa_pietro, id_epoka) VALUES
(1, 'Pietro', 22),
(2, 'Pietro', 22),
(3, 'Pietro', 22),
(4, 'Pietro', 21),
(5, 'Pietro', 21),
(6, 'Pietro', 21),
(7, 'Pietro', 20),
(8, 'Pietro', 20),
(9, 'Pietro', 20),
(10, 'Pietro', 19),
(11, 'Pietro', 19),
(12, 'Pietro', 19),
(13, 'Pietro', 18),
(14, 'Pietro', 18),
(15, 'Pietro', 18),
(16, 'Pietro', 17),
(17, 'Pietro', 17),
(18, 'Pietro', 17),
(19, 'Pietro', 16),
(20, 'Pietro', 16),
(21, 'Pietro', 16),
(22, 'Pietro', 15),
(23, 'Pietro', 15),
(24, 'Pietro', 15),
(25, 'Pietro', 14),
(26, 'Pietro', 14),
(27, 'Pietro', 14),
(28, 'Pietro', 13),
(29, 'Pietro', 13),
(30, 'Pietro', 13),
(31, 'Pietro', 12),
(32, 'Pietro', 12),
(33, 'Pietro', 12),
(34, 'Pietro', 11),
(35, 'Pietro', 11),
(36, 'Pietro', 11),
(37, 'Pietro', 10),
(38, 'Pietro', 10),
(39, 'Pietro', 10),
(40, 'Pietro', 9),
(41, 'Pietro', 9),
(42, 'Pietro', 9),
(43, 'Pietro', 8),
(44, 'Pietro', 8),
(45, 'Pietro', 8),
(46, 'Pietro', 7),
(47, 'Pietro', 7),
(48, 'Pietro', 7),
(49, 'Pietro', 7),
(50, 'Pietro', 6),
(51, 'Pietro', 6),
(52, 'Pietro', 6),
(53, 'Pietro', 6),
(54, 'Pietro', 5),
(55, 'Pietro', 5),
(56, 'Pietro', 5),
(57, 'Pietro', 4),
(58, 'Pietro', 4),
(59, 'Pietro', 4),
(60, 'Pietro', 3),
(61, 'Pietro', 3),
(62, 'Pietro', 3),
(63, 'Pietro', 2),
(64, 'Pietro', 2),
(65, 'Pietro', 2),
(66, 'Pietro', 1),
(67, 'Pietro', 1),
(68, 'Pietro', 1);

CREATE TABLE denormalizedtable.GeoTabela AS (SELECT * FROM normalizedtable.GeoPietro NATURAL JOIN normalizedtable.GeoEpoka NATURAL 
JOIN normalizedtable.GeoOkres NATURAL JOIN normalizedtable.GeoEra NATURAL JOIN normalizedtable.GeoEon );


CREATE TABLE denormalizedtable.Dziesiec (
	cyfra INT PRIMARY KEY,
	bit INT
);

INSERT INTO denormalizedtable.Dziesiec VAlUES
(0, 1),
(1, 1),
(2, 0),
(3, 1),
(4, 0),
(5, 0),
(6, 1),
(7, 1),
(8, 0),
(9, 1);


CREATE TABLE denormalizedtable.Milion(liczba INT,cyfra INT, bit INT);
INSERT INTO denormalizedtable.Milion SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra 
+ 10000*a5.cyfra + 10000*a6.cyfra AS liczba , a1.cyfra AS cyfra, a1.bit AS bit 
FROM denormalizedtable.Dziesiec a1, denormalizedtable.Dziesiec a2, denormalizedtable.Dziesiec a3, denormalizedtable.Dziesiec a4, denormalizedtable.Dziesiec a5, denormalizedtable.Dziesiec a6;

-- 1ZL

SELECT COUNT(*) FROM denormalizedtable.Milion INNER JOIN denormalizedtable.GeoTabela ON 
(mod(denormalizedtable.Milion.liczba,68)=(denormalizedtable.GeoTabela.id_pietro));


-- 2ZL

SELECT COUNT(*) FROM denormalizedtable.Milion INNER JOIN normalizedtable.GeoPietro ON 
(mod(denormalizedtable.Milion.liczba,68)=normalizedtable.GeoPietro.id_pietro) NATURAL JOIN normalizedtable.GeoEpoka NATURAL JOIN 
normalizedtable.GeoOkres NATURAL JOIN normalizedtable.GeoEra NATURAL JOIN normalizedtable.GeoEon;

-- 3ZG

SELECT COUNT(*) FROM denormalizedtable.Milion WHERE mod(denormalizedtable.Milion.liczba,68)= 
(SELECT id_pietro FROM denormalizedtable.GeoTabela WHERE mod(denormalizedtable.Milion.liczba,68)=(id_pietro));

-- 4ZG

SELECT COUNT(*) FROM denormalizedtable.Milion WHERE mod(denormalizedtable.Milion.liczba,68) IN
(SELECT normalizedtable.GeoPietro.id_pietro FROM normalizedtable.GeoPietro NATURAL JOIN normalizedtable.GeoEpoka NATURAL JOIN 
normalizedtable.GeoOkres NATURAL JOIN normalizedtable.GeoEra NATURAL JOIN normalizedtable.GeoEon);

CREATE INDEX indxmil ON denormalizedtable.Milion (liczba);
CREATE INDEX indxgeotabpietro ON denormalizedtable.GeoTabela (id_pietro);
CREATE INDEX indxgeopietropietro ON normalizedtable.GeoPietro (id_pietro);


