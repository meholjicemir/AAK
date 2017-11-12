/****** Object:  View [dbo].[vLica_Id_Naziv]    Script Date: 12.11.2017 22:39:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[vLica_Id_Naziv]
AS
	SELECT	Id,
			CASE WHEN (IsNULL(Ime, '') <> '' Or IsNULL(Prezime, '') <> '') THEN Prezime + ' ' + Ime + ' ' + IsNULL(PravnoLice, '') ELSE IsNULL(PravnoLice, '') END AS Naziv
	FROM	Lica
	WHERE	is_deleted = 0
GO


