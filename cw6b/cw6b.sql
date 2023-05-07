USE firma;

--a)

UPDATE ksiegowosc.pracownicy
SET telefon = '(+48)' + telefon;

SELECT * 
FROM ksiegowosc.pracownicy;

--b)

UPDATE ksiegowosc.pracownicy
SET telefon = '(+48)' + SUBSTRING(telefon, 6, 3) + '-' + SUBSTRING(telefon, 10, 3) + '-' +  SUBSTRING(telefon, 14, 3);

SELECT * 
FROM ksiegowosc.pracownicy;

--c)

SELECT id_pracownika, UPPER(imie) AS imie , UPPER(nazwisko) AS nazwisko, UPPER(adres) AS adres, telefon
FROM ksiegowosc.pracownicy
WHERE LEN(nazwisko) = (SELECT MAX(LEN(nazwisko)) FROM ksiegowosc.pracownicy);

--d)

SELECT HASHBYTES('MD5', CONVERT(NVARCHAR(32), pracownicy.id_pracownika)) AS id_pracownika, HASHBYTES('MD5', imie) AS imie , HASHBYTES('MD5', nazwisko) AS nazwisko, HASHBYTES('MD5', adres) AS adres, HASHBYTES('MD5', telefon) AS telefon,  HASHBYTES('MD5', CONVERT(NVARCHAR(32), kwota)) AS kwota
FROM ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji 

--f)

SELECT pracownicy.id_pracownika, imie, nazwisko, adres, telefon, pensja.id_pensji, pensja.kwota AS kwota_pensji, premia.id_premii, premia.kwota AS kwota_premii, stanowisko, rodzaj AS rodzaj_premii
FROM ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pracownicy  ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji LEFT OUTER JOIN ksiegowosc.premia ON wynagrodzenie.id_premii = premia.id_premii

--g)

DECLARE @imie VARCHAR(50)
DECLARE @nazwisko VARCHAR(50)
SET @imie = 'Jacek'
SET @nazwisko = 'Kowalski'
DECLARE @data DATE
DECLARE @kwota_pensji_i_premii_i_nadgodziny INT
DECLARE @kwota_pensji INT
DECLARE @kwota_premii INT
DECLARE @nadgodziny INT
SELECT DISTINCT @kwota_pensji_i_premii_i_nadgodziny = pensja.kwota + premia.kwota + ((liczba_godzin-160) * 20), @data = wynagrodzenie.data, @imie = imie, @nazwisko = @nazwisko, @kwota_pensji = pensja.kwota, @kwota_premii = premia.kwota, @nadgodziny = ((liczba_godzin-160) * 20) FROM ksiegowosc.wynagrodzenie 
INNER JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
INNER JOIN ksiegowosc.godziny ON wynagrodzenie.id_pracownika = godziny.id_pracownika
INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji 
LEFT OUTER JOIN ksiegowosc.premia ON wynagrodzenie.id_premii = premia.id_premii
WHERE imie = @imie AND nazwisko = @nazwisko AND wynagrodzenie.data = (SELECT data FROM ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika WHERE imie = @imie AND nazwisko = @nazwisko)


PRINT(CONCAT('Pracownik ', @imie, ' ', @nazwisko, ',', ' w dniu ', CONVERT(NVARCHAR(30), @data, 104), ' otrzyma³ pensjê ca³kowit¹ na kwotê ',  @kwota_pensji_i_premii_i_nadgodziny, ' z³, gdzie wynagrodzenie zasadnicze wynosi³o: ', @kwota_pensji, ' z³, premia: ', @kwota_premii, ' z³, nadgodziny: ', @nadgodziny, ' z³'));


