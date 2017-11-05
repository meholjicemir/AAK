Update predmeti
set StrankaNasa = N'Ćurić Nedim',
StrankaProtivna = N'Camelija osiguranje d.d. Bihać',
StrankePostupak = N'Ćurić Nedim - Camelija osiguranje d.d. Bihać, naknada štete',
SkontroBiljeska = N'Vidjeti da li je predmet uzet na rad.  	23.02.2018 - SKONTRO'
where NasBroj = 998
GO



/****** Object:  View [dbo].[vLica]    Script Date: 5.11.2017 13:21:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [dbo].[vLica]
AS
	SELECT	Id,
			CASE WHEN IsNULL(Ime, '') <> '' AND IsNULL(Prezime, '') <> '' THEN Prezime + ' ' + Ime + ' ' + IsNULL(PravnoLice, '') ELSE IsNULL(PravnoLice, '') END AS Naziv,
			Adresa,
			PostanskiBroj,
			Grad,
			JMBG_IDBroj
	FROM	dbo.Lica AS L



GO





/****** Object:  StoredProcedure [dbo].[Lica_GetAll]    Script Date: 5.11.2017 13:22:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-11
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Lica_GetAll] (
	@userId int,
	@filter nvarchar(MAX),
	@rowCount int,
	@partyId int = null
)
AS
BEGIN
	SET NOCOUNT ON;

	Select	Top (@rowCount)
			L.[Id]
			,IsNULL([Prezime], '') As Prezime
			,IsNULL([Ime], '') As Ime
			,IsNULL([ZakonskiZastupnik], '') As ZakonskiZastupnik
			,IsNULL([PravnoLice], '') As PravnoLice
			,IsNULL([Adresa], '') As Adresa
			,IsNULL([PostanskiBroj], '') As PostanskiBroj
			,IsNULL([Grad], '') As Grad
			,IsNULL([DrzavaId], -1) As DrzavaId
			,IsNULL(d.name, '') As DrzavaName
			,IsNULL([Telefon], '') As Telefon
			,IsNULL([Fax], '') As Fax
			,IsNULL(L.[Email], '') As Email
			,IsNULL([JMBG_IDBroj], '') As JMBG_IDBroj
			,IsNULL(Biljeske, '') as Biljeske
			,[IsMinor],
			u.first_name + ' ' + u.last_name As CreatedByName,
			modified As Modified,
			modified_by As ModifiedBy,
			um.first_name + ' ' + um.last_name As ModifiedByName,
			CASE WHEN IsNULL(Ime, '') <> '' AND IsNULL(Prezime, '') <> '' THEN Prezime + ' ' + Ime + ' ' + IsNULL(PravnoLice, '') ELSE IsNULL(PravnoLice, '') END AS Naziv
	FROM	[dbo].[Lica] As L
			Left Join Drzave d ON L.DrzavaId = d.id
			Left Join uUsers u On L.created_by = u.id
			Left Join uUsers um On L.modified_by = um.id
	Where	IsNULL(L.is_deleted, 0) = 0
			And (
				(
					@filter = ''
					Or (
						Prezime Like '%' + @filter + '%'
						Or Ime Like '%' + @filter + '%'
						Or ZakonskiZastupnik Like '%' + @filter + '%'
						Or PravnoLice Like '%' + @filter + '%'
						Or Adresa Like '%' + @filter + '%'
						Or PostanskiBroj Like '%' + @filter + '%'
						Or Grad Like '%' + @filter + '%'
						Or ISNULL(d.name, '') Like '%' + @filter + '%'
						Or Telefon Like '%' + @filter + '%'
						Or Fax Like '%' + @filter + '%'
						Or L.Email Like '%' + @filter + '%'
						Or JMBG_IDBroj Like '%' + @filter + '%'
						Or L.Biljeske Like '%' + @filter + '%'
						Or CASE WHEN IsNULL(Ime, '') <> '' AND IsNULL(Prezime, '') <> '' THEN Prezime + ' ' + Ime + ' ' + IsNULL(PravnoLice, '') ELSE IsNULL(PravnoLice, '') END Like '%' + @filter + '%'
					)
				)
				Or L.Id = IsNULL(@partyId, -1)
			)
	Order By	case when (@partyId Is NOT NULL And L.Id = @partyId) then 1 else 2 end ASC,
				case when Ime Is Not NULL And Prezime Is Not NULL then Prezime + ' ' + Ime else PravnoLice end ASC

END
GO







Update predmeti
set StrankaNasa = N'Bećiraj Ćerim',
StrankaProtivna = N'Zaštitni fond FBiH Sarajevo',
StrankePostupak = N'Bećiraj Ćerim - Zaštitni fond FBiH Sarajevo, naknada štete',
SkontroBiljeska = N'ZVATI LETU ISMETA Vidjeti hoćemo li raditi tužbu'
where NasBroj = 1259
GO








UPDATE Predmeti Set StrankaNasa = N'Arny Company d.o.o. Sarajevo - Podružnica Mostar' WHERE StrankaNasa = N'Arny Company d.o.o. Sarajevo - Posružnica Mostar';
UPDATE Predmeti Set StrankaNasa = N'Babić Dušan' WHERE StrankaNasa = N'Babić Dušan';
UPDATE Predmeti Set StrankaNasa = N'Čilić Salko SZR Ribogojilište Prenj' WHERE StrankaNasa = N'Čilić Salko SZR Ribogojilište Prenj';
UPDATE Predmeti Set StrankaNasa = N'Čolović Srećko' WHERE StrankaNasa = N'Čolović Ljubica';
UPDATE Predmeti Set StrankaNasa = N'Čomor Tanja Restoran Tekija' WHERE StrankaNasa = N'Čomor Tanja Restoran Tekija';
UPDATE Predmeti Set StrankaNasa = N'Advokat Đonko Mensud' WHERE StrankaNasa = N'Đonko Mensud';
UPDATE Predmeti Set StrankaNasa = N'Goluža Gortat' WHERE StrankaNasa = N'Goluža Gorat';
UPDATE Predmeti Set StrankaNasa = N'Hasić Hasan Auto Škola Hasić' WHERE StrankaNasa = N'Hasić Hasan Auto Škola Hasić';
UPDATE Predmeti Set StrankaNasa = N'JKP Jablanica d.d. Jablanica' WHERE StrankaNasa = N'JKP Jablanica d.d. Jablanica';
UPDATE Predmeti Set StrankaNasa = N'JU Kantonalna bolnica "Dr. Safet Mujić" Mostar' WHERE StrankaNasa = N'Kantonalna bolnica "Dr. Safet Mujić" Mostar';
UPDATE Predmeti Set StrankaNasa = N'Macić Amela' WHERE StrankaNasa = N'Macić Amela';
UPDATE Predmeti Set StrankaNasa = N'Omerović Enver SZR Ribogojilište Drežanjka' WHERE StrankaNasa = N'Omerović Enver SZR Ribogojilište Drežanjka';
UPDATE Predmeti Set StrankaNasa = N'Pračanka d.o.o. Hrenovica-Prača' WHERE StrankaNasa = N'Pračanka d.o.o. Prača';
UPDATE Predmeti Set StrankaNasa = N'Šafro Alija Samostalna ugostiteljska radnja Brada' WHERE StrankaNasa = N'Šafro Alija Samostalna ugostiteljska radnja Brada';
UPDATE Predmeti Set StrankaNasa = N'Šantić Nermina' WHERE StrankaNasa = N'Šantić Nermin';
UPDATE Predmeti Set StrankaNasa = N'Sarajevo osiguranje d.d. Sarajevo - Podružnica Bugojno' WHERE StrankaNasa = N'Sarajevo osiguranje d.d. Sarajevo - Filijala Bugojno';
UPDATE Predmeti Set StrankaNasa = N'Sarajevo osiguranje d.d. Sarajevo - Podružnica Mostar' WHERE StrankaNasa = N'Sarajevo osiguranje d.d. Sarajevo - Filijala Mostar';
UPDATE Predmeti Set StrankaNasa = N'Sarajevo osiguranje d.d. Sarajevo - Podružnica Sarajevo' WHERE StrankaNasa = N'Sarajevo osiguranje d.d. Sarajevo - Filijala Sarajevo';
UPDATE Predmeti Set StrankaNasa = N'Lendo Selma' WHERE StrankaNasa = N'Šemšić Selma';
UPDATE Predmeti Set StrankaNasa = N'Sivrić Sandra' WHERE StrankaNasa = N'Sivirić Sandra';
UPDATE Predmeti Set StrankaNasa = N'Jarak Stranko' WHERE StrankaNasa = N'Stanko Jarak';
UPDATE Predmeti Set StrankaNasa = N'Trbonja Halil STR Winhouse' WHERE StrankaNasa = N'Trbonja Halil STR Winhouse';
UPDATE Predmeti Set StrankaNasa = N'Turkić Nermin SZR Ribogojilište Bijela' WHERE StrankaNasa = N'Turkić Nermin SZR Ribogojilište Bijela';
UPDATE Predmeti Set StrankaNasa = N'Zukić Semir SZR Riblja Farma "Forelle" Donja Drežnica' WHERE StrankaNasa = N'Zukić Semir SZR Riblja Farma Forelle';












Update	Lica_Predmet
Set		is_nasa_stranka = case when (select Naziv from vLica where Lica_Predmet.Id = vLica.Id) = (Select StrankaNasa From Predmeti Where Predmeti.Id = Lica_Predmet.PredmetId) then 1 else 0 end
Where	PredmetId In (52  ,
53  ,
56  ,
164 ,
256 ,
322 ,
354 ,
368 ,
413 ,
415 ,
484 ,
497 ,
502 ,
503 ,
504 ,
540 ,
580 ,
581 ,
583 ,
614 ,
649 ,
657 ,
699 ,
723 ,
758 ,
778 ,
783 ,
791 ,
792 ,
793 ,
818 ,
840 ,
843 ,
864 ,
980 ,
998 ,
1005,
1075,
1095,
1115,
1182,
1231,
1265,
1274,
1275,
1277,
1292,
1295)
go








UPDATE Predmeti Set StrankaProtivna = N'Biosphera d.o.o. Mostar' WHERE StrankaProtivna = N'Biosfera d.o.o. Mostar';
UPDATE Predmeti Set StrankaProtivna = N'Bosna sunce osiguranje d.d. Sarajevo - Podružnica Livno' WHERE StrankaProtivna = N'Bosna sunce osiguranje d.d. Sarajevo - Podružnica Livno';
UPDATE Predmeti Set StrankaProtivna = N'Central osiguranje d.d. Sarajevo' WHERE StrankaProtivna = N'Central osiguranje d.d. Sarajevo - Ured za štete';
UPDATE Predmeti Set StrankaProtivna = N'Croatia osiguranje d.d. Mostar - Podružnica Ljubuški' WHERE StrankaProtivna = N'Croatia osiguranje d.d. Ljubuški';
UPDATE Predmeti Set StrankaProtivna = N'Derby Sport d.o.o. Mostar' WHERE StrankaProtivna = N'Derby Bet Shop d.o.o. Mostar';
UPDATE Predmeti Set StrankaProtivna = N'Advokat Đonko Mensud' WHERE StrankaProtivna = N'Đonko Mensud';
UPDATE Predmeti Set StrankaProtivna = N'Euroherc osiguranje d.d. Sarajevo' WHERE StrankaProtivna = N'Euroherc osiguranje d.d. Mostar';
UPDATE Predmeti Set StrankaProtivna = N'Euroherc osiguranje d.d. Sarajevo - Podružnica Banja Luka' WHERE StrankaProtivna = N'Euroherc osiguranje d.d. Sarajevo - Filijala Banja Luka';
UPDATE Predmeti Set StrankaProtivna = N'Euroherc osiguranje d.d. Sarajevo - Podružnica Mostar' WHERE StrankaProtivna = N'Euroherc osiguranje d.d. Sarajevo - Podružnica Mostar';
UPDATE Predmeti Set StrankaProtivna = N'GD Bišina d.o.o. Mostar' WHERE StrankaProtivna = N'G.D. Bišina d.o.o. Mostar';
UPDATE Predmeti Set StrankaProtivna = N'Hidrogradnja d.d. Sarajevo - u stečaju' WHERE StrankaProtivna = N'Hidrogradnja d.d. Sarajevo';
UPDATE Predmeti Set StrankaProtivna = N'Jahorina osiguranje a.d. Pale' WHERE StrankaProtivna = N'Jahorina osiguranje a.d. Pale';
UPDATE Predmeti Set StrankaProtivna = N'JKP Gradska groblja d.o.o. Visoko - u stečaju' WHERE StrankaProtivna = N'JKP Gradska groblja d.o.o. Visoko';
UPDATE Predmeti Set StrankaProtivna = N'JKP Jablanica d.d. Jablanica' WHERE StrankaProtivna = N'JKP Jablanica d.d. Jablanica';
UPDATE Predmeti Set StrankaProtivna = N'Zvečevo Lasta d.d. Čapljina' WHERE StrankaProtivna = N'Lasta d.d. Čapljina';
UPDATE Predmeti Set StrankaProtivna = N'Matić Stanislav vl. Samostalne obrtničke radnje "Klesarstvo Matić" Neum' WHERE StrankaProtivna = N'Matić Stanislav vl. Samostalne obrtničke radnje "Klesarstvo Matić" Neum';
UPDATE Predmeti Set StrankaProtivna = N'Ministarstvo unutrašnjih poslova HNK' WHERE StrankaProtivna = N'Ministarstvo unutrašnjih poslova HNK';
UPDATE Predmeti Set StrankaProtivna = N'Putevi d.d. Mostar' WHERE StrankaProtivna = N'Preduzeće za puteve d.d. Mostar';
UPDATE Predmeti Set StrankaProtivna = N'JU Kantonalna bolnica "Dr. Safet Mujić" Mostar' WHERE StrankaProtivna = N'RMC Dr. Safet Mujić Mostar';
UPDATE Predmeti Set StrankaProtivna = N'Sarajevo osiguranje d.d. Sarajevo - Podružnica Banja Luka' WHERE StrankaProtivna = N'Sarajevo osiguranje d.d. Sarajevo - Filijala Banja Luka';
UPDATE Predmeti Set StrankaProtivna = N'Sarajevo osiguranje d.d. Sarajevo - Podružnica Bugojno' WHERE StrankaProtivna = N'Sarajevo osiguranje d.d. Sarajevo - Filijala Bugojno';
UPDATE Predmeti Set StrankaProtivna = N'Sarajevo osiguranje d.d. Sarajevo - Podružnica Mostar' WHERE StrankaProtivna = N'Sarajevo osiguranje d.d. Sarajevo - Filijala Mostar';
UPDATE Predmeti Set StrankaProtivna = N'Sarajevo osiguranje d.d. Sarajevo - Podružnica Sarajevo' WHERE StrankaProtivna = N'Sarajevo osiguranje d.d. Sarajevo - Filijala Sarajevo';
UPDATE Predmeti Set StrankaProtivna = N'Sarajevo osiguranje d.d. Sarajevo - Podružnica Tešanj' WHERE StrankaProtivna = N'Sarajevo osiguranje d.d. Sarajevo - Filijala Tešanj';
UPDATE Predmeti Set StrankaProtivna = N'Sarajevo osiguranje d.d. Sarajevo - Podružnica Visoko' WHERE StrankaProtivna = N'Sarajevo osiguranje d.d. Sarajevo - Filijala Visoko';
UPDATE Predmeti Set StrankaProtivna = N'Sarajevo osiguranje d.d. Sarajevo - Podružnica Zenica' WHERE StrankaProtivna = N'Sarajevo osiguranje d.d. Sarajevo - Filijala Zenica';
UPDATE Predmeti Set StrankaProtivna = N'Uniqa osiguranje d.d. Sarajevo' WHERE StrankaProtivna = N'Uniqa osiguranje d.d. Sarajevo';







Update	Lica_Predmet
Set		is_protivna_stranka = case when (select Naziv from vLica where Lica_Predmet.Id = vLica.Id) = (Select StrankaProtivna From Predmeti Where Predmeti.Id = Lica_Predmet.PredmetId) then 1 else 0 end
where	PredmetId in (9    ,
23   ,
26   ,
36   ,
37   ,
66   ,
88   ,
89   ,
90   ,
100  ,
107  ,
109  ,
113  ,
118  ,
121  ,
122  ,
123  ,
124  ,
127  ,
128  ,
136  ,
137  ,
140  ,
149  ,
150  ,
158  ,
159  ,
160  ,
163  ,
194  ,
197  ,
204  ,
210  ,
216  ,
221  ,
231  ,
234  ,
237  ,
242  ,
244  ,
245  ,
248  ,
256  ,
259  ,
262  ,
265  ,
269  ,
271  ,
277  ,
288  ,
290  ,
293  ,
295  ,
318  ,
321  ,
324  ,
327  ,
331  ,
336  ,
337  ,
340  ,
341  ,
343  ,
346  ,
347  ,
348  ,
350  ,
358  ,
368  ,
370  ,
374  ,
391  ,
393  ,
397  ,
402  ,
405  ,
410  ,
413  ,
415  ,
417  ,
418  ,
422  ,
426  ,
432  ,
433  ,
434  ,
442  ,
448  ,
457  ,
479  ,
480  ,
481  ,
482  ,
484  ,
485  ,
488  ,
491  ,
498  ,
501  ,
502  ,
503  ,
504  ,
505  ,
513  ,
514  ,
515  ,
517  ,
522  ,
527  ,
538  ,
539  ,
540  ,
543  ,
544  ,
558  ,
575  ,
576  ,
635  ,
646  ,
651  ,
652  ,
653  ,
657  ,
661  ,
664  ,
665  ,
666  ,
668  ,
670  ,
673  ,
674  ,
676  ,
683  ,
684  ,
685  ,
687  ,
697  ,
701  ,
705  ,
711  ,
718  ,
719  ,
720  ,
721  ,
724  ,
733  ,
734  ,
741  ,
753  ,
758  ,
762  ,
774  ,
779  ,
788  ,
790  ,
796  ,
806  ,
807  ,
808  ,
820  ,
821  ,
826  ,
834  ,
841  ,
845  ,
846  ,
863  ,
865  ,
867  ,
869  ,
870  ,
873  ,
874  ,
875  ,
880  ,
881  ,
882  ,
883  ,
884  ,
891  ,
895  ,
899  ,
910  ,
929  ,
930  ,
931  ,
932  ,
933  ,
941  ,
942  ,
951  ,
954  ,
955  ,
961  ,
962  ,
964  ,
965  ,
969  ,
975  ,
983  ,
986  ,
987  ,
988  ,
989  ,
990  ,
991  ,
992  ,
998  ,
1002 ,
1009 ,
1014 ,
1018 ,
1019 ,
1021 ,
1026 ,
1027 ,
1029 ,
1030 ,
1032 ,
1043 ,
1053 ,
1058 ,
1076 ,
1078 ,
1080 ,
1088 ,
1095 ,
1096 ,
1098 ,
1101 ,
1104 ,
1110 ,
1111 ,
1123 ,
1128 ,
1131 ,
1134 ,
1146 ,
1162 ,
1173 ,
1199 ,
1201 ,
1205 ,
1206 ,
1207 ,
1213 ,
1249 ,
1252 ,
1258 ,
1262 ,
1265 ,
1274 ,
1275 ,
1276 ,
1279 ,
1292 ,
1295 ,
1305 ,
1309 ,
1316 ,
1322 ,
1339 ,
1348 ,
1350 ,
1356 )
go









Update Predmeti Set StrankaNasa = 'Jarak Stanko' where StrankaNasa = 'Jarak Stranko'
go



Update	Lica_Predmet
Set		is_nasa_stranka = case when (select Naziv from vLica where Lica_Predmet.Id = vLica.Id) = (Select StrankaNasa From Predmeti Where Predmeti.Id = Lica_Predmet.PredmetId) then 1 else 0 end
Where	PredmetId = 256
Go





Update Predmeti set StrankaNasa = 'Macić Seid' where nasbroj = 765
go



Update	Lica_Predmet
Set		is_nasa_stranka = case when (select Naziv from vLica where Lica_Predmet.Id = vLica.Id) = (Select StrankaNasa From Predmeti Where Predmeti.Id = Lica_Predmet.PredmetId) then 1 else 0 end
Where	PredmetId = 778
Go








Update	Lica_Predmet
Set		is_protivna_stranka = case when (select Naziv from vLica where Lica_Predmet.Id = vLica.Id) = (Select StrankaProtivna From Predmeti Where Predmeti.Id = Lica_Predmet.PredmetId) then 1 else 0 end
Where	Lica_Predmet.PredmetId In (
			Select	Distinct p.Id
			From	Predmeti p
					Left Join Lica_Predmet lpp On p.Id = lpp.PredmetId And lpp.is_protivna_stranka = 1
					Left Join vLica lp On lpp.id = lp.Id
			Where	(StrankaProtivna Is Not NULL And lp.Naziv Is NULL)
		)
Go




Update Predmeti Set StrankaProtivna = 'Euroherc osiguranje d.d. Sarajevo - Podružnica Mostar'
Where id in (
	Select	PredmetId
	From	Lica_Predmet
	Where	Id In (
				Select	Id
				From	Lica
				Where	PravnoLice = 'Euroherc osiguranje d.d. Sarajevo - Podružnica Mostar'
			)
			And PredmetId In (
				Select	Id
				From	Predmeti
				Where	StrankaProtivna = 'Euroherc osiguranje d.d. Sarajevo'
			)
)
GO





Update	Lica_Predmet
Set		is_protivna_stranka = case when (select Naziv from vLica where Lica_Predmet.Id = vLica.Id) = (Select StrankaProtivna From Predmeti Where Predmeti.Id = Lica_Predmet.PredmetId) then 1 else 0 end
where	PredmetId In (Select Id From Predmeti Where StrankaProtivna = 'Euroherc osiguranje d.d. Sarajevo - Podružnica Mostar')
GO








/****** Object:  View [dbo].[vLica]    Script Date: 5.11.2017 16:27:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER VIEW [dbo].[vLica]
AS
	SELECT	Id,
			CASE WHEN (IsNULL(Ime, '') <> '' Or IsNULL(Prezime, '') <> '') THEN Prezime + ' ' + Ime + ' ' + IsNULL(PravnoLice, '') ELSE IsNULL(PravnoLice, '') END AS Naziv,
			Adresa,
			PostanskiBroj,
			Grad,
			JMBG_IDBroj
	FROM	dbo.Lica AS L




GO







/****** Object:  StoredProcedure [dbo].[Lica_GetAll]    Script Date: 5.11.2017 16:29:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-11
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Lica_GetAll] (
	@userId int,
	@filter nvarchar(MAX),
	@rowCount int,
	@partyId int = null
)
AS
BEGIN
	SET NOCOUNT ON;

	Select	Top (@rowCount)
			L.[Id]
			,IsNULL([Prezime], '') As Prezime
			,IsNULL([Ime], '') As Ime
			,IsNULL([ZakonskiZastupnik], '') As ZakonskiZastupnik
			,IsNULL([PravnoLice], '') As PravnoLice
			,IsNULL([Adresa], '') As Adresa
			,IsNULL([PostanskiBroj], '') As PostanskiBroj
			,IsNULL([Grad], '') As Grad
			,IsNULL([DrzavaId], -1) As DrzavaId
			,IsNULL(d.name, '') As DrzavaName
			,IsNULL([Telefon], '') As Telefon
			,IsNULL([Fax], '') As Fax
			,IsNULL(L.[Email], '') As Email
			,IsNULL([JMBG_IDBroj], '') As JMBG_IDBroj
			,IsNULL(Biljeske, '') as Biljeske
			,[IsMinor],
			u.first_name + ' ' + u.last_name As CreatedByName,
			modified As Modified,
			modified_by As ModifiedBy,
			um.first_name + ' ' + um.last_name As ModifiedByName,
			CASE WHEN (IsNULL(Ime, '') <> '' Or IsNULL(Prezime, '') <> '') THEN Prezime + ' ' + Ime + ' ' + IsNULL(PravnoLice, '') ELSE IsNULL(PravnoLice, '') END AS Naziv
	FROM	[dbo].[Lica] As L
			Left Join Drzave d ON L.DrzavaId = d.id
			Left Join uUsers u On L.created_by = u.id
			Left Join uUsers um On L.modified_by = um.id
	Where	IsNULL(L.is_deleted, 0) = 0
			And (
				(
					@filter = ''
					Or (
						Prezime Like '%' + @filter + '%'
						Or Ime Like '%' + @filter + '%'
						Or ZakonskiZastupnik Like '%' + @filter + '%'
						Or PravnoLice Like '%' + @filter + '%'
						Or Adresa Like '%' + @filter + '%'
						Or PostanskiBroj Like '%' + @filter + '%'
						Or Grad Like '%' + @filter + '%'
						Or ISNULL(d.name, '') Like '%' + @filter + '%'
						Or Telefon Like '%' + @filter + '%'
						Or Fax Like '%' + @filter + '%'
						Or L.Email Like '%' + @filter + '%'
						Or JMBG_IDBroj Like '%' + @filter + '%'
						Or L.Biljeske Like '%' + @filter + '%'
						Or CASE WHEN IsNULL(Ime, '') <> '' AND IsNULL(Prezime, '') <> '' THEN Prezime + ' ' + Ime + ' ' + IsNULL(PravnoLice, '') ELSE IsNULL(PravnoLice, '') END Like '%' + @filter + '%'
					)
				)
				Or L.Id = IsNULL(@partyId, -1)
			)
	Order By	case when (@partyId Is NOT NULL And L.Id = @partyId) then 1 else 2 end ASC,
				case when Ime Is Not NULL And Prezime Is Not NULL then Prezime + ' ' + Ime else PravnoLice end ASC

END
GO






