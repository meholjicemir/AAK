/****** Object:  StoredProcedure [dbo].[LicePredmet_Insert]    Script Date: 15.1.2018 13:55:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2018-01-15
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[LicePredmet_Update] (
	@predmetId int,
	@liceId int,
	@isNasaStranka bit,
	@isProtivnaStranka bit,
	@ulogaId int,
	@broj nvarchar(255),
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	Update	Lica_Predmet
	Set		Id = @liceId,
			PredmetId = @predmetId,
			is_nasa_stranka = @isNasaStranka,
			is_protivna_stranka = @isProtivnaStranka,
			UlogaId = @ulogaId,
			Broj = @broj
	Where	Lica_PredmetId = @id

END

GO


