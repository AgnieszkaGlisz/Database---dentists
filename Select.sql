-- their number: from 7 to 10 (8/7)
-- at least 1 query using a view (3/1)
-- at least 2 queries using joins (5/2)
-- at least 2 queries with subqueries (5/2)
-- at least 2 queries using aggregate functions (3/2)
-- at least 2 queries using grouping (2/2)
-- at least 1 query with ordering (1/1)

USE [dentysci]
GO

--1.
/*DROP VIEW [MaleCustormes];
CREATE VIEW [MaleCustormes] AS
(SELECT Imię, Nazwisko
FROM Klienci
WHERE Płeć = 'mężczyzna')*/

SELECT * FROM [MaleCustormes]; 
--Opis : Wyswietla wszystkich klientow plci meskiej
--Wykorzystane: view, subqueries

--2.
SELECT Dentyści.Imię, Dentyści.Nazwisko,Specjalizacje.Nazwa,Dyplomy.Dyplom, Dyplomy.Ocena
	FROM  (Dentyści
	INNER JOIN Specjalizacje ON Dentyści.SpecjalizacjeREF = Specjalizacje.Nazwa
	INNER JOIN Dyplomy ON Dentyści.NumerID = Dyplomy.DentyściREF)
	WHERE Dyplomy.Ocena BETWEEN 50 AND 100
--Opis: Wyswietla imie, nazwisko dentysty oraz ich specjalizacje, zdjecie dyplomu i ocene uslugi
--Wykorzystuje: join, subqueries

--3.
SELECT Dentyści.Imię, Dentyści.Nazwisko, Terminarz.DzienTygodnia, Terminarz.GodzinaOtawrcia, Terminarz.GodzinaZamknięcia
	FROM ( Dentyści
		INNER JOIN Terminarz ON Dentyści.NumerID=Terminarz.DentysciREF)
		WHERE Terminarz.DzienTygodnia = 'poniedzialek'
		OR Terminarz.DzienTygodnia = 'czwartek'
--Opis: Wyswietla godziny otwarcia dentysty w odpowiednich dniach tygodnia
--Wykorzystuje: join, subqueries


--4.
 SELECT COUNT(MiejsceZamieszkania)
  FROM Klienci WHERE Klienci.MiejsceZamieszkania = 'Rumia'
--Opis: Oblicza liczbe klientow, ktorzy mieszkaja w podanej miejscowosci
--Wykorzystuje: aggregate functions, subqueries

--5
SELECT  Dentyści.Imię , Dentyści.Nazwisko, Relacje.Ocena    
	FROM ( Dentyści
	INNER JOIN Relacje ON Dentyści.NumerID=Relacje.DentyściREF)
	WHERE (SELECT MAX(Ocena) AS MaxOcena FROM Relacje) = Relacje.Ocena
	OR (SELECT MIN(Ocena) AS MinOcena FROM Relacje) = Relacje.Ocena
--Opis: wyswietla dentystow z minimalna i maksymalna ocena
--Wykorzystuje: join, aggregate functions, subqueries


--6
SELECT MiejsceZamieszkania, Płeć, COUNT(MiejsceZamieszkania) AS LiczbaMieszkancow
FROM Klienci
GROUP by MiejsceZamieszkania, Płeć
--Opis: Wyswietla liczbe mieszkancow danej plci zamieszkujacych rozne miejscowosci
--Wykorzystuje: aggregate functions, group


--7
/*DROP VIEW [RachunkiDentystow]
CREATE VIEW [RachunkiDentystow] AS
 (SELECT  Dentyści.Imię as ImieLekarza, Dentyści.Nazwisko as NazwiskoLekarza,
		Klienci.Imię as ImieKlienta, Klienci.Nazwisko as NazwiskoKlienta,
		Rachunki.Kwota, Rachunki.StatusRachunku
   FROM Rachunki
	INNER JOIN Terminy ON Rachunki.TerminyREF = Terminy.NumerIDRachunku
	INNER JOIN Dentyści ON Dentyści.NumerID = Terminy.DentyściREF
	INNER JOIN Klienci ON Klienci.NumerID = Terminy.KlienciREF)*/

SELECT ImieLekarza, NazwiskoLekarza, StatusRachunku, SUM(KWOTA) AS LacznyRachunek
FROM RachunkiDentystow
GROUP by StatusRachunku, ImieLekarza, NazwiskoLekarza
--Opis: Wyswietla sumy rachunkow w zaleznosci od statusu danych dentystow
--Wykorzystuje: view, group, join

--8
/*CREATE VIEW [DentysciOceny] AS
 (SELECT Dentyści.Imię, Dentyści.Nazwisko, Relacje.Ocena
	FROM Dentyści
	INNER JOIN Relacje ON Relacje.DentyściREF = Dentyści.NumerID)*/

SELECT Imię, Nazwisko, Ocena
FROM DentysciOceny
ORDER by Ocena DESC
--Opis: Wyswietla posortowane oceny dentystow
--Wykorzystuje: view, join, order 
