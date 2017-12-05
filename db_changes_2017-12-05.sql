Alter Table Lica_Predmet
Add is_deleted bit
Go

Update Lica_Predmet
Set is_deleted = 0
Go



/****** Object:  StoredProcedure [dbo].[LicePredmet_Delete]    Script Date: 5.12.2017 16:42:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-08
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[LicePredmet_Delete] (
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	Update Lica_Predmet
	Set is_deleted = 1
	Where Lica_PredmetId = @id;
END
GO




/****** Object:  StoredProcedure [dbo].[LicePredmet_GetForPredmet]    Script Date: 5.12.2017 16:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-08
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[LicePredmet_GetForPredmet] (
	@predmetId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Select	lp.Lica_PredmetId As Id,
			lp.PredmetId As PredmetId,
			lp.Id As LiceId,
			vl.Naziv As Lice,
			lp.UlogaId As UlogaId,
			lp.Broj,
			u.name As Uloga,
			lp.is_nasa_stranka As IsNasaStranka,
			lp.is_protivna_stranka As IsProtivnaStranka,
			case
				when is_nasa_stranka = 1 then 'Naša stranka'
				when is_protivna_stranka = 1 then 'Protivna stranka'
				else '-----'
			end As GlavnaStranka
	From	Lica_Predmet lp
			Inner Join vLica vl On lp.Id = vl.Id And lp.PredmetId = @predmetId And IsNULL(lp.is_deleted, 0) = 0
			Inner Join Uloge u On lp.UlogaId = u.id
	Order By lp.Lica_PredmetId Asc
	
END
GO



/****** Object:  StoredProcedure [dbo].[LicePredmet_Insert]    Script Date: 5.12.2017 16:51:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-08
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[LicePredmet_Insert] (
	@predmetId int,
	@liceId int,
	@isNasaStranka bit,
	@isProtivnaStranka bit,
	@ulogaId int,
	@broj nvarchar(255)
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Lica_PredmetId), 0) From Lica_Predmet) + 1;
	
	Insert Into Lica_Predmet (Lica_PredmetId, Id, PredmetId, is_nasa_stranka, is_protivna_stranka, UlogaId, Broj, is_deleted)
	Values (@id, @liceId, @predmetId, @isNasaStranka, @isProtivnaStranka, @ulogaId, @broj, 0);

	Select @id;
END
GO




/****** Object:  StoredProcedure [dbo].[Predmeti_GetAll]    Script Date: 5.12.2017 16:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-03
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Predmeti_GetAll] (
	@userId int,
	@filter nvarchar(MAX),
	@filterNasBroj int,
	@rowCount int,
	@caseId int
)
AS
BEGIN
	SET NOCOUNT ON;

	If @caseId > 0 Or @filterNasBroj > 0
	Begin
		Select	p.[Id]
				,[NasBroj]
				,[SudId]
				,[BrojPredmeta]
				,[SudijaId]
				,[Iniciran]
				,[VrijednostSpora]
				,[KategorijaPredmetaId]
				,[PristupPredmetu]
				,p.[UlogaId]
				,[PrivremeniZastupnici]
				,IsNULL(p.PristupPredmetu, CAST(0 as bit)) As PristupPredmetu
				,[VrstaPredmetaId]
				,[Uspjehu Postupku] As Uspjeh
				,[PravniOsnov]
				,[DatumStanjaPredmeta]
				,[StanjePredmetaId]
				,[DatumArhiviranja]
				,[NacinOkoncanjaId]
				,[BrojArhive]
				,[BrojArhiveRegistrator]
				,[SkontroDan]
				,[SkontroDatum]
				,[SkontroBiljeska]
				,ISNULL((Select Top 1 for_all_users From cCaseActivities Where case_id = p.Id Order by cCaseActivities.id Desc), cast(0 as bit)) As Skontro_ForAllUsers
				--,[StrankePostupak]

				,s.Sud as SudName
				,kp.name As KategorijaPredmetaName
				,sj.name As SudijaName
				,vp.name As VrstaPredmetaName
				,u.name As UlogaName
				,sp.name As StanjePredmetaName
				,nok.name As NacinOkoncanjaName

				,vl_nasa.Naziv as StrankaNasa
				,vl_protivna.Naziv as StrankaProtivna

				,case IsNULL(p.BrojArhive, '') + '/' + IsNULL(p.BrojArhiveRegistrator, '')
					when '/' then '' 
					else IsNULL(p.BrojArhive, '') + '/' + IsNULL(p.BrojArhiveRegistrator, '')
				end As BrojArhiveTotal,

				uc.first_name + ' ' + uc.last_name As CreatedByName,
				p.modified As Modified,
				p.modified_by As ModifiedBy,
				um.first_name + ' ' + um.last_name As ModifiedByName,
				dbo.Case_GetLabelIds(p.Id) As LabelIds,
				dbo.Case_GetFullName(p.Id) As Naziv
		From	[dbo].[Predmeti] As p
			
				Left Join Sudovi s On p.SudId = s.Id
				Left Join KategorijePredmeta kp On p.KategorijaPredmetaId = kp.id
				Left Join Sudije sj On p.SudijaId = sj.id
				Left Join VrstePredmeta vp On p.VrstaPredmetaId = vp.id
				Left Join Uloge u On p.UlogaId = u.id
				Left Join NaciniOkoncanja nok On p.NacinOkoncanjaId = nok.id
				Left Join StanjaPredmeta sp On p.StanjePredmetaId = sp.id

				Left Join Lica_Predmet lp_nasa On p.Id = lp_nasa.PredmetId And lp_nasa.is_nasa_stranka = 1 And dbo.Case_GetPrvaNasaStrankaId(p.Id) = lp_nasa.Id And IsNULL(lp_nasa.is_deleted, 0) = 0
				Left Join vLica vl_nasa On lp_nasa.Id = vl_nasa.Id
				Left Join Lica_Predmet lp_protivna On p.Id = lp_protivna.PredmetId And lp_protivna.is_protivna_stranka = 1 And dbo.Case_GetPrvaProtivnaStrankaId(p.Id) = lp_protivna.Id And IsNULL(lp_protivna.is_deleted, 0) = 0
				Left Join vLica vl_protivna On lp_protivna.Id = vl_protivna.Id

				Left Join uUsers uc On p.created_by = uc.id
				Left Join uUsers um On p.modified_by = um.id
		Where	IsNULL(p.is_deleted, 0) = 0
				And (p.Id = @caseId Or p.NasBroj = @filterNasBroj)
	End
	Else
	Begin

		Select	Top (@rowCount)
				p.[Id]
				,[NasBroj]
				,[SudId]
				,[BrojPredmeta]
				,[SudijaId]
				,[Iniciran]
				,[VrijednostSpora]
				,[KategorijaPredmetaId]
				,[PristupPredmetu]
				,p.[UlogaId]
				,[PrivremeniZastupnici]
				,IsNULL(p.PristupPredmetu, CAST(0 as bit)) As PristupPredmetu
				,[VrstaPredmetaId]
				,[Uspjehu Postupku] As Uspjeh
				,[PravniOsnov]
				,[DatumStanjaPredmeta]
				,[StanjePredmetaId]
				,[DatumArhiviranja]
				,[NacinOkoncanjaId]
				,[BrojArhive]
				,[BrojArhiveRegistrator]
				,[SkontroDan]
				,[SkontroDatum]
				,[SkontroBiljeska]
				,ISNULL((Select Top 1 for_all_users From cCaseActivities Where case_id = p.Id Order by cCaseActivities.id Desc), cast(0 as bit)) As Skontro_ForAllUsers
				--,[StrankePostupak]

				,s.Sud as SudName
				,kp.name As KategorijaPredmetaName
				,sj.name As SudijaName
				,vp.name As VrstaPredmetaName
				,u.name As UlogaName
				,sp.name As StanjePredmetaName
				,nok.name As NacinOkoncanjaName

				,vl_nasa.Naziv as StrankaNasa
				,vl_protivna.Naziv as StrankaProtivna

				,case IsNULL(p.BrojArhive, '') + '/' + IsNULL(p.BrojArhiveRegistrator, '')
					when '/' then '' 
					else IsNULL(p.BrojArhive, '') + '/' + IsNULL(p.BrojArhiveRegistrator, '')
				end As BrojArhiveTotal,

				uc.first_name + ' ' + uc.last_name As CreatedByName,
				p.modified As Modified,
				p.modified_by As ModifiedBy,
				um.first_name + ' ' + um.last_name As ModifiedByName,
				dbo.Case_GetLabelIds(p.Id) As LabelIds,
				dbo.Case_GetFullName(p.Id) As Naziv
		From	[dbo].[Predmeti] As p
			
				Left Join Sudovi s On p.SudId = s.Id
				Left Join KategorijePredmeta kp On p.KategorijaPredmetaId = kp.id
				Left Join Sudije sj On p.SudijaId = sj.id
				Left Join VrstePredmeta vp On p.VrstaPredmetaId = vp.id
				Left Join Uloge u On p.UlogaId = u.id
				Left Join NaciniOkoncanja nok On p.NacinOkoncanjaId = nok.id
				Left Join StanjaPredmeta sp On p.StanjePredmetaId = sp.id

				Left Join Lica_Predmet lp_nasa On p.Id = lp_nasa.PredmetId And lp_nasa.is_nasa_stranka = 1 And dbo.Case_GetPrvaNasaStrankaId(p.Id) = lp_nasa.Id And IsNULL(lp_nasa.is_deleted, 0) = 0
				Left Join vLica vl_nasa On lp_nasa.Id = vl_nasa.Id
				Left Join Lica_Predmet lp_protivna On p.Id = lp_protivna.PredmetId And lp_protivna.is_protivna_stranka = 1 And dbo.Case_GetPrvaProtivnaStrankaId(p.Id) = lp_protivna.Id And IsNULL(lp_protivna.is_deleted, 0) = 0
				Left Join vLica vl_protivna On lp_protivna.Id = vl_protivna.Id

				Left Join uUsers uc On p.created_by = uc.id
				Left Join uUsers um On p.modified_by = um.id
		Where	IsNULL(p.is_deleted, 0) = 0
				And (
					--(p.Id = @caseId)
					--Or (p.NasBroj = @filterNasBroj)
					(@filter Like 'oznaka:%' And @filter In (Select 'oznaka:' + name From lLabels Where id In (Select label_id From lLabelConnections Where content_id = p.Id and content_type = 'case')))
					Or (
						@filterNasBroj Is NULL
						And @caseId Is NULL
						And (
							@filter = ''
							Or (
								NasBroj Like '%' + @filter + '%'
								Or BrojPredmeta Like '%' + @filter + '%'
								Or VrijednostSpora Like '%' + @filter + '%'
								Or PravniOsnov Like '%' + @filter + '%'
								Or [Uspjehu Postupku] Like '%' + @filter + '%'
				
								Or s.Sud Like '%' + @filter + '%'
								Or kp.name Like '%' + @filter + '%'
								Or sj.name Like '%' + @filter + '%'
								Or vp.name Like '%' + @filter + '%'
								Or u.name Like '%' + @filter + '%'
								Or nok.name Like '%' + @filter + '%'
								Or sp.name Like '%' + @filter + '%'

								Or vl_nasa.Naziv Like '%' + @filter + '%'
								Or vl_protivna.Naziv Like '%' + @filter + '%'
							)
						)
					)
				)
		Order By NasBroj Desc
	End
END
GO




/****** Object:  StoredProcedure [dbo].[Predmeti_GetForAdvancedSearch]    Script Date: 5.12.2017 16:55:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-09-19
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Predmeti_GetForAdvancedSearch] (
	@userId int,
	@nasBroj int,
	@kategorije varchar(MAX),
	@ulogeUPostupku varchar(MAX),
	@brojPredmeta nvarchar(MAX),
	@bezBrojaPredmeta bit,
	@sudovi varchar(MAX),
	@sudije varchar(MAX),
	@vrijednostSporaFrom decimal(19,4),
	@vrijednostSporaTo decimal(19,4),
	@vrstePredmeta varchar(MAX),
	@datumStanjaPredmeta datetime,
	@stanjePredmeta nvarchar(MAX),
	@labels varchar(MAX),
	@iniciranFrom datetime,
	@iniciranTo datetime,
	@arhiviranFrom datetime,
	@arhiviranTo datetime,
	@uspjehFrom int,
	@uspjehTo int,
	@pristupPredmetu bit,
	@pravniOsnov nvarchar(MAX),
	@rowCount int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @kategorijeTable Table (kategorija int);
	If @kategorije <> ''
		Insert Into @kategorijeTable Select splitdata From SplitString(@kategorije, ',');

	Declare @ulogeUPostupkuTable Table (ulogaUPostupku int);
	If @ulogeUPostupku <> ''
		Insert Into @ulogeUPostupkuTable Select splitdata From SplitString(@ulogeUPostupku, ',');

	Declare @sudoviTable Table (sud int);
	If @sudovi <> ''
		Insert Into @sudoviTable Select splitdata From SplitString(@sudovi, ',');

	Declare @sudijeTable Table (sudija int);
	If @sudije <> ''
		Insert Into @sudijeTable Select splitdata From SplitString(@sudije, ',');

	Declare @vrstePredmetaTable Table (vrstaPredmeta int);
	If @vrstePredmeta <> ''
		Insert Into @vrstePredmetaTable Select splitdata From SplitString(@vrstePredmeta, ',');

	Declare @labelsTable Table (label int);
	If @labels <> ''
		Insert Into @labelsTable Select splitdata From SplitString(@labels, ',');

	Select	Top (@rowCount)
			p.[Id]
			,[NasBroj]
			,[SudId]
			,[BrojPredmeta]
			,[SudijaId]
			,[Iniciran]
			,[VrijednostSpora]
			,[KategorijaPredmetaId]
			,[PristupPredmetu]
			,p.[UlogaId]
			,[PrivremeniZastupnici]
			,IsNULL(p.PristupPredmetu, CAST(0 As bit)) As PristupPredmetu
			,[VrstaPredmetaId]
			,[Uspjehu Postupku] As Uspjeh
			,[PravniOsnov]
			,[DatumStanjaPredmeta]
			,[StanjePredmetaId]
			,[DatumArhiviranja]
			,[NacinOkoncanjaId]
			,[BrojArhive]
			,[BrojArhiveRegistrator]
			,[SkontroDan]
			,[SkontroDatum]
			,[SkontroBiljeska]
			,[StrankePostupak]

			,s.Sud as SudName
			,kp.name As KategorijaPredmetaName
			,sj.name As SudijaName
			,vp.name As VrstaPredmetaName
			,u.name As UlogaName
			,sp.name As StanjePredmetaName
			,nok.name As NacinOkoncanjaName

			,vl_nasa.Naziv as StrankaNasa
			,vl_protivna.Naziv as StrankaProtivna

			,case IsNULL(p.BrojArhive, '') + '/' + IsNULL(p.BrojArhiveRegistrator, '')
				when '/' then '' 
				else IsNULL(p.BrojArhive, '') + '/' + IsNULL(p.BrojArhiveRegistrator, '')
			end As BrojArhiveTotal,

			uc.first_name + ' ' + uc.last_name As CreatedByName,
			p.modified As Modified,
			p.modified_by As ModifiedBy,
			um.first_name + ' ' + um.last_name As ModifiedByName,
			dbo.Case_GetLabelIds(p.Id) As LabelIds,
			dbo.Case_GetFullName(p.Id) As Naziv
	From	[dbo].[Predmeti] As p
			
			Left Join Sudovi s On p.SudId = s.Id
			Left Join KategorijePredmeta kp On p.KategorijaPredmetaId = kp.id
			Left Join Sudije sj On p.SudijaId = sj.id
			Left Join VrstePredmeta vp On p.VrstaPredmetaId = vp.id
			Left Join Uloge u On p.UlogaId = u.id
			Left Join NaciniOkoncanja nok On p.NacinOkoncanjaId = nok.id
			Left Join StanjaPredmeta sp On p.StanjePredmetaId = sp.id
			Left Join Lica_Predmet lp_nasa On p.Id = lp_nasa.PredmetId And lp_nasa.is_nasa_stranka = 1 And dbo.Case_GetPrvaNasaStrankaId(p.Id) = lp_nasa.Id And IsNULL(lp_nasa.is_deleted, 0) = 0
			Left Join vLica vl_nasa On lp_nasa.Id = vl_nasa.Id
			Left Join Lica_Predmet lp_protivna On p.Id = lp_protivna.PredmetId And lp_protivna.is_protivna_stranka = 1 And dbo.Case_GetPrvaProtivnaStrankaId(p.Id) = lp_protivna.Id And IsNULL(lp_protivna.is_deleted, 0) = 0
			Left Join vLica vl_protivna On lp_protivna.Id = vl_protivna.Id

			Left Join uUsers uc On p.created_by = uc.id
			Left Join uUsers um On p.modified_by = um.id
	Where	IsNULL(p.is_deleted, 0) = 0
			And (@nasBroj = -1 Or CAST(p.NasBroj as varchar(MAX)) Like '%' + CAST(@nasBroj as varchar(MAX)) + '%')
			And (
				(@bezBrojaPredmeta = 1 And IsNULL(p.BrojPredmeta, '') = '')
				Or (@bezBrojaPredmeta = 0 And (@brojPredmeta = '' Or p.BrojPredmeta Like '%' + @brojPredmeta + '%'))
			)
			And (@vrijednostSporaFrom = 0 Or p.VrijednostSpora >= @vrijednostSporaFrom)
			And (@vrijednostSporaTo = 0 Or p.VrijednostSpora <= @vrijednostSporaTo)
			And sp.name Like '%' + @stanjePredmeta + '%'
			And (@datumStanjaPredmeta Is NULL Or p.DatumStanjaPredmeta = @datumStanjaPredmeta)

			And (@iniciranFrom Is NULL Or p.Iniciran >= @iniciranFrom)
			And (@iniciranTo Is NULL Or p.Iniciran <= @iniciranTo)

			And (@arhiviranFrom Is NULL Or p.DatumArhiviranja >= @arhiviranFrom)
			And (@arhiviranTo Is NULL Or p.DatumArhiviranja <= @arhiviranTo)

			And (@pristupPredmetu Is NULL Or p.PristupPredmetu = @pristupPredmetu)
			And (@pravniOsnov Is NULL Or p.PravniOsnov Like '%' + @pravniOsnov + '%')

			And CAST(REPLACE(IsNULL(p.[Uspjehu Postupku], '0%'), '%', '') as int) Between @uspjehFrom And @uspjehTo
			
			And (@sudovi = '' Or s.Id In (Select sud From @sudoviTable))
			And (@kategorije = '' Or kp.Id In (Select kategorija From @kategorijeTable))
			And (@sudije = '' Or sj.Id In (Select sudija From @sudijeTable))
			And (@vrstePredmeta = '' Or vp.Id In (Select vrstaPredmeta From @vrstePredmetaTable))
			And (@ulogeUPostupku = '' Or u.Id In (Select ulogaUPostupku From @ulogeUPostupkuTable))

			And (
				@labels = ''
				Or Exists (
					Select	1
					From	lLabelConnections
					Where	content_id = p.Id
							And content_type = 'case'
							And label_id In (Select label From @labelsTable)
				)
			)
	Order By NasBroj Desc
END
GO



/****** Object:  StoredProcedure [dbo].[GetCasesForParty]    Script Date: 5.12.2017 16:57:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-06
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[GetCasesForParty] (
	@partyId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Select	PredmetId As Id,
			dbo.Case_GetFullName(PredmetId) As Naziv
	From	Lica_Predmet
	Where	Id = @partyId
			And IsNULL(is_deleted, 0) = 0
END
GO




/****** Object:  StoredProcedure [dbo].[Case_GetTemplateFields]    Script Date: 5.12.2017 16:59:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Case_GetTemplateFields] (
	@caseId int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;


    Select	DISTINCT
			IsNULL(p.BrojPredmeta, '') As broj_predmeta,
			IsNULL(s.Sud, '') As naziv_suda,
			IsNULL(s.PostanskiBroj, '') As postanski_broj_suda,
			IsNULL(s.Grad, '') As grad_suda,
			IsNULL(vlProtivna.Naziv, '') As protivna_stranka,
			IsNULL(vlProtivna.Adresa, '') As adresa_protivne_stranke,
			IsNULL(vlProtivna.PostanskiBroj, '') As postanski_broj_protivne_stranke,
			IsNULL(vlProtivna.Grad, '') As grad_protivne_stranke,
			IsNULL(vlNasa.Naziv, '') As nasa_stranka,
			IsNULL(vlNasa.Adresa, '') As adresa_nase_stranke,
			IsNULL(vlNasa.PostanskiBroj, '') As postanski_broj_nase_stranke,
			IsNULL(vlNasa.Grad, '') As grad_nase_stranke,
			IsNULL(s.RacunTakse, '') As broj_racuna_suda_za_takse,
			IsNULL(s.RacunVjestacenja, '') As broj_racuna_suda_za_vjestacenja,
			IsNULL(p.NasBroj, '') As nas_broj,
			IsNULL(sudije.name, '') As sudija,
			IsNULL(vp.name, '') As vrsta_predmeta,
			dbo.Case_GetStrankeKontakti(p.id) as kontakt_stranke,
			dbo.Case_GetCaseConnections(p.Id) As sve_veze_sa_drugim_predetima,
			CONVERT(varchar, p.VrijednostSpora, 1) + ' KM' As vrijednost_spora,
			IsNULL(ulogeNasa.name, '') As uloga_nase_stranke,
			IsNULL(ulogeProtivna.name, '') As uloga_protivne_stranke,
			dbo.Case_GetNaseStrankeSaPunimAdresama(p.Id) As nase_stranke_sve_sa_punim_adresama,
			dbo.Case_GetNaseStrankeNazivi(p.Id) As nasa_stranka_sve,
			dbo.Case_GetProtivneStrankeSaPunimAdresama(p.Id) As protivne_stranke_sve_sa_punim_adresama,
			IsNULL(vlNasa.JMBG_IDBroj, '') As jmbg_ili_id_nase_stranke
	From	Predmeti p
			Left Join Sudovi s On p.SudID = s.Id And p.Id = @caseId
			Left Join vLica vlProtivna On dbo.Case_GetPrvaProtivnaStrankaId(p.Id) = vlProtivna.Id
			Left Join Lica_Predmet lpProtivna On p.Id = lpProtivna.PredmetId And vlProtivna.Id = lpProtivna.Id And IsNULL(lpProtivna.is_deleted, 0) = 0
			Left Join Uloge ulogeProtivna On lpProtivna.UlogaId = ulogeProtivna.id
			Left Join vLica vlNasa On dbo.Case_GetPrvaNasaStrankaId(p.Id) = vlNasa.Id
			Left Join Lica_Predmet lpNasa On p.Id = lpNasa.PredmetId And vlNasa.Id = lpNasa.Id And IsNULL(lpNasa.is_deleted, 0) = 0
			Left Join Uloge ulogeNasa On lpNasa.UlogaId = ulogeNasa.id
			Left Join Sudije sudije On p.SudijaId = sudije.id
			Left Join VrstePredmeta vp On p.VrstaPredmetaId = vp.id
	Where	p.Id = @caseId;

END
GO






/****** Object:  UserDefinedFunction [dbo].[Case_GetStrankeKontakti]    Script Date: 5.12.2017 17:01:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[Case_GetStrankeKontakti]
(
	@caseId int
)
RETURNS nvarchar(MAX)
AS
BEGIN
	DECLARE @result nvarchar(MAX)

	Set @result = (
		Select	', ' + IsNULL(l.Telefon, '') + IsNULL(', ' + l.Fax, '')
		From	Lica_Predmet lp
				Inner Join Lica l On lp.Id = l.Id And lp.is_nasa_stranka = 1 And IsNULL(lp.is_deleted, 0) = 0
		Where	lp.PredmetId = @caseId
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 3, LEN(@result))

	RETURN @result
END
GO




/****** Object:  UserDefinedFunction [dbo].[Case_GetPrvaProtivnaStrankaId]    Script Date: 5.12.2017 17:04:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[Case_GetPrvaProtivnaStrankaId]
(
	@caseId int
)
RETURNS int
AS
BEGIN
	DECLARE @result nvarchar(MAX)

	Declare @countProtivneStranke int = (Select COUNT(1) From Lica_Predmet Where PredmetId = @caseId And is_protivna_stranka = 1 And IsNULL(is_deleted, 0) = 0);
	If @countProtivneStranke = 0
		Set @result = '';
	Else If @countProtivneStranke = 1
		Set @result = (Select Id From Lica_Predmet Where PredmetId = @caseId And is_protivna_stranka = 1 And IsNULL(is_deleted, 0) = 0)
	Else
		Set @result = (Select Top 1 Id From Lica_Predmet Where PredmetId = @caseId And is_protivna_stranka = 1 And Broj = '1' And IsNULL(is_deleted, 0) = 0)

	RETURN @result
END
GO



-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[Case_GetPrvaNasaStrankaId]
(
	@caseId int
)
RETURNS int
AS
BEGIN
	DECLARE @result nvarchar(MAX)

	Declare @countNaseStranke int = (Select COUNT(1) From Lica_Predmet Where PredmetId = @caseId And is_nasa_stranka = 1 And IsNULL(is_deleted, 0) = 0);
	If @countNaseStranke = 0
		Set @result = '';
	Else If @countNaseStranke = 1
		Set @result = (Select Id From Lica_Predmet Where PredmetId = @caseId And is_nasa_stranka = 1 And IsNULL(is_deleted, 0) = 0)
	Else
		Set @result = (Select Top 1 Id From Lica_Predmet Where PredmetId = @caseId And is_nasa_stranka = 1 And Broj = '1' And IsNULL(is_deleted, 0) = 0)

	RETURN @result
END
GO



-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[Case_GetProtivneStrankeSaPunimAdresama]
(
	@caseId int
)
RETURNS nvarchar(MAX)
AS
BEGIN
	DECLARE @result nvarchar(MAX)

	Set @result = (
		Select	'\n' + IsNULL(vl.Naziv, '') + ', ' + IsNULL(vl.Adresa, '') + ', ' + IsNULL(vl.PostanskiBroj, '') + ', ' + IsNULL(vl.Grad, '')
		From	Lica_Predmet lp
				Inner Join vLica vl On lp.Id = vl.Id
		Where	PredmetId = @caseId
				And is_protivna_stranka = 1
				And IsNULL(lp.is_deleted, 0) = 0
		Order By CAST(IsNULL(lp.Broj, '9999') as int) Asc
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 3, LEN(@result))

	RETURN @result
END
GO



-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[Case_GetNaseStrankeSaPunimAdresama]
(
	@caseId int
)
RETURNS nvarchar(MAX)
AS
BEGIN
	DECLARE @result nvarchar(MAX)

	Set @result = (
		Select	'\\n' + IsNULL(vl.Naziv, '') + ', ' + IsNULL(vl.Adresa, '') + ', ' + IsNULL(vl.PostanskiBroj, '') + ', ' + IsNULL(vl.Grad, '')
		From	Lica_Predmet lp
				Inner Join vLica vl On lp.Id = vl.Id
		Where	PredmetId = @caseId
				And is_nasa_stranka = 1
				And IsNULL(lp.is_deleted, 0) = 0
		Order By CAST(IsNULL(lp.Broj, '9999') as int) Asc
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 4, LEN(@result))

	RETURN @result
END
GO



-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[Case_GetNaseStrankeNazivi]
(
	@caseId int
)
RETURNS nvarchar(MAX)
AS
BEGIN
	DECLARE @result nvarchar(MAX)

	Set @result = (
		Select	', ' + IsNULL(vl.Naziv, '')
		From	Lica_Predmet lp
				Inner Join vLica vl On lp.Id = vl.Id
		Where	PredmetId = @caseId
				And is_nasa_stranka = 1
				And IsNULL(lp.is_deleted, 0) = 0
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 3, LEN(@result))

	RETURN @result
END
GO




-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	Gets the full name of case
-- =============================================
ALTER FUNCTION [dbo].[Case_GetFullName]
(
	@caseId int
)
RETURNS nvarchar(MAX)
AS
BEGIN
	DECLARE @fullName nvarchar(MAX)

	
	Select	@fullName = CAST(p.NasBroj as varchar(50)) + ': ' + IsNULL(vln.Naziv, '') + ' - ' + IsNULL(vlp.Naziv, '') + ', ' + IsNULL(vp.name, '')
	From	Predmeti p
			Left Join VrstePredmeta vp On p.VrstaPredmetaId = vp.id And p.Id = @caseId
			Left Join Lica_Predmet lpn On p.Id = lpn.PredmetId And lpn.is_nasa_stranka = 1 And p.Id = @caseId And lpn.PredmetId = @caseId And IsNULL(lpn.is_deleted, 0) = 0
			Left Join vLica vln On lpn.Id = vln.Id
			Left Join Lica_Predmet lpp On p.Id = lpp.PredmetId And lpp.is_protivna_stranka = 1 And p.Id = @caseId And lpp.PredmetId = @caseId And IsNULL(lpp.is_deleted, 0) = 0
			Left Join vLica vlp On lpp.Id = vlp.Id
	Where	p.Id = @caseId

	RETURN @fullName

END
GO





