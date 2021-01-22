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
1. 	RESTORE RELACIJSKE BAZE prihodi I MODIFICIRANJE TABELA

	a) 	Iz defaultnog backup foldera MS SQL servera izvršiti 
		restore relacione baze podataka prihodi iz fajla prihodi.bak

	b) 	U tabeli red_prihodi kreirati izračunatu kolonu klasa_neto i 
		popuniti je po sljedećem pravilu:
			- neto manje 499.99 ili null = 0
			- neto između 500 i 999.99 = 1
			- neto između 1000 i 1499.99 = 2
			- neto između 1500 i 1999.99 = 3

	c)	Kreirati tabelu red_pomocni sljedeće strukture:
			- red_prihodi_id
			- klasa_neto
		Tabela red_pomocni treba biti povezana sa tabelom red_prihodi,
		pri čemu je u jednoj od tabela potrebno postaviti FK.
		Tipove podataka uskladiti sa postojećim tipovima u tabeli red_prihodi.
		Nakon kreiranja izvršiti odgovarajući insert podataka u tabelu red_pomocni.

	d)	U tabeli poslodavac kreirati izračunatu kolonu domena i
		popuniti je oznakama domena iz kolone web (com, org...)
15 bodova
*/


/*
2. 	KREIRANJE SKLADIŠTA PODATAKA 
Kreirati skladište podataka pod vlastitim brojem indeksa po pravilu IB123456_DW.

Tipove podataka kolona u tabelama skladišta uskladiti sa tipovima podatka kolona u tabelama u relacijskoj bazi.

	a) 	dimenzijske tabele
	Svaka dimenzijska tabela treba imati odgovarajući poslovni (bussines) ključ.

	1. 	dim_klasa_neto
		Polja tabele su polja tabele red_pomocni
	
	2. 	dim_osoba
		Polja tabele su:
			- osoba_id - odgovara koloni osoba_id iz tabele osoba
			- naziv_grada - odgovara koloni naziv_grada iz tabele grad
			- naziv_drzave - odgovara koloni naziv_drzave iz tabele drzava 
			- naziv_poslodavca - odgovara koloni naziv_poslodavca iz tabele poslodavac
			- domena_poslodavac - odgovara koloni domena iz tabele poslodavac
	
	3. 	dim_tip_red_prihoda
		Polja tabele su polja tabele tip_red_prihoda


	b) 	tabela činjenica (fact tabela) - fact_red_prihodi
		Tabela činjenica se zasniva na tabeli red_prihodi
		i osim odgovarajućeg poslovnog (bussines) ključa, 
		kao i polja koja će biti spoljni ključevi prema 
		dimenzijskim tabelama njena polja su:
			- neto
			- zdravstveno
			- penzijsko
15 bodova
*/

/*
3. 	IMPORT PODATAKA U SKLADIŠTE
Import podataka u dimenzijske tabele smjestiti u package dim.dtsx, 
a fact tabelu u fact.dtsx. Projekt imenovati po pravilu IB123456-IS.
	
	a) 	Dimenzijske tabele
		
		1. 	Import podataka u dimenzijsku tabelu dim_tip_red_prihoda
		izvršiti mapiranjem odgovarajućih polja tabele tip_red_prihoda u
		relacijskoj bazi. (prosti prenos podataka)
		
		2. 	Import podataka u tabelu dim_klasa_neto
		izvršiti mapiranjem odgovarajućih polja tabele klasa_neto u
		relacijskoj bazi. (prosti prenos podataka)
	
		3.	Import podataka u tabelu dim_osoba
		izvršiti upotrebom upita kombinirajući 
		odgovarajuća polja tabela iz relacione baze.
	
	b) Tabela činjenica
		fact_red_prihodi
		Izvorišna tabela u procesu importa podataka 
		u tabelu činjenica je tabela red_prihodi.
25 bodova
*/

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
	- Mjere
		Mjere OBAVEZNO imenovati nazivima koji su dati u tekstu zadatka. Kao mjere definirati:
		-	Na sheetu dim_klasa_neto nad kolonom klasa
			kreirati mjeru prebrojano_klasa 
			a zatim filtrirati na klasu 2
		
		-	Na sheetu dim_osoba kreirati nad kolonom domena_poslodavac
			mjeru prebrojano_domena
		
		-	Na sheetu fact_red_prihodi nad kolonama
			neto, zdravstveno i penzijsko 
			kreirati mjere uk_neto, uk_zdravstvo i uk_penzijsko
			kojim će se sumirati vrijednosti
	
10 bodova
*/

/*
5. 	ANALIZA U EXCELU
Iz tabularnog modela kreirati analize u excelu. 
Nazivi dokumenata

Analize se mogu kreirati u jednom dokumentu pri čemu svaka treba biti 
na zasebnom sheetu ili u zasebnim dokumentima. 

Ako su sve analize u jednom dokumentu imenovati ga po pravilu IB123456.xlsx, 
pri čemu će se sheetovi imenovati po pravilu 5a_a, 5a_b... 

Ako su analize u zasebnim dokumentima imenovati ih po pravilu 
IB123456_5a_a.xlsx, IB123456_5a_b.xlsx.

	a) 	rows: naziv_grada
		columns: klasa_neto
		values: uk_zdravstveno
		filters: naziv_red_prihoda - filtrirati na plata
		Iz pivot tabele kreirati stupčasti dijagram 
		pa na dijagramu filtrirati na klasa_neto = 3
	b) 	rows: naziv_poslodavca
		columns: domena_poslodavac
		values: uk_penzijsko
		filters: naziv_drzave - filterom isključiti China
		Iz pivot tabele kreirati stupčasti dijagram 
		pa na dijagramu filtrirati na domene com, edu i org
	c)	rows: naziv_grada
		columns: naziv_red_prihoda i klasa_neto
		values: uk_neto
		filters:  – filtrirati na
20 bodova
*/

/*
6. ANALIZA U POWERBI
Nazivi dokumenata

Analize se mogu kreirati u jednom dokumentu pri čemu svaka treba biti 
na zasebnoj stranici (page) ili u zasebnim dokumentima. 

Ako su sve analize u jednom dokumentu imenovati ga po pravilu IB123456.pbix, 
pri čemu će se stranice imenovati po pravilu 5b_a, 5b_b... 

Ako su analize u zasebnim dokumentima imenovati ih po pravilu 
IB123456_5b_a.pbix, IB123456_5b_b.pbix...

PowerBI konektovati na SQL server – ___________ i dohvatiti tabele

Kreirati sljedeće analize:
	a) 	matrični prikaz u kojem će po redovima biti
	
	po kolonama

	a u presjecima (kao predmet agregiranja) 
	
	Nakon toga filtrirati matricu na prikaz samo prvog kvartala.
10 bodova
*/

/*
6. IZVJEŠTAJ (REPORT)
Koristeći skladište podataka u matričnom modu kreirati izvještaj koji će sadržavati: 

pri čemu je potrebno uključiti 
sumiranje po list_price i to polje nazvati ukupno.

	Struktura izvještaja:
		- page: brand_name i god_order
		- column groups: store_name
		- row groups: product_name
		- details: ukupno
Eksportovati izvještaj u pdf.
5 bodova
*/