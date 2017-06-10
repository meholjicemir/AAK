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






/****** Object:  StoredProcedure [dbo].[Predmeti_GetAll]    Script Date: 10.6.2017 16:14:27 ******/
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
	@rowCount int
)
AS
BEGIN
	SET NOCOUNT ON;

	Select	Top (@rowCount)
			p.[Id]
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
	Where	@filter = ''
			Or (
				NasBroj Like '%' + @filter + '%'
				Or BrojPredmeta Like '%' + @filter + '%'
				Or Sudija Like '%' + @filter + '%'
				Or VrijednostSpora Like '%' + @filter + '%'
				Or Kategorija Like '%' + @filter + '%'
				Or PravniOsnov Like '%' + @filter + '%'
				Or UlogauPostupku Like '%' + @filter + '%'
				Or VrstaPredmeta Like '%' + @filter + '%'
				Or [Uspjehu Postupku] Like '%' + @filter + '%'
				Or StanjePredmeta Like '%' + @filter + '%'
				Or s.Sud Like '%' + @filter + '%'
			)
	Order By Iniciran Desc
END
GO







USE [AdvokatDB]
GO

/****** Object:  Table [dbo].[KategorijePredmeta]    Script Date: 10.6.2017 16:29:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[KategorijePredmeta](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_KategorijePredmeta] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO








Insert Into KategorijePredmeta (name)
select distinct Kategorija from Predmeti
GO



Alter Table Predmeti
Add KategorijaPredmetaId int FOREIGN KEY REFERENCES KategorijePredmeta(Id)
GO



Update Predmeti
Set	KategorijaPredmetaId = (Select Id From KategorijePredmeta Where name = Predmeti.Kategorija)
GO





Alter Table Predmeti
Drop Column Kategorija
GO








USE [AdvokatDB]
GO

/****** Object:  Table [dbo].[KategorijePredmeta]    Script Date: 10.6.2017 16:29:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].Sudije(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Sudije] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO








Insert Into Sudije (name)
select distinct Sudija from Predmeti where Sudija Is Not NULL
GO



Alter Table Predmeti
Add SudijaId int FOREIGN KEY REFERENCES Sudije(Id)
GO



Update Predmeti
Set	SudijaId = (Select Id From Sudije Where name = Predmeti.Sudija)
GO





Alter Table Predmeti
Drop Column Sudija
GO








CREATE TABLE [dbo].VrstePredmeta(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_VrstePredmeta] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO








Insert Into VrstePredmeta (name)
select distinct VrstaPredmeta from Predmeti where VrstaPredmeta Is Not NULL
GO



Alter Table Predmeti
Add VrstaPredmetaId int FOREIGN KEY REFERENCES VrstePredmeta(Id)
GO



Update Predmeti
Set	VrstaPredmetaId = (Select Id From VrstaPredmeta Where name = Predmeti.VrstaPredmeta)
GO





Alter Table Predmeti
Drop Column VrstaPredmeta
GO








CREATE TABLE [dbo].Uloge(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Uloge] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO








Insert Into Uloge(name)
select distinct UlogauPostupku from Predmeti where UlogauPostupku Is Not NULL
GO



Alter Table Predmeti
Add UlogaId int FOREIGN KEY REFERENCES Uloge(Id)
GO



Update Predmeti
Set	UlogaId = (Select Id From Uloge Where name = Predmeti.UlogauPostupku)
GO





Alter Table Predmeti
Drop Column UlogauPostupku
GO







CREATE TABLE [dbo].NaciniOkoncanja(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_NaciniOkoncanja] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO








Insert Into NaciniOkoncanja(name)
select distinct NacinOkoncanja from Predmeti where NacinOkoncanja Is Not NULL
GO



Alter Table Predmeti
Add NacinOkoncanjaId int FOREIGN KEY REFERENCES NaciniOkoncanja(Id)
GO



Update Predmeti
Set	NacinOkoncanjaId = (Select Id From NaciniOkoncanja Where name = Predmeti.NacinOkoncanja)
GO





Alter Table Predmeti
Drop Column NacinOkoncanja
GO





CREATE TABLE [dbo].StanjaPredmeta(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_StanjaPredmeta] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


Insert Into StanjaPredmeta(name)
select distinct StanjePredmeta from Predmeti where StanjePredmeta Is Not NULL
GO


Alter Table Predmeti
Add StanjePredmetaId int FOREIGN KEY REFERENCES StanjaPredmeta(Id)
GO


Update Predmeti
Set	StanjePredmetaId = (Select Id From StanjaPredmeta Where name = Predmeti.StanjePredmeta)
GO


Alter Table Predmeti
Drop Column StanjePredmeta
GO






USE [AdvokatDB]
GO
/****** Object:  StoredProcedure [dbo].[Predmeti_GetAll]    Script Date: 10.6.2017 16:14:27 ******/
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
	@rowCount int
)
AS
BEGIN
	SET NOCOUNT ON;

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
			,[UlogaId]
			,[PrivremeniZastupnici]
			,[VrstaPredmetaId]
			,[Uspjehu Postupku]
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
			,[StrankaNasa]
			,[StrankaProtivna]
			,[StrankePostupak]

			,s.Sud as SudName
			,kp.name As KategorijaPredmetaName
			,sj.name As SudijaName
			,vp.name As VrstaPredmetaName
			,u.name As UlogaName
	From	[dbo].[Predmeti] As p
			Left Join Sudovi s On p.SudId = s.Id
			Left Join KategorijePredmeta kp On p.KategorijaPredmetaId = kp.id
			Left Join Sudije sj On p.SudijaId = sj.id
			Left Join VrstePredmeta vp On p.VrstaPredmetaId = vp.id
			Left Join Uloge u On p.UlogaId = u.id
			Left Join NaciniOkoncanja nok On p.NacinOkoncanjaId = nok.id
			Left Join StanjaPredmeta sp On p.StanjePredmetaId = sp.id
	Where	@filter = ''
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
			)
	Order By Iniciran Desc
END
GO







USE [AdvokatDB]
GO
/****** Object:  StoredProcedure [dbo].[Predmeti_GetAll]    Script Date: 10.6.2017 16:14:27 ******/
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
	@rowCount int
)
AS
BEGIN
	SET NOCOUNT ON;

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
			,[UlogaId]
			,[PrivremeniZastupnici]
			,[VrstaPredmetaId]
			,[Uspjehu Postupku]
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
			,[StrankaNasa]
			,[StrankaProtivna]
			,[StrankePostupak]

			,s.Sud as SudName
			,kp.name As KategorijaPredmetaName
			,sj.name As SudijaName
			,vp.name As VrstaPredmetaName
			,u.name As UlogaName
			,sp.name As StanjePredmetaName
	From	[dbo].[Predmeti] As p
			Left Join Sudovi s On p.SudId = s.Id
			Left Join KategorijePredmeta kp On p.KategorijaPredmetaId = kp.id
			Left Join Sudije sj On p.SudijaId = sj.id
			Left Join VrstePredmeta vp On p.VrstaPredmetaId = vp.id
			Left Join Uloge u On p.UlogaId = u.id
			Left Join NaciniOkoncanja nok On p.NacinOkoncanjaId = nok.id
			Left Join StanjaPredmeta sp On p.StanjePredmetaId = sp.id
	Where	@filter = ''
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
			)
	Order By Iniciran Desc
END
GO






USE [AdvokatDB]
GO
/****** Object:  StoredProcedure [dbo].[CodeTable_GetData]    Script Date: 10.6.2017 18:58:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-10
-- Description:	Get data from code table
-- =============================================
CREATE PROCEDURE [dbo].[CodeTable_GetData] (
	@tableName varchar(255),
	@columnName varchar(255)
)
AS
BEGIN
	SET NOCOUNT ON;

    EXEC('SELECT Id, ' + @columnName + ' AS Name FROM ' + @tableName + ' ORDER BY 2 ASC');
END
GO






USE [AdvokatDB]
GO
/****** Object:  StoredProcedure [dbo].[CodeTable_InsertRecord]    Script Date: 10.6.2017 20:13:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-10
-- Description:	Insert record in code table
-- =============================================
CREATE PROCEDURE [dbo].[CodeTable_InsertRecord] (
	@tableName varchar(255),
	@name nvarchar(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;
	EXEC ('INSERT INTO ' + @tableName + ' (Name) VALUES (''' + @name + '''); SELECT SCOPE_IDENTITY();');
END




