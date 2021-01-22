/*
Svi dokumenti i folderi koje je potrebno kreirati moraju sadržavati broj indeksa. 
Solution trebaju sadržavati i oznaku procesa (IS – Integration Services, TAB - tabularni model, REP - report). 
Npr. folder projekta za integracijski servis treba imati oznaku IB123456_IS. 

---------------------------------------------------------------------------------------------
Prag prolaznosti je u POTPUNOSTI tačno kreirano i tačnim brojem podataka napunjeno skladište.
---------------------------------------------------------------------------------------------

Po završetku rada arhivirati sve foldere i dokumente pod vlastitim brojem indeksa (IB123456.zip) i uploadovati na ftp. 
username: student_fd
password: student_fd
*/

/*
Arhiva treba sadržavati sljedeće dokumente i foldere:
    1. SQL skriptu za kreiranje dodatne tabele u relacijskoj bazi (IB123456_DB)
    2. SQL skriptu za kreiranja skladišta (IB123456_DW)
    3. bak fajl skladišta podataka (IB123456_DW.bak)
    4. Folder projekta za import podataka u skladište (IB123456_IS)
    5. Folder projekta za kreiranje tabular modela (IB123456_TAB)
    6. Excel dokument(e) u kojima je izvršena analiza (IB123456.xlsx ili IB123456_a.xlsx, IB123456_b.xlsx …)
    7. PowerBI dokument(e) u kojima je izvršena analiza (IB123456.pbix ili IB123456_a.pbix, IB123456_b.pbix ...)
    8. Folder projekta za kreiranje reporta (IB123456_REP)
    9. pdf format izvještaja (IB123456.pdf)
*/

/*
1. 	RESTORE RELACIJSKE BAZE narucitelj I MODIFICIRANJE TABELA
a) 	Iz defaultnog backup foldera MS SQL servera izvršiti 
	restore relacione baze podataka narucitelj iz fajla narucitelj.bak
	U slučaju nemogućnosti kreiranja dijagrama pokrenuti 
	kod za dobivanje ovlasti nad bazom.
*/
--kod za dobijanje ovlasti nad bazom
alter authorization on database :: prodaja to sa

/*
b)	U bazi kreirati tabelu godina sljedeće strukture:
	- order_id, cjelobrojna vrijednost
	- god_narudzbe, godina iz kolone OrderDate
	- god_isporuke, godina iz kolone ShippedDate
Tabela godina mora biti na odgovarajući 
način povezana sa tabelom Orders.
Nakon kreiranja, tabelu godina popuniti 
odgovarajućim podacima iz tabele Orders.
*/

/*
c)	U tabeli Employees koristeći kolone BirthDate i HireDate kreirati 
	izračunatu kolonu star_kat po sljedećem principu:
	broj godina 		
	u trenutku 
	zapošljavanja		kategorija	
	0 - 29				1
	30 - 39				2
	40 - 49				3
	50 - 59				4
*/
--15 bodova

/*
2. 	KREIRANJE SKLADIŠTA PODATAKA 
Kreirati skladište podataka pod vlastitim brojem indeksa po pravilu IB123456_DW.

Tipove podataka kolona u tabelama skladišta uskladiti 
sa tipovima podatka kolona u tabelama u relacijskoj bazi.

	a) 	dimenzijske tabele
	Svaka dimenzijska tabela treba imati odgovarajući poslovni (bussines) ključ.
	1. 	dim_customers
		Polja tabele su sva polja tabele Customers
	2.	dim_employees
		Polja tabele su:
		EmployeeID, HireDate i star_kat iz tabele Employees,
		TerritoryDescription iz tabele Territories
	3. 	dim_godina
		Polja tabele su sva polja tabele godina.
	4.	dim_shippers
		Polja tabele su sva polja tabele Shippers

	b) 	tabela činjenica (fact tabela) - fact_orders
		Tabela činjenica odgovara tabeli Orders
		i osim odgovarajućeg poslovnog (bussines) ključa, 
		kao i polja koja će biti spoljni ključevi prema dimenzijskim tabelama njeno polje je:
		- Freight
*/
--20 bodova

/*
3. 	IMPORT PODATAKA U SKLADIŠTE
Import podataka u dimenzijske tabele smjestiti u package dim.dtsx, 
a fact tabelu u fact.dtsx. Projekt imenovati po pravilu IB123456-IS.
	
	a) 	Dimenzijske tabele
		
		1. 	Import podataka u dimenzijske tabele dim_customers, dim_godina i dim_shippers
		izvršiti mapiranjem odgovarajućih polja 
		tabela Customers, godina i Shippers u relacijskoj bazi. 
		(prosti prenos podataka)
		
		2. 	Import podataka u dimenzijsku tabelu dim_employees
		izvršiti upotrebom upita kombinirajući 
		odgovarajuća polja tabela iz relacione baze
	
	b) Tabela činjenica
		fact_orders
		Izvorišna tabela u procesu importa podataka u tabelu činjenica je tabela Orders
*/
--20 bodova

-----------------------------------------------------------
--GRANICA ZA OCJENU 6
----------------------------------------------------------- 
  

/*
4. TABULAR MODEL
Napomena za konekciju
Konekcija se može ostvariti putem integrated workspace. 

Ako se na početku kreiranja tabularnog modela prijavljivanje vrši putem opcije 
workspace server obavezno koristiti oblik konekcije localhost\tabular.
 
Provesti postupak kreiranja tabularnog modela na osnovu 
skladišta podataka imenovanog prema vlastitom broju indeksa - 
povući sve dimenzijske i tabelu činjenica.
	a) Nove kolone
	-	na sheetu dim_employee kreirati kolonu godina u kojoj će 
		biti smještena godina iz kolone HireDate

	b) Mjere
		Mjere OBAVEZNO imenovati nazivima koji su dati u tekstu zadatka. Kao mjere definirati:
		-	na sheetu dim_customers
			-	prebroj_title nad kolonom ContactTitle
				a zatim filtrirati na Sales Representative
		-	na sheetu dim_godina
			-	prebroj_isp nad kolonom god_isporuke
				a zatim filtrirati na 1997
		
		-	na sheetu fact_order_header
			mjeru sumiranja nad kolonom:
			- Freight
*/
--15 bodova

/*
5. 	ANALIZA U EXCELU
Iz tabularnog modela kreirati analize u excelu. 

Nazivi dokumenata
-	Analize se mogu kreirati u jednom dokumentu pri čemu svaka treba biti 
	na zasebnom sheetu ili u zasebnim dokumentima. 
-	Ako su sve analize u jednom dokumentu imenovati ga po pravilu IB123456.xlsx, 
	pri čemu će se sheetovi imenovati po pravilu 5a_a, 5a_b... 

Ako su analize u zasebnim dokumentima imenovati ih po pravilu 
IB123456_5a_a.xlsx, IB123456_5a_b.xlsx.

	a) 	rows: ContactTitle i Country
		values: Freight
		filters: god_nar
		Filtrirati na 1997. godinu kao godinu narudžbe.
	b) 	rows: Region
		columns: Country
		values: ContactTitle
		Iz pivot tabele kreirati stupčasti dijagram pa na 
		dijagramu filtrirati na neevropske zemlje.
	c) 	rows: god_isp
		columns: CompanyName (Shipper)
		values: Freight
		filters: ContactTitle
		Iz pivot tabele kreirati stupčasti dijagram pa na 
		dijagramu filtrirati na sva zanimanja koja sadrže riječ Manager.
*/
--15 bodova

/*
6. ANALIZA U POWERBI
Nazivi dokumenata
Analize se mogu kreirati u jednom dokumentu pri čemu svaka treba biti 
na zasebnoj stranici (page) ili u zasebnim dokumentima. 
-	Ako su sve analize u jednom dokumentu imenovati ga po pravilu IB123456.pbix, 
	pri čemu će se stranice imenovati po pravilu 5b_a, 5b_b... 
-	Ako su analize u zasebnim dokumentima imenovati ih po pravilu 
	IB123456_5b_a.pbix, IB123456_5b_b.pbix...

PowerBI konektovati na SQL server, relaciona baza narucitelj i dohvatiti tabele:
	-	Products
	-	Order Details
	-	Orders

Kreirati sljedeću analizu:
	a) 	matrični prikaz sljedeće strukture: 
		- redovi:		ShipCountry i kvartali iz OrderDate
		- kolone:		UnitsOnOrder
		- agregatna vrijednost: Freight
	
	Nakon toga filtrirati matricu na prikaz vrijednosti 
	UnitsOnOrder koje su manje ili jednake 50.
*/
--10 bodova

/*
6. IZVJEŠTAJ (REPORT)
Koristeći skladište podataka u matričnom modu kreirati 
izvještaj koji će sadržavati: 
	- Country, Region, star_kat, CompanyName i Freight
pri čemu je potrebno uključiti 
sumiranje po Freight i to polje nazvati ukupno.

	Struktura izvještaja:
		- page: Country i Region
		- column groups: star_kat
		- row groups: CompanyName
		- details: ukupno
Eksportovati izvještaj u pdf.
*/
--5 bodova