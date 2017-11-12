SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vLica_Id_Naziv]
AS
	SELECT	Id,
			CASE WHEN (IsNULL(Ime, '') <> '' Or IsNULL(Prezime, '') <> '') THEN Prezime + ' ' + Ime + ' ' + IsNULL(PravnoLice, '') ELSE IsNULL(PravnoLice, '') END AS Naziv
	FROM	Lica
GO





/****** Object:  StoredProcedure [dbo].[Predmeti_Insert]    Script Date: 8.11.2017 16:56:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-05
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Predmeti_Insert] (
	@kategorijaPredmetaId int,
	@ulogaId int,
	@privremeniZastupnici bit,
	@pristupPredmetu bit,
	@iniciran datetime,
	@brojPredmeta nvarchar(255),
	@sudId int,
	@sudijaId int,
	@vrijednostSpora decimal(19,4),
	@vrstaPredmetaId int,
	@datumStanjaPredmeta datetime,
	--@stanjePredmetaId int,
	@stanjePredmetaName nvarchar(MAX),

	@nacinOkoncanjaId int,
    @uspjeh nvarchar(255),
    @datumArhiviranja datetime,
    @brojArhive nvarchar(255),
	@brojArhiveRegistrator nvarchar(255),

	@pravniOsnov nvarchar(MAX),

	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Id), 0) From Predmeti) + 1;
	Declare @nasBroj int = (Select IsNULL(MAX(NasBroj), 0) From Predmeti) + 1;

	If @sudijaId = -1 Set @sudijaId = NULL;
	If @sudId = -1 Set @sudId = NULL;
	If @kategorijaPredmetaId = -1 Set @kategorijaPredmetaId = NULL;
	If @ulogaId = -1 Set @ulogaId = NULL;
	If @vrstaPredmetaId = -1 Set @vrstaPredmetaId = NULL;
	--If @stanjePredmetaId = -1 Set @stanjePredmetaId = NULL;
	If @nacinOkoncanjaId = -1 Set @nacinOkoncanjaId = NULL;

	Declare @stanjePredmetaId int
	If IsNULL(@stanjePredmetaName, '') = ''
		Set @stanjePredmetaId = NULL;
	Else
	Begin
		Set @stanjePredmetaId = (Select id From StanjaPredmeta Where name = @stanjePredmetaName)
		If @stanjePredmetaId Is NULL
		Begin
			Insert Into StanjaPredmeta(name) Values (@stanjePredmetaName);
			Set @stanjePredmetaId = SCOPE_IDENTITY();
		End
	End

	Declare @now datetime = GETDATE();

	Insert Into Predmeti (Id, NasBroj, KategorijaPredmetaId, UlogaId, PrivremeniZastupnici, PristupPredmetu, BrojPredmeta, SudID, SudijaId, VrijednostSpora,
		VrstaPredmetaId, DatumStanjaPredmeta, StanjePredmetaId,
		NacinOkoncanjaId, [Uspjehu Postupku], DatumArhiviranja, BrojArhive, BrojArhiveRegistrator,
		PravniOsnov,
		is_deleted, created, iniciran, created_by)
	Values (@id, @nasBroj, @kategorijaPredmetaId, @ulogaId, @privremeniZastupnici, @pristupPredmetu, @brojPredmeta, @sudId, @sudijaId, @vrijednostSpora,
		@vrstaPredmetaId, @datumStanjaPredmeta, @stanjePredmetaId,
		@nacinOkoncanjaId, @uspjeh, @datumArhiviranja, @brojArhive, @brojArhiveRegistrator,
		@pravniOsnov,
		0, @now, @iniciran, @userId);

	Select @id;
END
GO





/****** Object:  StoredProcedure [dbo].[Predmeti_Update]    Script Date: 8.11.2017 16:56:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-05
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Predmeti_Update] (
	@kategorijaPredmetaId int,
	@ulogaId int,
	@privremeniZastupnici bit,
	@pristupPredmetu bit,
	@iniciran datetime,
	@brojPredmeta nvarchar(255),
	@sudId int,
	@sudijaId int,
	@vrijednostSpora decimal(19,4),
	@vrstaPredmetaId int,
	@datumStanjaPredmeta datetime,
	--@stanjePredmetaId int,
	@stanjePredmetaName nvarchar(MAX),

	@nacinOkoncanjaId int,
    @uspjeh nvarchar(255),
    @datumArhiviranja datetime,
    @brojArhive nvarchar(255),
	@brojArhiveRegistrator nvarchar(255),

	@pravniOsnov nvarchar(MAX),

	@id int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	If @sudijaId = -1 Set @sudijaId = NULL;
	If @sudId = -1 Set @sudId = NULL;
	If @kategorijaPredmetaId = -1 Set @kategorijaPredmetaId = NULL;
	If @ulogaId = -1 Set @ulogaId = NULL;
	If @vrstaPredmetaId = -1 Set @vrstaPredmetaId = NULL;
	--If @stanjePredmetaId = -1 Set @stanjePredmetaId = NULL;
	If @nacinOkoncanjaId = -1 Set @nacinOkoncanjaId = NULL;

	Declare @stanjePredmetaId int
	If IsNULL(@stanjePredmetaName, '') = ''
		Set @stanjePredmetaId = NULL;
	Else
	Begin
		Set @stanjePredmetaId = (Select id From StanjaPredmeta Where name = @stanjePredmetaName)
		If @stanjePredmetaId Is NULL
		Begin
			Insert Into StanjaPredmeta(name) Values (@stanjePredmetaName);
			Set @stanjePredmetaId = SCOPE_IDENTITY();
		End
	End


	Update	Predmeti
	Set		KategorijaPredmetaId = @kategorijaPredmetaId,
			UlogaId = @ulogaId,
			PrivremeniZastupnici = @privremeniZastupnici,
			PristupPredmetu = @pristupPredmetu,
			Iniciran = @iniciran,
			BrojPredmeta = @brojPredmeta,
			SudID = @sudId,
			SudijaId = @sudijaId,
			VrijednostSpora = @vrijednostSpora,
			VrstaPredmetaId = @vrstaPredmetaId,
			DatumStanjaPredmeta = @datumStanjaPredmeta,
			StanjePredmetaId = @stanjePredmetaId,

			NacinOkoncanjaId = @nacinOkoncanjaId,
			[Uspjehu Postupku] = @uspjeh,
			DatumArhiviranja = @datumArhiviranja,
			BrojArhive = @brojArhive,
			BrojArhiveRegistrator = @brojArhiveRegistrator,

			PravniOsnov = @pravniOsnov,

			modified = GETDATE(),
			modified_by = @userId
	Where	id = @id

END
GO




