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
GO





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-11
-- Description:	Get all sudovi.
-- =============================================
CREATE PROCEDURE Sudovi_GetAll
AS
BEGIN
	SET NOCOUNT ON;

	Select	Id,
			Sud as Naziv,
			Adresa,
			PostanskiBroj,
			Grad,
			Telefon,
			Fax,
			RacunTakse,
			RacunVjestacenja
	From	Sudovi
	Order By Sud Asc
END
GO




Alter Table Sudovi Add created_by int FOREIGN KEY REFERENCES uUsers(id)
GO

Alter Table Sudovi Add created datetime
GO

Alter Table Sudovi Add modified_by int FOREIGN KEY REFERENCES uUsers(id)
GO

Alter Table Sudovi Add modified datetime
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-11
-- Description:	Insert sud
-- =============================================
CREATE PROCEDURE Sudovi_Insert (
	@naziv nvarchar(255),
	@adresa nvarchar(255),
	@postanskiBroj nvarchar(255),
	@grad nvarchar(255),
	@telefon nvarchar(255),
	@fax nvarchar(255),
	@racunTakse nvarchar(255),
	@racunVjestacenja nvarchar(255),
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Insert Into Sudovi (Sud, Adresa, PostanskiBroj, Grad, Telefon, Fax, RacunTakse, RacunVjestacenja, created_by, created)
	Values (@naziv, @adresa, @postanskiBroj, @grad, @telefon, @fax, @racunTakse, @racunVjestacenja, @userId, GETDATE());

	Select SCOPE_IDENTITY();
END
GO











USE [AdvokatDB]
GO
/****** Object:  StoredProcedure [dbo].[Sudovi_GetAll]    Script Date: 11.6.2017 16:43:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-11
-- Description:	Get all sudovi.
-- =============================================
ALTER PROCEDURE [dbo].[Sudovi_GetAll]
AS
BEGIN
	SET NOCOUNT ON;

	Select	s.Id,
			Sud as Naziv,
			Adresa,
			PostanskiBroj,
			Grad,
			Telefon,
			Fax,
			RacunTakse,
			RacunVjestacenja,
			created As Created,
			created_by As CreatedBy,
			u.first_name + ' ' + u.last_name As CreatedByName,
			modified As Modified,
			modified_by As ModifiedBy,
			um.first_name + ' ' + um.last_name As ModifiedByName
	From	Sudovi s
			Left Join uUsers u On s.created_by = u.id
			Left Join uUsers um On s.modified_by = um.id
	Order By Sud Asc
END
GO






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-11
-- Description:	Insert sud
-- =============================================
CREATE PROCEDURE [dbo].[Sudovi_Update] (
	@naziv nvarchar(255),
	@adresa nvarchar(255),
	@postanskiBroj nvarchar(255),
	@grad nvarchar(255),
	@telefon nvarchar(255),
	@fax nvarchar(255),
	@racunTakse nvarchar(255),
	@racunVjestacenja nvarchar(255),
	@id int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Update	Sudovi
	Set		Sud = @naziv,
			Adresa = @adresa,
			PostanskiBroj = @postanskiBroj,
			Grad = @grad,
			Telefon = @grad,
			Fax = @fax,
			RacunTakse = @racunTakse,
			RacunVjestacenja = @racunVjestacenja,
			modified_by = @userId,
			modified = GETDATE()
	Where	id = @id;
END
GO







Alter Table Sudovi Add id2 int IDENTITY(1, 1)
GO


ALTER TABLE [dbo].[Predmeti] DROP CONSTRAINT [FK__Predmeti__SudID__03F0984C]
GO

/****** Object:  Index [PK__Sudovi__3214EC07E30D0D37]    Script Date: 11.6.2017 17:06:29 ******/
ALTER TABLE [dbo].[Sudovi] DROP CONSTRAINT [PK__Sudovi__3214EC07E30D0D37]
GO




Alter Table Sudovi Drop Column Id
GO

exec sp_rename 'Sudovi.id2', 'Id', 'Column'
go




alter table sudovi add constraint pk_sudovi primary key clustered (id)
go

ALTER TABLE [dbo].[Predmeti]  WITH CHECK ADD FOREIGN KEY([SudID])
REFERENCES [dbo].[Sudovi] ([Id])
GO





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-11
-- Description:	Delete sud
-- =============================================
CREATE PROCEDURE [dbo].[Sudovi_Delete] (
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	Delete From Sudovi
	Where	id = @id;
END
GO







USE [AdvokatDB]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-11
-- Description:	Update record in code table
-- =============================================
CREATE PROCEDURE [dbo].[CodeTable_UpdateRecord] (
	@tableName varchar(255),
	@name nvarchar(MAX),
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;
	Declare @idString varchar(50) = CAST(@id As varchar(50))
	EXEC ('UPDATE ' + @tableName + ' SET Name = ''' + @name + ''' WHERE id = ' + @idString + ');');
END
GO





USE [AdvokatDB]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-11
-- Description:	Delete record in code table
-- =============================================
CREATE PROCEDURE [dbo].[CodeTable_DeleteRecord] (
	@tableName varchar(255),
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;
	Declare @idString varchar(50) = CAST(@id As varchar(50))
	EXEC ('DELETE FROM ' + @tableName + ' WHERE id = ' + @idString + ');');
END
GO




/****** Object:  StoredProcedure [dbo].[CodeTable_InsertRecord]    Script Date: 11.6.2017 18:07:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-10
-- Description:	Insert record in code table
-- =============================================
ALTER PROCEDURE [dbo].[CodeTable_InsertRecord] (
	@tableName varchar(255),
	@name nvarchar(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;
	EXEC ('INSERT INTO ' + @tableName + ' (Name) VALUES (N''' + @name + '''); SELECT SCOPE_IDENTITY();');
END
GO






/****** Object:  StoredProcedure [dbo].[CodeTable_UpdateRecord]    Script Date: 11.6.2017 18:08:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-11
-- Description:	Update record in code table
-- =============================================
ALTER PROCEDURE [dbo].[CodeTable_UpdateRecord] (
	@tableName varchar(255),
	@name nvarchar(MAX),
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;
	Declare @idString varchar(50) = CAST(@id As varchar(50))
	EXEC ('UPDATE ' + @tableName + ' SET Name = N''' + @name + ''' WHERE id = ' + @idString + ';');
END
GO




/****** Object:  StoredProcedure [dbo].[CodeTable_DeleteRecord]    Script Date: 11.6.2017 18:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-11
-- Description:	Delete record in code table
-- =============================================
ALTER PROCEDURE [dbo].[CodeTable_DeleteRecord] (
	@tableName varchar(255),
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;
	Declare @idString varchar(50) = CAST(@id As varchar(50))
	EXEC ('DELETE FROM ' + @tableName + ' WHERE id = ' + @idString + ';');
END
GO




Alter Table Lica Add IsMinor bit
GO

Update Lica Set IsMinor = (case when Mldb is not null then 1 else 0 end)
GO

Alter Table Lica Drop Column Mldb
GO




Alter Table Lica Add created_by int FOREIGN KEY REFERENCES uUsers(id)
GO

Alter Table Lica Add created datetime
GO

Alter Table Lica Add modified_by int FOREIGN KEY REFERENCES uUsers(id)
GO

Alter Table Lica Add modified datetime
GO



USE [AdvokatDB]
GO
/****** Object:  StoredProcedure [dbo].[Lica_GetAll]    Script Date: 11.6.2017 18:45:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-11
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Lica_GetAll] (
	@userId int,
	@filter nvarchar(MAX),
	@rowCount int
)
AS
BEGIN
	SET NOCOUNT ON;

	Select	Top (@rowCount)
			L.[Id]
			,[Prezime]
			,[Ime]
			,[ZakonskiZastupnik]
			,[PravnoLice]
			,[Adresa]
			,[PostanskiBroj]
			,[Grad]
			,[Drzava]
			,[Telefon]
			,[Fax]
			,L.[Email]
			,[JMBG_IDBroj]
			,[IsMinor],
			u.first_name + ' ' + u.last_name As CreatedByName,
			modified As Modified,
			modified_by As ModifiedBy,
			um.first_name + ' ' + um.last_name As ModifiedByName,
			case when Ime Is Not NULL And Prezime Is Not NULL then Ime + ' ' + Prezime else PravnoLice end As Naziv
	FROM	[dbo].[Lica] As L
			Left Join uUsers u On L.created_by = u.id
			Left Join uUsers um On L.modified_by = um.id
	Where	@filter = ''
			Or (
				Prezime Like '%' + @filter + '%'
				Or Ime Like '%' + @filter + '%'
				Or ZakonskiZastupnik Like '%' + @filter + '%'
				Or PravnoLice Like '%' + @filter + '%'
				Or Adresa Like '%' + @filter + '%'
				Or PostanskiBroj Like '%' + @filter + '%'
				Or Grad Like '%' + @filter + '%'
				Or Drzava Like '%' + @filter + '%'
				Or Telefon Like '%' + @filter + '%'
				Or Fax Like '%' + @filter + '%'
				Or L.Email Like '%' + @filter + '%'
				Or JMBG_IDBroj Like '%' + @filter + '%'
			)
END
GO





USE [AdvokatDB]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].Drzave(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Drzave] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


Insert Into Drzave (name)
select distinct Drzava from Lica where Drzava Is Not NULL
GO

Alter Table Lica
Add DrzavaId int FOREIGN KEY REFERENCES Drzave(Id)
GO

Update Lica
Set	DrzavaId = (Select Id From Drzave Where name = Lica.Drzava)
GO

Alter Table Lica
Drop Column Drzava
GO




USE [AdvokatDB]
GO
/****** Object:  StoredProcedure [dbo].[Lica_GetAll]    Script Date: 18.6.2017 15:18:38 ******/
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
	@rowCount int
)
AS
BEGIN
	SET NOCOUNT ON;

	Select	Top (@rowCount)
			L.[Id]
			,[Prezime]
			,[Ime]
			,[ZakonskiZastupnik]
			,[PravnoLice]
			,[Adresa]
			,[PostanskiBroj]
			,[Grad]
			,[DrzavaId]
			,ISNULL(d.name, '') As DrzavaName
			,[Telefon]
			,[Fax]
			,L.[Email]
			,[JMBG_IDBroj]
			,[IsMinor],
			u.first_name + ' ' + u.last_name As CreatedByName,
			modified As Modified,
			modified_by As ModifiedBy,
			um.first_name + ' ' + um.last_name As ModifiedByName,
			case when Ime Is Not NULL And Prezime Is Not NULL then Ime + ' ' + Prezime else PravnoLice end As Naziv
	FROM	[dbo].[Lica] As L
			Left Join Drzave d ON L.DrzavaId = d.id
			Left Join uUsers u On L.created_by = u.id
			Left Join uUsers um On L.modified_by = um.id
	Where	@filter = ''
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
			)
END
GO





USE [AdvokatDB]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-18
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Lica_Insert] (
	@prezime nvarchar(MAX),
	@ime nvarchar(MAX),
	@zakonskiZastupnik nvarchar(MAX),
	@pravnoLice nvarchar(MAX),
	@adresa nvarchar(MAX),
	@postanskiBroj nvarchar(MAX),
	@grad nvarchar(MAX),
	@drzavaId int,
	@telefon nvarchar(MAX),
	@fax nvarchar(MAX),
	@email nvarchar(MAX),
	@JMBG_IDBroj nvarchar(MAX),
	@isMinor bit,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Insert Into Lica (prezime, ime, ZakonskiZastupnik, PravnoLice, Adresa, PostanskiBroj, Grad, DrzavaId, Telefon, Fax, Email, JMBG_IDBroj, IsMinor, created_by, created)
	Values (@prezime, @ime, @zakonskiZastupnik, @pravnoLice, @adresa, @postanskiBroj, @grad, @drzavaId, @telefon, @fax, @email, @JMBG_IDBroj, @isMinor, @userId, GETDATE());

	Select SCOPE_IDENTITY();
END
GO





USE [AdvokatDB]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-18
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Lica_Update] (
	@prezime nvarchar(MAX),
	@ime nvarchar(MAX),
	@zakonskiZastupnik nvarchar(MAX),
	@pravnoLice nvarchar(MAX),
	@adresa nvarchar(MAX),
	@postanskiBroj nvarchar(MAX),
	@grad nvarchar(MAX),
	@drzavaId int,
	@telefon nvarchar(MAX),
	@fax nvarchar(MAX),
	@email nvarchar(MAX),
	@JMBG_IDBroj nvarchar(MAX),
	@isMinor bit,
	@id int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Update	Lica
	Set		prezime = @prezime,
			ime = @ime,
			ZakonskiZastupnik = @zakonskiZastupnik,
			PravnoLice = @pravnoLice,
			Adresa = @adresa,
			PostanskiBroj = @postanskiBroj,
			Grad = @grad,
			DrzavaId = @drzavaId,
			Telefon = @telefon,
			Fax = @fax,
			Email = @email,
			JMBG_IDBroj = @JMBG_IDBroj,
			IsMinor = @isMinor,
			modified_by = @userId,
			modified = GETDATE()
	Where	id = @id;

END
GO


Alter Table Lica
Add is_deleted bit
GO


Update Lica set is_deleted = 0 
go



USE [AdvokatDB]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-18
-- Description:	Delete lice
-- =============================================
CREATE PROCEDURE [dbo].[Lica_Delete] (
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	Update	Lica
	Set		is_deleted = 1
	Where	id = @id;
END
GO


USE [AdvokatDB]
GO
/****** Object:  StoredProcedure [dbo].[Lica_GetAll]    Script Date: 18.6.2017 15:51:04 ******/
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
	@rowCount int
)
AS
BEGIN
	SET NOCOUNT ON;

	Select	Top (@rowCount)
			L.[Id]
			,[Prezime]
			,[Ime]
			,[ZakonskiZastupnik]
			,[PravnoLice]
			,[Adresa]
			,[PostanskiBroj]
			,[Grad]
			,[DrzavaId]
			,ISNULL(d.name, '') As DrzavaName
			,[Telefon]
			,[Fax]
			,L.[Email]
			,[JMBG_IDBroj]
			,[IsMinor],
			u.first_name + ' ' + u.last_name As CreatedByName,
			modified As Modified,
			modified_by As ModifiedBy,
			um.first_name + ' ' + um.last_name As ModifiedByName,
			case when Ime Is Not NULL And Prezime Is Not NULL then Ime + ' ' + Prezime else PravnoLice end As Naziv
	FROM	[dbo].[Lica] As L
			Left Join Drzave d ON L.DrzavaId = d.id
			Left Join uUsers u On L.created_by = u.id
			Left Join uUsers um On L.modified_by = um.id
	Where	L.is_deleted = 0
			And (
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
				)
			)
END
GO




Alter Table Sudovi
Add is_deleted bit
GO

Update Sudovi Set is_deleted = 0
GO





USE [AdvokatDB]
GO
/****** Object:  StoredProcedure [dbo].[Sudovi_Delete]    Script Date: 18.6.2017 15:51:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-11
-- Description:	Delete sud
-- =============================================
ALTER PROCEDURE [dbo].[Sudovi_Delete] (
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	Update	Sudovi
	Set		is_deleted = 1
	Where	id = @id;
END
GO






USE [AdvokatDB]
GO
/****** Object:  StoredProcedure [dbo].[Sudovi_GetAll]    Script Date: 18.6.2017 15:52:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-11
-- Description:	Get all sudovi.
-- =============================================
ALTER PROCEDURE [dbo].[Sudovi_GetAll]
AS
BEGIN
	SET NOCOUNT ON;

	Select	s.Id,
			Sud as Naziv,
			Adresa,
			PostanskiBroj,
			Grad,
			Telefon,
			Fax,
			RacunTakse,
			RacunVjestacenja,
			created As Created,
			created_by As CreatedBy,
			u.first_name + ' ' + u.last_name As CreatedByName,
			modified As Modified,
			modified_by As ModifiedBy,
			um.first_name + ' ' + um.last_name As ModifiedByName
	From	Sudovi s
			Left Join uUsers u On s.created_by = u.id
			Left Join uUsers um On s.modified_by = um.id
	Where	s.is_deleted = 0
	Order By Sud Asc
END
GO





USE [AdvokatDB]
GO
/****** Object:  StoredProcedure [dbo].[Lica_GetAll]    Script Date: 18.6.2017 15:58:05 ******/
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
	@rowCount int
)
AS
BEGIN
	SET NOCOUNT ON;

	Select	Top (@rowCount)
			L.[Id]
			,[Prezime]
			,[Ime]
			,[ZakonskiZastupnik]
			,[PravnoLice]
			,[Adresa]
			,[PostanskiBroj]
			,[Grad]
			,[DrzavaId]
			,ISNULL(d.name, '') As DrzavaName
			,[Telefon]
			,[Fax]
			,L.[Email]
			,[JMBG_IDBroj]
			,IsNULL(Biljeske, '') as Biljeske
			,[IsMinor],
			u.first_name + ' ' + u.last_name As CreatedByName,
			modified As Modified,
			modified_by As ModifiedBy,
			um.first_name + ' ' + um.last_name As ModifiedByName,
			case when Ime Is Not NULL And Prezime Is Not NULL then Ime + ' ' + Prezime else PravnoLice end As Naziv
	FROM	[dbo].[Lica] As L
			Left Join Drzave d ON L.DrzavaId = d.id
			Left Join uUsers u On L.created_by = u.id
			Left Join uUsers um On L.modified_by = um.id
	Where	L.is_deleted = 0
			And (
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
				)
			)
END
GO





USE [AdvokatDB]
GO
/****** Object:  StoredProcedure [dbo].[Lica_Insert]    Script Date: 18.6.2017 15:58:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-18
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Lica_Insert] (
	@prezime nvarchar(MAX),
	@ime nvarchar(MAX),
	@zakonskiZastupnik nvarchar(MAX),
	@pravnoLice nvarchar(MAX),
	@adresa nvarchar(MAX),
	@postanskiBroj nvarchar(MAX),
	@grad nvarchar(MAX),
	@drzavaId int,
	@telefon nvarchar(MAX),
	@fax nvarchar(MAX),
	@email nvarchar(MAX),
	@JMBG_IDBroj nvarchar(MAX),
	@biljeske nvarchar(MAX),
	@isMinor bit,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Insert Into Lica (prezime, ime, ZakonskiZastupnik, PravnoLice, Adresa, PostanskiBroj, Grad, DrzavaId, Telefon, Fax, Email, JMBG_IDBroj, Biljeske, IsMinor, created_by, created)
	Values (@prezime, @ime, @zakonskiZastupnik, @pravnoLice, @adresa, @postanskiBroj, @grad, @drzavaId, @telefon, @fax, @email, @JMBG_IDBroj, @biljeske, @isMinor, @userId, GETDATE());

	Select SCOPE_IDENTITY();
END
GO







USE [AdvokatDB]
GO
/****** Object:  StoredProcedure [dbo].[Lica_Update]    Script Date: 18.6.2017 15:59:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-18
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Lica_Update] (
	@prezime nvarchar(MAX),
	@ime nvarchar(MAX),
	@zakonskiZastupnik nvarchar(MAX),
	@pravnoLice nvarchar(MAX),
	@adresa nvarchar(MAX),
	@postanskiBroj nvarchar(MAX),
	@grad nvarchar(MAX),
	@drzavaId int,
	@telefon nvarchar(MAX),
	@fax nvarchar(MAX),
	@email nvarchar(MAX),
	@JMBG_IDBroj nvarchar(MAX),
	@biljeske nvarchar(MAX),
	@isMinor bit,
	@id int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Update	Lica
	Set		prezime = @prezime,
			ime = @ime,
			ZakonskiZastupnik = @zakonskiZastupnik,
			PravnoLice = @pravnoLice,
			Adresa = @adresa,
			PostanskiBroj = @postanskiBroj,
			Grad = @grad,
			DrzavaId = @drzavaId,
			Telefon = @telefon,
			Fax = @fax,
			Email = @email,
			JMBG_IDBroj = @JMBG_IDBroj,
			Biljeske = @biljeske,
			IsMinor = @isMinor,
			modified_by = @userId,
			modified = GETDATE()
	Where	id = @id;

END
GO







USE [AdvokatDB]
GO
/****** Object:  StoredProcedure [dbo].[Lica_GetAll]    Script Date: 18.6.2017 16:19:02 ******/
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
	@rowCount int
)
AS
BEGIN
	SET NOCOUNT ON;

	Select	Top (@rowCount)
			L.[Id]
			,ISNULL([Prezime], '') As Prezime
			,ISNULL([Ime], '') As Ime
			,ISNULL([ZakonskiZastupnik], '') As ZakonskiZastupnik
			,ISNULL([PravnoLice], '') As PravnoLice
			,ISNULL([Adresa], '') As Adresa
			,ISNULL([PostanskiBroj], '') As PostanskiBroj
			,ISNULL([Grad], '') As Grad
			,ISNULL([DrzavaId], -1) As DrzavaId
			,ISNULL(d.name, '') As DrzavaName
			,ISNULL([Telefon], '') As Telefon
			,ISNULL([Fax], '') As Fax
			,ISNULL(L.[Email], '') As Email
			,IsNULL([JMBG_IDBroj], '') As JMBG_IDBroj
			,IsNULL(Biljeske, '') as Biljeske
			,[IsMinor],
			u.first_name + ' ' + u.last_name As CreatedByName,
			modified As Modified,
			modified_by As ModifiedBy,
			um.first_name + ' ' + um.last_name As ModifiedByName,
			case when Ime Is Not NULL And Prezime Is Not NULL then Ime + ' ' + Prezime else PravnoLice end As Naziv
	FROM	[dbo].[Lica] As L
			Left Join Drzave d ON L.DrzavaId = d.id
			Left Join uUsers u On L.created_by = u.id
			Left Join uUsers um On L.modified_by = um.id
	Where	L.is_deleted = 0
			And (
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
				)
			)
END
GO






USE [AdvokatDB]
GO
/****** Object:  StoredProcedure [dbo].[Lica_Insert]    Script Date: 18.6.2017 16:21:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-18
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Lica_Insert] (
	@prezime nvarchar(MAX),
	@ime nvarchar(MAX),
	@zakonskiZastupnik nvarchar(MAX),
	@pravnoLice nvarchar(MAX),
	@adresa nvarchar(MAX),
	@postanskiBroj nvarchar(MAX),
	@grad nvarchar(MAX),
	@drzavaId int,
	@telefon nvarchar(MAX),
	@fax nvarchar(MAX),
	@email nvarchar(MAX),
	@JMBG_IDBroj nvarchar(MAX),
	@biljeske nvarchar(MAX),
	@isMinor bit,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select MAX(Id) From Lica) + 1;

	Insert Into Lica (id, prezime, ime, ZakonskiZastupnik, PravnoLice, Adresa, PostanskiBroj, Grad, DrzavaId, Telefon, Fax, Email, JMBG_IDBroj, Biljeske, IsMinor, created_by, created)
	Values (@id, @prezime, @ime, @zakonskiZastupnik, @pravnoLice, @adresa, @postanskiBroj, @grad, @drzavaId, @telefon, @fax, @email, @JMBG_IDBroj, @biljeske, @isMinor, @userId, GETDATE());

	Select @id;
END
GO






USE [AdvokatDB]
GO
/****** Object:  StoredProcedure [dbo].[Lica_GetAll]    Script Date: 18.6.2017 16:24:18 ******/
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
	@rowCount int
)
AS
BEGIN
	SET NOCOUNT ON;

	Select	Top (@rowCount)
			L.[Id]
			,ISNULL([Prezime], '') As Prezime
			,ISNULL([Ime], '') As Ime
			,ISNULL([ZakonskiZastupnik], '') As ZakonskiZastupnik
			,ISNULL([PravnoLice], '') As PravnoLice
			,ISNULL([Adresa], '') As Adresa
			,ISNULL([PostanskiBroj], '') As PostanskiBroj
			,ISNULL([Grad], '') As Grad
			,ISNULL([DrzavaId], -1) As DrzavaId
			,ISNULL(d.name, '') As DrzavaName
			,ISNULL([Telefon], '') As Telefon
			,ISNULL([Fax], '') As Fax
			,ISNULL(L.[Email], '') As Email
			,IsNULL([JMBG_IDBroj], '') As JMBG_IDBroj
			,IsNULL(Biljeske, '') as Biljeske
			,[IsMinor],
			u.first_name + ' ' + u.last_name As CreatedByName,
			modified As Modified,
			modified_by As ModifiedBy,
			um.first_name + ' ' + um.last_name As ModifiedByName,
			case when Ime Is Not NULL And Prezime Is Not NULL then Ime + ' ' + Prezime else PravnoLice end As Naziv
	FROM	[dbo].[Lica] As L
			Left Join Drzave d ON L.DrzavaId = d.id
			Left Join uUsers u On L.created_by = u.id
			Left Join uUsers um On L.modified_by = um.id
	Where	L.is_deleted = 0
			And (
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
					Or case when Ime Is Not NULL And Prezime Is Not NULL then Ime + ' ' + Prezime else PravnoLice end Like '%' + @filter + '%'
				)
			)
END
GO




USE [AdvokatDB]
GO
/****** Object:  StoredProcedure [dbo].[Lica_Insert]    Script Date: 18.6.2017 16:47:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-18
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Lica_Insert] (
	@prezime nvarchar(MAX),
	@ime nvarchar(MAX),
	@zakonskiZastupnik nvarchar(MAX),
	@pravnoLice nvarchar(MAX),
	@adresa nvarchar(MAX),
	@postanskiBroj nvarchar(MAX),
	@grad nvarchar(MAX),
	@drzavaId int,
	@telefon nvarchar(MAX),
	@fax nvarchar(MAX),
	@email nvarchar(MAX),
	@JMBG_IDBroj nvarchar(MAX),
	@biljeske nvarchar(MAX),
	@isMinor bit,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select MAX(Id) From Lica) + 1;

	Insert Into Lica (id, prezime, ime, ZakonskiZastupnik, PravnoLice, Adresa, PostanskiBroj, Grad, DrzavaId, Telefon, Fax, Email, JMBG_IDBroj, Biljeske, IsMinor, created_by, created, is_deleted)
	Values (@id, @prezime, @ime, @zakonskiZastupnik, @pravnoLice, @adresa, @postanskiBroj, @grad, @drzavaId, @telefon, @fax, @email, @JMBG_IDBroj, @biljeske, @isMinor, @userId, GETDATE(), 0);

	Select @id;
END

GO






USE [AdvokatDB]
GO
/****** Object:  StoredProcedure [dbo].[Lica_GetAll]    Script Date: 18.6.2017 16:48:03 ******/
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
	@rowCount int
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
			case when Ime Is Not NULL And Prezime Is Not NULL then Ime + ' ' + Prezime else PravnoLice end As Naziv
	FROM	[dbo].[Lica] As L
			Left Join Drzave d ON L.DrzavaId = d.id
			Left Join uUsers u On L.created_by = u.id
			Left Join uUsers um On L.modified_by = um.id
	Where	IsNULL(L.is_deleted, 0) = 0
			And (
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
					Or case when Ime Is Not NULL And Prezime Is Not NULL then Ime + ' ' + Prezime else PravnoLice end Like '%' + @filter + '%'
				)
			)
END
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-05
-- Description:	Gets next NasBroj
-- =============================================
CREATE PROCEDURE GetNextNasBroj
AS
BEGIN
	SET NOCOUNT ON;

    Select	IsNULL(MAX(NasBroj), 0) + 1
	From	Predmeti
END
GO




/****** Object:  View [dbo].[vLica]    Script Date: 5.7.2017 17:06:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vLica]
AS
SELECT        Id, CASE WHEN Ime IS NOT NULL AND Prezime IS NOT NULL THEN Prezime + ' ' + Ime ELSE PravnoLice END AS Naziv
FROM            dbo.Lica AS L

GO





/****** Object:  StoredProcedure [dbo].[Lica_GetAll]    Script Date: 5.7.2017 17:07:19 ******/
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
	@rowCount int
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
			case when Ime Is Not NULL And Prezime Is Not NULL then Prezime + ' ' + Ime else PravnoLice end As Naziv
	FROM	[dbo].[Lica] As L
			Left Join Drzave d ON L.DrzavaId = d.id
			Left Join uUsers u On L.created_by = u.id
			Left Join uUsers um On L.modified_by = um.id
	Where	IsNULL(L.is_deleted, 0) = 0
			And (
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
					Or case when Ime Is Not NULL And Prezime Is Not NULL then Ime + ' ' + Prezime else PravnoLice end Like '%' + @filter + '%'
				)
			)
END
GO






Alter Table Lica_Predmet
Add is_nasa_stranka bit null
go
Alter Table Lica_Predmet
Add is_protivna_stranka bit null
go





Update	Lica_Predmet
Set		is_nasa_stranka = case when (select Naziv from vLica where Lica_Predmet.Id = vLica.Id) = (Select StrankaNasa From Predmeti Where Predmeti.Id = Lica_Predmet.PredmetId) then 1 else 0 end
go

Update	Lica_Predmet
Set		is_protivna_stranka = case when (select Naziv from vLica where Lica_Predmet.Id = vLica.Id) = (Select StrankaProtivna From Predmeti Where Predmeti.Id = Lica_Predmet.PredmetId) then 1 else 0 end
go






/****** Object:  StoredProcedure [dbo].[Predmeti_GetAll]    Script Date: 5.7.2017 17:37:08 ******/
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

			,vl_nasa.Naziv as StrankaNasa
			,vl_protivna.Naziv as StrankaProtivna
	From	[dbo].[Predmeti] As p
			Left Join Sudovi s On p.SudId = s.Id
			Left Join KategorijePredmeta kp On p.KategorijaPredmetaId = kp.id
			Left Join Sudije sj On p.SudijaId = sj.id
			Left Join VrstePredmeta vp On p.VrstaPredmetaId = vp.id
			Left Join Uloge u On p.UlogaId = u.id
			Left Join NaciniOkoncanja nok On p.NacinOkoncanjaId = nok.id
			Left Join StanjaPredmeta sp On p.StanjePredmetaId = sp.id

			Left Join Lica_Predmet lp_nasa On p.Id = lp_nasa.PredmetId And lp_nasa.is_nasa_stranka = 1
			Left Join vLica vl_nasa On lp_nasa.Id = vl_nasa.Id
			Left Join Lica_Predmet lp_protivna On p.Id = lp_protivna.PredmetId And lp_protivna.is_protivna_stranka = 1
			Left Join vLica vl_protivna On lp_protivna.Id = vl_protivna.Id
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




/****** Object:  StoredProcedure [dbo].[Lica_Insert]    Script Date: 5.7.2017 17:54:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-18
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Lica_Insert] (
	@prezime nvarchar(MAX),
	@ime nvarchar(MAX),
	@zakonskiZastupnik nvarchar(MAX),
	@pravnoLice nvarchar(MAX),
	@adresa nvarchar(MAX),
	@postanskiBroj nvarchar(MAX),
	@grad nvarchar(MAX),
	@drzavaId int,
	@telefon nvarchar(MAX),
	@fax nvarchar(MAX),
	@email nvarchar(MAX),
	@JMBG_IDBroj nvarchar(MAX),
	@biljeske nvarchar(MAX),
	@isMinor bit,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Id), 0) From Lica) + 1;

	Insert Into Lica (id, prezime, ime, ZakonskiZastupnik, PravnoLice, Adresa, PostanskiBroj, Grad, DrzavaId, Telefon, Fax, Email, JMBG_IDBroj, Biljeske, IsMinor, created_by, created, is_deleted)
	Values (@id, @prezime, @ime, @zakonskiZastupnik, @pravnoLice, @adresa, @postanskiBroj, @grad, @drzavaId, @telefon, @fax, @email, @JMBG_IDBroj, @biljeske, @isMinor, @userId, GETDATE(), 0);

	Select @id;
END
GO








Alter Table Predmeti
Add is_deleted bit
GO

Update Predmeti
Set is_deleted = 0
Go





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-05
-- Description:	Delete case
-- =============================================
CREATE PROCEDURE [dbo].[Predmeti_Delete] (
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	Update	Predmeti
	Set		is_deleted = 1
	Where	id = @id;
END
GO









Alter Table Predmeti Add created_by int FOREIGN KEY REFERENCES uUsers(id)
GO

Alter Table Predmeti Add created datetime
GO

Alter Table Predmeti Add modified_by int FOREIGN KEY REFERENCES uUsers(id)
GO

Alter Table Predmeti Add modified datetime
GO




/****** Object:  StoredProcedure [dbo].[Predmeti_GetAll]    Script Date: 5.7.2017 18:10:50 ******/
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

			,vl_nasa.Naziv as StrankaNasa
			,vl_protivna.Naziv as StrankaProtivna,


			uc.first_name + ' ' + uc.last_name As CreatedByName,
			p.modified As Modified,
			p.modified_by As ModifiedBy,
			um.first_name + ' ' + um.last_name As ModifiedByName
	From	[dbo].[Predmeti] As p
			Left Join Sudovi s On p.SudId = s.Id
			Left Join KategorijePredmeta kp On p.KategorijaPredmetaId = kp.id
			Left Join Sudije sj On p.SudijaId = sj.id
			Left Join VrstePredmeta vp On p.VrstaPredmetaId = vp.id
			Left Join Uloge u On p.UlogaId = u.id
			Left Join NaciniOkoncanja nok On p.NacinOkoncanjaId = nok.id
			Left Join StanjaPredmeta sp On p.StanjePredmetaId = sp.id

			Left Join Lica_Predmet lp_nasa On p.Id = lp_nasa.PredmetId And lp_nasa.is_nasa_stranka = 1
			Left Join vLica vl_nasa On lp_nasa.Id = vl_nasa.Id
			Left Join Lica_Predmet lp_protivna On p.Id = lp_protivna.PredmetId And lp_protivna.is_protivna_stranka = 1
			Left Join vLica vl_protivna On lp_protivna.Id = vl_protivna.Id

			Left Join uUsers uc On p.created_by = uc.id
			Left Join uUsers um On p.modified_by = um.id
	Where	IsNULL(p.is_deleted, 0) = 0
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
				)
			)
	Order By Iniciran Desc
END
GO




/****** Object:  StoredProcedure [dbo].[Predmeti_Insert]    Script Date: 5.7.2017 18:31:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-05
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Predmeti_Insert] (
	@kategorijaPredmetaId int,
	@ulogaId int,
	@privremeniZastupnici bit,
	@brojPredmeta nvarchar(255),
	@sudId int,
	@sudijaId int,
	@vrijednostSpora decimal(19,4),
	@vrstaPredmetaId int,
	@datumStanjaPredmeta datetime,
	@stanjePredmetaId int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Id), 0) From Predmeti) + 1;
	Declare @nasBroj int = (Select IsNULL(MAX(NasBroj), 0) From Predmeti) + 1;

	Insert Into Predmeti (Id, NasBroj, KategorijaPredmetaId, UlogaId, PrivremeniZastupnici, BrojPredmeta, SudID, SudijaId, VrijednostSpora,
		VrstaPredmetaId, DatumStanjaPredmeta, StanjePredmetaId, is_deleted, created, created_by)
	Values (@id, @nasBroj, @kategorijaPredmetaId, @ulogaId, @privremeniZastupnici, @brojPredmeta, @sudId, @sudijaId, @vrijednostSpora,
		@vrstaPredmetaId, @datumStanjaPredmeta, @stanjePredmetaId, 0, GETDATE(), @userId);

	Select @id;
END
GO




/****** Object:  StoredProcedure [dbo].[Predmeti_Update]    Script Date: 5.7.2017 18:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-05
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Predmeti_Update] (
	@kategorijaPredmetaId int,
	@ulogaId int,
	@privremeniZastupnici bit,
	@brojPredmeta nvarchar(255),
	@sudId int,
	@sudijaId int,
	@vrijednostSpora decimal(19,4),
	@vrstaPredmetaId int,
	@datumStanjaPredmeta datetime,
	@stanjePredmetaId int,
	@id int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Update	Predmeti
	Set		KategorijaPredmetaId = @kategorijaPredmetaId,
			UlogaId = @ulogaId,
			PrivremeniZastupnici = @privremeniZastupnici,
			BrojPredmeta = @brojPredmeta,
			SudID = @sudId,
			SudijaId = @sudijaId,
			VrijednostSpora = @vrijednostSpora,
			VrstaPredmetaId = @vrstaPredmetaId,
			DatumStanjaPredmeta = @datumStanjaPredmeta,
			StanjePredmetaId = @stanjePredmetaId,
			modified = GETDATE(),
			modified_by = @userId
	Where	id = @id

END
GO





Insert Into Uloge(name)
select distinct uloga from Lica_Predmet where Uloga not in (select name from uloge)
GO



Alter Table Lica_Predmet
Add UlogaId int FOREIGN KEY REFERENCES Uloge(Id)
GO

Update Lica_Predmet
Set	UlogaId = (Select Id From Uloge Where name = Lica_Predmet.Uloga)
GO

Alter Table Lica_Predmet
Drop Column Uloga
GO





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-08
-- Description:	
-- =============================================
CREATE PROCEDURE LicePredmet_Insert (
	@predmetId int,
	@liceId int,
	@isNasaStranka bit,
	@isProtivnaStranka bit,
	@ulogaId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Lica_PredmetId), 0) From Lica_Predmet) + 1;
	
	Insert Into Lica_Predmet (Lica_PredmetId, Id, PredmetId, is_nasa_stranka, is_protivna_stranka, UlogaId)
	Values (@id, @liceId, @predmetId, @isNasaStranka, @isProtivnaStranka, @ulogaId);

	Select @id;
END
GO





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-08
-- Description:	
-- =============================================
Create PROCEDURE LicePredmet_Delete (
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	Delete From Lica_Predmet Where Lica_PredmetId = @id;
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-08
-- Description:	
-- =============================================
CREATE PROCEDURE LicePredmet_GetForPredmet (
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
			u.name As Uloga,
			case
				when is_nasa_stranka = 1 then 'Naša stranka'
				when is_protivna_stranka = 1 then 'Protivna stranka'
				else ''
			end As GlavnaStranka
	From	Lica_Predmet lp
			Inner Join vLica vl On lp.Id = vl.Id And lp.PredmetId = @predmetId
			Inner Join Uloge u On lp.UlogaId = u.id
END
GO




/****** Object:  StoredProcedure [dbo].[Predmeti_GetAll]    Script Date: 8.7.2017 18:53:22 ******/
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
			,p.[UlogaId]
			,[PrivremeniZastupnici]
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

			,vl_nasa.Naziv as StrankaNasa
			,vl_protivna.Naziv as StrankaProtivna,


			uc.first_name + ' ' + uc.last_name As CreatedByName,
			p.modified As Modified,
			p.modified_by As ModifiedBy,
			um.first_name + ' ' + um.last_name As ModifiedByName
	From	[dbo].[Predmeti] As p
			Left Join Sudovi s On p.SudId = s.Id
			Left Join KategorijePredmeta kp On p.KategorijaPredmetaId = kp.id
			Left Join Sudije sj On p.SudijaId = sj.id
			Left Join VrstePredmeta vp On p.VrstaPredmetaId = vp.id
			Left Join Uloge u On p.UlogaId = u.id
			Left Join NaciniOkoncanja nok On p.NacinOkoncanjaId = nok.id
			Left Join StanjaPredmeta sp On p.StanjePredmetaId = sp.id

			Left Join Lica_Predmet lp_nasa On p.Id = lp_nasa.PredmetId And lp_nasa.is_nasa_stranka = 1
			Left Join vLica vl_nasa On lp_nasa.Id = vl_nasa.Id
			Left Join Lica_Predmet lp_protivna On p.Id = lp_protivna.PredmetId And lp_protivna.is_protivna_stranka = 1
			Left Join vLica vl_protivna On lp_protivna.Id = vl_protivna.Id

			Left Join uUsers uc On p.created_by = uc.id
			Left Join uUsers um On p.modified_by = um.id
	Where	IsNULL(p.is_deleted, 0) = 0
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
				)
			)
	Order By Iniciran Desc
END
GO


/****** Object:  StoredProcedure [dbo].[Predmeti_Insert]    Script Date: 8.7.2017 19:02:05 ******/
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
	@brojPredmeta nvarchar(255),
	@sudId int,
	@sudijaId int,
	@vrijednostSpora decimal(19,4),
	@vrstaPredmetaId int,
	@datumStanjaPredmeta datetime,
	@stanjePredmetaId int,
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
	If @stanjePredmetaId = -1 Set @stanjePredmetaId = NULL;

	Insert Into Predmeti (Id, NasBroj, KategorijaPredmetaId, UlogaId, PrivremeniZastupnici, BrojPredmeta, SudID, SudijaId, VrijednostSpora,
		VrstaPredmetaId, DatumStanjaPredmeta, StanjePredmetaId, is_deleted, created, created_by)
	Values (@id, @nasBroj, @kategorijaPredmetaId, @ulogaId, @privremeniZastupnici, @brojPredmeta, @sudId, @sudijaId, @vrijednostSpora,
		@vrstaPredmetaId, @datumStanjaPredmeta, @stanjePredmetaId, 0, GETDATE(), @userId);

	Select @id;
END
GO



/****** Object:  StoredProcedure [dbo].[Predmeti_Update]    Script Date: 8.7.2017 19:03:43 ******/
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
	@brojPredmeta nvarchar(255),
	@sudId int,
	@sudijaId int,
	@vrijednostSpora decimal(19,4),
	@vrstaPredmetaId int,
	@datumStanjaPredmeta datetime,
	@stanjePredmetaId int,
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
	If @stanjePredmetaId = -1 Set @stanjePredmetaId = NULL;

	Update	Predmeti
	Set		KategorijaPredmetaId = @kategorijaPredmetaId,
			UlogaId = @ulogaId,
			PrivremeniZastupnici = @privremeniZastupnici,
			BrojPredmeta = @brojPredmeta,
			SudID = @sudId,
			SudijaId = @sudijaId,
			VrijednostSpora = @vrijednostSpora,
			VrstaPredmetaId = @vrstaPredmetaId,
			DatumStanjaPredmeta = @datumStanjaPredmeta,
			StanjePredmetaId = @stanjePredmetaId,
			modified = GETDATE(),
			modified_by = @userId
	Where	id = @id

END
GO


/****** Object:  StoredProcedure [dbo].[LicePredmet_GetForPredmet]    Script Date: 8.7.2017 19:07:51 ******/
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
			u.name As Uloga,
			lp.is_nasa_stranka As IsNasaStranka,
			lp.is_protivna_stranka As IsProtivnaStranka,
			case
				when is_nasa_stranka = 1 then 'Naša stranka'
				when is_protivna_stranka = 1 then 'Protivna stranka'
				else ''
			end As GlavnaStranka
	From	Lica_Predmet lp
			Inner Join vLica vl On lp.Id = vl.Id And lp.PredmetId = @predmetId
			Inner Join Uloge u On lp.UlogaId = u.id
END
GO



/****** Object:  StoredProcedure [dbo].[LicePredmet_GetForPredmet]    Script Date: 8.7.2017 19:35:19 ******/
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
			u.name As Uloga,
			lp.is_nasa_stranka As IsNasaStranka,
			lp.is_protivna_stranka As IsProtivnaStranka,
			case
				when is_nasa_stranka = 1 then 'Naša stranka'
				when is_protivna_stranka = 1 then 'Protivna stranka'
				else '-----'
			end As GlavnaStranka
	From	Lica_Predmet lp
			Inner Join vLica vl On lp.Id = vl.Id And lp.PredmetId = @predmetId
			Inner Join Uloge u On lp.UlogaId = u.id
END
GO





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Users_GetAll]
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
			),',') As UserGroupCodes,
			dbo.Trim((
				Select	', ' + ug.name
				From	uUserUserGroups uug
						Inner Join uUserGroups ug On uug.user_group_id = ug.id And uug.user_id = u.id
				For XML Path('')
			),', ') As UserGroupNames
	From	uUsers u
			
END
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-08
-- Description:	
-- =============================================
CREATE PROCEDURE UserGroups_GetAll
AS
BEGIN
	SET NOCOUNT ON;

    Select	id As Id,
			code As Code,
			name as Name
	From	uUserGroups
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[SplitString] 
( 
    @string NVARCHAR(MAX), 
    @delimiter CHAR(1) 
) 
RETURNS @output TABLE(splitdata NVARCHAR(MAX) 
) 
BEGIN 
    DECLARE @start INT, @end INT 
    SELECT @start = 1, @end = CHARINDEX(@delimiter, @string) 
    WHILE @start < LEN(@string) + 1 BEGIN 
        IF @end = 0  
            SET @end = LEN(@string) + 1
       
        INSERT INTO @output (splitdata)  
        VALUES(SUBSTRING(@string, @start, @end - @start)) 
        SET @start = @end + 1 
        SET @end = CHARINDEX(@delimiter, @string, @start)
        
    END 
    RETURN 
END
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-08
-- Description:	Insert user
-- =============================================
CREATE PROCEDURE [dbo].[User_Insert] (
	@email nvarchar(255),
	@firstName nvarchar(MAX),
	@lastName nvarchar(MAX),
	@phone nvarchar(50),
	@userGroupCodes nvarchar(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;

	Insert Into uUsers (email, first_name, last_name, phone)
	Values (@email, @firstName, @lastName, @phone);

	Declare @insertedUserId int = (Select SCOPE_IDENTITY());

	select * from uUserUserGroups

	Insert Into uUserUserGroups
	Select	(Select id From uUserGroups Where code = ss.splitdata),
			@insertedUserId
	From	SplitString(@userGroupCodes, ',') ss
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-08
-- Description:	Insert user
-- =============================================
ALTER PROCEDURE [dbo].[User_Insert] (
	@email nvarchar(255),
	@firstName nvarchar(MAX),
	@lastName nvarchar(MAX),
	@phone nvarchar(50),
	@userGroupCodes nvarchar(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;

	Insert Into uUsers (email, first_name, last_name, phone)
	Values (@email, @firstName, @lastName, @phone);

	Declare @insertedUserId int = (Select SCOPE_IDENTITY());

	Insert Into uUserUserGroups (user_group_id, [user_id])
	Select	(Select id From uUserGroups Where code = ss.splitdata),
			@insertedUserId
	From	SplitString(@userGroupCodes, ',') ss
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	Update user
-- =============================================
CREATE PROCEDURE [dbo].[User_Update] (
	@email nvarchar(255),
	@firstName nvarchar(MAX),
	@lastName nvarchar(MAX),
	@phone nvarchar(50),
	@userGroupCodes nvarchar(MAX),
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	Update	uUsers
	Set		email = @email,
			first_name = @firstName,
			last_name = @lastName,
			phone = @phone
	Where	id = @id

	Delete From uUserUserGroups
	Where [user_id] = @id;

	Insert Into uUserUserGroups (user_group_id, [user_id])
	Select	(Select id From uUserGroups Where code = ss.splitdata),
			@id
	From	SplitString(@userGroupCodes, ',') ss
END
GO



Alter Table uUsers Add is_deleted bit
Go

Update uUsers Set is_deleted = 0
Go



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	Delete user
-- =============================================
CREATE PROCEDURE [dbo].[User_Delete] (
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	Update	uUsers
	Set		is_deleted = 1
	Where	id = @id;
END
GO



/****** Object:  StoredProcedure [dbo].[User_GetByEmail]    Script Date: 9.7.2017 0:31:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[User_GetByEmail] (
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
			And IsNULL(u.is_deleted, 0) = 0
END
GO



/****** Object:  StoredProcedure [dbo].[Users_GetAll]    Script Date: 9.7.2017 0:33:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Users_GetAll]
AS
BEGIN
	SET NOCOUNT ON;

    Select	u.id as Id,
			u.email as Email,
			u.first_name as FirstName,
			u.last_name as LastName,
			u.phone As Phone,
			dbo.Trim((
				Select	',' + ug.code
				From	uUserUserGroups uug
						Inner Join uUserGroups ug On uug.user_group_id = ug.id And uug.user_id = u.id
				For XML Path('')
			),',') As UserGroupCodes,
			dbo.Trim((
				Select	', ' + ug.name
				From	uUserUserGroups uug
						Inner Join uUserGroups ug On uug.user_group_id = ug.id And uug.user_id = u.id
				For XML Path('')
			),', ') As UserGroupNames
	From	uUsers u
	Where	IsNULL(u.is_deleted, 0) = 0	
END
GO



/****** Object:  StoredProcedure [dbo].[Predmeti_GetAll]    Script Date: 9.7.2017 1:02:50 ******/
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
			,p.[UlogaId]
			,[PrivremeniZastupnici]
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

			,IsNULL(p.BrojArhive, '') + '/' + IsNULL(p.BrojArhiveRegistrator, '') As BrojArhiveTotal,

			uc.first_name + ' ' + uc.last_name As CreatedByName,
			p.modified As Modified,
			p.modified_by As ModifiedBy,
			um.first_name + ' ' + um.last_name As ModifiedByName
	From	[dbo].[Predmeti] As p
			Left Join Sudovi s On p.SudId = s.Id
			Left Join KategorijePredmeta kp On p.KategorijaPredmetaId = kp.id
			Left Join Sudije sj On p.SudijaId = sj.id
			Left Join VrstePredmeta vp On p.VrstaPredmetaId = vp.id
			Left Join Uloge u On p.UlogaId = u.id
			Left Join NaciniOkoncanja nok On p.NacinOkoncanjaId = nok.id
			Left Join StanjaPredmeta sp On p.StanjePredmetaId = sp.id

			Left Join Lica_Predmet lp_nasa On p.Id = lp_nasa.PredmetId And lp_nasa.is_nasa_stranka = 1
			Left Join vLica vl_nasa On lp_nasa.Id = vl_nasa.Id
			Left Join Lica_Predmet lp_protivna On p.Id = lp_protivna.PredmetId And lp_protivna.is_protivna_stranka = 1
			Left Join vLica vl_protivna On lp_protivna.Id = vl_protivna.Id

			Left Join uUsers uc On p.created_by = uc.id
			Left Join uUsers um On p.modified_by = um.id
	Where	IsNULL(p.is_deleted, 0) = 0
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
				)
			)
	Order By Iniciran Desc
END
GO



/****** Object:  StoredProcedure [dbo].[Predmeti_Insert]    Script Date: 9.7.2017 1:14:57 ******/
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
	@brojPredmeta nvarchar(255),
	@sudId int,
	@sudijaId int,
	@vrijednostSpora decimal(19,4),
	@vrstaPredmetaId int,
	@datumStanjaPredmeta datetime,
	@stanjePredmetaId int,

	@nacinOkoncanjaId int,
    @uspjeh nvarchar(255),
    @datumArhiviranja datetime,
    @brojArhive nvarchar(255),
	@brojArhiveRegistrator nvarchar(255),
	
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
	If @stanjePredmetaId = -1 Set @stanjePredmetaId = NULL;
	If @nacinOkoncanjaId = -1 Set @nacinOkoncanjaId = NULL;

	Insert Into Predmeti (Id, NasBroj, KategorijaPredmetaId, UlogaId, PrivremeniZastupnici, BrojPredmeta, SudID, SudijaId, VrijednostSpora,
		VrstaPredmetaId, DatumStanjaPredmeta, StanjePredmetaId,
		NacinOkoncanjaId, [Uspjehu Postupku], DatumArhiviranja, BrojArhive, BrojArhiveRegistrator,
		is_deleted, created, created_by)
	Values (@id, @nasBroj, @kategorijaPredmetaId, @ulogaId, @privremeniZastupnici, @brojPredmeta, @sudId, @sudijaId, @vrijednostSpora,
		@vrstaPredmetaId, @datumStanjaPredmeta, @stanjePredmetaId,
		@nacinOkoncanjaId, @uspjeh, @datumArhiviranja, @brojArhive, @brojArhiveRegistrator,
		0, GETDATE(), @userId);

	Select @id;
END
GO



/****** Object:  StoredProcedure [dbo].[Predmeti_Update]    Script Date: 9.7.2017 1:14:59 ******/
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
	@brojPredmeta nvarchar(255),
	@sudId int,
	@sudijaId int,
	@vrijednostSpora decimal(19,4),
	@vrstaPredmetaId int,
	@datumStanjaPredmeta datetime,
	@stanjePredmetaId int,

	@nacinOkoncanjaId int,
    @uspjeh nvarchar(255),
    @datumArhiviranja datetime,
    @brojArhive nvarchar(255),
	@brojArhiveRegistrator nvarchar(255),

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
	If @stanjePredmetaId = -1 Set @stanjePredmetaId = NULL;
	If @nacinOkoncanjaId = -1 Set @nacinOkoncanjaId = NULL;

	Update	Predmeti
	Set		KategorijaPredmetaId = @kategorijaPredmetaId,
			UlogaId = @ulogaId,
			PrivremeniZastupnici = @privremeniZastupnici,
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

			modified = GETDATE(),
			modified_by = @userId
	Where	id = @id

END
GO







/****** Object:  Table [dbo].[cCaseActivities]    Script Date: 9.7.2017 13:39:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[cCaseActivities](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[case_id] [int] NOT NULL,
	[note] [nvarchar](max) NOT NULL,
	[activity_date] [datetime] NOT NULL,
	[created] [datetime] NOT NULL,
	[created_by] [int] NOT NULL,
	[is_deleted] [bit] NOT NULL,
 CONSTRAINT [PK_cCaseActivities] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[cCaseActivities]  WITH CHECK ADD  CONSTRAINT [FK_cCaseActivities_uUsers] FOREIGN KEY([created_by])
REFERENCES [dbo].[uUsers] ([id])
GO

ALTER TABLE [dbo].[cCaseActivities] CHECK CONSTRAINT [FK_cCaseActivities_uUsers]
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	Creates case activity
-- =============================================
CREATE PROCEDURE CaseActivity_Create (
	@caseId int,
	@note nvarchar(MAX),
	@activityDate datetime,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

    Insert Into cCaseActivities(case_id, note, activity_date, created, created_by, is_deleted)
	Values(@caseId, @note, @activityDate, GETDATE(), @userId, 0);

	Select SCOPE_IDENTITY();
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	Delete case activity
-- =============================================
CREATE PROCEDURE CaseActivity_Delete (
	@id bigint
)
AS
BEGIN
	SET NOCOUNT ON;

    Update	cCaseActivities
	Set		is_deleted = 1
	Where	id = @id;
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	Get all case activities for case
-- =============================================
CREATE PROCEDURE [dbo].[CaseActivities_GetForCase] (
	@caseId int
)
AS
BEGIN
	SET NOCOUNT ON;

    Select	ca.id As Id,
			ca.case_id As CaseId,
			ca.note As Note,
			ca.activity_date As ActivityDate,
			ca.created As Created,
			ca.created_by As CreatedBy,
			u.first_name + ' ' + u.last_name As CreatedByName
	From	cCaseActivities ca
			Left Join uUsers u On ca.created_by = u.id
	Where	case_id = @caseId
			And IsNULL(ca.is_deleted, 0) = 0
END
GO




Declare @now datetime = GETDATE();
Insert Into cCaseActivities(case_id, note, activity_date, created, created_by, is_deleted)
Select	id, skontrobiljeska, SkontroDatum, @now, 1, 0
From	predmeti
Where	SkontroBiljeska is not null
GO





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	Get all case activities
-- =============================================
CREATE PROCEDURE [dbo].[CaseActivities_GetAll] (
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

    Select	ca.id As Id,
			ca.case_id As CaseId,
			ca.note As Note,
			ca.activity_date As ActivityDate,
			ca.created As Created,
			ca.created_by As CreatedBy,
			u.first_name + ' ' + u.last_name As CreatedByName
	From	cCaseActivities ca
			Left Join uUsers u On ca.created_by = u.id
	Where	IsNULL(ca.is_deleted, 0) = 0
	Order By ActivityDate Asc
	
END
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	Gets the full name of case
-- =============================================
CREATE FUNCTION Case_GetFullName
(
	@caseId int
)
RETURNS nvarchar(MAX)
AS
BEGIN
	DECLARE @fullName nvarchar(MAX)

	
	Select	@fullName = IsNULL(vln.Naziv, '') + ' - ' + IsNULL(vlp.Naziv, '') + ', ' + IsNULL(vp.name, '')
	From	Predmeti p
			Left Join VrstePredmeta vp On p.VrstaPredmetaId = vp.id And p.Id = @caseId
			Left Join Lica_Predmet lpn On p.Id = lpn.PredmetId And lpn.is_nasa_stranka = 1 And p.Id = @caseId And lpn.PredmetId = @caseId
			Left Join vLica vln On lpn.Id = vln.Id
			Left Join Lica_Predmet lpp On p.Id = lpp.PredmetId And lpp.is_protivna_stranka = 1 And p.Id = @caseId And lpp.PredmetId = @caseId
			Left Join vLica vlp On lpp.Id = vlp.Id
	Where	p.Id = @caseId

	RETURN @fullName

END
GO








SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	Get all case activities
-- =============================================
ALTER PROCEDURE [dbo].[CaseActivities_GetAll] (
	@userId int,
	@filter nvarchar(MAX),
	@rowCount int
)
AS
BEGIN
	SET NOCOUNT ON;

    Select	Top (@rowCount)
			ca.id As Id,
			ca.case_id As CaseId,
			ca.note As Note,
			ca.activity_date As ActivityDate,
			ca.created As Created,
			ca.created_by As CreatedBy,
			u.first_name + ' ' + u.last_name As CreatedByName,

			[dbo].[Case_GetFullName] (ca.case_id) As CaseFullName,
			IsNULL(p.BrojPredmeta, '') As BrojPredmeta,
			IsNULL(kp.name, '') As KategorijaPredmeta
	From	cCaseActivities ca
			Inner Join Predmeti p On ca.case_id = p.Id
			Left Join KategorijePredmeta kp On p.KategorijaPredmetaId = kp.id
			Left Join uUsers u On ca.created_by = u.id
	Where	IsNULL(ca.is_deleted, 0) = 0
			And ca.note Like '%' + @filter + '%'
			And CAST(ca.activity_date as varchar(MAX)) Like '%' + @filter + '%'
			And p.BrojPredmeta Like '%' + @filter + '%'
			And kp.name Like '%' + @filter + '%'
			And [dbo].[Case_GetFullName] (ca.case_id) Like '%' + @filter + '%'
	Order By ActivityDate Asc
	
END
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	Get all case activities for case
-- =============================================
ALTER PROCEDURE [dbo].[CaseActivities_GetForCase] (
	@caseId int
)
AS
BEGIN
	SET NOCOUNT ON;

    Select	ca.id As Id,
			ca.case_id As CaseId,
			ca.note As Note,
			ca.activity_date As ActivityDate,
			ca.created As Created,
			ca.created_by As CreatedBy,
			u.first_name + ' ' + u.last_name As CreatedByName,

			[dbo].[Case_GetFullName] (ca.case_id) As CaseFullName,
			IsNULL(p.BrojPredmeta, '') As BrojPredmeta,
			IsNULL(kp.name, '') As KategorijaPredmeta
	From	cCaseActivities ca
			Inner Join Predmeti p On ca.case_id = p.Id And ca.case_id = @caseId
			Left Join KategorijePredmeta kp On p.KategorijaPredmetaId = kp.id
			Left Join uUsers u On ca.created_by = u.id
	Where	case_id = @caseId
			And IsNULL(ca.is_deleted, 0) = 0
END
GO





/****** Object:  StoredProcedure [dbo].[CaseActivities_GetAll]    Script Date: 9.7.2017 14:51:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	Get all case activities
-- =============================================
ALTER PROCEDURE [dbo].[CaseActivities_GetAll] (
	@userId int,
	@filter nvarchar(MAX),
	@rowCount int
)
AS
BEGIN
	SET NOCOUNT ON;

    Select	Top (@rowCount)
			ca.id As Id,
			ca.case_id As CaseId,
			ca.note As Note,
			ca.activity_date As ActivityDate,
			ca.created As Created,
			ca.created_by As CreatedBy,
			u.first_name + ' ' + u.last_name As CreatedByName,

			[dbo].[Case_GetFullName] (ca.case_id) As CaseFullName,
			IsNULL(p.BrojPredmeta, '') As BrojPredmeta,
			IsNULL(kp.name, '') As KategorijaPredmeta
	From	cCaseActivities ca
			Inner Join Predmeti p On ca.case_id = p.Id
			Left Join KategorijePredmeta kp On p.KategorijaPredmetaId = kp.id
			Left Join uUsers u On ca.created_by = u.id
	Where	IsNULL(ca.is_deleted, 0) = 0
			And (
				ca.note Like '%' + @filter + '%'
				Or CAST(ca.activity_date as varchar(MAX)) Like '%' + @filter + '%'
				Or p.BrojPredmeta Like '%' + @filter + '%'
				Or kp.name Like '%' + @filter + '%'
				Or [dbo].[Case_GetFullName] (ca.case_id) Like '%' + @filter + '%'
			)
	Order By ActivityDate Asc
	
END
GO





/****** Object:  StoredProcedure [dbo].[User_Insert]    Script Date: 9.7.2017 17:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-08
-- Description:	Insert user
-- =============================================
ALTER PROCEDURE [dbo].[User_Insert] (
	@email nvarchar(255),
	@firstName nvarchar(MAX),
	@lastName nvarchar(MAX),
	@phone nvarchar(50),
	@userGroupCodes nvarchar(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;

	If Not Exists (Select 1 From uUsers Where email = @email)
	Begin

		Insert Into uUsers (email, first_name, last_name, phone, is_deleted)
		Values (@email, @firstName, @lastName, @phone, 0);

		Declare @insertedUserId int = (Select SCOPE_IDENTITY());

		Insert Into uUserUserGroups (user_group_id, [user_id])
		Select	(Select id From uUserGroups Where code = ss.splitdata),
				@insertedUserId
		From	SplitString(@userGroupCodes, ',') ss

		Select @insertedUserId;

	End
END
GO





Alter Table Biljeske
Add created_by int foreign key references uUsers(id)
GO






--------------- NAPRAVITI KORISNIKE MENSUD, MERSAD, JASMINA prije ovoga ispod!

Update	Biljeske
Set		created_by = (Select u.id From uUsers u Where u.first_name + ' ' + u.last_name = Biljeske.IzradjenaOd And IsNULL(is_deleted, 0) = 0)
Go




Alter Table Biljeske
Drop Column IzradjenaOd
Go







SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Notes_GetForCase] (
	@caseId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Select	b.Id As Id,
			b.PredmetId As CaseId,
			b.Datum As NoteDate,
			b.Biljeska As NoteText,
			b.created_by As CreatedBy,
			u.first_name + ' ' + u.last_name As CreatedByName
	From	Biljeske b
			Left Join uUsers u On b.created_by = u.id
	Where	b.PredmetId = @caseId
END
GO




/****** Object:  StoredProcedure [dbo].[Predmeti_Insert]    Script Date: 9.7.2017 19:35:27 ******/
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
	@brojPredmeta nvarchar(255),
	@sudId int,
	@sudijaId int,
	@vrijednostSpora decimal(19,4),
	@vrstaPredmetaId int,
	@datumStanjaPredmeta datetime,
	@stanjePredmetaId int,

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
	If @stanjePredmetaId = -1 Set @stanjePredmetaId = NULL;
	If @nacinOkoncanjaId = -1 Set @nacinOkoncanjaId = NULL;

	Insert Into Predmeti (Id, NasBroj, KategorijaPredmetaId, UlogaId, PrivremeniZastupnici, BrojPredmeta, SudID, SudijaId, VrijednostSpora,
		VrstaPredmetaId, DatumStanjaPredmeta, StanjePredmetaId,
		NacinOkoncanjaId, [Uspjehu Postupku], DatumArhiviranja, BrojArhive, BrojArhiveRegistrator,
		PravniOsnov,
		is_deleted, created, created_by)
	Values (@id, @nasBroj, @kategorijaPredmetaId, @ulogaId, @privremeniZastupnici, @brojPredmeta, @sudId, @sudijaId, @vrijednostSpora,
		@vrstaPredmetaId, @datumStanjaPredmeta, @stanjePredmetaId,
		@nacinOkoncanjaId, @uspjeh, @datumArhiviranja, @brojArhive, @brojArhiveRegistrator,
		@pravniOsnov,
		0, GETDATE(), @userId);

	Select @id;
END
GO



/****** Object:  StoredProcedure [dbo].[Predmeti_Update]    Script Date: 9.7.2017 19:36:16 ******/
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
	@brojPredmeta nvarchar(255),
	@sudId int,
	@sudijaId int,
	@vrijednostSpora decimal(19,4),
	@vrstaPredmetaId int,
	@datumStanjaPredmeta datetime,
	@stanjePredmetaId int,

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
	If @stanjePredmetaId = -1 Set @stanjePredmetaId = NULL;
	If @nacinOkoncanjaId = -1 Set @nacinOkoncanjaId = NULL;

	Update	Predmeti
	Set		KategorijaPredmetaId = @kategorijaPredmetaId,
			UlogaId = @ulogaId,
			PrivremeniZastupnici = @privremeniZastupnici,
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




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Note_Insert] (
	@caseId int,
	@noteDate datetime,
	@noteText nvarchar(MAX),
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Insert Into Biljeske (PredmetId, Datum, Biljeska, created_by)
	Values (@caseId, @noteDate, @noteText, @userId);

	Select SCOPE_IDENTITY();
END
GO





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Note_Delete] (
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	Delete From Biljeske
	Where id = @id;
END
GO





/****** Object:  StoredProcedure [dbo].[Note_Insert]    Script Date: 9.7.2017 20:14:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Note_Insert] (
	@caseId int,
	@noteDate datetime,
	@noteText nvarchar(MAX),
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select MAX(Id) From Biljeske) + 1;

	Insert Into Biljeske (Id, PredmetId, Datum, Biljeska, created_by)
	Values (@id, @caseId, @noteDate, @noteText, @userId);

	Select SCOPE_IDENTITY();
END
GO






Update Takse Set PlacenoOd = 'ADVOKAT' Where PlacenoOd = 'ADVOKATs'
GO





CREATE TABLE [dbo].VrsteTroskova(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_VrsteTroskova] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO





Insert Into VrsteTroskova(name)
select distinct Taksa from Takse where Taksa Is Not NULL
GO

Alter Table Takse
Add VrstaTroskaId int FOREIGN KEY REFERENCES VrsteTroskova(Id)
GO

Update Takse
Set	VrstaTroskaId = (Select Id From VrsteTroskova Where name = Takse.Taksa)
GO

Alter Table Takse
Drop Column Taksa
GO









/****** Object:  StoredProcedure [dbo].[Note_Insert]    Script Date: 9.7.2017 20:36:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Note_Insert] (
	@caseId int,
	@noteDate datetime,
	@noteText nvarchar(MAX),
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select MAX(Id) From Biljeske) + 1;

	Insert Into Biljeske (Id, PredmetId, Datum, Biljeska, created_by)
	Values (@id, @caseId, @noteDate, @noteText, @userId);

	Select @id;
END
GO






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Expense_Insert] (
	@caseId int,
	@amount decimal(19,4),
	@expenseDate datetime,
	@paidBy nvarchar(50),
	@vrstaTroskaId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select MAX(Id) From Takse) + 1;

	Insert Into Takse (Id, PredmetID, Iznos, DatumPlacanja, PlacenoOd, VrstaTroskaId)
	Values (@id, @caseId, @amount, @expenseDate, @paidBy, @vrstaTroskaId);

	Select @id;
END
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Expense_Delete] (
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	Delete From Takse
	Where id = @id;
END
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Expenses_GetForCase] (
	@caseId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Select	t.Id,
			t.PredmetID As CaseId,
			t.Iznos As Amount,
			t.DatumPlacanja As ExpenseDate,
			t.PlacenoOd As PaidBy,
			t.VrstaTroskaId,
			IsNULL(vt.name, '') As VrstaTroskaName 
	From	Takse t
			Left Join VrsteTroskova vt On t.VrstaTroskaId = vt.id And t.PredmetID = @caseId
	Where	t.PredmetID = @caseId
END
GO





CREATE TABLE [dbo].VrsteRadnji(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_VrsteRadnji] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


Insert Into VrsteRadnji(name)
select distinct SUBSTRING(Radnja, 1, CHARINDEX('#', Radnja, 1) - 1)
from Radnje where Radnja is not null
GO

Alter Table Radnje
Add VrstaRadnjeId int FOREIGN KEY REFERENCES VrsteRadnji(Id)
GO

Update Radnje
Set	VrstaRadnjeId = (Select Id From VrsteRadnji Where name = SUBSTRING(Radnje.Radnja, 1, CHARINDEX('#', Radnje.Radnja, 1) - 1))
GO






Alter Table Radnje
Add RadnjuObavioId int foreign key references uUsers(id)
Go

Update Radnje
set RadnjuObavioId = (Select id From uUsers where Radnje.RadnjuObavio = first_name + ' ' + last_name and isnull(is_deleted, 0) = 0)
GO

alter table Radnje
drop column radnjuobavio
go








CREATE TABLE [dbo].NaciniObavljanjaRadnje(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_NaciniObavljanjaRadnje] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


Insert Into NaciniObavljanjaRadnje(name)
select distinct NacinObavljanja from Radnje where NacinObavljanja is not null
GO

Alter Table Radnje
Add NacinObavljanjaId int FOREIGN KEY REFERENCES NaciniObavljanjaRadnje(Id)
GO

Update Radnje
Set	NacinObavljanjaId = (Select Id From NaciniObavljanjaRadnje Where name = Radnje.NacinObavljanja)
GO

Alter Table Radnje
Drop Column NacinObavljanja
GO









SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-16
-- Description:	
-- =============================================
CREATE PROCEDURE Radnje_GetForCase (
	@caseId int
)
AS
BEGIN
	SET NOCOUNT ON;

    Select	r.Id,
			r.PredmetId,
			r.Datum as DatumRadnje,
			r.Troskovi,
			r.Biljeske,
			r.VrstaRadnjeId,
			IsNULL(vr.name, '') As VrstaRadnjeName,
			r.DatumPrijema,
			r.VrijednostRadnje,
			r.RadnjuObavioId,
			IsNULL(u.first_name + ' ' + u.last_name, '') As RadnjuObavioName,
			r.NacinObavljanjaId,
			IsNULL(nor.name, '') As NacinObavljanjaName
	From	Radnje r
			Left Join VrsteRadnji vr On r.VrstaRadnjeId = vr.id And r.PredmetId = @caseId
			Left Join uUsers u On r.RadnjuObavioId = u.id
			Left Join NaciniObavljanjaRadnje nor On r.NacinObavljanjaId = nor.id
	Where	r.PredmetId = @caseId
END
GO






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-16
-- Description:	
-- =============================================
CREATE PROCEDURE Radnja_Insert (
	@caseId int,
	@datumRadnje datetime,
	@troskovi nvarchar(255),
	@biljeske nvarchar(MAX),
	@vrstaRadnjeId int,
	@datumPrijema datetime,
	@vrijednostRadnje decimal(19,4),
	@radnjuObavioId int,
	@nacinObavljanjaId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Id), 0) From Radnje) + 1;

    Insert Into Radnje (PredmetId, Radnja, Datum, Troskovi, Biljeske, DatumPrijema, VrijednostRadnje, VrstaRadnjeId, RadnjuObavioId, NacinObavljanjaId)
	Values (@caseId, '', @datumRadnje, @troskovi, @biljeske, @datumPrijema, @vrijednostRadnje, @vrstaRadnjeId, @radnjuObavioId, @nacinObavljanjaId);

	Select @id;
END
GO






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-16
-- Description:	
-- =============================================
CREATE PROCEDURE Radnja_Update (
	@caseId int,
	@datumRadnje datetime,
	@troskovi nvarchar(255),
	@biljeske nvarchar(MAX),
	@vrstaRadnjeId int,
	@datumPrijema datetime,
	@vrijednostRadnje decimal(19,4),
	@radnjuObavioId int,
	@nacinObavljanjaId int,
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

    Update	Radnje
	Set		PredmetId = @caseId,
			Datum = @datumRadnje,
			Troskovi = @troskovi,
			Biljeske = @biljeske,
			DatumPrijema = @datumPrijema,
			VrijednostRadnje = @vrijednostRadnje,
			VrstaRadnjeId = @vrstaRadnjeId,
			RadnjuObavioId = @radnjuObavioId,
			NacinObavljanjaId = @nacinObavljanjaId
	Where	id = @id

END
GO







Alter Table Radnje
Add is_deleted bit
GO

Update Radnje
Set is_deleted = 0
GO







/****** Object:  StoredProcedure [dbo].[Radnje_GetForCase]    Script Date: 16.7.2017 21:25:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-16
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Radnje_GetForCase] (
	@caseId int
)
AS
BEGIN
	SET NOCOUNT ON;

    Select	r.Id,
			r.PredmetId,
			r.Datum as DatumRadnje,
			r.Troskovi,
			r.Biljeske,
			r.VrstaRadnjeId,
			IsNULL(vr.name, '') As VrstaRadnjeName,
			r.DatumPrijema,
			r.VrijednostRadnje,
			r.RadnjuObavioId,
			IsNULL(u.first_name + ' ' + u.last_name, '') As RadnjuObavioName,
			r.NacinObavljanjaId,
			IsNULL(nor.name, '') As NacinObavljanjaName
	From	Radnje r
			Left Join VrsteRadnji vr On r.VrstaRadnjeId = vr.id And r.PredmetId = @caseId And IsNULL(r.is_deleted, 0) = 0
			Left Join uUsers u On r.RadnjuObavioId = u.id
			Left Join NaciniObavljanjaRadnje nor On r.NacinObavljanjaId = nor.id
	Where	r.PredmetId = @caseId
			And IsNULL(r.is_deleted, 0) = 0
END
GO




/****** Object:  StoredProcedure [dbo].[Radnja_Insert]    Script Date: 16.7.2017 21:26:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-16
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Radnja_Insert] (
	@caseId int,
	@datumRadnje datetime,
	@troskovi nvarchar(255),
	@biljeske nvarchar(MAX),
	@vrstaRadnjeId int,
	@datumPrijema datetime,
	@vrijednostRadnje decimal(19,4),
	@radnjuObavioId int,
	@nacinObavljanjaId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Id), 0) From Radnje) + 1;

    Insert Into Radnje (PredmetId, Radnja, Datum, Troskovi, Biljeske, DatumPrijema, VrijednostRadnje, VrstaRadnjeId, RadnjuObavioId, NacinObavljanjaId, is_deleted)
	Values (@caseId, '', @datumRadnje, @troskovi, @biljeske, @datumPrijema, @vrijednostRadnje, @vrstaRadnjeId, @radnjuObavioId, @nacinObavljanjaId, 0);

	Select @id;
END
GO







SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-16
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Radnja_Delete] (
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	Update	Radnje
	Set		is_deleted = 1
	Where	id = @id;
END
GO





/****** Object:  StoredProcedure [dbo].[Radnja_Insert]    Script Date: 16.7.2017 21:38:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-16
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Radnja_Insert] (
	@caseId int,
	@datumRadnje datetime,
	@troskovi nvarchar(255),
	@biljeske nvarchar(MAX),
	@vrstaRadnjeId int,
	@datumPrijema datetime,
	@vrijednostRadnje decimal(19,4),
	@radnjuObavioId int,
	@nacinObavljanjaId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Id), 0) From Radnje) + 1;

	If @vrstaRadnjeId = -1
		Set @vrstaRadnjeId = NULL;

    Insert Into Radnje (PredmetId, Radnja, Datum, Troskovi, Biljeske, DatumPrijema, VrijednostRadnje, VrstaRadnjeId, RadnjuObavioId, NacinObavljanjaId, is_deleted)
	Values (@caseId, '', @datumRadnje, @troskovi, @biljeske, @datumPrijema, @vrijednostRadnje, @vrstaRadnjeId, @radnjuObavioId, @nacinObavljanjaId, 0);

	Select @id;
END
GO



/****** Object:  StoredProcedure [dbo].[Radnja_Update]    Script Date: 16.7.2017 21:38:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-16
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Radnja_Update] (
	@caseId int,
	@datumRadnje datetime,
	@troskovi nvarchar(255),
	@biljeske nvarchar(MAX),
	@vrstaRadnjeId int,
	@datumPrijema datetime,
	@vrijednostRadnje decimal(19,4),
	@radnjuObavioId int,
	@nacinObavljanjaId int,
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	If @vrstaRadnjeId = -1
		Set @vrstaRadnjeId = NULL;

    Update	Radnje
	Set		PredmetId = @caseId,
			Datum = @datumRadnje,
			Troskovi = @troskovi,
			Biljeske = @biljeske,
			DatumPrijema = @datumPrijema,
			VrijednostRadnje = @vrijednostRadnje,
			VrstaRadnjeId = @vrstaRadnjeId,
			RadnjuObavioId = @radnjuObavioId,
			NacinObavljanjaId = @nacinObavljanjaId
	Where	id = @id

END
GO







/****** Object:  StoredProcedure [dbo].[CaseActivities_GetAll]    Script Date: 16.7.2017 22:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	Get all case activities
-- =============================================
ALTER PROCEDURE [dbo].[CaseActivities_GetAll] (
	@userId int,
	@filter nvarchar(MAX),
	@rowCount int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @nowNoTime datetime = DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0);

    Select	Top (@rowCount)
			ca.id As Id,
			ca.case_id As CaseId,
			ca.note As Note,
			ca.activity_date As ActivityDate,
			ca.created As Created,
			ca.created_by As CreatedBy,
			u.first_name + ' ' + u.last_name As CreatedByName,

			[dbo].[Case_GetFullName] (ca.case_id) As CaseFullName,
			IsNULL(p.BrojPredmeta, '') As BrojPredmeta,
			IsNULL(kp.name, '') As KategorijaPredmeta
	From	cCaseActivities ca
			Inner Join Predmeti p On ca.case_id = p.Id
			Left Join KategorijePredmeta kp On p.KategorijaPredmetaId = kp.id
			Left Join uUsers u On ca.created_by = u.id
	Where	IsNULL(ca.is_deleted, 0) = 0
			And ca.activity_date >= @nowNoTime
			And (
				ca.note Like '%' + @filter + '%'
				Or CAST(ca.activity_date as varchar(MAX)) Like '%' + @filter + '%'
				Or p.BrojPredmeta Like '%' + @filter + '%'
				Or kp.name Like '%' + @filter + '%'
				Or [dbo].[Case_GetFullName] (ca.case_id) Like '%' + @filter + '%'
			)
	Order By ActivityDate Asc
	
END
GO





/****** Object:  StoredProcedure [dbo].[Radnje_GetAll]    Script Date: 16.7.2017 22:39:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-16
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Radnje_GetAll] (
	@userId int,
	@filter nvarchar(MAX),
	@rowCount int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @nowNoTime datetime = DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0);

    Select	r.Id,
			r.PredmetId,
			r.Datum as DatumRadnje,
			r.Troskovi,
			r.Biljeske,
			r.VrstaRadnjeId,
			IsNULL(vr.name, '') As VrstaRadnjeName,
			r.DatumPrijema,
			r.VrijednostRadnje,
			r.RadnjuObavioId,
			IsNULL(u.first_name + ' ' + u.last_name, '') As RadnjuObavioName,
			r.NacinObavljanjaId,
			IsNULL(nor.name, '') As NacinObavljanjaName,
			[dbo].[Case_GetFullName] (r.PredmetId) As CaseFullName,
			p.NasBroj As CaseNasBroj
	From	Radnje r
			Inner Join Predmeti p On r.PredmetId = p.Id And IsNULL(r.is_deleted, 0) = 0
			Left Join VrsteRadnji vr On r.VrstaRadnjeId = vr.id 
			Left Join uUsers u On r.RadnjuObavioId = u.id
			Left Join NaciniObavljanjaRadnje nor On r.NacinObavljanjaId = nor.id
	Where	IsNULL(r.is_deleted, 0) = 0
			And r.Datum >= @nowNoTime
			And (
				r.Troskovi Like '%' + @filter + '%'
				Or r.Biljeske Like '%' + @filter + '%'
				Or CAST(r.Datum as varchar(MAX)) Like '%' + @filter + '%'
				Or p.BrojPredmeta Like '%' + @filter + '%'
				Or p.NasBroj Like '%' + @filter + '%'
				Or vr.name Like '%' + @filter + '%'
				Or [dbo].[Case_GetFullName] (r.PredmetId) Like '%' + @filter + '%'
			)
	Order By r.Datum Asc
END
GO




/****** Object:  StoredProcedure [dbo].[Radnja_Insert]    Script Date: 16.7.2017 22:43:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-16
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Radnja_Insert] (
	@caseId int,
	@datumRadnje datetime,
	@troskovi nvarchar(255),
	@biljeske nvarchar(MAX),
	@vrstaRadnjeId int,
	@datumPrijema datetime,
	@vrijednostRadnje decimal(19,4),
	@radnjuObavioId int,
	@nacinObavljanjaId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Id), 0) From Radnje) + 1;

	If @vrstaRadnjeId = -1
		Set @vrstaRadnjeId = NULL;

    Insert Into Radnje (id, PredmetId, Radnja, Datum, Troskovi, Biljeske, DatumPrijema, VrijednostRadnje, VrstaRadnjeId, RadnjuObavioId, NacinObavljanjaId, is_deleted)
	Values (@id, @caseId, '', @datumRadnje, @troskovi, @biljeske, @datumPrijema, @vrijednostRadnje, @vrstaRadnjeId, @radnjuObavioId, @nacinObavljanjaId, 0);

	Select @id;
END
GO






/****** Object:  StoredProcedure [dbo].[CaseActivities_GetAll]    Script Date: 16.7.2017 23:34:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	Get all case activities
-- =============================================
ALTER PROCEDURE [dbo].[CaseActivities_GetAll] (
	@userId int,
	@filter nvarchar(MAX),
	@rowCount int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @nowNoTime datetime = DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0);

    Select	Top (@rowCount)
			ca.id As Id,
			ca.case_id As CaseId,
			ca.note As Note,
			ca.activity_date As ActivityDate,
			ca.created As Created,
			ca.created_by As CreatedBy,
			u.first_name + ' ' + u.last_name As CreatedByName,

			[dbo].[Case_GetFullName] (ca.case_id) As CaseFullName,
			IsNULL(p.BrojPredmeta, '') As BrojPredmeta,
			IsNULL(kp.name, '') As KategorijaPredmeta
	From	cCaseActivities ca
			Inner Join Predmeti p On ca.case_id = p.Id
			Left Join KategorijePredmeta kp On p.KategorijaPredmetaId = kp.id
			Left Join uUsers u On ca.created_by = u.id
	Where	IsNULL(ca.is_deleted, 0) = 0
			And (
				ca.note Like '%' + @filter + '%'
				Or CAST(ca.activity_date as varchar(MAX)) Like '%' + @filter + '%'
				Or p.BrojPredmeta Like '%' + @filter + '%'
				Or kp.name Like '%' + @filter + '%'
				Or [dbo].[Case_GetFullName] (ca.case_id) Like '%' + @filter + '%'
			)
	Order By ActivityDate Asc
	
END
GO




/****** Object:  UserDefinedFunction [dbo].[Case_GetFullName]    Script Date: 16.7.2017 23:36:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
			Left Join Lica_Predmet lpn On p.Id = lpn.PredmetId And lpn.is_nasa_stranka = 1 And p.Id = @caseId And lpn.PredmetId = @caseId
			Left Join vLica vln On lpn.Id = vln.Id
			Left Join Lica_Predmet lpp On p.Id = lpp.PredmetId And lpp.is_protivna_stranka = 1 And p.Id = @caseId And lpp.PredmetId = @caseId
			Left Join vLica vlp On lpp.Id = vlp.Id
	Where	p.Id = @caseId

	RETURN @fullName

END
GO







Alter Table cCaseActivities
Add for_all_users bit
GO


Update cCaseActivities
Set for_all_users = 1
Go









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
	@forAllUsers bit,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

    Insert Into cCaseActivities(case_id, note, activity_date, for_all_users, created, created_by, is_deleted)
	Values(@caseId, @note, @activityDate, @forAllUsers, GETDATE(), @userId, 0);

	Select SCOPE_IDENTITY();
END
GO






/****** Object:  StoredProcedure [dbo].[CaseActivities_GetForCase]    Script Date: 17.7.2017 22:07:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	Get all case activities for case
-- =============================================
ALTER PROCEDURE [dbo].[CaseActivities_GetForCase] (
	@caseId int
)
AS
BEGIN
	SET NOCOUNT ON;

    Select	ca.id As Id,
			ca.case_id As CaseId,
			ca.note As Note,
			ca.activity_date As ActivityDate,
			ca.created As Created,
			ca.created_by As CreatedBy,
			u.first_name + ' ' + u.last_name As CreatedByName,
			ca.for_all_users As ForAllUsers,

			[dbo].[Case_GetFullName] (ca.case_id) As CaseFullName,
			IsNULL(p.BrojPredmeta, '') As BrojPredmeta,
			IsNULL(kp.name, '') As KategorijaPredmeta
	From	cCaseActivities ca
			Inner Join Predmeti p On ca.case_id = p.Id And ca.case_id = @caseId
			Left Join KategorijePredmeta kp On p.KategorijaPredmetaId = kp.id
			Left Join uUsers u On ca.created_by = u.id
	Where	case_id = @caseId
			And IsNULL(ca.is_deleted, 0) = 0
END
GO




/****** Object:  StoredProcedure [dbo].[CaseActivities_GetAll]    Script Date: 17.7.2017 22:08:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	Get all case activities
-- =============================================
ALTER PROCEDURE [dbo].[CaseActivities_GetAll] (
	@userId int,
	@filter nvarchar(MAX),
	@rowCount int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @nowNoTime datetime = DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0);

    Select	Top (@rowCount)
			ca.id As Id,
			ca.case_id As CaseId,
			ca.note As Note,
			ca.activity_date As ActivityDate,
			ca.created As Created,
			ca.created_by As CreatedBy,
			u.first_name + ' ' + u.last_name As CreatedByName,
			ca.for_all_users As ForAllUsers,

			[dbo].[Case_GetFullName] (ca.case_id) As CaseFullName,
			IsNULL(p.BrojPredmeta, '') As BrojPredmeta,
			IsNULL(kp.name, '') As KategorijaPredmeta
	From	cCaseActivities ca
			Inner Join Predmeti p On ca.case_id = p.Id
			Left Join KategorijePredmeta kp On p.KategorijaPredmetaId = kp.id
			Left Join uUsers u On ca.created_by = u.id
	Where	IsNULL(ca.is_deleted, 0) = 0
			And (ca.created_by = @userId Or ca.for_all_users = 1)
			And (
				ca.note Like '%' + @filter + '%'
				Or CAST(ca.activity_date as varchar(MAX)) Like '%' + @filter + '%'
				Or p.BrojPredmeta Like '%' + @filter + '%'
				Or kp.name Like '%' + @filter + '%'
				Or [dbo].[Case_GetFullName] (ca.case_id) Like '%' + @filter + '%'
			)
	Order By ActivityDate Asc
	
END
GO





