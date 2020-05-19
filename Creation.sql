CREATE TABLE Klienci(
	Imię varchar(100) NOT NULL,
	Nazwisko nchar(100) NOT NULL,
	Wiek smallint NULL,
	Email varchar(100) NOT NULL,
	NumerTelefonu char(9) NULL,
	NumerID int PRIMARY KEY,
	MiejsceZamieszkania varchar(200) NOT NULL,
	Płeć varchar(10) NOT NULL, CHECK (Płeć IN('kobieta', 'mężczyzna', 'nieznana'))
)

CREATE TABLE Specjalizacje(
	Nazwa varchar(100) PRIMARY KEY,
	Opis text NOT NULL,
)

CREATE TABLE Dentyści(
	Imię varchar(100) NOT NULL,
	Nazwisko varchar(100) NOT NULL,
	NumerTelefonu nchar(10) NOT NULL,
	Adres varchar(255) NOT NULL,
	NumerID int PRIMARY KEY,
	NumerKonta nchar(26) NOT NULL,
	SpecjalizacjeREF varchar(100) FOREIGN KEY REFERENCES Specjalizacje(Nazwa)
)

CREATE TABLE Relacje(
	DataDodania datetime NOT NULL,
	Ocena tinyint NULL,
	CONSTRAINT poprawny_ocena CHECK ( Ocena > 0),
	NumerID_relacji int PRIMARY KEY,
	KlienciREF int FOREIGN KEY REFERENCES Klienci(NumerID),
	DentyściREF int FOREIGN KEY REFERENCES Dentyści(NumerID)
)

CREATE TABLE Komentarze(
	Tytuł varchar(50) PRIMARY KEY,
	Tekst text NULL,
	RelacjeREF int FOREIGN KEY REFERENCES Relacje(NumerID_relacji)
)

CREATE TABLE Dyplomy (
	Ocena tinyint NOT NULL,
	Dyplom text NOT NULL,
	NumerID int PRIMARY KEY,
	DentyściREF int FOREIGN KEY REFERENCES Dentyści(NumerID),
	SpecjalizacjeREF varchar(100) FOREIGN KEY REFERENCES Specjalizacje(Nazwa)
)

CREATE TABLE Terminarz(
	DzienTygodnia varchar(12) NOT NULL CHECK (DzienTygodnia IN('poniedziałek', 'wtorek', 'środa', 'czwartek','piątek', 'sobota','niedziela')),
	GodzinaOtawrcia nchar(10) NOT NULL,
	GodzinaZamknięcia nchar(10) NOT NULL,
	NumerDniaID int PRIMARY KEY,
	DentysciREF int FOREIGN KEY REFERENCES Dentyści(NumerID)
)

CREATE TABLE Terminy(
	Data datetime NOT NULL,
	Usługa varchar(50) NULL,
	NumerIDRachunku int PRIMARY KEY,
	DentyściREF int FOREIGN KEY REFERENCES Terminarz(NumerDniaID),
	KlienciREF int FOREIGN KEY REFERENCES Klienci(NumerID)
)

CREATE TABLE Rachunki(
	StatusRachunku nchar(10) NOT NULL CHECK (StatusRachunku IN('opłacony', 'do zapłaty', 'raty', 'karta podarunkowa', 'darmowe')),
	Kwota int NOT NULL,
	DataSpłaty datetime NOT NULL,
	Nazwa nchar(20) NOT NULL,
	NumerRachunkuID int PRIMARY KEY,
	TerminyREF int FOREIGN KEY REFERENCES Terminy(NumerIDRachunku) ON DELETE CASCADE
)
