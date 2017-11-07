/****** Object:  StoredProcedure [dbo].[CaseActivity_Create]    Script Date: 7.11.2017 12:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	Creates case activity
-- =============================================
ALTER PROCEDURE [dbo].[CaseActivity_Create] (
	@caseId int,
	@note nvarchar(MAX),
	@activityDate datetime,
	@activityDaysOffset int,
	@forAllUsers bit,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

    Insert Into cCaseActivities(case_id, note, activity_date, for_all_users, created, created_by, is_deleted)
	Values(@caseId, @note, DATEADD(day, @activityDaysOffset, @activityDate), @forAllUsers, GETDATE(), @userId, 0);

	Declare @insertedId bigint = SCOPE_IDENTITY();

	Update	Predmeti
	Set		SkontroBiljeska = @note,
			SkontroDatum = @activityDate,
			SkontroDan = @activityDaysOffset
	Where	Id = @caseId;

	Select @insertedId;
END
GO




/****** Object:  StoredProcedure [dbo].[Predmeti_GetAll]    Script Date: 7.11.2017 14:53:48 ******/
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

				Left Join Lica_Predmet lp_nasa On p.Id = lp_nasa.PredmetId And lp_nasa.is_nasa_stranka = 1 And dbo.Case_GetPrvaNasaStrankaId(p.Id) = lp_nasa.Id
				Left Join vLica vl_nasa On lp_nasa.Id = vl_nasa.Id
				Left Join Lica_Predmet lp_protivna On p.Id = lp_protivna.PredmetId And lp_protivna.is_protivna_stranka = 1 And dbo.Case_GetPrvaProtivnaStrankaId(p.Id) = lp_protivna.Id
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

				Left Join Lica_Predmet lp_nasa On p.Id = lp_nasa.PredmetId And lp_nasa.is_nasa_stranka = 1 And dbo.Case_GetPrvaNasaStrankaId(p.Id) = lp_nasa.Id
				Left Join vLica vl_nasa On lp_nasa.Id = vl_nasa.Id
				Left Join Lica_Predmet lp_protivna On p.Id = lp_protivna.PredmetId And lp_protivna.is_protivna_stranka = 1 And dbo.Case_GetPrvaProtivnaStrankaId(p.Id) = lp_protivna.Id
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
		Order By Iniciran Desc
	End
END
GO






Update Takse Set PlacenoOd = 'STRANKA' Where PlacenoOd = 'Stranka';
Update Takse Set PlacenoOd = 'ADVOKAT' Where PlacenoOd = 'Advokat';
Update Takse Set PlacenoOd = N'OSLOBOĐEN' Where PlacenoOd = N'Oslobođen';







SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-11
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Expense_Update] (
	@caseId int,
	@amount decimal(19,4),
	@expenseDate datetime,
	@paidBy nvarchar(50),
	@vrstaTroskaId int,
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	Update	Takse
	Set		PredmetID = @caseId,
			Iznos = @amount,
			DatumPlacanja = @expenseDate,
			PlacenoOd = @paidBy,
			VrstaTroskaId = @vrstaTroskaId
	Where	Id = @id;
END
GO






