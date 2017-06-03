USE [AdvokatDB]
GO
/****** Object:  Table [dbo].[Biljeske]    Script Date: 27.5.2017 18:32:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Biljeske](
	[Id] [int] NULL,
	[PredmetId] [int] NULL,
	[Datum] [datetime] NULL,
	[Biljeska] [nvarchar](max) NULL,
	[IzradjenaOd] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Dokumenti]    Script Date: 27.5.2017 18:32:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dokumenti](
	[PredmetId] [int] NULL,
	[Id] [int] NULL,
	[TipDokumenta] [nvarchar](255) NULL,
	[Biljeske] [nvarchar](max) NULL,
	[Predato] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Lica]    Script Date: 27.5.2017 18:32:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lica](
	[Biljeske] [nvarchar](max) NULL,
	[Id] [int] NULL,
	[Prezime] [nvarchar](255) NULL,
	[Ime] [nvarchar](255) NULL,
	[Mldb] [nvarchar](255) NULL,
	[ZakonskiZastupnik] [nvarchar](255) NULL,
	[PravnoLice] [nvarchar](255) NULL,
	[Adresa] [nvarchar](255) NULL,
	[PostanskiBroj] [nvarchar](10) NULL,
	[Grad] [nvarchar](255) NULL,
	[Drzava] [nvarchar](255) NULL,
	[Telefon] [nvarchar](255) NULL,
	[Fax] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[JMBG_IDBroj] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Lica_Predmet]    Script Date: 27.5.2017 18:32:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lica_Predmet](
	[Id] [int] NULL,
	[Lica_PredmetId] [int] NULL,
	[PredmetId] [int] NULL,
	[Broj] [nvarchar](255) NULL,
	[Uloga] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OdlukeNaCekanju]    Script Date: 27.5.2017 18:32:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OdlukeNaCekanju](
	[Id] [int] NULL,
	[PredmetId] [int] NULL,
	[OdlukeID] [int] NULL,
	[NasBroj] [int] NULL,
	[DatumOdluke] [datetime] NULL,
	[Rok] [int] NULL,
	[DatumIstekaRoka] [datetime] NULL,
	[ZalbaIzjavljena] [bit] NULL,
	[VrstaOdluke] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Predmeti]    Script Date: 27.5.2017 18:32:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Predmeti](
	[PredmetId] [int] NULL,
	[NasBroj] [int] NULL,
	[SudID] [int] NULL,
	[BiljeskeID] [int] NULL,
	[DokumentiID] [int] NULL,
	[VezeID] [int] NULL,
	[BrojPredmeta] [nvarchar](255) NULL,
	[Sud] [nvarchar](255) NULL,
	[Sudija] [nvarchar](255) NULL,
	[Iniciran] [datetime] NULL,
	[VrijednostSpora] [money] NULL,
	[Kategorija] [nvarchar](255) NULL,
	[PristupPredmetu] [bit] NULL,
	[UlogauPostupku] [nvarchar](255) NULL,
	[PrivremeniZastupnici] [bit] NULL,
	[VrstaPredmeta] [nvarchar](255) NULL,
	[Uspjehu Postupku] [nvarchar](255) NULL,
	[PravniOsnov] [nvarchar](max) NULL,
	[DatumStanjaPredmeta] [datetime] NULL,
	[StanjePredmeta] [nvarchar](max) NULL,
	[DatumArhiviranja] [datetime] NULL,
	[NacinOkoncanja] [nvarchar](255) NULL,
	[BrojArhive] [nvarchar](255) NULL,
	[BrojArhiveRegistrator] [nvarchar](255) NULL,
	[SkontroDan] [int] NULL,
	[SkontroDatum] [datetime] NULL,
	[SkontroBiljeska] [nvarchar](max) NULL,
	[StrankaNasa] [nvarchar](255) NULL,
	[StrankaProtivna] [nvarchar](255) NULL,
	[StrankePostupak] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Radnje]    Script Date: 27.5.2017 18:32:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Radnje](
	[PredmetId] [int] NULL,
	[Id] [int] NULL,
	[Radnja] [nvarchar](max) NULL,
	[Datum] [datetime] NULL,
	[Troskovi] [nvarchar](255) NULL,
	[Biljeske] [nvarchar](max) NULL,
	[RadnjuObavio] [nvarchar](255) NULL,
	[DatumPrijema] [datetime] NULL,
	[VrijednostRadnje] [money] NULL,
	[NacinObavljanja] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sudovi]    Script Date: 27.5.2017 18:32:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sudovi](
	[Id] [int] NULL,
	[Sud] [nvarchar](255) NULL,
	[Adresa] [nvarchar](255) NULL,
	[PostanskiBroj] [nvarchar](255) NULL,
	[Grad] [nvarchar](255) NULL,
	[Telefon] [nvarchar](255) NULL,
	[Fax] [nvarchar](255) NULL,
	[RacunTakse] [nvarchar](255) NULL,
	[RacunVjestacenja] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Takse]    Script Date: 27.5.2017 18:32:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Takse](
	[Id] [int] NULL,
	[PredmetID] [int] NULL,
	[Taksa] [nvarchar](255) NULL,
	[Iznos] [money] NULL,
	[DatumPlacanja] [datetime] NULL,
	[PlacenoOd] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Veze]    Script Date: 27.5.2017 18:32:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Veze](
	[PredmetId] [int] NULL,
	[Id] [int] NULL,
	[NasBrojVeze] [int] NULL,
	[Biljeske] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[uUsers]  WITH CHECK ADD  CONSTRAINT [FK_uUsers_uUserGroups] FOREIGN KEY([user_group_id])
REFERENCES [dbo].[uUserGroups] ([id])
GO
ALTER TABLE [dbo].[uUsers] CHECK CONSTRAINT [FK_uUsers_uUserGroups]
GO



USE [AdvokatDB]
GO

/****** Object:  Table [dbo].[uUserGroups]    Script Date: 27.5.2017 19:17:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[uUserGroups](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[code] [nvarchar](max) NOT NULL,
	[name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_uUserGroups] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO






USE [AdvokatDB]
GO

/****** Object:  Table [dbo].[uUsers]    Script Date: 27.5.2017 19:18:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[uUsers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[first_name] [nvarchar](max) NOT NULL,
	[last_name] [nvarchar](max) NOT NULL,
	[phone] [nvarchar](50) NULL,
 CONSTRAINT [PK_uUsers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO





USE [AdvokatDB]
GO

/****** Object:  Table [dbo].[uUserUserGroups]    Script Date: 28.5.2017 16:27:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[uUserUserGroups](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[user_group_id] [int] NOT NULL,
 CONSTRAINT [PK_uUserUserGroups] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[uUserUserGroups]  WITH CHECK ADD  CONSTRAINT [FK_uUserUserGroups_uUserGroups] FOREIGN KEY([user_group_id])
REFERENCES [dbo].[uUserGroups] ([id])
GO

ALTER TABLE [dbo].[uUserUserGroups] CHECK CONSTRAINT [FK_uUserUserGroups_uUserGroups]
GO

ALTER TABLE [dbo].[uUserUserGroups]  WITH CHECK ADD  CONSTRAINT [FK_uUserUserGroups_uUsers] FOREIGN KEY([user_id])
REFERENCES [dbo].[uUsers] ([id])
GO

ALTER TABLE [dbo].[uUserUserGroups] CHECK CONSTRAINT [FK_uUserUserGroups_uUsers]
GO






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-05-24
-- Description:	Trim string from the end of string
-- =============================================
CREATE FUNCTION TrimEnd
(
	@string nvarchar(MAX),
	@character nvarchar(MAX)
)
RETURNS nvarchar(MAX)
AS
BEGIN
	WHILE @string Like '%' + @character
	BEGIN
		Set @string = LEFT(@string, LEN(@string) - LEN(@character))
	END

	RETURN @string

END
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-05-24
-- Description:	Trim string from the start and the end of string
-- =============================================
CREATE FUNCTION Trim
(
	@string nvarchar(MAX),
	@character nvarchar(MAX)
)
RETURNS nvarchar(MAX)
AS
BEGIN
	WHILE @string Like '%' + @character
	BEGIN
		Set @string = LEFT(@string, LEN(@string) - LEN(@character))
	END

	WHILE @string Like @character + '%'
	BEGIN
		Set @string = RIGHT(@string, LEN(@string) - LEN(@character))
	END

	RETURN @string

END
GO






/****** Object:  UserDefinedFunction [dbo].[TrimStart]    Script Date: 24.5.2017 10:22:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-05-24
-- Description:	Trim string from the start of string
-- =============================================
CREATE FUNCTION [dbo].[TrimStart]
(
	@string nvarchar(MAX),
	@character nvarchar(MAX)
)
RETURNS nvarchar(MAX)
AS
BEGIN
	WHILE @string Like @character + '%'
	BEGIN
		Set @string = RIGHT(@string, LEN(@string) - LEN(@character))
	END

	RETURN @string

END

GO





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE User_GetByEmail (
	@email nvarchar(255)
)
AS
BEGIN
	SET NOCOUNT ON;

    Select	u.id as Id,
			u.email as Email,
			u.first_name as FirstName,
			u.last_name as LastName,
			dbo.Trim((
				Select	',' + ug.code
				From	uUserUserGroups uug
						Inner Join uUserGroups ug On uug.user_group_id = ug.id And uug.user_id = u.id
				For XML Path('')
			),',') As UserGroupCodes
	From	uUsers u
	Where	u.email = @email
			
END
GO



/****** Object:  Table [dbo].[logGeneral]    Script Date: 18.10.2016 11:33:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[logGeneral](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[is_exception] [bit] NOT NULL,
	[message] [nvarchar](max) NOT NULL,
	[execution_date] [datetime] NOT NULL,
	[exception_type] [nvarchar](max) NULL,
	[stack_trace] [nvarchar](max) NULL,
	[identification_code] [varchar](50) NOT NULL,
 CONSTRAINT [PK_logGeneral] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



Alter Table logGeneral Add execution_time float NULL;
Go

Alter Table logGeneral
Alter Column identification_code varchar(MAX)
GO

/****** Object:  StoredProcedure [dbo].[logGeneral_Insert]    Script Date: 25.1.2017 11:16:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2016-10-18
-- Description:	Inserts general log entry.
-- =============================================
CREATE PROCEDURE [dbo].[logGeneral_Insert] (
	@is_exception bit,
	@message nvarchar(MAX),
	@exception_type nvarchar(MAX),
	@stack_trace nvarchar(MAX),
	@identification_code varchar(MAX),
	@execution_time float = NULL
)
AS
BEGIN
	SET NOCOUNT ON;
	
	If (@execution_time Is Not NULL)
		Set @execution_time = ROUND(@execution_time, 6);

    Insert Into dbo.logGeneral (is_exception, [message], exception_type, stack_trace, identification_code, execution_date, execution_time)
	Values (@is_exception, @message, @exception_type, @stack_trace, @identification_code, GETDATE(), @execution_time)

	Select SCOPE_IDENTITY();
END
GO














Alter Table Sudovi Alter Column Id int not null
GO
Alter Table Sudovi Add Primary Key (Id)
GO

Alter Table Predmeti
Add Foreign Key (SudID) References Sudovi(Id)
GO




Update Predmeti
Set SudID = (Select Id From Sudovi Where Sudovi.Sud = Predmeti.Sud)
GO

alter table predmeti drop column sud
GO















SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-03
-- Description:	
-- =============================================
CREATE PROCEDURE Predmeti_GetAll (
	@userId int	
)
AS
BEGIN
	SET NOCOUNT ON;

	Select	p.[Id]
			,[NasBroj]
			,[SudId]
			--,[BiljeskeID]
			--,[DokumentiID]
			--,[VezeID]
			,[BrojPredmeta]
			,[Sudija]
			,[Iniciran]
			,[VrijednostSpora]
			,[Kategorija]
			,[PristupPredmetu]
			,[UlogauPostupku]
			,[PrivremeniZastupnici]
			,[VrstaPredmeta]
			,[Uspjehu Postupku]
			,[PravniOsnov]
			,[DatumStanjaPredmeta]
			,[StanjePredmeta]
			,[DatumArhiviranja]
			,[NacinOkoncanja]
			,[BrojArhive]
			,[BrojArhiveRegistrator]
			,[SkontroDan]
			,[SkontroDatum]
			,[SkontroBiljeska]
			,[StrankaNasa]
			,[StrankaProtivna]
			,[StrankePostupak]
			,s.Sud as SudName
	From	[dbo].[Predmeti] As p
			Left Join Sudovi s On p.SudId = s.Id
END
GO






