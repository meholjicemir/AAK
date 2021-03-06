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



-- COPY DATA FROM ACCESS TO SQL TABLES

--delete from predmeti where predmetid is null
--delete from dokumenti where id is null
--delete from lica where id is null
--delete from radnje where id is null






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











-- !!!!!!!!!!!! RENAME "PredmetiId" column to "Id" in table "Predmeti"



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
Set	VrstaPredmetaId = (Select Id From VrstePredmeta Where name = Predmeti.VrstaPredmeta)
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



--!!!! CONSTRAINT names need updating below:

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




/****** Object:  View [dbo].[vLica]    Script Date: 1.11.2017 23:56:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [dbo].[vLica]
AS
	SELECT	Id,
			CASE WHEN IsNULL(Ime, '') <> '' AND IsNULL(Prezime, '') <> '' THEN Prezime + ' ' + Ime ELSE PravnoLice END AS Naziv,
			Adresa,
			PostanskiBroj,
			Grad,
			JMBG_IDBroj
	FROM	dbo.Lica AS L

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





Insert Into uUsers(email, first_name, last_name, phone, is_deleted)
Values('meholjic.emir@gmail.com', 'Emir', N'Meholjić', '061505994', 0)
Go



Alter Table cCaseActivities
Alter Column activity_date datetime null
Go




Declare @now datetime = GETDATE();
Insert Into cCaseActivities(case_id, note, activity_date, created, created_by, is_deleted)
Select	id, skontrobiljeska, SkontroDatum, @now, 1, 0
From	predmeti
Where	IsNULL(SkontroBiljeska, '') <> ''
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

Insert Into uUsers(email, first_name, last_name, phone, is_deleted)
Values
('', 'Mensud', N'Đonko', '', 0),
('', 'Mersad', N'Đonko', '', 0),
('', 'Jasmina', N'Đonko', '', 0)
Go





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


delete from radnje where radnja = ''
go



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





/****** Object:  StoredProcedure [dbo].[Predmeti_GetAll]    Script Date: 25.7.2017 16:18:06 ******/
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
				(p.NasBroj = @filterNasBroj)
				Or (
					@filterNasBroj Is NULL
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
END
GO




/****** Object:  StoredProcedure [dbo].[LicePredmet_Insert]    Script Date: 1.8.2017 23:02:17 ******/
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
	
	Insert Into Lica_Predmet (Lica_PredmetId, Id, PredmetId, is_nasa_stranka, is_protivna_stranka, UlogaId, Broj)
	Values (@id, @liceId, @predmetId, @isNasaStranka, @isProtivnaStranka, @ulogaId, @broj);

	Select @id;
END
GO




/****** Object:  StoredProcedure [dbo].[LicePredmet_GetForPredmet]    Script Date: 1.8.2017 23:02:20 ******/
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
			Inner Join vLica vl On lp.Id = vl.Id And lp.PredmetId = @predmetId
			Inner Join Uloge u On lp.UlogaId = u.id
END
GO





/****** Object:  StoredProcedure [dbo].[Predmeti_Insert]    Script Date: 1.8.2017 23:42:07 ******/
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




/****** Object:  StoredProcedure [dbo].[Predmeti_Update]    Script Date: 1.8.2017 23:42:09 ******/
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





/****** Object:  StoredProcedure [dbo].[CodeTable_GetData]    Script Date: 1.8.2017 23:52:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-10
-- Description:	Get data from code table
-- =============================================
ALTER PROCEDURE [dbo].[CodeTable_GetData] (
	@tableName varchar(255),
	@columnName varchar(255),
	@filter nvarchar(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;

    EXEC('SELECT Id, ' + @columnName + ' AS Name FROM ' + @tableName + ' WHERE ' + @columnName + ' LIKE ''%' + @filter + '%'' ORDER BY 2 ASC');
END
GO




Alter Table uUsers
Add google_drive_local_folder_path nvarchar(MAX)
GO



/****** Object:  StoredProcedure [dbo].[User_Insert]    Script Date: 1.8.2017 23:58:13 ******/
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
	@userGroupCodes nvarchar(MAX),
	@googleDriveLocalFolderPath nvarchar(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;

	If Not Exists (Select 1 From uUsers Where email = @email)
	Begin

		Insert Into uUsers (email, first_name, last_name, phone, google_drive_local_folder_path, is_deleted)
		Values (@email, @firstName, @lastName, @phone, @googleDriveLocalFolderPath, 0);

		Declare @insertedUserId int = (Select SCOPE_IDENTITY());

		Insert Into uUserUserGroups (user_group_id, [user_id])
		Select	(Select id From uUserGroups Where code = ss.splitdata),
				@insertedUserId
		From	SplitString(@userGroupCodes, ',') ss

		Select @insertedUserId;

	End
END
GO




/****** Object:  StoredProcedure [dbo].[User_Update]    Script Date: 1.8.2017 23:58:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-09
-- Description:	Update user
-- =============================================
ALTER PROCEDURE [dbo].[User_Update] (
	@email nvarchar(255),
	@firstName nvarchar(MAX),
	@lastName nvarchar(MAX),
	@phone nvarchar(50),
	@userGroupCodes nvarchar(MAX),
	@googleDriveLocalFolderPath nvarchar(MAX),
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	Update	uUsers
	Set		email = @email,
			first_name = @firstName,
			last_name = @lastName,
			phone = @phone,
			google_drive_local_folder_path = @googleDriveLocalFolderPath
	Where	id = @id

	Delete From uUserUserGroups
	Where [user_id] = @id;

	Insert Into uUserUserGroups (user_group_id, [user_id])
	Select	(Select id From uUserGroups Where code = ss.splitdata),
			@id
	From	SplitString(@userGroupCodes, ',') ss
END
GO




/****** Object:  StoredProcedure [dbo].[Users_GetAll]    Script Date: 1.8.2017 23:59:23 ******/
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
			u.google_drive_local_folder_path As GoogleDriveLocalFolderPath,
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






Alter Table Radnje
Add document_link nvarchar(MAX)
Go


Update	Radnje
Set		document_link = [dbo].[TrimStart] ([dbo].[TrimEnd] (SUBSTRING(Radnja, CHARINDEX('#', Radnja, 1) + 1, 8000), '#'), 'http://') 
Where	Radnja Like '%#%#'
GO



/****** Object:  StoredProcedure [dbo].[Radnje_GetForCase]    Script Date: 4.8.2017 20:54:06 ******/
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
			IsNULL(nor.name, '') As NacinObavljanjaName,
			r.document_link As DocumentLink
	From	Radnje r
			Left Join VrsteRadnji vr On r.VrstaRadnjeId = vr.id And r.PredmetId = @caseId And IsNULL(r.is_deleted, 0) = 0
			Left Join uUsers u On r.RadnjuObavioId = u.id
			Left Join NaciniObavljanjaRadnje nor On r.NacinObavljanjaId = nor.id
	Where	r.PredmetId = @caseId
			And IsNULL(r.is_deleted, 0) = 0
END
GO




/****** Object:  StoredProcedure [dbo].[Radnja_Insert]    Script Date: 4.8.2017 20:54:39 ******/
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
	@nacinObavljanjaId int,
	@documentLink nvarchar(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Id), 0) From Radnje) + 1;

	If @vrstaRadnjeId = -1
		Set @vrstaRadnjeId = NULL;

    Insert Into Radnje (id, PredmetId, Radnja, Datum, Troskovi, Biljeske, DatumPrijema, VrijednostRadnje, VrstaRadnjeId, RadnjuObavioId, NacinObavljanjaId, document_link, is_deleted)
	Values (@id, @caseId, '', @datumRadnje, @troskovi, @biljeske, @datumPrijema, @vrijednostRadnje, @vrstaRadnjeId, @radnjuObavioId, @nacinObavljanjaId, @documentLink, 0);

	Select @id;
END
GO




/****** Object:  StoredProcedure [dbo].[Radnja_Update]    Script Date: 4.8.2017 20:54:41 ******/
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
	@documentLink nvarchar(MAX),
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
			NacinObavljanjaId = @nacinObavljanjaId,
			document_link = @documentLink
	Where	id = @id

END
GO






/****** Object:  StoredProcedure [dbo].[Radnje_GetForCase]    Script Date: 4.8.2017 21:00:49 ******/
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
	@caseId int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @userGoogleDriveLocalFolderPath nvarchar(MAX) = (Select IsNULL(google_drive_local_folder_path, '') From uUsers Where id = @userId)

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
			r.document_link As DocumentLink,
			dbo.TrimEnd(@userGoogleDriveLocalFolderPath, '\') + '\' + dbo.TrimStart(r.document_link, '\') As AbsoluteDocumentLink
	From	Radnje r
			Left Join VrsteRadnji vr On r.VrstaRadnjeId = vr.id And r.PredmetId = @caseId And IsNULL(r.is_deleted, 0) = 0
			Left Join uUsers u On r.RadnjuObavioId = u.id
			Left Join NaciniObavljanjaRadnje nor On r.NacinObavljanjaId = nor.id
	Where	r.PredmetId = @caseId
			And IsNULL(r.is_deleted, 0) = 0
END
GO







'




/****** Object:  StoredProcedure [dbo].[User_GetByEmail]    Script Date: 4.8.2017 21:46:03 ******/
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
			),',') As UserGroupCodes,
			u.google_drive_local_folder_path As GoogleDriveLocalFolderPath
	From	uUsers u
	Where	u.email = @email
			And IsNULL(u.is_deleted, 0) = 0
END
GO









CREATE TABLE [dbo].TipoviDokumenata(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_TipoviDokumenata] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



delete from Dokumenti where TipDokumenta = ''
go



Insert Into TipoviDokumenata(name)
select distinct SUBSTRING(TipDokumenta, 1, CHARINDEX('#', TipDokumenta, 1) - 1)
from Dokumenti where TipDokumenta is not null
GO

Alter Table Dokumenti
Add TipDokumentaId int FOREIGN KEY REFERENCES TipoviDokumenata(Id)
GO

Update Dokumenti
Set	TipDokumentaId = (Select Id From TipoviDokumenata Where name = SUBSTRING(Dokumenti.TipDokumenta, 1, CHARINDEX('#', Dokumenti.TipDokumenta, 1) - 1))
GO






CREATE TABLE [dbo].PredatoUzDokumenti(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_PredatoUzDokumenti] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


Insert Into PredatoUzDokumenti(name)
select distinct Predato
from Dokumenti where Predato is not null
GO

Alter Table Dokumenti
Add PredatoUzDokumentiId int FOREIGN KEY REFERENCES PredatoUzDokumenti(Id)
GO

Update Dokumenti
Set	PredatoUzDokumentiId = (Select Id From PredatoUzDokumenti Where name = Dokumenti.Predato)
GO

Alter Table Dokumenti Drop Column Predato
GO







Alter Table Dokumenti Add document_link nvarchar(MAX)
GO



Update	Dokumenti
Set		document_link = [dbo].[TrimStart] ([dbo].[TrimEnd] (SUBSTRING(TipDokumenta, CHARINDEX('#', TipDokumenta, 1) + 1, 8000), '#'), 'http://')
GO









Alter Table Dokumenti Add is_deleted bit
Go

Update Dokumenti
Set is_deleted = 0
Go




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-04
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Documents_GetForCase] (
	@caseId int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @userGoogleDriveLocalFolderPath nvarchar(MAX) = (Select IsNULL(google_drive_local_folder_path, '') From uUsers Where id = @userId)
	
    Select	d.Id,
			d.PredmetId As CaseId,
			d.Biljeske As Note,
			d.TipDokumentaId,
			IsNULL(td.name, '') As TipDokumentaName,
			d.PredatoUzDokumentiId As PredatoUzDokumentId,
			IsNULL(pud.name, '') As PredatoUzDokumentName,
			d.document_link As DocumentLink,
			dbo.TrimEnd(@userGoogleDriveLocalFolderPath, '\') + '\' + dbo.TrimStart(d.document_link, '\') As AbsoluteDocumentLink
	From	Dokumenti d
			Left Join TipoviDokumenata td On d.TipDokumentaId = td.id And d.PredmetId = @caseId And IsNULL(d.is_deleted, 0) = 0
			Left Join PredatoUzDokumenti pud On d.PredatoUzDokumentiId = pud.id
	Where	d.PredmetId = @caseId
			And IsNULL(d.is_deleted, 0) = 0
END
GO










'













SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-04
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Document_Insert] (
	@caseId int,
	@note nvarchar(MAX),
	@tipDokumentaId int,
	@predatoUzDokumentName nvarchar(MAX),
	@documentLink nvarchar(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Id), 0) From Dokumenti) + 1;

	If @tipDokumentaId = -1
		Set @tipDokumentaId = NULL;

	Declare @predatoUzDokumentId int
	If IsNULL(@predatoUzDokumentName, '') = ''
		Set @predatoUzDokumentId = NULL;
	Else
	Begin
		Set @predatoUzDokumentId = (Select id From PredatoUzDokumenti Where name = @predatoUzDokumentName)
		If @predatoUzDokumentId Is NULL
		Begin
			Insert Into PredatoUzDokumenti(name) Values (@predatoUzDokumentName);
			Set @predatoUzDokumentId = SCOPE_IDENTITY();
		End
	End
		
    Insert Into Dokumenti (id, PredmetId, Biljeske, TipDokumentaId, PredatoUzDokumentiId, document_link, is_deleted)
	Values (@id, @caseId, @note, @tipDokumentaId, @predatoUzDokumentId, @documentLink, 0);

	Select @id;
END
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-04
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Document_Update] (
	@caseId int,
	@note nvarchar(MAX),
	@tipDokumentaId int,
	@predatoUzDokumentName nvarchar(MAX),
	@documentLink nvarchar(MAX),
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	If @tipDokumentaId = -1
		Set @tipDokumentaId = NULL;

	Declare @predatoUzDokumentId int
	If IsNULL(@predatoUzDokumentName, '') = ''
		Set @predatoUzDokumentId = NULL;
	Else
	Begin
		Set @predatoUzDokumentId = (Select id From PredatoUzDokumenti Where name = @predatoUzDokumentName)
		If @predatoUzDokumentId Is NULL
		Begin
			Insert Into PredatoUzDokumenti(name) Values (@predatoUzDokumentName);
			Set @predatoUzDokumentId = SCOPE_IDENTITY();
		End
	End

    Update	Dokumenti
	Set		PredmetId = @caseId,
			Biljeske = @note,
			TipDokumentaId = @tipDokumentaId,
			PredatoUzDokumentiId = @predatoUzDokumentId,
			document_link = @documentLink
	Where	id = @id

END
GO





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-04
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Document_Delete] (
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	Update	Dokumenti
	Set		is_deleted = 1
	Where	id = @id;
END
GO







Alter Table Veze
Add ConnectionCaseId int
GO

Update Veze
Set ConnectionCaseId = (Select Id From Predmeti Where NasBroj = Veze.NasBrojVeze)
GO

Alter Table Veze Drop Column NasBrojVeze
Go






Alter Table Veze Add is_deleted bit
Go

Update Veze
Set is_deleted = 0
Go





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-04
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Connections_GetForCase] (
	@caseId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Select	v.Id,
			v.PredmetId As CaseId,
			v.Biljeske As Note,
			ConnectionCaseId,
			[dbo].[Case_GetFullName] (v.ConnectionCaseId) As ConnectionCaseName
	From	Veze v
    Where	v.PredmetId = @caseId
			And IsNULL(v.is_deleted, 0) = 0
END
GO






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-04
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Connection_Insert] (
	@caseId int,
	@note nvarchar(MAX),
	@connectionCaseId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Id), 0) From Veze) + 1;

	Insert Into Veze(PredmetId, Biljeske, ConnectionCaseId, is_deleted)
	Values (@caseId, @note, @connectionCaseId, 0);

	Select @id;
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-04
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Connection_Update] (
	@caseId int,
	@note nvarchar(MAX),
	@connectionCaseId int,
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	Update	Veze
	Set		PredmetId = @caseId,
			Biljeske = @note,
			ConnectionCaseId = @connectionCaseId
	Where	Id = @id;

END
GO





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-04
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Connection_Delete] (
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	Update	Veze
	Set		is_deleted = 1
	Where	Id = @id;

END
GO






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vCases]
AS
	SELECT	Id,
			dbo.Case_GetFullName(Id) As Name
	FROM	dbo.Predmeti
	Where	IsNULL(is_deleted, 0) = 0
GO














/****** Object:  StoredProcedure [dbo].[Connection_Insert]    Script Date: 5.8.2017 0:25:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-04
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Connection_Insert] (
	@caseId int,
	@note nvarchar(MAX),
	@connectionCaseId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Id), 0) From Veze) + 1;

	Insert Into Veze(Id, PredmetId, Biljeske, ConnectionCaseId, is_deleted)
	Values (@id, @caseId, @note, @connectionCaseId, 0);

	Select @id;
END
GO









Alter Table VrsteRadnji
Add [Show on home page] bit
Go


Update VrsteRadnji
Set [Show on home page] = 0
Go







/****** Object:  StoredProcedure [dbo].[Radnje_GetAll]    Script Date: 5.8.2017 1:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-16
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Radnje_GetAll] (
	@userId int,
	@filter nvarchar(MAX),
	@rowCount int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @nowNoTime datetime = DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0);

    Select	Top (@rowCount)
			r.Id,
			r.PredmetId,
			r.Datum as DatumRadnje,
			r.Troskovi,
			r.Biljeske,
			r.VrstaRadnjeId,
			dbo.TrimEnd(IsNULL(vr.name, ''), '*') As VrstaRadnjeName,
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
			Left Join VrsteRadnji vr On r.VrstaRadnjeId = vr.id And vr.name Like '%*'
			Left Join uUsers u On r.RadnjuObavioId = u.id
			Left Join NaciniObavljanjaRadnje nor On r.NacinObavljanjaId = nor.id
	Where	IsNULL(r.is_deleted, 0) = 0
			And vr.name Like '%*'
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





/****** Object:  StoredProcedure [dbo].[Radnje_GetForCase]    Script Date: 5.8.2017 1:04:06 ******/
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
	@caseId int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @userGoogleDriveLocalFolderPath nvarchar(MAX) = (Select IsNULL(google_drive_local_folder_path, '') From uUsers Where id = @userId)

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
			IsNULL(r.document_link, '') As DocumentLink,
			case IsNULL(r.document_link, '')
				when '' then ''
				else dbo.TrimEnd(@userGoogleDriveLocalFolderPath, '\') + '\' + dbo.TrimStart(r.document_link, '\')
			end As AbsoluteDocumentLink
	From	Radnje r
			Left Join VrsteRadnji vr On r.VrstaRadnjeId = vr.id And r.PredmetId = @caseId And IsNULL(r.is_deleted, 0) = 0
			Left Join uUsers u On r.RadnjuObavioId = u.id
			Left Join NaciniObavljanjaRadnje nor On r.NacinObavljanjaId = nor.id
	Where	r.PredmetId = @caseId
			And IsNULL(r.is_deleted, 0) = 0
END
GO










'


















/****** Object:  StoredProcedure [dbo].[Documents_GetForCase]    Script Date: 5.8.2017 1:06:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-04
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Documents_GetForCase] (
	@caseId int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @userGoogleDriveLocalFolderPath nvarchar(MAX) = (Select IsNULL(google_drive_local_folder_path, '') From uUsers Where id = @userId)
	
    Select	d.Id,
			d.PredmetId As CaseId,
			d.Biljeske As Note,
			d.TipDokumentaId,
			IsNULL(td.name, '') As TipDokumentaName,
			d.PredatoUzDokumentiId As PredatoUzDokumentId,
			IsNULL(pud.name, '') As PredatoUzDokumentName,
			IsNULL(d.document_link, '') As DocumentLink,
			case IsNULL(d.document_link, '')
				when '' then ''
				else dbo.TrimEnd(@userGoogleDriveLocalFolderPath, '\') + '\' + dbo.TrimStart(d.document_link, '\')
			end As AbsoluteDocumentLink
	From	Dokumenti d
			Left Join TipoviDokumenata td On d.TipDokumentaId = td.id And d.PredmetId = @caseId And IsNULL(d.is_deleted, 0) = 0
			Left Join PredatoUzDokumenti pud On d.PredatoUzDokumentiId = pud.id
	Where	d.PredmetId = @caseId
			And IsNULL(d.is_deleted, 0) = 0
END
GO








'










/****** Object:  StoredProcedure [dbo].[Predmeti_GetAll]    Script Date: 5.8.2017 1:29:55 ******/
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
				(p.NasBroj = @filterNasBroj)
				Or (p.Id = @caseId)
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
END
GO









-- LABELS

/****** Object:  Table [dbo].[lLabelConnections]    Script Date: 6.8.2017 0:24:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[lLabelConnections](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[label_id] [int] NOT NULL,
	[content_type] [varchar](50) NOT NULL,
	[content_id] [int] NOT NULL,
 CONSTRAINT [PK_lLabelConnections] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lLabels]    Script Date: 6.8.2017 0:24:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[lLabels](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NOT NULL,
	[color] [varchar](10) NOT NULL,
 CONSTRAINT [PK_lLabels] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[lLabelConnections]  WITH CHECK ADD  CONSTRAINT [FK_lLabelConnections_lLabels] FOREIGN KEY([label_id])
REFERENCES [dbo].[lLabels] ([id])
GO
ALTER TABLE [dbo].[lLabelConnections] CHECK CONSTRAINT [FK_lLabelConnections_lLabels]
GO





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-06
-- Description:	
-- =============================================
CREATE PROCEDURE Labels_GetAll (
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

    Select	id As Id,
			name As Name,
			color As Color
	From	lLabels
END
GO




Alter Table lLabels Add is_deleted bit
Go





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-06
-- Description:	
-- =============================================
CREATE PROCEDURE Label_Insert (
	@name nvarchar(MAX),
	@color varchar(10)
)
AS
BEGIN
	SET NOCOUNT ON;

    Insert Into lLabels (name, color, is_deleted)
	Values (@name, @color, 0);

	Select SCOPE_IDENTITY();
END
GO





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-06
-- Description:	
-- =============================================
CREATE PROCEDURE Label_Update (
	@name nvarchar(MAX),
	@color varchar(10),
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

    Update	lLabels
	Set		name = @name,
			color = @color
	Where	id = @id;
END
GO





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-06
-- Description:	
-- =============================================
CREATE PROCEDURE Label_Delete (
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

    Update	lLabels
	Set		is_deleted = 1
	Where	id = @id;
END
GO






Alter Table lLabels Drop Column color
Go

Alter Table lLabels
Add background_color varchar(10),
font_color varchar(10)
Go










SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-06
-- Description:	
-- =============================================
ALTER PROCEDURE Label_Insert (
	@name nvarchar(MAX),
	@backgroundColor varchar(10),
	@fontColor varchar(10)
)
AS
BEGIN
	SET NOCOUNT ON;

    Insert Into lLabels (name, background_color, font_color, is_deleted)
	Values (@name, @backgroundColor, @fontColor, 0);

	Select SCOPE_IDENTITY();
END
GO





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-06
-- Description:	
-- =============================================
ALTER PROCEDURE Label_Update (
	@name nvarchar(MAX),
	@backgroundColor varchar(10),
	@fontColor varchar(10),
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

    Update	lLabels
	Set		name = @name,
			background_color = @backgroundColor,
			font_color = @fontColor
	Where	id = @id;
END
GO






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-06
-- Description:	
-- =============================================
ALTER PROCEDURE Labels_GetAll
AS
BEGIN
	SET NOCOUNT ON;

    Select	id As Id,
			name As Name,
			background_color As BackgroundColor,
			font_color As FontColor
	From	lLabels
	Where	IsNULL(is_deleted, 0) = 0
END
GO








SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-06
-- Description:	
-- =============================================
CREATE PROCEDURE LabelConnection_Create (
	@labelId int,
	@contentType varchar(50),
	@contentId int
)
AS
BEGIN
	SET NOCOUNT ON;
	
    If Not Exists (Select 1 From lLabelConnections Where label_id = @labelId And content_id = @contentId And content_type = @contentType)
	Begin
		Insert Into lLabelConnections (label_id, content_id, content_type)
		Values (@labelId, @contentId, @contentType);
		Select SCOPE_IDENTITY();
	End
	Else
	Begin
		Select Top 1 id From lLabelConnections Where label_id = @labelId And content_id = @contentId And content_type = @contentType
	End
END
GO







SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-06
-- Description:	
-- =============================================
CREATE PROCEDURE LabelConnection_Delete (
	@labelId int,
	@contentId int,
	@contentType varchar(10)
)
AS
BEGIN
	SET NOCOUNT ON;
	
    Delete From lLabelConnections Where label_id = @labelId And content_id = @contentId And content_type = @contentType;
END
GO







SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-06
-- Description:	
-- =============================================
CREATE FUNCTION Case_GetLabelIds
(
	@caseId int
)
RETURNS varchar
AS
BEGIN
	DECLARE @ids varchar(MAX) = (
		Select	',' + CAST(label_id as varchar(10))
		From	lLabelConnections
		Where	content_id = @caseId
				And content_type = 'case'
		For XML Path('')
	)

	If LEN(@ids) > 0
		Set @ids = SUBSTRING(@ids, 2, LEN(@ids))

	Return @ids
END
GO





/****** Object:  StoredProcedure [dbo].[Predmeti_GetAll]    Script Date: 6.8.2017 20:09:30 ******/
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
			um.first_name + ' ' + um.last_name As ModifiedByName,
			dbo.Case_GetLabelIds(p.Id) As LabelIds
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
				(p.NasBroj = @filterNasBroj)
				Or (p.Id = @caseId)
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
END
GO








/****** Object:  UserDefinedFunction [dbo].[Case_GetLabelIds]    Script Date: 6.8.2017 21:36:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-06
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[Case_GetLabelIds]
(
	@caseId int
)
RETURNS varchar(MAX)
AS
BEGIN
	DECLARE @ids varchar(MAX) = (
		Select	',' + CAST(label_id as varchar(10))
		From	lLabelConnections
		Where	content_id = @caseId
				And content_type = 'case'
		Order By label_id Asc
		For XML Path('')
	)

	If LEN(@ids) > 0
		Set @ids = SUBSTRING(@ids, 2, LEN(@ids))

	Return @ids
END
GO






/****** Object:  StoredProcedure [dbo].[GetCasesForParty]    Script Date: 6.8.2017 22:26:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-06
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetCasesForParty] (
	@partyId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Select	PredmetId As Id,
			vc.Name As Naziv
	From	Lica_Predmet lp
			Inner Join vCases vc On lp.PredmetId = vc.Id And lp.Id = @partyId
	Where	lp.Id = @partyId
END
GO





/****** Object:  StoredProcedure [dbo].[Lica_GetAll]    Script Date: 6.8.2017 22:27:31 ******/
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
					Or case when Ime Is Not NULL And Prezime Is Not NULL then Prezime + ' ' + Ime else PravnoLice end Like '%' + @filter + '%'
				)
			)
END
GO




/****** Object:  StoredProcedure [dbo].[Predmeti_GetAll]    Script Date: 6.8.2017 22:34:08 ******/
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

			Left Join Lica_Predmet lp_nasa On p.Id = lp_nasa.PredmetId And lp_nasa.is_nasa_stranka = 1
			Left Join vLica vl_nasa On lp_nasa.Id = vl_nasa.Id
			Left Join Lica_Predmet lp_protivna On p.Id = lp_protivna.PredmetId And lp_protivna.is_protivna_stranka = 1
			Left Join vLica vl_protivna On lp_protivna.Id = vl_protivna.Id

			Left Join uUsers uc On p.created_by = uc.id
			Left Join uUsers um On p.modified_by = um.id
	Where	IsNULL(p.is_deleted, 0) = 0
			And (
				(p.NasBroj = @filterNasBroj)
				Or (p.Id = @caseId)
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
END
GO






/****** Object:  StoredProcedure [dbo].[GetCasesForParty]    Script Date: 6.8.2017 22:35:32 ******/
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
END
GO




/****** Object:  StoredProcedure [dbo].[Predmeti_GetAll]    Script Date: 7.8.2017 10:40:48 ******/
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

			Left Join Lica_Predmet lp_nasa On p.Id = lp_nasa.PredmetId And lp_nasa.is_nasa_stranka = 1
			Left Join vLica vl_nasa On lp_nasa.Id = vl_nasa.Id
			Left Join Lica_Predmet lp_protivna On p.Id = lp_protivna.PredmetId And lp_protivna.is_protivna_stranka = 1
			Left Join vLica vl_protivna On lp_protivna.Id = vl_protivna.Id

			Left Join uUsers uc On p.created_by = uc.id
			Left Join uUsers um On p.modified_by = um.id
	Where	IsNULL(p.is_deleted, 0) = 0
			And (
				(p.Id = @caseId)
				Or (p.NasBroj = @filterNasBroj)
				Or (@filter Like 'oznaka:%' And @filter In (Select 'oznaka:' + name From lLabels Where id In (Select label_id From lLabelConnections Where content_id = p.Id and content_type = 'case')))
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
END
GO











Update	Lica_Predmet
Set		Broj = REPLACE(Broj, '.', '')
Where	Broj like '%.'
GO













SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
CREATE FUNCTION Case_GetPrvaProtivnaStrankaId
(
	@caseId int
)
RETURNS int
AS
BEGIN
	DECLARE @result nvarchar(MAX)

	Declare @countProtivneStranke int = (Select COUNT(1) From Lica_Predmet Where PredmetId = @caseId And is_protivna_stranka = 1);
	If @countProtivneStranke = 0
		Set @result = '';
	Else If @countProtivneStranke = 1
		Set @result = (Select Id From Lica_Predmet Where PredmetId = @caseId And is_protivna_stranka = 1)
	Else
		Set @result = (Select Top 1 Id From Lica_Predmet Where PredmetId = @caseId And is_protivna_stranka = 1 And Broj = '1')

	RETURN @result
END
GO





/****** Object:  View [dbo].[vLica]    Script Date: 7.8.2017 15:19:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vLica]
AS
	SELECT	Id,
			CASE WHEN Ime IS NOT NULL AND Prezime IS NOT NULL THEN Prezime + ' ' + Ime ELSE PravnoLice END AS Naziv,
			Adresa,
			PostanskiBroj,
			Grad
	FROM	dbo.Lica AS L
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[Case_GetPrvaNasaStrankaId]
(
	@caseId int
)
RETURNS int
AS
BEGIN
	DECLARE @result nvarchar(MAX)

	Declare @countNaseStranke int = (Select COUNT(1) From Lica_Predmet Where PredmetId = @caseId And is_nasa_stranka = 1);
	If @countNaseStranke = 0
		Set @result = '';
	Else If @countNaseStranke = 1
		Set @result = (Select Id From Lica_Predmet Where PredmetId = @caseId And is_nasa_stranka = 1)
	Else
		Set @result = (Select Top 1 Id From Lica_Predmet Where PredmetId = @caseId And is_nasa_stranka = 1 And Broj = '1')

	RETURN @result
END
GO







SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[Case_GetCaseConnections]
(
	@caseId int
)
RETURNS int
AS
BEGIN
	DECLARE @result nvarchar(MAX)

	Set @result = (
		Select	'\n' + vc.Name
		From	Veze v
				Inner Join vCases vc On v.ConnectionCaseId = vc.Id
		Where	PredmetId = @caseId
		For XML Path('')
	)

	RETURN @result
END
GO






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[Case_GetNaseStrankeSaPunimAdresama]
(
	@caseId int
)
RETURNS int
AS
BEGIN
	DECLARE @result nvarchar(MAX)

	Set @result = (
		Select	'\n' + IsNULL(vl.Naziv, '') + ', ' + IsNULL(vl.Adresa, '') + ', ' + IsNULL(vl.PostanskiBroj, '') + ', ' + IsNULL(vl.Grad, '')
		From	Lica_Predmet lp
				Inner Join vLica vl On lp.Id = vl.Id
		Where	PredmetId = @caseId
				And is_nasa_stranka = 1
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 2, LEN(@result))

	RETURN @result
END
GO






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[Case_GetCaseConnections]
(
	@caseId int
)
RETURNS int
AS
BEGIN
	DECLARE @result nvarchar(MAX)

	Set @result = (
		Select	'\n' + vc.Name
		From	Veze v
				Inner Join vCases vc On v.ConnectionCaseId = vc.Id
		Where	PredmetId = @caseId
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 1, LEN(@result))

	RETURN @result
END
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[Case_GetNaseStrankeNazivi]
(
	@caseId int
)
RETURNS int
AS
BEGIN
	DECLARE @result nvarchar(MAX)

	Set @result = (
		Select	', ' + IsNULL(vl.Naziv, '')
		From	Lica_Predmet lp
				Inner Join vLica vl On lp.Id = vl.Id
		Where	PredmetId = @caseId
				And is_nasa_stranka = 1
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 3, LEN(@result))

	RETURN @result
END
GO







SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[Case_GetProtivneStrankeSaPunimAdresama]
(
	@caseId int
)
RETURNS int
AS
BEGIN
	DECLARE @result nvarchar(MAX)

	Set @result = (
		Select	'\n' + IsNULL(vl.Naziv, '') + ', ' + IsNULL(vl.Adresa, '') + ', ' + IsNULL(vl.PostanskiBroj, '') + ', ' + IsNULL(vl.Grad, '')
		From	Lica_Predmet lp
				Inner Join vLica vl On lp.Id = vl.Id
		Where	PredmetId = @caseId
				And is_protivna_stranka = 1
		Order By CAST(IsNULL(lp.Broj, '9999') as int) Asc
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 2, LEN(@result))

	RETURN @result
END
GO





/****** Object:  UserDefinedFunction [dbo].[Case_GetNaseStrankeSaPunimAdresama]    Script Date: 7.8.2017 16:36:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
RETURNS int
AS
BEGIN
	DECLARE @result nvarchar(MAX)

	Set @result = (
		Select	'\n' + IsNULL(vl.Naziv, '') + ', ' + IsNULL(vl.Adresa, '') + ', ' + IsNULL(vl.PostanskiBroj, '') + ', ' + IsNULL(vl.Grad, '')
		From	Lica_Predmet lp
				Inner Join vLica vl On lp.Id = vl.Id
		Where	PredmetId = @caseId
				And is_nasa_stranka = 1
		Order By CAST(IsNULL(lp.Broj, '9999') as int) Asc
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 2, LEN(@result))

	RETURN @result
END
GO





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vLica]
AS
	SELECT	Id,
			CASE WHEN Ime IS NOT NULL AND Prezime IS NOT NULL THEN Prezime + ' ' + Ime ELSE PravnoLice END AS Naziv,
			Adresa,
			PostanskiBroj,
			Grad,
			JMBG_IDBroj
	FROM	dbo.Lica AS L

GO








SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[Case_GetStrankeKontakti]
(
	@caseId int
)
RETURNS int
AS
BEGIN
	DECLARE @result nvarchar(MAX)

	Set @result = (
		Select	', ' + IsNULL(l.Telefon, '') + IsNULL(', ' + l.Fax, '')
		From	Lica_Predmet lp
				Inner Join Lica l On l.Id = l.Id
		Where	PredmetId = @caseId
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 3, LEN(@result))

	RETURN @result
END
GO








SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
CREATE PROCEDURE Case_GetTemplateFields (
	@caseId int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;


    Select	IsNULL(p.BrojPredmeta, '') As broj_predmeta,
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
			p.NasBroj As nas_broj,
			sudije.name As sudija,
			vp.name As vrsta_predmeta,
			dbo.Case_GetStrankeKontakti(p.id) as kontakt_stranke,
			dbo.Case_GetCaseConnections(p.Id) As sve_veze_sa_drugim_predetima,
			CONVERT(varchar, p.VrijednostSpora, 1) As vrijednost_spora,
			ulogeNasa.name As uloga_nase_stranke,
			ulogeProtivna.name As uloga_protivne_stranke,
			dbo.Case_GetNaseStrankeSaPunimAdresama(p.Id) As nase_stranke_sve_sa_punim_adresama,
			dbo.Case_GetNaseStrankeNazivi(p.Id) As nasa_stranka_sve,
			dbo.Case_GetProtivneStrankeSaPunimAdresama(p.Id) As protivne_stranke_sve_sa_punim_adresama,
			vlNasa.JMBG_IDBroj As jmbg_ili_id_nase_stranke
	From	Predmeti p
			Left Join Sudovi s On p.SudID = s.Id And p.Id = @caseId
			Left Join vLica vlProtivna On dbo.Case_GetPrvaProtivnaStrankaId(p.Id) = vlProtivna.Id
			Left Join Lica_Predmet lpProtivna On p.Id = lpProtivna.PredmetId And vlProtivna.Id = lpProtivna.Id
			Left Join Uloge ulogeProtivna On lpProtivna.UlogaId = ulogeProtivna.id
			Left Join vLica vlNasa On dbo.Case_GetPrvaNasaStrankaId(p.Id) = vlNasa.Id
			Left Join Lica_Predmet lpNasa On p.Id = lpNasa.PredmetId And vlNasa.Id = vlNasa.Id
			Left Join Uloge ulogeNasa On lpNasa.UlogaId = ulogeNasa.id
			Left Join Sudije sudije On p.SudijaId = sudije.id
			Left Join VrstePredmeta vp On p.VrstaPredmetaId = vp.id
	Where	p.Id = @caseId;

END
GO





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
ALTER PROCEDURE Case_GetTemplateFields (
	@caseId int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;


    Select	IsNULL(p.BrojPredmeta, '') As broj_predmeta,
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
			CONVERT(varchar, p.VrijednostSpora, 1) As vrijednost_spora,
			IsNULL(ulogeNasa.name, '') As uloga_nase_stranke,
			IsNULL(ulogeProtivna.name, '') As uloga_protivne_stranke,
			dbo.Case_GetNaseStrankeSaPunimAdresama(p.Id) As nase_stranke_sve_sa_punim_adresama,
			dbo.Case_GetNaseStrankeNazivi(p.Id) As nasa_stranka_sve,
			dbo.Case_GetProtivneStrankeSaPunimAdresama(p.Id) As protivne_stranke_sve_sa_punim_adresama,
			IsNULL(vlNasa.JMBG_IDBroj, '') As jmbg_ili_id_nase_stranke
	From	Predmeti p
			Left Join Sudovi s On p.SudID = s.Id And p.Id = @caseId
			Left Join vLica vlProtivna On dbo.Case_GetPrvaProtivnaStrankaId(p.Id) = vlProtivna.Id
			Left Join Lica_Predmet lpProtivna On p.Id = lpProtivna.PredmetId And vlProtivna.Id = lpProtivna.Id
			Left Join Uloge ulogeProtivna On lpProtivna.UlogaId = ulogeProtivna.id
			Left Join vLica vlNasa On dbo.Case_GetPrvaNasaStrankaId(p.Id) = vlNasa.Id
			Left Join Lica_Predmet lpNasa On p.Id = lpNasa.PredmetId And vlNasa.Id = vlNasa.Id
			Left Join Uloge ulogeNasa On lpNasa.UlogaId = ulogeNasa.id
			Left Join Sudije sudije On p.SudijaId = sudije.id
			Left Join VrstePredmeta vp On p.VrstaPredmetaId = vp.id
	Where	p.Id = @caseId;

END
GO





/****** Object:  UserDefinedFunction [dbo].[Case_GetNaseStrankeSaPunimAdresama]    Script Date: 7.8.2017 17:25:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
		Order By CAST(IsNULL(lp.Broj, '9999') as int) Asc
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 4, LEN(@result))

	RETURN @result
END
GO





/****** Object:  UserDefinedFunction [dbo].[Case_GetProtivneStrankeSaPunimAdresama]    Script Date: 7.8.2017 17:27:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
		Order By CAST(IsNULL(lp.Broj, '9999') as int) Asc
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 4, LEN(@result))

	RETURN @result
END
GO




/****** Object:  UserDefinedFunction [dbo].[Case_GetNaseStrankeNazivi]    Script Date: 7.8.2017 17:28:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 3, LEN(@result))

	RETURN @result
END
GO





/****** Object:  UserDefinedFunction [dbo].[Case_GetStrankeKontakti]    Script Date: 7.8.2017 17:29:09 ******/
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
				Inner Join Lica l On l.Id = l.Id
		Where	PredmetId = @caseId
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 3, LEN(@result))

	RETURN @result
END
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
ALTER PROCEDURE Case_GetTemplateFields (
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
			CONVERT(varchar, p.VrijednostSpora, 1) As vrijednost_spora,
			IsNULL(ulogeNasa.name, '') As uloga_nase_stranke,
			IsNULL(ulogeProtivna.name, '') As uloga_protivne_stranke,
			dbo.Case_GetNaseStrankeSaPunimAdresama(p.Id) As nase_stranke_sve_sa_punim_adresama,
			dbo.Case_GetNaseStrankeNazivi(p.Id) As nasa_stranka_sve,
			dbo.Case_GetProtivneStrankeSaPunimAdresama(p.Id) As protivne_stranke_sve_sa_punim_adresama,
			IsNULL(vlNasa.JMBG_IDBroj, '') As jmbg_ili_id_nase_stranke
	From	Predmeti p
			Left Join Sudovi s On p.SudID = s.Id And p.Id = @caseId
			Left Join vLica vlProtivna On dbo.Case_GetPrvaProtivnaStrankaId(p.Id) = vlProtivna.Id
			Left Join Lica_Predmet lpProtivna On p.Id = lpProtivna.PredmetId And vlProtivna.Id = lpProtivna.Id
			Left Join Uloge ulogeProtivna On lpProtivna.UlogaId = ulogeProtivna.id
			Left Join vLica vlNasa On dbo.Case_GetPrvaNasaStrankaId(p.Id) = vlNasa.Id
			Left Join Lica_Predmet lpNasa On p.Id = lpNasa.PredmetId And vlNasa.Id = vlNasa.Id
			Left Join Uloge ulogeNasa On lpNasa.UlogaId = ulogeNasa.id
			Left Join Sudije sudije On p.SudijaId = sudije.id
			Left Join VrstePredmeta vp On p.VrstaPredmetaId = vp.id
	Where	p.Id = @caseId;

END
GO




/****** Object:  StoredProcedure [dbo].[Connections_GetForCase]    Script Date: 8.8.2017 11:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-04
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Connections_GetForCase] (
	@caseId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Select	v.Id,
			v.PredmetId As CaseId,
			v.Biljeske As Note,
			ConnectionCaseId,
			[dbo].[Case_GetFullName] (v.ConnectionCaseId) As ConnectionCaseName
	From	Veze v
    Where	v.PredmetId = @caseId
			And IsNULL(v.is_deleted, 0) = 0

	Union All

	Select	v.Id,
			v.ConnectionCaseId As CaseId,
			v.Biljeske As Note,
			v.PredmetId As ConnectionCaseId,
			[dbo].[Case_GetFullName] (v.PredmetId) As ConnectionCaseName
	From	Veze v
    Where	v.ConnectionCaseId = @caseId
			And IsNULL(v.is_deleted, 0) = 0
END
GO





/****** Object:  UserDefinedFunction [dbo].[Case_GetCaseConnections]    Script Date: 10.8.2017 18:08:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[Case_GetCaseConnections]
(
	@caseId int
)
RETURNS nvarchar(MAX)
AS
BEGIN
	DECLARE @result nvarchar(MAX)

	Set @result = (
		Select	'\n' + vc.Name
		From	Veze v
				Inner Join vCases vc On v.ConnectionCaseId = vc.Id
		Where	PredmetId = @caseId
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 1, LEN(@result))

	RETURN @result
END
GO




/****** Object:  UserDefinedFunction [dbo].[Case_GetProtivneStrankeSaPunimAdresama]    Script Date: 11.8.2017 15:49:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
		Order By CAST(IsNULL(lp.Broj, '9999') as int) Asc
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 3, LEN(@result))

	RETURN @result
END
GO





/****** Object:  UserDefinedFunction [dbo].[Case_GetCaseConnections]    Script Date: 11.8.2017 15:50:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-07
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[Case_GetCaseConnections]
(
	@caseId int
)
RETURNS nvarchar(MAX)
AS
BEGIN
	DECLARE @result nvarchar(MAX)

	Set @result = (
		Select	'\n' + vc.Name
		From	Veze v
				Inner Join vCases vc On v.ConnectionCaseId = vc.Id
		Where	PredmetId = @caseId
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 3, LEN(@result))

	RETURN @result
END
GO



/****** Object:  StoredProcedure [dbo].[Predmeti_GetAll]    Script Date: 11.8.2017 16:19:26 ******/
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
				(p.Id = @caseId)
				Or (p.NasBroj = @filterNasBroj)
				Or (@filter Like 'oznaka:%' And @filter In (Select 'oznaka:' + name From lLabels Where id In (Select label_id From lLabelConnections Where content_id = p.Id and content_type = 'case')))
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
END
GO






/****** Object:  StoredProcedure [dbo].[Case_GetTemplateFields]    Script Date: 11.8.2017 21:39:35 ******/
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
			Left Join Lica_Predmet lpProtivna On p.Id = lpProtivna.PredmetId And vlProtivna.Id = lpProtivna.Id
			Left Join Uloge ulogeProtivna On lpProtivna.UlogaId = ulogeProtivna.id
			Left Join vLica vlNasa On dbo.Case_GetPrvaNasaStrankaId(p.Id) = vlNasa.Id
			Left Join Lica_Predmet lpNasa On p.Id = lpNasa.PredmetId And vlNasa.Id = lpNasa.Id
			Left Join Uloge ulogeNasa On lpNasa.UlogaId = ulogeNasa.id
			Left Join Sudije sudije On p.SudijaId = sudije.id
			Left Join VrstePredmeta vp On p.VrstaPredmetaId = vp.id
	Where	p.Id = @caseId;

END
GO






/****** Object:  UserDefinedFunction [dbo].[Case_GetStrankeKontakti]    Script Date: 11.8.2017 22:07:13 ******/
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
				Inner Join Lica l On lp.Id = l.Id
		Where	lp.PredmetId = @caseId
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 3, LEN(@result))

	RETURN @result
END
GO




/****** Object:  UserDefinedFunction [dbo].[Case_GetStrankeKontakti]    Script Date: 11.8.2017 22:37:30 ******/
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
				Inner Join Lica l On lp.Id = l.Id And lp.is_nasa_stranka = 1
		Where	lp.PredmetId = @caseId
		For XML Path('')
	)
	Set @result = SUBSTRING(@result, 3, LEN(@result))

	RETURN @result
END
GO






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-09-19
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Predmeti_GetForAdvancedSearch] (
	@userId int,
	@nasBroj int,
	@kategorije varchar(MAX),
	@ulogeUPostupku varchar(MAX),
	@brojPredmeta nvarchar(MAX),
	@sudovi varchar(MAX),
	@sudije varchar(MAX),
	@vrijednostSporaFrom decimal(19,4),
	@vrijednostSporaTo decimal(19,4),
	@vrstePredmeta varchar(MAX),
	@datumStanjaPredmeta datetime,
	@stanjePredmeta nvarchar(MAX),
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
			And (@nasBroj = -1 Or CAST(p.NasBroj as varchar(MAX)) Like '%' + CAST(@nasBroj as varchar(MAX)) + '%')
			And p.BrojPredmeta Like '%' + @brojPredmeta + '%'
			And (@vrijednostSporaFrom = 0 Or p.VrijednostSpora >= @vrijednostSporaFrom)
			And (@vrijednostSporaTo = 0 Or p.VrijednostSpora <= @vrijednostSporaTo)
			And sp.name Like '%' + @stanjePredmeta + '%'
			And (@datumStanjaPredmeta Is NULL Or p.DatumStanjaPredmeta = @datumStanjaPredmeta)
			
			And (@sudovi = '' Or s.Id In (Select sud From @sudoviTable))
			And (@kategorije = '' Or kp.Id In (Select kategorija From @kategorijeTable))
			And (@sudije = '' Or sj.Id In (Select sudija From @sudijeTable))
			And (@vrstePredmeta = '' Or vp.Id In (Select vrstaPredmeta From @vrstePredmetaTable))
			And (@ulogeUPostupku = '' Or u.Id In (Select ulogaUPostupku From @ulogeUPostupkuTable))
	Order By Iniciran Desc
END
GO






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
	@sudovi varchar(MAX),
	@sudije varchar(MAX),
	@vrijednostSporaFrom decimal(19,4),
	@vrijednostSporaTo decimal(19,4),
	@vrstePredmeta varchar(MAX),
	@datumStanjaPredmeta datetime,
	@stanjePredmeta nvarchar(MAX),
	@labels varchar(MAX),
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
			And (@nasBroj = -1 Or CAST(p.NasBroj as varchar(MAX)) Like '%' + CAST(@nasBroj as varchar(MAX)) + '%')
			And p.BrojPredmeta Like '%' + @brojPredmeta + '%'
			And (@vrijednostSporaFrom = 0 Or p.VrijednostSpora >= @vrijednostSporaFrom)
			And (@vrijednostSporaTo = 0 Or p.VrijednostSpora <= @vrijednostSporaTo)
			And sp.name Like '%' + @stanjePredmeta + '%'
			And (@datumStanjaPredmeta Is NULL Or p.DatumStanjaPredmeta = @datumStanjaPredmeta)
			
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
	Order By Iniciran Desc
END
GO




-- 2017-09-25




/****** Object:  StoredProcedure [dbo].[Predmeti_Insert]    Script Date: 25.9.2017 14:22:16 ******/
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

	Insert Into Predmeti (Id, NasBroj, KategorijaPredmetaId, UlogaId, PrivremeniZastupnici, BrojPredmeta, SudID, SudijaId, VrijednostSpora,
		VrstaPredmetaId, DatumStanjaPredmeta, StanjePredmetaId,
		NacinOkoncanjaId, [Uspjehu Postupku], DatumArhiviranja, BrojArhive, BrojArhiveRegistrator,
		PravniOsnov,
		is_deleted, created, iniciran, created_by)
	Values (@id, @nasBroj, @kategorijaPredmetaId, @ulogaId, @privremeniZastupnici, @brojPredmeta, @sudId, @sudijaId, @vrijednostSpora,
		@vrstaPredmetaId, @datumStanjaPredmeta, @stanjePredmetaId,
		@nacinOkoncanjaId, @uspjeh, @datumArhiviranja, @brojArhive, @brojArhiveRegistrator,
		@pravniOsnov,
		0, @now, @now, @userId);

	Select @id;
END
GO







/****** Object:  StoredProcedure [dbo].[Predmeti_GetAll]    Script Date: 25.9.2017 16:41:55 ******/
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
				(p.Id = @caseId)
				Or (p.NasBroj = @filterNasBroj)
				Or (@filter Like 'oznaka:%' And @filter In (Select 'oznaka:' + name From lLabels Where id In (Select label_id From lLabelConnections Where content_id = p.Id and content_type = 'case')))
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
END
GO






/****** Object:  StoredProcedure [dbo].[Predmeti_GetForAdvancedSearch]    Script Date: 25.9.2017 14:30:32 ******/
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
			Left Join Lica_Predmet lp_nasa On p.Id = lp_nasa.PredmetId And lp_nasa.is_nasa_stranka = 1 And dbo.Case_GetPrvaNasaStrankaId(p.Id) = lp_nasa.Id
			Left Join vLica vl_nasa On lp_nasa.Id = vl_nasa.Id
			Left Join Lica_Predmet lp_protivna On p.Id = lp_protivna.PredmetId And lp_protivna.is_protivna_stranka = 1 And dbo.Case_GetPrvaProtivnaStrankaId(p.Id) = lp_protivna.Id
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
	Order By Iniciran Desc
END
GO





Alter Table Radnje
Add google_event_id nvarchar(255)
go





/****** Object:  StoredProcedure [dbo].[Radnja_Insert]    Script Date: 27.9.2017 14:20:05 ******/
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
	@nacinObavljanjaId int,
	@documentLink nvarchar(MAX),
	@googleEventId nvarchar(255)
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Id), 0) From Radnje) + 1;

	If @vrstaRadnjeId = -1
		Set @vrstaRadnjeId = NULL;

    Insert Into Radnje (id, PredmetId, Radnja, Datum, Troskovi, Biljeske, DatumPrijema, VrijednostRadnje, VrstaRadnjeId, RadnjuObavioId, NacinObavljanjaId, document_link, google_event_id, is_deleted)
	Values (@id, @caseId, '', @datumRadnje, @troskovi, @biljeske, @datumPrijema, @vrijednostRadnje, @vrstaRadnjeId, @radnjuObavioId, @nacinObavljanjaId, @documentLink, @googleEventId, 0);

	Select @id;
END
GO






/****** Object:  StoredProcedure [dbo].[Radnje_GetForCase]    Script Date: 27.9.2017 14:37:34 ******/
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
	@caseId int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @userGoogleDriveLocalFolderPath nvarchar(MAX) = (Select IsNULL(google_drive_local_folder_path, '') From uUsers Where id = @userId)

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
			IsNULL(r.google_event_id, '') As GoogleEventId,
			IsNULL(r.document_link, '') As DocumentLink,
			case IsNULL(r.document_link, '')
				when '' then ''
				else dbo.TrimEnd(@userGoogleDriveLocalFolderPath, '\') + '\' + dbo.TrimStart(r.document_link, '\')
			end As AbsoluteDocumentLink
	From	Radnje r
			Left Join VrsteRadnji vr On r.VrstaRadnjeId = vr.id And r.PredmetId = @caseId And IsNULL(r.is_deleted, 0) = 0
			Left Join uUsers u On r.RadnjuObavioId = u.id
			Left Join NaciniObavljanjaRadnje nor On r.NacinObavljanjaId = nor.id
	Where	r.PredmetId = @caseId
			And IsNULL(r.is_deleted, 0) = 0
END
GO







'







/****** Object:  StoredProcedure [dbo].[Radnje_GetAll]    Script Date: 27.9.2017 14:38:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-07-16
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Radnje_GetAll] (
	@userId int,
	@filter nvarchar(MAX),
	@rowCount int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @nowNoTime datetime = DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0);

    Select	Top (@rowCount)
			r.Id,
			r.PredmetId,
			r.Datum as DatumRadnje,
			r.Troskovi,
			r.Biljeske,
			r.VrstaRadnjeId,
			dbo.TrimEnd(IsNULL(vr.name, ''), '*') As VrstaRadnjeName,
			r.DatumPrijema,
			r.VrijednostRadnje,
			r.RadnjuObavioId,
			IsNULL(u.first_name + ' ' + u.last_name, '') As RadnjuObavioName,
			r.NacinObavljanjaId,
			IsNULL(nor.name, '') As NacinObavljanjaName,
			[dbo].[Case_GetFullName] (r.PredmetId) As CaseFullName,
			p.NasBroj As CaseNasBroj,
			IsNULL(r.google_event_id, '') As GoogleEventId
	From	Radnje r
			Inner Join Predmeti p On r.PredmetId = p.Id And IsNULL(r.is_deleted, 0) = 0
			Left Join VrsteRadnji vr On r.VrstaRadnjeId = vr.id And vr.name Like '%*'
			Left Join uUsers u On r.RadnjuObavioId = u.id
			Left Join NaciniObavljanjaRadnje nor On r.NacinObavljanjaId = nor.id
	Where	IsNULL(r.is_deleted, 0) = 0
			And vr.name Like '%*'
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





/****** Object:  StoredProcedure [dbo].[Radnje_GetForCase]    Script Date: 28.9.2017 13:30:37 ******/
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
	@caseId int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @userGoogleDriveLocalFolderPath nvarchar(MAX) = (Select IsNULL(google_drive_local_folder_path, '') From uUsers Where id = @userId)

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
			IsNULL(r.google_event_id, '') As GoogleEventId,
			@userId As UserId,
			IsNULL(r.document_link, '') As DocumentLink,
			case IsNULL(r.document_link, '')
				when '' then ''
				else dbo.TrimEnd(@userGoogleDriveLocalFolderPath, '\') + '\' + dbo.TrimStart(r.document_link, '\')
			end As AbsoluteDocumentLink
	From	Radnje r
			Left Join VrsteRadnji vr On r.VrstaRadnjeId = vr.id And r.PredmetId = @caseId And IsNULL(r.is_deleted, 0) = 0
			Left Join uUsers u On r.RadnjuObavioId = u.id
			Left Join NaciniObavljanjaRadnje nor On r.NacinObavljanjaId = nor.id
	Where	r.PredmetId = @caseId
			And IsNULL(r.is_deleted, 0) = 0
END
GO







'













------------------------------------------------------------------


/****** Object:  StoredProcedure [dbo].[Predmeti_GetAll]    Script Date: 2.10.2017 11:31:51 ******/
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

			Left Join Lica_Predmet lp_nasa On p.Id = lp_nasa.PredmetId And lp_nasa.is_nasa_stranka = 1 And dbo.Case_GetPrvaNasaStrankaId(p.Id) = lp_nasa.Id
			Left Join vLica vl_nasa On lp_nasa.Id = vl_nasa.Id
			Left Join Lica_Predmet lp_protivna On p.Id = lp_protivna.PredmetId And lp_protivna.is_protivna_stranka = 1 And dbo.Case_GetPrvaProtivnaStrankaId(p.Id) = lp_protivna.Id
			Left Join vLica vl_protivna On lp_protivna.Id = vl_protivna.Id

			Left Join uUsers uc On p.created_by = uc.id
			Left Join uUsers um On p.modified_by = um.id
	Where	IsNULL(p.is_deleted, 0) = 0
			And (
				(p.Id = @caseId)
				Or (p.NasBroj = @filterNasBroj)
				Or (@filter Like 'oznaka:%' And @filter In (Select 'oznaka:' + name From lLabels Where id In (Select label_id From lLabelConnections Where content_id = p.Id and content_type = 'case')))
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
END
GO




/****** Object:  StoredProcedure [dbo].[Predmeti_Insert]    Script Date: 2.10.2017 11:31:24 ******/
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
		0, @now, @now, @userId);

	Select @id;
END
GO




/****** Object:  StoredProcedure [dbo].[Predmeti_Update]    Script Date: 2.10.2017 11:31:25 ******/
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






/****** Object:  StoredProcedure [dbo].[Predmeti_GetForAdvancedSearch]    Script Date: 2.10.2017 11:31:21 ******/
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
			Left Join Lica_Predmet lp_nasa On p.Id = lp_nasa.PredmetId And lp_nasa.is_nasa_stranka = 1 And dbo.Case_GetPrvaNasaStrankaId(p.Id) = lp_nasa.Id
			Left Join vLica vl_nasa On lp_nasa.Id = vl_nasa.Id
			Left Join Lica_Predmet lp_protivna On p.Id = lp_protivna.PredmetId And lp_protivna.is_protivna_stranka = 1 And dbo.Case_GetPrvaProtivnaStrankaId(p.Id) = lp_protivna.Id
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
	Order By Iniciran Desc
END
GO

















-----------------












/****** Object:  StoredProcedure [dbo].[Predmeti_GetForAdvancedSearch]    Script Date: 10.10.2017 16:20:07 ******/
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
			Left Join Lica_Predmet lp_nasa On p.Id = lp_nasa.PredmetId And lp_nasa.is_nasa_stranka = 1 And dbo.Case_GetPrvaNasaStrankaId(p.Id) = lp_nasa.Id
			Left Join vLica vl_nasa On lp_nasa.Id = vl_nasa.Id
			Left Join Lica_Predmet lp_protivna On p.Id = lp_protivna.PredmetId And lp_protivna.is_protivna_stranka = 1 And dbo.Case_GetPrvaProtivnaStrankaId(p.Id) = lp_protivna.Id
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
	Order By Iniciran Desc
END
GO







----------------------------------------------------------------------------------------------------------------------------------------------------------------










SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-10-11
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Radnja_UpdateGoogleEventId] (
	@googleEventId nvarchar(MAX),
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

    Update	Radnje
	Set		google_event_id = @googleEventId
	Where	id = @id

END
GO










Alter Table Dokumenti Add google_drive_doc_id nvarchar(255)
Go




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-10-12
-- Description:	
-- =============================================
CREATE PROCEDURE GetDocsForMapping
AS
BEGIN
	SET NOCOUNT ON;

    Select	Id,
			REPLACE(document_link, '%20', ' ') as UNC
	From	Dokumenti
	Where	TipDokumenta Is Not NULL
	Order By	id Desc
END
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-10-12
-- Description:	
-- =============================================
CREATE PROCEDURE Dokument_UpdateGoogleDocDriveId (
	@id int,
	@googleDriveDocId nvarchar(255)
)
AS
BEGIN
	SET NOCOUNT ON;

	Update	Dokumenti
	Set		google_drive_doc_id = @googleDriveDocId
	Where	id = @id;
END
GO






Alter Table Radnje Add google_drive_doc_id nvarchar(255)
Go



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-10-18
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetRadnjeForMapping]
AS
BEGIN
	SET NOCOUNT ON;

    Select	Id,
			REPLACE(document_link, '%20', ' ') as UNC
	From	Radnje
	Where	IsNULL(google_drive_doc_id, '') = ''
			And document_link <> ''
	Order By	id Desc
END
GO






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-10-18
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Radnja_UpdateGoogleDocDriveId] (
	@id int,
	@googleDriveDocId nvarchar(255)
)
AS
BEGIN
	SET NOCOUNT ON;

	Update	Radnje
	Set		google_drive_doc_id = @googleDriveDocId
	Where	id = @id;
END
GO









/****** Object:  StoredProcedure [dbo].[Documents_GetForCase]    Script Date: 18.10.2017 14:44:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-04
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Documents_GetForCase] (
	@caseId int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @userGoogleDriveLocalFolderPath nvarchar(MAX) = (Select IsNULL(google_drive_local_folder_path, '') From uUsers Where id = @userId)
	
    Select	d.Id,
			d.PredmetId As CaseId,
			d.Biljeske As Note,
			d.TipDokumentaId,
			IsNULL(td.name, '') As TipDokumentaName,
			d.PredatoUzDokumentiId As PredatoUzDokumentId,
			IsNULL(pud.name, '') As PredatoUzDokumentName,
			IsNULL(d.google_drive_doc_id, '') As GoogleDriveDocId
	From	Dokumenti d
			Left Join TipoviDokumenata td On d.TipDokumentaId = td.id And d.PredmetId = @caseId And IsNULL(d.is_deleted, 0) = 0
			Left Join PredatoUzDokumenti pud On d.PredatoUzDokumentiId = pud.id
	Where	d.PredmetId = @caseId
			And IsNULL(d.is_deleted, 0) = 0
END
GO


/****** Object:  StoredProcedure [dbo].[Document_Insert]    Script Date: 18.10.2017 14:49:34 ******/
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
	@tipDokumentaId int,
	@predatoUzDokumentName nvarchar(MAX),
	@googleDriveDocId nvarchar(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Id), 0) From Dokumenti) + 1;

	If @tipDokumentaId = -1
		Set @tipDokumentaId = NULL;

	Declare @predatoUzDokumentId int
	If IsNULL(@predatoUzDokumentName, '') = ''
		Set @predatoUzDokumentId = NULL;
	Else
	Begin
		Set @predatoUzDokumentId = (Select id From PredatoUzDokumenti Where name = @predatoUzDokumentName)
		If @predatoUzDokumentId Is NULL
		Begin
			Insert Into PredatoUzDokumenti(name) Values (@predatoUzDokumentName);
			Set @predatoUzDokumentId = SCOPE_IDENTITY();
		End
	End
		
    Insert Into Dokumenti (id, PredmetId, Biljeske, TipDokumentaId, PredatoUzDokumentiId, google_drive_doc_id, is_deleted)
	Values (@id, @caseId, @note, @tipDokumentaId, @predatoUzDokumentId, @googleDriveDocId, 0);

	Select @id;
END
GO


/****** Object:  StoredProcedure [dbo].[Document_Update]    Script Date: 18.10.2017 14:50:05 ******/
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
	@tipDokumentaId int,
	@predatoUzDokumentName nvarchar(MAX),
	@googleDriveDocId nvarchar(MAX),
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	If @tipDokumentaId = -1
		Set @tipDokumentaId = NULL;

	Declare @predatoUzDokumentId int
	If IsNULL(@predatoUzDokumentName, '') = ''
		Set @predatoUzDokumentId = NULL;
	Else
	Begin
		Set @predatoUzDokumentId = (Select id From PredatoUzDokumenti Where name = @predatoUzDokumentName)
		If @predatoUzDokumentId Is NULL
		Begin
			Insert Into PredatoUzDokumenti(name) Values (@predatoUzDokumentName);
			Set @predatoUzDokumentId = SCOPE_IDENTITY();
		End
	End

    Update	Dokumenti
	Set		PredmetId = @caseId,
			Biljeske = @note,
			TipDokumentaId = @tipDokumentaId,
			PredatoUzDokumentiId = @predatoUzDokumentId,
			google_drive_doc_id = @googleDriveDocId
	Where	id = @id

END
GO




/****** Object:  StoredProcedure [dbo].[Radnja_Insert]    Script Date: 18.10.2017 14:52:00 ******/
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
	@nacinObavljanjaId int,
	@googleDriveDocId nvarchar(MAX),
	@googleEventId nvarchar(255)
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Id), 0) From Radnje) + 1;

	If @vrstaRadnjeId = -1
		Set @vrstaRadnjeId = NULL;

    Insert Into Radnje (id, PredmetId, Radnja, Datum, Troskovi, Biljeske, DatumPrijema, VrijednostRadnje, VrstaRadnjeId, RadnjuObavioId, NacinObavljanjaId, google_drive_doc_id, google_event_id, is_deleted)
	Values (@id, @caseId, '', @datumRadnje, @troskovi, @biljeske, @datumPrijema, @vrijednostRadnje, @vrstaRadnjeId, @radnjuObavioId, @nacinObavljanjaId, @googleDriveDocId, @googleEventId, 0);

	Select @id;
END
GO




/****** Object:  StoredProcedure [dbo].[Radnja_Update]    Script Date: 18.10.2017 14:52:26 ******/
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
	@googleDriveDocId nvarchar(MAX),
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
			NacinObavljanjaId = @nacinObavljanjaId,
			google_drive_doc_id = @googleDriveDocId
	Where	id = @id

END
GO




/****** Object:  StoredProcedure [dbo].[Documents_GetForCase]    Script Date: 18.10.2017 16:36:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-08-04
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[Documents_GetForCase] (
	@caseId int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @userGoogleDriveLocalFolderPath nvarchar(MAX) = (Select IsNULL(google_drive_local_folder_path, '') From uUsers Where id = @userId)
	
    Select	d.Id,
			d.PredmetId As CaseId,
			d.Biljeske As Note,
			d.TipDokumentaId,
			IsNULL(td.name, '') As TipDokumentaName,
			d.PredatoUzDokumentiId As PredatoUzDokumentId,
			IsNULL(pud.name, '') As PredatoUzDokumentName,
			IsNULL(d.google_drive_doc_id, '') As GoogleDriveDocId,
			IsNULL(document_link, '') As DocumentName
	From	Dokumenti d
			Left Join TipoviDokumenata td On d.TipDokumentaId = td.id And d.PredmetId = @caseId And IsNULL(d.is_deleted, 0) = 0
			Left Join PredatoUzDokumenti pud On d.PredatoUzDokumentiId = pud.id
	Where	d.PredmetId = @caseId
			And IsNULL(d.is_deleted, 0) = 0
END
GO





/****** Object:  StoredProcedure [dbo].[Radnje_GetForCase]    Script Date: 18.10.2017 16:48:16 ******/
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
	@caseId int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @userGoogleDriveLocalFolderPath nvarchar(MAX) = (Select IsNULL(google_drive_local_folder_path, '') From uUsers Where id = @userId)

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
			IsNULL(r.google_event_id, '') As GoogleEventId,
			@userId As UserId,
			IsNULL(r.google_drive_doc_id, '') As GoogleDriveDocId,
			IsNULL(r.document_link, '') As DocumentName
	From	Radnje r
			Left Join VrsteRadnji vr On r.VrstaRadnjeId = vr.id And r.PredmetId = @caseId And IsNULL(r.is_deleted, 0) = 0
			Left Join uUsers u On r.RadnjuObavioId = u.id
			Left Join NaciniObavljanjaRadnje nor On r.NacinObavljanjaId = nor.id
	Where	r.PredmetId = @caseId
			And IsNULL(r.is_deleted, 0) = 0
END
GO







------------------------------------------------------------------------------------------------------------------------------



/****** Object:  StoredProcedure [dbo].[Radnja_Insert]    Script Date: 18.10.2017 19:28:48 ******/
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
	@nacinObavljanjaId int,
	@documentName nvarchar(MAX),
	@googleDriveDocId nvarchar(MAX),
	@googleEventId nvarchar(255)
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Id), 0) From Radnje) + 1;

	If @vrstaRadnjeId = -1
		Set @vrstaRadnjeId = NULL;

    Insert Into Radnje (id, PredmetId, Radnja, Datum, Troskovi, Biljeske, DatumPrijema, VrijednostRadnje, VrstaRadnjeId, RadnjuObavioId, NacinObavljanjaId, document_link, google_drive_doc_id, google_event_id, is_deleted)
	Values (@id, @caseId, '', @datumRadnje, @troskovi, @biljeske, @datumPrijema, @vrijednostRadnje, @vrstaRadnjeId, @radnjuObavioId, @nacinObavljanjaId, @documentName, @googleDriveDocId, @googleEventId, 0);

	Select @id;
END
GO





/****** Object:  StoredProcedure [dbo].[Radnja_Update]    Script Date: 18.10.2017 19:29:26 ******/
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
	@documentName nvarchar(MAX),
	@googleDriveDocId nvarchar(MAX),
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
			NacinObavljanjaId = @nacinObavljanjaId,
			document_link = @documentName,
			google_drive_doc_id = @googleDriveDocId
	Where	id = @id

END
GO





/****** Object:  StoredProcedure [dbo].[Document_Insert]    Script Date: 18.10.2017 19:37:16 ******/
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
	@tipDokumentaId int,
	@predatoUzDokumentName nvarchar(MAX),
	@documentName nvarchar(MAX),
	@googleDriveDocId nvarchar(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @id int = (Select IsNULL(MAX(Id), 0) From Dokumenti) + 1;

	If @tipDokumentaId = -1
		Set @tipDokumentaId = NULL;

	Declare @predatoUzDokumentId int
	If IsNULL(@predatoUzDokumentName, '') = ''
		Set @predatoUzDokumentId = NULL;
	Else
	Begin
		Set @predatoUzDokumentId = (Select id From PredatoUzDokumenti Where name = @predatoUzDokumentName)
		If @predatoUzDokumentId Is NULL
		Begin
			Insert Into PredatoUzDokumenti(name) Values (@predatoUzDokumentName);
			Set @predatoUzDokumentId = SCOPE_IDENTITY();
		End
	End
		
    Insert Into Dokumenti (id, PredmetId, Biljeske, TipDokumentaId, PredatoUzDokumentiId, document_link, google_drive_doc_id, is_deleted)
	Values (@id, @caseId, @note, @tipDokumentaId, @predatoUzDokumentId, @documentName, @googleDriveDocId, 0);

	Select @id;
END
GO





/****** Object:  StoredProcedure [dbo].[Document_Update]    Script Date: 18.10.2017 19:37:54 ******/
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
	@tipDokumentaId int,
	@predatoUzDokumentName nvarchar(MAX),
	@documentName nvarchar(MAX),
	@googleDriveDocId nvarchar(MAX),
	@id int
)
AS
BEGIN
	SET NOCOUNT ON;

	If @tipDokumentaId = -1
		Set @tipDokumentaId = NULL;

	Declare @predatoUzDokumentId int
	If IsNULL(@predatoUzDokumentName, '') = ''
		Set @predatoUzDokumentId = NULL;
	Else
	Begin
		Set @predatoUzDokumentId = (Select id From PredatoUzDokumenti Where name = @predatoUzDokumentName)
		If @predatoUzDokumentId Is NULL
		Begin
			Insert Into PredatoUzDokumenti(name) Values (@predatoUzDokumentName);
			Set @predatoUzDokumentId = SCOPE_IDENTITY();
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






/****** Object:  StoredProcedure [dbo].[Lica_GetAll]    Script Date: 27.10.2017 16:57:52 ******/
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
			case when Ime Is Not NULL And Prezime Is Not NULL then Prezime + ' ' + Ime else PravnoLice end As Naziv
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
						Or case when Ime Is Not NULL And Prezime Is Not NULL then Prezime + ' ' + Ime else PravnoLice end Like '%' + @filter + '%'
					)
				)
				Or L.Id = IsNULL(@partyId, -1)
			)
	Order By	case when (@partyId Is NOT NULL And L.Id = @partyId) then 1 else 2 end ASC,
				case when Ime Is Not NULL And Prezime Is Not NULL then Prezime + ' ' + Ime else PravnoLice end ASC

END
GO










/****** Object:  StoredProcedure [dbo].[Radnje_GetForCase]    Script Date: 31.10.2017 14:11:52 ******/
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
	@caseId int,
	@userId int
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @userGoogleDriveLocalFolderPath nvarchar(MAX) = (Select IsNULL(google_drive_local_folder_path, '') From uUsers Where id = @userId)

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
			IsNULL(r.google_event_id, '') As GoogleEventId,
			@userId As UserId,
			IsNULL(r.google_drive_doc_id, '') As GoogleDriveDocId,
			IsNULL(r.document_link, '') As DocumentName,
			CAST((case when IsNULL(vr.name, '') Like '%*' then 1 else 0 end) As bit) As CreateCalendarEvent
	From	Radnje r
			Left Join VrsteRadnji vr On r.VrstaRadnjeId = vr.id And r.PredmetId = @caseId And IsNULL(r.is_deleted, 0) = 0
			Left Join uUsers u On r.RadnjuObavioId = u.id
			Left Join NaciniObavljanjaRadnje nor On r.NacinObavljanjaId = nor.id
	Where	r.PredmetId = @caseId
			And IsNULL(r.is_deleted, 0) = 0
END
GO





/****** Object:  StoredProcedure [dbo].[CodeTable_GetData]    Script Date: 31.10.2017 16:20:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-06-10
-- Description:	Get data from code table
-- =============================================
ALTER PROCEDURE [dbo].[CodeTable_GetData] (
	@tableName varchar(255),
	@columnName varchar(255),
	@filter nvarchar(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;

    EXEC('SELECT Id, ' + @columnName + ' AS Name FROM ' + @tableName + ' WHERE ' + @columnName + ' LIKE N''%' + @filter + '%'' ORDER BY 2 ASC');
END
GO







Insert Into uUserGroups (code, name)
Values ('user_admin','Administrator korisnika'),
('office_admin', 'Administrator kancelarije'),
('office_reader', 'Čitač kancelarije')
GO


Insert Into uUserUserGroups(user_group_id, user_id) Values (1, 1), (2, 1), (3, 1)
Go






/****** Object:  StoredProcedure [dbo].[GetDocsForMapping]    Script Date: 2.11.2017 0:40:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Meholjic
-- Create date: 2017-10-12
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[GetDocsForMapping]
AS
BEGIN
	SET NOCOUNT ON;

    Select	Id,
			REPLACE(document_link, '%20', ' ') as UNC
	From	Dokumenti
	Where	IsNULL(google_drive_doc_id, '') = ''
			And TipDokumenta Is Not NULL
	Order By	id Desc
END
GO











-- !!!!!!!!! MAP THESE PARTIES MANUALLY:

Select	Distinct StrankaNasa, ln.Naziv
From	Predmeti p
		Left Join Lica_Predmet lpn On p.Id = lpn.PredmetId And lpn.is_nasa_stranka = 1
		Left Join vLica ln On lpn.id = ln.Id
Where	(StrankaNasa Is Not NULL And ln.Naziv Is NULL)

Select	Distinct StrankaProtivna, lp.Naziv
From	Predmeti p
		Left Join Lica_Predmet lpp On p.Id = lpp.PredmetId And lpp.is_protivna_stranka = 1
		Left Join vLica lp On lpp.id = lp.Id
Where	(StrankaProtivna Is Not NULL And lp.Naziv Is NULL)













If Not Exists (Select 1 From VrsteRadnji Where name = N'Vansudski zahtjev') Insert Into VrsteRadnji (name) Values (N'Vansudski zahtjev');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Vansudski sporazum') Insert Into VrsteRadnji (name) Values (N'Vansudski sporazum');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Opomena pred tužbu') Insert Into VrsteRadnji (name) Values (N'Opomena pred tužbu');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Opomena pred izvršenje') Insert Into VrsteRadnji (name) Values (N'Opomena pred izvršenje');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Tužba') Insert Into VrsteRadnji (name) Values (N'Tužba');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Tužba za naknadu materijalne štete') Insert Into VrsteRadnji (name) Values (N'Tužba za naknadu materijalne štete');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Tužba za naknadu nematerijalne štete') Insert Into VrsteRadnji (name) Values (N'Tužba za naknadu nematerijalne štete');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Tužba za naknadu materijalne/nematerijalne štete') Insert Into VrsteRadnji (name) Values (N'Tužba za naknadu materijalne/nematerijalne štete');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Tužba za utvrdenje') Insert Into VrsteRadnji (name) Values (N'Tužba za utvrdenje');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Tužba za utvrdenje i uknjižbu') Insert Into VrsteRadnji (name) Values (N'Tužba za utvrdenje i uknjižbu');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Tužba za razvod braka') Insert Into VrsteRadnji (name) Values (N'Tužba za razvod braka');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Tužba za prava iz radnog odnosa') Insert Into VrsteRadnji (name) Values (N'Tužba za prava iz radnog odnosa');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Tužba za razvod braka') Insert Into VrsteRadnji (name) Values (N'Tužba za razvod braka');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Tužba za utvrdenje bracne stecevine') Insert Into VrsteRadnji (name) Values (N'Tužba za utvrdenje bracne stecevine');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Odgovor na tužbu') Insert Into VrsteRadnji (name) Values (N'Odgovor na tužbu');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Odgovor na žalbu') Insert Into VrsteRadnji (name) Values (N'Odgovor na žalbu');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Odgovor na reviziju') Insert Into VrsteRadnji (name) Values (N'Odgovor na reviziju');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Odgovor na apelaciju') Insert Into VrsteRadnji (name) Values (N'Odgovor na apelaciju');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Odgovor na dopis') Insert Into VrsteRadnji (name) Values (N'Odgovor na dopis');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Odgovor na zahtjev') Insert Into VrsteRadnji (name) Values (N'Odgovor na zahtjev');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Odgovor na prigovor') Insert Into VrsteRadnji (name) Values (N'Odgovor na prigovor');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Pripremno rocište*') Insert Into VrsteRadnji (name) Values (N'Pripremno rocište*');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Glavna rasprava*') Insert Into VrsteRadnji (name) Values (N'Glavna rasprava*');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rocište za prodaju*') Insert Into VrsteRadnji (name) Values (N'Rocište za prodaju*');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rocište za popis imovine*') Insert Into VrsteRadnji (name) Values (N'Rocište za popis imovine*');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Uvidaj*') Insert Into VrsteRadnji (name) Values (N'Uvidaj*');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Podnesak') Insert Into VrsteRadnji (name) Values (N'Podnesak');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Podnesak kojim se povlaci tužba') Insert Into VrsteRadnji (name) Values (N'Podnesak kojim se povlaci tužba');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Podnesak kojim se traži odgoda rocišta') Insert Into VrsteRadnji (name) Values (N'Podnesak kojim se traži odgoda rocišta');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Podnesak kojim se preinacava tužba') Insert Into VrsteRadnji (name) Values (N'Podnesak kojim se preinacava tužba');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Podnesak kojim se ureduje tužbeni zahtjev') Insert Into VrsteRadnji (name) Values (N'Podnesak kojim se ureduje tužbeni zahtjev');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Podnesak kojim se dostavljaju dokazi') Insert Into VrsteRadnji (name) Values (N'Podnesak kojim se dostavljaju dokazi');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Dokaz o uplati takse') Insert Into VrsteRadnji (name) Values (N'Dokaz o uplati takse');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Dokaz o uplati vještacenja') Insert Into VrsteRadnji (name) Values (N'Dokaz o uplati vještacenja');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Dopis kojim se traži dostava dokumentacije') Insert Into VrsteRadnji (name) Values (N'Dopis kojim se traži dostava dokumentacije');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Presuda') Insert Into VrsteRadnji (name) Values (N'Presuda');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Presuda kojom se tužbeni zahtjev usvaja') Insert Into VrsteRadnji (name) Values (N'Presuda kojom se tužbeni zahtjev usvaja');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Presuda kojom se tužbeni zahtjev odbija') Insert Into VrsteRadnji (name) Values (N'Presuda kojom se tužbeni zahtjev odbija');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Presuda kojom se tužbeni zahtjev odbacuje') Insert Into VrsteRadnji (name) Values (N'Presuda kojom se tužbeni zahtjev odbacuje');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Presuda kojom se tužbeni zahtjev djelimicno usvaja') Insert Into VrsteRadnji (name) Values (N'Presuda kojom se tužbeni zahtjev djelimicno usvaja');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Presuda kojom se žalba usvaja') Insert Into VrsteRadnji (name) Values (N'Presuda kojom se žalba usvaja');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Presuda kojom se žalba odbija') Insert Into VrsteRadnji (name) Values (N'Presuda kojom se žalba odbija');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Presuda kojom se žalba djelimicno usvaja') Insert Into VrsteRadnji (name) Values (N'Presuda kojom se žalba djelimicno usvaja');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Presuda kojom se revizija usvaja') Insert Into VrsteRadnji (name) Values (N'Presuda kojom se revizija usvaja');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Presuda kojom se revizija odbija') Insert Into VrsteRadnji (name) Values (N'Presuda kojom se revizija odbija');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Presuda kojom se revizija djelimicno usvaja') Insert Into VrsteRadnji (name) Values (N'Presuda kojom se revizija djelimicno usvaja');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rješenje') Insert Into VrsteRadnji (name) Values (N'Rješenje');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rješenje o povlacenju tužbe') Insert Into VrsteRadnji (name) Values (N'Rješenje o povlacenju tužbe');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rješenje o izvršenju') Insert Into VrsteRadnji (name) Values (N'Rješenje o izvršenju');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rješenje kojim se žalba usvaja') Insert Into VrsteRadnji (name) Values (N'Rješenje kojim se žalba usvaja');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rješenje kojim se žalba odbija') Insert Into VrsteRadnji (name) Values (N'Rješenje kojim se žalba odbija');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rješenje kojim se žalba odbacuje') Insert Into VrsteRadnji (name) Values (N'Rješenje kojim se žalba odbacuje');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rješenje kojim se revizija odbacuje') Insert Into VrsteRadnji (name) Values (N'Rješenje kojim se revizija odbacuje');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rješenje kojim se žalba djelimicno usvaja') Insert Into VrsteRadnji (name) Values (N'Rješenje kojim se žalba djelimicno usvaja');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rješenje o troškovima postupka') Insert Into VrsteRadnji (name) Values (N'Rješenje o troškovima postupka');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rješenje kojim se presuda ') Insert Into VrsteRadnji (name) Values (N'Rješenje kojim se presuda ');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rješenje po prigovoru') Insert Into VrsteRadnji (name) Values (N'Rješenje po prigovoru');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rješenje kojim se prigovor usvaja') Insert Into VrsteRadnji (name) Values (N'Rješenje kojim se prigovor usvaja');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rješenje kojim se prigovor djelimicno usvaja') Insert Into VrsteRadnji (name) Values (N'Rješenje kojim se prigovor djelimicno usvaja');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rješenje kojim se prigovor obija') Insert Into VrsteRadnji (name) Values (N'Rješenje kojim se prigovor obija');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rješenje kojim se prigovor odbacuje') Insert Into VrsteRadnji (name) Values (N'Rješenje kojim se prigovor odbacuje');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rješenje kojim se potvrduje optužnica') Insert Into VrsteRadnji (name) Values (N'Rješenje kojim se potvrduje optužnica');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Dopunska presuda') Insert Into VrsteRadnji (name) Values (N'Dopunska presuda');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Dopunsko rješenje') Insert Into VrsteRadnji (name) Values (N'Dopunsko rješenje');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Žalba') Insert Into VrsteRadnji (name) Values (N'Žalba');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Žalba tuženog') Insert Into VrsteRadnji (name) Values (N'Žalba tuženog');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Žalba tužitelja') Insert Into VrsteRadnji (name) Values (N'Žalba tužitelja');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Žacba umješaca') Insert Into VrsteRadnji (name) Values (N'Žacba umješaca');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Revizija') Insert Into VrsteRadnji (name) Values (N'Revizija');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Revizija tuženog') Insert Into VrsteRadnji (name) Values (N'Revizija tuženog');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Revizija tužitelja') Insert Into VrsteRadnji (name) Values (N'Revizija tužitelja');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Revizija umješaca') Insert Into VrsteRadnji (name) Values (N'Revizija umješaca');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Apelacija') Insert Into VrsteRadnji (name) Values (N'Apelacija');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Odluka kojom se apelacija usvaja') Insert Into VrsteRadnji (name) Values (N'Odluka kojom se apelacija usvaja');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Odluka kojom se apelacija odbacuje kao nedopuštena') Insert Into VrsteRadnji (name) Values (N'Odluka kojom se apelacija odbacuje kao nedopuštena');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Odluka kojom se apelacija odbacuje kao preuranjena') Insert Into VrsteRadnji (name) Values (N'Odluka kojom se apelacija odbacuje kao preuranjena');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Odluka kojom se apelacija odbija se kao neosnovana') Insert Into VrsteRadnji (name) Values (N'Odluka kojom se apelacija odbija se kao neosnovana');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Zahtjev za iskljucenje') Insert Into VrsteRadnji (name) Values (N'Zahtjev za iskljucenje');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Zahtjev za izuzece') Insert Into VrsteRadnji (name) Values (N'Zahtjev za izuzece');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Zahtjev za sporazumni razvod braka') Insert Into VrsteRadnji (name) Values (N'Zahtjev za sporazumni razvod braka');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Zahtjev za oslobadanje od placanja sudskih troškova') Insert Into VrsteRadnji (name) Values (N'Zahtjev za oslobadanje od placanja sudskih troškova');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Optužnica') Insert Into VrsteRadnji (name) Values (N'Optužnica');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rocište o prethodnom saslušanju*') Insert Into VrsteRadnji (name) Values (N'Rocište o prethodnom saslušanju*');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Rocište radi izjašnjenja o krivnji*') Insert Into VrsteRadnji (name) Values (N'Rocište radi izjašnjenja o krivnji*');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Pretres*') Insert Into VrsteRadnji (name) Values (N'Pretres*');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Prekršajni nalog') Insert Into VrsteRadnji (name) Values (N'Prekršajni nalog');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Prijedlog za izvršenje') Insert Into VrsteRadnji (name) Values (N'Prijedlog za izvršenje');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Prijedlog za protivizvršenje') Insert Into VrsteRadnji (name) Values (N'Prijedlog za protivizvršenje');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Prijedlog za oduzimanje roditeljskog staranja') Insert Into VrsteRadnji (name) Values (N'Prijedlog za oduzimanje roditeljskog staranja');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Prijedlog za raspravljanje zaostavštine') Insert Into VrsteRadnji (name) Values (N'Prijedlog za raspravljanje zaostavštine');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Prijedlog za donošenje dopunske presude') Insert Into VrsteRadnji (name) Values (N'Prijedlog za donošenje dopunske presude');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Prijedlog za ispravku presude') Insert Into VrsteRadnji (name) Values (N'Prijedlog za ispravku presude');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Prigovor na rješenje o izvršenju') Insert Into VrsteRadnji (name) Values (N'Prigovor na rješenje o izvršenju');
If Not Exists (Select 1 From VrsteRadnji Where name = N'Prigovor na ponudu') Insert Into VrsteRadnji (name) Values (N'Prigovor na ponudu');






UPDATE VrsteRadnji Set name = N'Dokaz o placenoj taksi' WHERE name = N'Podnesak o placenoj sudskoj taksi';
UPDATE VrsteRadnji Set name = N'Presuda' WHERE name = N'Drugostepena presuda';
UPDATE VrsteRadnji Set name = N'Presuda kojom se žalba usvaja' WHERE name = N'Drugostepena presuda kojom se žalba usvaja';
UPDATE VrsteRadnji Set name = N'Presuda kojom se žalba odbija' WHERE name = N'Drugostepena presuda kojom se žalba odbija';
UPDATE VrsteRadnji Set name = N'Rješenje kojim se žalba odbacuje' WHERE name = N'Drugostepena presuda kojom se žalba odbacuje';
UPDATE VrsteRadnji Set name = N'Presuda kojom se žalba djelimicno usvaja' WHERE name = N'Drugostepena presuda kojom se žalba djelimicno usvaja';
UPDATE VrsteRadnji Set name = N'Rješenje' WHERE name = N'Drugostepeno rješenje';
UPDATE VrsteRadnji Set name = N'Rješenje kojim se žalba usvaja' WHERE name = N'Drugostepeno rješenje kojim se žalba usvaja';
UPDATE VrsteRadnji Set name = N'Rješenje kojim se žalba odbija' WHERE name = N'Drugostepeno rješenje kojim se žalba odbija';
UPDATE VrsteRadnji Set name = N'Rješenje kojim se žalba odbacuje' WHERE name = N'Drugostepeno rješenje kojim se žalba odbacuje';
UPDATE VrsteRadnji Set name = N'Rješenje kojim se žalba djelimicno usvaja' WHERE name = N'Drugostepeno rješenje kojim se žalba djelimicno usvaja';
UPDATE VrsteRadnji Set name = N'Presuda kojom se revizija usvaja' WHERE name = N'Odluka po reviziji kojom se revizija usvaja';
UPDATE VrsteRadnji Set name = N'Presuda kojom se revizija odbija' WHERE name = N'Odluka po reviziji kojom se revizija odbija';
UPDATE VrsteRadnji Set name = N'Rješenje kojim se revizija odbacuje' WHERE name = N'Odluka po reviziji kojom se revizija odbacuje';
UPDATE VrsteRadnji Set name = N'Presuda kojom se revizija djelimicno usvaja' WHERE name = N'Odluka po reviziji kojom se revizija djelimicno usvaja';
UPDATE VrsteRadnji Set name = N'Odluka kojom se apelacija usvaja' WHERE name = N'Odluka po apelaciji - se usvaja';
UPDATE VrsteRadnji Set name = N'Odluka kojom se apelacija odbacuje kao nedopuštena' WHERE name = N'Odluka po apelaciji - odbacuje se kao nedopuštena';
UPDATE VrsteRadnji Set name = N'Odluka kojom se apelacija odbija se kao neosnovana' WHERE name = N'Odluka po apelaciji - odbija se kao neosnovana';
UPDATE VrsteRadnji Set name = N'Rocište radi izjašnjenja o krivnji' WHERE name = N'Rocište o priznanju krivnje';






update VrsteRadnji set name = name + '*' where id in (42,193,209,277,175,40,36,287);
delete from VrsteRadnji where id in (315, 316, 317, 318, 319, 346, 347, 348);





IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali tužbu na sud') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali tužbu na sud');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali odgovor na tužbu na sud') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali odgovor na tužbu na sud');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali prijedlog za izvršenje na sud') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali prijedlog za izvršenje na sud');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali vansudski zahtjev') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali vansudski zahtjev');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali našu žalbu na sud') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali našu žalbu na sud');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali našu reviziju na sud') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali našu reviziju na sud');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali potpisan vansudski sporazum') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali potpisan vansudski sporazum');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali zahtjev za isplatu') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali zahtjev za isplatu');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali zahtjev Centralnoj banci radi dostave podataka') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali zahtjev Centralnoj banci radi dostave podataka');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali zahtjev Agenciji za identifikacijske dokumente radi dostave podataka') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali zahtjev Agenciji za identifikacijske dokumente radi dostave podataka');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali zahtjev PIO radi dostave podataka') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali zahtjev PIO radi dostave podataka');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali zahtjev policiji radi dostave podataka') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali zahtjev policiji radi dostave podataka');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali zahtjev osiguranju radi dostave podataka') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali zahtjev osiguranju radi dostave podataka');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali podnesak sudu o placenoj taksi na tužbu') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali podnesak sudu o placenoj taksi na tužbu');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali podnesak sudu o placenoj taksi na presudu') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali podnesak sudu o placenoj taksi na presudu');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali podnesak sudu o placenom vještacenju') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali podnesak sudu o placenom vještacenju');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali podnesak sudu o povlacenju tužbe, sacekati rješenje pa arhivirati') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali podnesak sudu o povlacenju tužbe, sacekati rješenje pa arhivirati');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali podnesak sudu kojim se dostavlja uredena tužba') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali podnesak sudu kojim se dostavlja uredena tužba');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali podnesak sudu kojim se dostavlja uredeni prijedlog') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali podnesak sudu kojim se dostavlja uredeni prijedlog');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali podnesak sudu kojim se preinacava tužbeni zahtjev') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali podnesak sudu kojim se preinacava tužbeni zahtjev');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'poslali podnesak sudu kojim se dostavlja dodatna dokumentacija') INSERT INTO StanjaPredmeta (name) VALUES (N'poslali podnesak sudu kojim se dostavlja dodatna dokumentacija');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'zaprimljen poziv za placanje sudske takse na tužbu') INSERT INTO StanjaPredmeta (name) VALUES (N'zaprimljen poziv za placanje sudske takse na tužbu');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'zaprimljen poziv za placanje sudske takse na presudu') INSERT INTO StanjaPredmeta (name) VALUES (N'zaprimljen poziv za placanje sudske takse na presudu');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'zaprimljen poziv za placanje sudske takse na žalbu') INSERT INTO StanjaPredmeta (name) VALUES (N'zaprimljen poziv za placanje sudske takse na žalbu');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'zaprimljen poziv za placanje sudske takse na reviziju') INSERT INTO StanjaPredmeta (name) VALUES (N'zaprimljen poziv za placanje sudske takse na reviziju');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'zaprimljen odgovor na tužbu') INSERT INTO StanjaPredmeta (name) VALUES (N'zaprimljen odgovor na tužbu');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'zaprimljen odgovor na žalbu') INSERT INTO StanjaPredmeta (name) VALUES (N'zaprimljen odgovor na žalbu');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'zaprimljen poziv za pripremno rocište') INSERT INTO StanjaPredmeta (name) VALUES (N'zaprimljen poziv za pripremno rocište');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'zaprimljen poziv za glavnu raspravu') INSERT INTO StanjaPredmeta (name) VALUES (N'zaprimljen poziv za glavnu raspravu');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'zaprimljen prigovor na rješenje o izvršenju') INSERT INTO StanjaPredmeta (name) VALUES (N'zaprimljen prigovor na rješenje o izvršenju');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'zaprimljeno rješenje o izvršenju') INSERT INTO StanjaPredmeta (name) VALUES (N'zaprimljeno rješenje o izvršenju');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'zaprimljena žalba') INSERT INTO StanjaPredmeta (name) VALUES (N'zaprimljena žalba');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'zaprimljena revizija') INSERT INTO StanjaPredmeta (name) VALUES (N'zaprimljena revizija');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'zaprimljena apelacija') INSERT INTO StanjaPredmeta (name) VALUES (N'zaprimljena apelacija');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'zaprimljena presuda') INSERT INTO StanjaPredmeta (name) VALUES (N'zaprimljena presuda');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'zaprimljena drugostepena presuda') INSERT INTO StanjaPredmeta (name) VALUES (N'zaprimljena drugostepena presuda');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'zaprimljena odluka po reviziji') INSERT INTO StanjaPredmeta (name) VALUES (N'zaprimljena odluka po reviziji');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'zaprimljena odluka po apelaciji') INSERT INTO StanjaPredmeta (name) VALUES (N'zaprimljena odluka po apelaciji');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'zaprimljeno rješenje o provodenju vještacenja') INSERT INTO StanjaPredmeta (name) VALUES (N'zaprimljeno rješenje o provodenju vještacenja');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'cekamo stranku da plati vještacenje') INSERT INTO StanjaPredmeta (name) VALUES (N'cekamo stranku da plati vještacenje');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'cekamo stranku da plati sudsku taksu') INSERT INTO StanjaPredmeta (name) VALUES (N'cekamo stranku da plati sudsku taksu');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'cekamo presudu') INSERT INTO StanjaPredmeta (name) VALUES (N'cekamo presudu');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'cekamo žalbu') INSERT INTO StanjaPredmeta (name) VALUES (N'cekamo žalbu');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'cekamo reviziju') INSERT INTO StanjaPredmeta (name) VALUES (N'cekamo reviziju');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'stranka isplacena, predmet arhiviran') INSERT INTO StanjaPredmeta (name) VALUES (N'stranka isplacena, predmet arhiviran');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'uplata po drugostepenoj presudi') INSERT INTO StanjaPredmeta (name) VALUES (N'uplata po drugostepenoj presudi');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'uplata po prvostepenoj presudi') INSERT INTO StanjaPredmeta (name) VALUES (N'uplata po prvostepenoj presudi');
IF NOT EXISTS (SELECT 1 FROM StanjaPredmeta WHERE name = N'uplata po vansudskom sporazumu') INSERT INTO StanjaPredmeta (name) VALUES (N'uplata po vansudskom sporazumu');








/****** Object:  View [dbo].[vLica]    Script Date: 5.11.2017 1:46:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[vLica]
AS
	SELECT	Id,
			CASE WHEN IsNULL(Ime, '') <> '' AND IsNULL(Prezime, '') <> '' THEN Prezime + ' ' + Ime ELSE PravnoLice END AS Naziv,
			Adresa,
			PostanskiBroj,
			Grad,
			JMBG_IDBroj
	FROM	dbo.Lica AS L


GO





/****** Object:  StoredProcedure [dbo].[Lica_GetAll]    Script Date: 5.11.2017 1:45:36 ******/
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
			CASE WHEN IsNULL(Ime, '') <> '' AND IsNULL(Prezime, '') <> '' THEN Prezime + ' ' + Ime ELSE PravnoLice END AS Naziv
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
						Or case when Ime Is Not NULL And Prezime Is Not NULL then Prezime + ' ' + Ime else PravnoLice end Like '%' + @filter + '%'
					)
				)
				Or L.Id = IsNULL(@partyId, -1)
			)
	Order By	case when (@partyId Is NOT NULL And L.Id = @partyId) then 1 else 2 end ASC,
				case when Ime Is Not NULL And Prezime Is Not NULL then Prezime + ' ' + Ime else PravnoLice end ASC

END
GO







