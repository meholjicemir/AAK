/****** Object:  StoredProcedure [dbo].[Document_Update]    Script Date: 16.11.2017 19:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-04
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Document_Update] (
	@caseId int,
	@note nvarchar(MAX),
	--@tipDokumentaId int,
	@tipDokumentaname nvarchar(MAX),
	@predatoUzDokumentName nvarchar(MAX),
	@documentName nvarchar(MAX),
	@googleDriveDocId nvarchar(MAX),
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @predatoUzDokumentId int
	If IsNULL(@predatoUzDokumentName, '') = ''
		Set @predatoUzDokumentId = NULL;
	Else
	Begin
		Set @predatoUzDokumentId = (Select Top 1 id From PredatoUzDokumenti Where name = @predatoUzDokumentName)
		If @predatoUzDokumentId Is NULL
		Begin
			Insert Into PredatoUzDokumenti(name) Values (@predatoUzDokumentName);
			Set @predatoUzDokumentId = SCOPE_IDENTITY();
		End
	End

	Declare @tipDokumentaId int
	If IsNULL(@tipDokumentaName, '') = ''
		Set @tipDokumentaId = NULL;
	Else
	Begin
		Set @tipDokumentaId = (Select Top 1 id From TipoviDokumenata Where name = @tipDokumentaName)
		If @tipDokumentaId Is NULL
		Begin
			Insert Into TipoviDokumenata(name) Values (@tipDokumentaName);
			Set @tipDokumentaId = SCOPE_IDENTITY();
		End
	End

    Update	Dokumenti
	Set		PredmetId = @caseId,
			Biljeske = @note,
			TipDokumentaId = @tipDokumentaId,
			PredatoUzDokumentiId = @predatoUzDokumentId,
			document_link = @documentName,
			google_drive_doc_id = @googleDriveDocId
	Where	id = @id

END
GO






/****** Object:  StoredProcedure [dbo].[Document_Insert]    Script Date: 16.11.2017 19:03:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-04
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Document_Insert] (
	@caseId int,
	@note nvarchar(MAX),
	--@tipDokumentaId int,
	@tipDokumentaName nvarchar(MAX),
	@predatoUzDokumentName nvarchar(MAX),
	@documentName nvarchar(MAX),
	@googleDriveDocId nvarchar(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Id), 0) From Dokumenti) + 1;

	Declare @predatoUzDokumentId int
	If IsNULL(@predatoUzDokumentName, '') = ''
		Set @predatoUzDokumentId = NULL;
	Else
	Begin
		Set @predatoUzDokumentId = (Select Top 1 id From PredatoUzDokumenti Where name = @predatoUzDokumentName)
		If @predatoUzDokumentId Is NULL
		Begin
			Insert Into PredatoUzDokumenti(name) Values (@predatoUzDokumentName);
			Set @predatoUzDokumentId = SCOPE_IDENTITY();
		End
	End

	Declare @tipDokumentaId int
	If IsNULL(@tipDokumentaName, '') = ''
		Set @tipDokumentaId = NULL;
	Else
	Begin
		Set @tipDokumentaId = (Select Top 1 id From TipoviDokumenata Where name = @tipDokumentaName)
		If @tipDokumentaId Is NULL
		Begin
			Insert Into TipoviDokumenata(name) Values (@tipDokumentaName);
			Set @tipDokumentaId = SCOPE_IDENTITY();
		End
	End
		
    Insert Into Dokumenti (id, PredmetId, Biljeske, TipDokumentaId, PredatoUzDokumentiId, document_link, google_drive_doc_id, is_deleted)
	Values (@id, @caseId, @note, @tipDokumentaId, @predatoUzDokumentId, @documentName, @googleDriveDocId, 0);

	Select @id;
END
GO

