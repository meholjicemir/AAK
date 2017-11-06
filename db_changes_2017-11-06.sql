/****** Object:  StoredProcedure [dbo].[Predmeti_GetAll]    Script Date: 6.11.2017 10:40:00 ******/
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






/****** Object:  StoredProcedure [dbo].[LicePredmet_GetForPredmet]    Script Date: 6.11.2017 18:15:54 ******/
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
	Order By lp.Lica_PredmetId Asc
	
END
GO







UPDATE Takse SET Iznos = 	750.00	WHERE Id = 	1	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	2	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	3	;
UPDATE Takse SET Iznos = 	1143.00	WHERE Id = 	4	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	5	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	6	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	7	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	8	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	9	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	10	;
UPDATE Takse SET Iznos = 	225.00	WHERE Id = 	11	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	12	;
UPDATE Takse SET Iznos = 	279.00	WHERE Id = 	13	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	14	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	15	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	16	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	17	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	18	;
UPDATE Takse SET Iznos = 	221.00	WHERE Id = 	19	;
UPDATE Takse SET Iznos = 	15.00	WHERE Id = 	20	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	21	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	22	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	23	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	24	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	25	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	26	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	27	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	28	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	29	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	30	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	31	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	32	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	33	;
UPDATE Takse SET Iznos = 	390.00	WHERE Id = 	34	;
UPDATE Takse SET Iznos = 	387.72	WHERE Id = 	35	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	36	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	37	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	38	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	39	;
UPDATE Takse SET Iznos = 	330.00	WHERE Id = 	40	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	41	;
UPDATE Takse SET Iznos = 	216.90	WHERE Id = 	42	;
UPDATE Takse SET Iznos = 	220.00	WHERE Id = 	43	;
UPDATE Takse SET Iznos = 	600.00	WHERE Id = 	44	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	45	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	46	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	47	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	48	;
UPDATE Takse SET Iznos = 	60.00	WHERE Id = 	49	;
UPDATE Takse SET Iznos = 	405.00	WHERE Id = 	50	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	51	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	52	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	53	;
UPDATE Takse SET Iznos = 	337.00	WHERE Id = 	54	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	55	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	56	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	57	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	58	;
UPDATE Takse SET Iznos = 	925.00	WHERE Id = 	59	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	60	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	61	;
UPDATE Takse SET Iznos = 	240.00	WHERE Id = 	62	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	63	;
UPDATE Takse SET Iznos = 	230.00	WHERE Id = 	64	;
UPDATE Takse SET Iznos = 	615.00	WHERE Id = 	65	;
UPDATE Takse SET Iznos = 	307.00	WHERE Id = 	66	;
UPDATE Takse SET Iznos = 	750.00	WHERE Id = 	67	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	68	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	69	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	70	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	71	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	72	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	73	;
UPDATE Takse SET Iznos = 	750.00	WHERE Id = 	74	;
UPDATE Takse SET Iznos = 	572.50	WHERE Id = 	75	;
UPDATE Takse SET Iznos = 	2827.00	WHERE Id = 	76	;
UPDATE Takse SET Iznos = 	1116.00	WHERE Id = 	77	;
UPDATE Takse SET Iznos = 	884.00	WHERE Id = 	78	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	79	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	80	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	81	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	82	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	83	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	84	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	85	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	86	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	87	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	88	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	89	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	90	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	91	;
UPDATE Takse SET Iznos = 	54.00	WHERE Id = 	92	;
UPDATE Takse SET Iznos = 	120.00	WHERE Id = 	93	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	94	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	95	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	96	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	97	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	98	;
UPDATE Takse SET Iznos = 	330.00	WHERE Id = 	99	;
UPDATE Takse SET Iznos = 	362.40	WHERE Id = 	100	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	101	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	103	;
UPDATE Takse SET Iznos = 	125.00	WHERE Id = 	104	;
UPDATE Takse SET Iznos = 	260.00	WHERE Id = 	105	;
UPDATE Takse SET Iznos = 	125.00	WHERE Id = 	106	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	107	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	108	;
UPDATE Takse SET Iznos = 	81.00	WHERE Id = 	109	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	110	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	111	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	112	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	113	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	114	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	115	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	116	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	117	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	118	;
UPDATE Takse SET Iznos = 	662.00	WHERE Id = 	119	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	120	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	121	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	122	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	123	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	124	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	125	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	126	;
UPDATE Takse SET Iznos = 	260.00	WHERE Id = 	127	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	128	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	129	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	130	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	131	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	132	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	133	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	134	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	135	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	136	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	137	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	138	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	139	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	140	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	141	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	142	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	143	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	144	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	145	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	146	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	147	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	148	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	149	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	150	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	151	;
UPDATE Takse SET Iznos = 	74.00	WHERE Id = 	152	;
UPDATE Takse SET Iznos = 	210.00	WHERE Id = 	153	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	154	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	155	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	156	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	157	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	158	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	159	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	160	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	161	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	162	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	163	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	164	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	165	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	166	;
UPDATE Takse SET Iznos = 	72.00	WHERE Id = 	167	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	168	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	169	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	170	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	171	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	172	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	173	;
UPDATE Takse SET Iznos = 	2500.00	WHERE Id = 	174	;
UPDATE Takse SET Iznos = 	105.00	WHERE Id = 	175	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	176	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	177	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	178	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	179	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	180	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	181	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	182	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	183	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	184	;
UPDATE Takse SET Iznos = 	105.00	WHERE Id = 	185	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	186	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	187	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	188	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	189	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	190	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	191	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	192	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	193	;
UPDATE Takse SET Iznos = 	15.00	WHERE Id = 	194	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	195	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	196	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	197	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	198	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	199	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	200	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	201	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	202	;
UPDATE Takse SET Iznos = 	2515.80	WHERE Id = 	203	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	204	;
UPDATE Takse SET Iznos = 	550.00	WHERE Id = 	205	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	206	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	207	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	208	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	209	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	210	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	211	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	212	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	213	;
UPDATE Takse SET Iznos = 	437.00	WHERE Id = 	214	;
UPDATE Takse SET Iznos = 	473.00	WHERE Id = 	215	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	216	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	217	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	218	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	219	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	220	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	221	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	223	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	224	;
UPDATE Takse SET Iznos = 	256.00	WHERE Id = 	225	;
UPDATE Takse SET Iznos = 	443.30	WHERE Id = 	226	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	227	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	228	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	229	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	230	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	231	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	232	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	233	;
UPDATE Takse SET Iznos = 	240.00	WHERE Id = 	234	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	235	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	236	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	237	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	238	;
UPDATE Takse SET Iznos = 	1920.00	WHERE Id = 	239	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	240	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	241	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	242	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	243	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	244	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	245	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	246	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	247	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	248	;
UPDATE Takse SET Iznos = 	550.00	WHERE Id = 	249	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	250	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	251	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	252	;
UPDATE Takse SET Iznos = 	303.15	WHERE Id = 	253	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	254	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	255	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	256	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	257	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	258	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	259	;
UPDATE Takse SET Iznos = 	1250.00	WHERE Id = 	260	;
UPDATE Takse SET Iznos = 	2000.00	WHERE Id = 	261	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	262	;
UPDATE Takse SET Iznos = 	330.00	WHERE Id = 	263	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	264	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	265	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	266	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	267	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	269	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	270	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	271	;
UPDATE Takse SET Iznos = 	330.00	WHERE Id = 	272	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	273	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	274	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	275	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	276	;
UPDATE Takse SET Iznos = 	330.00	WHERE Id = 	277	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	278	;
UPDATE Takse SET Iznos = 	176.00	WHERE Id = 	279	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	281	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	282	;
UPDATE Takse SET Iznos = 	155.00	WHERE Id = 	283	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	284	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	285	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	286	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	287	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	288	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	289	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	290	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	291	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	292	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	293	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	294	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	295	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	296	;
UPDATE Takse SET Iznos = 	165.00	WHERE Id = 	297	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	298	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	299	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	300	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	301	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	302	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	303	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	304	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	305	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	306	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	307	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	308	;
UPDATE Takse SET Iznos = 	72.00	WHERE Id = 	309	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	310	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	311	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	312	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	313	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	314	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	315	;
UPDATE Takse SET Iznos = 	225.00	WHERE Id = 	316	;
UPDATE Takse SET Iznos = 	525.00	WHERE Id = 	317	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	318	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	319	;
UPDATE Takse SET Iznos = 	258.00	WHERE Id = 	320	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	321	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	322	;
UPDATE Takse SET Iznos = 	195.00	WHERE Id = 	323	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	324	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	325	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	326	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	327	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	328	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	329	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	330	;
UPDATE Takse SET Iznos = 	219.00	WHERE Id = 	331	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	332	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	333	;
UPDATE Takse SET Iznos = 	120.00	WHERE Id = 	334	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	335	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	336	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	337	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	338	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	339	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	340	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	341	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	342	;
UPDATE Takse SET Iznos = 	15.79	WHERE Id = 	343	;
UPDATE Takse SET Iznos = 	30.00	WHERE Id = 	344	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	345	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	346	;
UPDATE Takse SET Iznos = 	1192.60	WHERE Id = 	347	;
UPDATE Takse SET Iznos = 	20.00	WHERE Id = 	348	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	349	;
UPDATE Takse SET Iznos = 	50.00	WHERE Id = 	350	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	352	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	353	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	354	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	355	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	356	;
UPDATE Takse SET Iznos = 	60.00	WHERE Id = 	359	;
UPDATE Takse SET Iznos = 	500.77	WHERE Id = 	360	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	361	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	362	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	363	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	364	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	365	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	366	;
UPDATE Takse SET Iznos = 	132.50	WHERE Id = 	367	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	368	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	369	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	370	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	371	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	372	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	373	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	374	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	375	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	376	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	377	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	378	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	379	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	380	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	381	;
UPDATE Takse SET Iznos = 	420.00	WHERE Id = 	382	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	383	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	384	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	385	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	386	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	387	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	388	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	389	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	390	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	391	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	392	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	393	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	394	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	395	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	396	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	398	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	399	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	400	;
UPDATE Takse SET Iznos = 	280.00	WHERE Id = 	401	;
UPDATE Takse SET Iznos = 	15.80	WHERE Id = 	402	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	403	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	404	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	405	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	406	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	407	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	408	;
UPDATE Takse SET Iznos = 	476.00	WHERE Id = 	409	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	410	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	411	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	412	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	413	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	414	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	415	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	416	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	417	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	418	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	419	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	420	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	421	;
UPDATE Takse SET Iznos = 	168.00	WHERE Id = 	422	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	423	;
UPDATE Takse SET Iznos = 	600.00	WHERE Id = 	424	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	425	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	426	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	427	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	428	;
UPDATE Takse SET Iznos = 	50.00	WHERE Id = 	429	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	430	;
UPDATE Takse SET Iznos = 	561.20	WHERE Id = 	431	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	433	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	434	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	435	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	436	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	437	;
UPDATE Takse SET Iznos = 	306.00	WHERE Id = 	438	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	439	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	440	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	441	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	442	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	443	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	444	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	445	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	447	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	448	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	449	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	450	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	451	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	453	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	454	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	455	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	456	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	457	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	458	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	459	;
UPDATE Takse SET Iznos = 	22.50	WHERE Id = 	460	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	461	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	462	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	463	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	464	;
UPDATE Takse SET Iznos = 	187.00	WHERE Id = 	468	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	469	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	470	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	471	;
UPDATE Takse SET Iznos = 	972.00	WHERE Id = 	472	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	473	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	474	;
UPDATE Takse SET Iznos = 	270.00	WHERE Id = 	475	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	476	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	477	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	478	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	479	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	480	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	481	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	482	;
UPDATE Takse SET Iznos = 	480.00	WHERE Id = 	483	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	484	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	485	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	486	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	487	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	488	;
UPDATE Takse SET Iznos = 	631.74	WHERE Id = 	489	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	490	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	491	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	492	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	493	;
UPDATE Takse SET Iznos = 	120.00	WHERE Id = 	494	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	495	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	496	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	497	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	498	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	502	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	503	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	504	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	505	;
UPDATE Takse SET Iznos = 	135.00	WHERE Id = 	506	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	507	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	508	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	510	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	511	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	512	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	513	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	514	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	515	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	516	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	517	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	518	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	519	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	520	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	521	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	522	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	523	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	524	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	525	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	526	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	527	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	528	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	529	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	530	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	531	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	532	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	533	;
UPDATE Takse SET Iznos = 	203.70	WHERE Id = 	534	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	535	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	536	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	537	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	538	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	539	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	540	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	541	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	542	;
UPDATE Takse SET Iznos = 	2000.00	WHERE Id = 	543	;
UPDATE Takse SET Iznos = 	1945.00	WHERE Id = 	544	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	545	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	546	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	547	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	548	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	549	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	550	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	551	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	552	;
UPDATE Takse SET Iznos = 	50.00	WHERE Id = 	553	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	554	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	555	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	556	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	557	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	558	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	559	;
UPDATE Takse SET Iznos = 	20.00	WHERE Id = 	560	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	561	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	562	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	563	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	564	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	565	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	566	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	567	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	568	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	569	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	570	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	571	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	572	;
UPDATE Takse SET Iznos = 	9000.00	WHERE Id = 	573	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	574	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	575	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	576	;
UPDATE Takse SET Iznos = 	260.00	WHERE Id = 	577	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	578	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	579	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	580	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	581	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	582	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	583	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	584	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	585	;
UPDATE Takse SET Iznos = 	270.00	WHERE Id = 	586	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	587	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	588	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	589	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	590	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	591	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	592	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	593	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	594	;
UPDATE Takse SET Iznos = 	125.00	WHERE Id = 	595	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	596	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	597	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	599	;
UPDATE Takse SET Iznos = 	54.00	WHERE Id = 	600	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	601	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	602	;
UPDATE Takse SET Iznos = 	240.00	WHERE Id = 	604	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	605	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	606	;
UPDATE Takse SET Iznos = 	240.00	WHERE Id = 	607	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	608	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	609	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	610	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	611	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	612	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	613	;
UPDATE Takse SET Iznos = 	9000.00	WHERE Id = 	614	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	615	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	616	;
UPDATE Takse SET Iznos = 	60.00	WHERE Id = 	617	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	618	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	619	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	620	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	621	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	622	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	623	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	624	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	625	;
UPDATE Takse SET Iznos = 	160.00	WHERE Id = 	626	;
UPDATE Takse SET Iznos = 	125.00	WHERE Id = 	627	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	628	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	629	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	630	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	631	;
UPDATE Takse SET Iznos = 	270.00	WHERE Id = 	632	;
UPDATE Takse SET Iznos = 	1600.00	WHERE Id = 	633	;
UPDATE Takse SET Iznos = 	210.00	WHERE Id = 	634	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	635	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	636	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	637	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	638	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	639	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	640	;
UPDATE Takse SET Iznos = 	35.00	WHERE Id = 	641	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	642	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	643	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	644	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	645	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	646	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	647	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	648	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	649	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	650	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	651	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	652	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	653	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	654	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	655	;
UPDATE Takse SET Iznos = 	5.00	WHERE Id = 	656	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	657	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	658	;
UPDATE Takse SET Iznos = 	30.00	WHERE Id = 	659	;
UPDATE Takse SET Iznos = 	170.00	WHERE Id = 	660	;
UPDATE Takse SET Iznos = 	170.00	WHERE Id = 	661	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	662	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	663	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	664	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	665	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	667	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	668	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	669	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	670	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	671	;
UPDATE Takse SET Iznos = 	303.00	WHERE Id = 	672	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	673	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	674	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	675	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	676	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	677	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	678	;
UPDATE Takse SET Iznos = 	600.00	WHERE Id = 	679	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	680	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	681	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	682	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	683	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	684	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	685	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	686	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	687	;
UPDATE Takse SET Iznos = 	168.00	WHERE Id = 	688	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	689	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	690	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	692	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	693	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	694	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	695	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	696	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	697	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	698	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	699	;
UPDATE Takse SET Iznos = 	80.00	WHERE Id = 	700	;
UPDATE Takse SET Iznos = 	210.00	WHERE Id = 	701	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	702	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	703	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	704	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	706	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	707	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	708	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	709	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	710	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	711	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	712	;
UPDATE Takse SET Iznos = 	5.00	WHERE Id = 	713	;
UPDATE Takse SET Iznos = 	5.00	WHERE Id = 	714	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	715	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	716	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	717	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	718	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	719	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	720	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	721	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	722	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	723	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	724	;
UPDATE Takse SET Iznos = 	720.00	WHERE Id = 	725	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	726	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	727	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	728	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	729	;
UPDATE Takse SET Iznos = 	265.00	WHERE Id = 	730	;
UPDATE Takse SET Iznos = 	265.00	WHERE Id = 	731	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	732	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	733	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	734	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	735	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	736	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	737	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	738	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	739	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	740	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	741	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	742	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	743	;
UPDATE Takse SET Iznos = 	107.00	WHERE Id = 	744	;
UPDATE Takse SET Iznos = 	107.35	WHERE Id = 	745	;
UPDATE Takse SET Iznos = 	107.35	WHERE Id = 	746	;
UPDATE Takse SET Iznos = 	164.00	WHERE Id = 	747	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	748	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	749	;
UPDATE Takse SET Iznos = 	92.15	WHERE Id = 	750	;
UPDATE Takse SET Iznos = 	89.78	WHERE Id = 	751	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	752	;
UPDATE Takse SET Iznos = 	22.50	WHERE Id = 	753	;
UPDATE Takse SET Iznos = 	24.45	WHERE Id = 	754	;
UPDATE Takse SET Iznos = 	24.45	WHERE Id = 	755	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	756	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	757	;
UPDATE Takse SET Iznos = 	270.00	WHERE Id = 	758	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	759	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	760	;
UPDATE Takse SET Iznos = 	34.80	WHERE Id = 	761	;
UPDATE Takse SET Iznos = 	36.76	WHERE Id = 	762	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	763	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	764	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	765	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	766	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	767	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	768	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	769	;
UPDATE Takse SET Iznos = 	43.60	WHERE Id = 	770	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	771	;
UPDATE Takse SET Iznos = 	150.42	WHERE Id = 	772	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	773	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	774	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	775	;
UPDATE Takse SET Iznos = 	330.00	WHERE Id = 	776	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	777	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	778	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	779	;
UPDATE Takse SET Iznos = 	225.00	WHERE Id = 	780	;
UPDATE Takse SET Iznos = 	442.50	WHERE Id = 	781	;
UPDATE Takse SET Iznos = 	442.50	WHERE Id = 	782	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	783	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	784	;
UPDATE Takse SET Iznos = 	77.00	WHERE Id = 	785	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	786	;
UPDATE Takse SET Iznos = 	51.70	WHERE Id = 	787	;
UPDATE Takse SET Iznos = 	120.65	WHERE Id = 	788	;
UPDATE Takse SET Iznos = 	60.00	WHERE Id = 	789	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	790	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	791	;
UPDATE Takse SET Iznos = 	41.50	WHERE Id = 	792	;
UPDATE Takse SET Iznos = 	2527.20	WHERE Id = 	793	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	794	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	795	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	796	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	797	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	798	;
UPDATE Takse SET Iznos = 	1200.00	WHERE Id = 	799	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	800	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	801	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	802	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	804	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	805	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	807	;
UPDATE Takse SET Iznos = 	270.00	WHERE Id = 	808	;
UPDATE Takse SET Iznos = 	92.00	WHERE Id = 	809	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	810	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	811	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	812	;
UPDATE Takse SET Iznos = 	738.00	WHERE Id = 	813	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	814	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	815	;
UPDATE Takse SET Iznos = 	270.00	WHERE Id = 	816	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	817	;
UPDATE Takse SET Iznos = 	750.00	WHERE Id = 	818	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	819	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	820	;
UPDATE Takse SET Iznos = 	330.00	WHERE Id = 	821	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	822	;
UPDATE Takse SET Iznos = 	330.00	WHERE Id = 	823	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	824	;
UPDATE Takse SET Iznos = 	528.00	WHERE Id = 	825	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	826	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	827	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	828	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	829	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	830	;
UPDATE Takse SET Iznos = 	115.00	WHERE Id = 	831	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	832	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	833	;
UPDATE Takse SET Iznos = 	332.64	WHERE Id = 	834	;
UPDATE Takse SET Iznos = 	665.28	WHERE Id = 	835	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	836	;
UPDATE Takse SET Iznos = 	182.00	WHERE Id = 	837	;
UPDATE Takse SET Iznos = 	633.00	WHERE Id = 	838	;
UPDATE Takse SET Iznos = 	633.00	WHERE Id = 	839	;
UPDATE Takse SET Iznos = 	50.00	WHERE Id = 	840	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	841	;
UPDATE Takse SET Iznos = 	140.00	WHERE Id = 	842	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	843	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	844	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	845	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	846	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	847	;
UPDATE Takse SET Iznos = 	154.00	WHERE Id = 	848	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	849	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	850	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	851	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	852	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	853	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	854	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	855	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	856	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	857	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	858	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	859	;
UPDATE Takse SET Iznos = 	315.60	WHERE Id = 	860	;
UPDATE Takse SET Iznos = 	651.00	WHERE Id = 	861	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	862	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	863	;
UPDATE Takse SET Iznos = 	101.85	WHERE Id = 	864	;
UPDATE Takse SET Iznos = 	33.15	WHERE Id = 	865	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	866	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	867	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	868	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	869	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	870	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	871	;
UPDATE Takse SET Iznos = 	186.00	WHERE Id = 	872	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	873	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	874	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	875	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	876	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	877	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	878	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	879	;
UPDATE Takse SET Iznos = 	175.00	WHERE Id = 	880	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	881	;
UPDATE Takse SET Iznos = 	30.00	WHERE Id = 	882	;
UPDATE Takse SET Iznos = 	125.00	WHERE Id = 	883	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	884	;
UPDATE Takse SET Iznos = 	50.00	WHERE Id = 	885	;
UPDATE Takse SET Iznos = 	50.00	WHERE Id = 	886	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	887	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	888	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	889	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	890	;
UPDATE Takse SET Iznos = 	125.30	WHERE Id = 	891	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	892	;
UPDATE Takse SET Iznos = 	15.00	WHERE Id = 	893	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	894	;
UPDATE Takse SET Iznos = 	225.00	WHERE Id = 	895	;
UPDATE Takse SET Iznos = 	31.50	WHERE Id = 	896	;
UPDATE Takse SET Iznos = 	5.00	WHERE Id = 	897	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	898	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	899	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	900	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	901	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	902	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	903	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	904	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	905	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	906	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	907	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	911	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	912	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	913	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	914	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	915	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	916	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	917	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	918	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	919	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	920	;
UPDATE Takse SET Iznos = 	840.00	WHERE Id = 	921	;
UPDATE Takse SET Iznos = 	459.00	WHERE Id = 	922	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	923	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	924	;
UPDATE Takse SET Iznos = 	459.00	WHERE Id = 	925	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	926	;
UPDATE Takse SET Iznos = 	5463.00	WHERE Id = 	927	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	928	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	929	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	930	;
UPDATE Takse SET Iznos = 	120.00	WHERE Id = 	931	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	932	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	933	;
UPDATE Takse SET Iznos = 	540.00	WHERE Id = 	934	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	935	;
UPDATE Takse SET Iznos = 	270.00	WHERE Id = 	936	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	937	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	938	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	939	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	940	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	941	;
UPDATE Takse SET Iznos = 	2000.00	WHERE Id = 	942	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	943	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	944	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	945	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	946	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	947	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	948	;
UPDATE Takse SET Iznos = 	130.00	WHERE Id = 	949	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	950	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	951	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	952	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	953	;
UPDATE Takse SET Iznos = 	289.00	WHERE Id = 	954	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	955	;
UPDATE Takse SET Iznos = 	70.00	WHERE Id = 	956	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	957	;
UPDATE Takse SET Iznos = 	1500.00	WHERE Id = 	958	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	959	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	960	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	961	;
UPDATE Takse SET Iznos = 	70.00	WHERE Id = 	962	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	963	;
UPDATE Takse SET Iznos = 	265.00	WHERE Id = 	964	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	965	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	966	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	967	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	968	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	969	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	970	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	971	;
UPDATE Takse SET Iznos = 	70.00	WHERE Id = 	972	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	973	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	974	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	975	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	976	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	977	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	978	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	979	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	980	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	981	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	982	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	983	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	984	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	985	;
UPDATE Takse SET Iznos = 	457.00	WHERE Id = 	986	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	987	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	988	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	989	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	990	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	991	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	992	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	993	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	994	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	995	;
UPDATE Takse SET Iznos = 	600.00	WHERE Id = 	996	;
UPDATE Takse SET Iznos = 	70.00	WHERE Id = 	997	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	999	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1000	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1001	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1002	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1003	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	1004	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1005	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1006	;
UPDATE Takse SET Iznos = 	120.00	WHERE Id = 	1007	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1008	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1009	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1010	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1011	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1012	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1013	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1014	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	1015	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1016	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1017	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1018	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	1019	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1020	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	1021	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1022	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1023	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1024	;
UPDATE Takse SET Iznos = 	40.00	WHERE Id = 	1025	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1026	;
UPDATE Takse SET Iznos = 	176.00	WHERE Id = 	1027	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1028	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1029	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1030	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1031	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1032	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1033	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1034	;
UPDATE Takse SET Iznos = 	265.00	WHERE Id = 	1035	;
UPDATE Takse SET Iznos = 	50.00	WHERE Id = 	1036	;
UPDATE Takse SET Iznos = 	50.00	WHERE Id = 	1037	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1038	;
UPDATE Takse SET Iznos = 	600.00	WHERE Id = 	1039	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1040	;
UPDATE Takse SET Iznos = 	2112.00	WHERE Id = 	1041	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1042	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	1043	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1044	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1045	;
UPDATE Takse SET Iznos = 	265.00	WHERE Id = 	1046	;
UPDATE Takse SET Iznos = 	265.00	WHERE Id = 	1047	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1048	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	1049	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1050	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1051	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1052	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1053	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1054	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	1055	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1056	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1057	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1058	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1059	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1060	;
UPDATE Takse SET Iznos = 	120.00	WHERE Id = 	1061	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1062	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1063	;
UPDATE Takse SET Iznos = 	600.00	WHERE Id = 	1064	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1065	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1066	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1067	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1068	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	1069	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1070	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1071	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1072	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1073	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1075	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1076	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	1077	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1078	;
UPDATE Takse SET Iznos = 	938.30	WHERE Id = 	1079	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1080	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1081	;
UPDATE Takse SET Iznos = 	1400.00	WHERE Id = 	1082	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1083	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1084	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1085	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1086	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1087	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1088	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1089	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1090	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1091	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1092	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1093	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1094	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1095	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1096	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1097	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1098	;
UPDATE Takse SET Iznos = 	3517.20	WHERE Id = 	1099	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1100	;
UPDATE Takse SET Iznos = 	600.00	WHERE Id = 	1101	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1102	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1103	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1104	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1105	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1106	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	1107	;
UPDATE Takse SET Iznos = 	352.00	WHERE Id = 	1108	;
UPDATE Takse SET Iznos = 	352.00	WHERE Id = 	1109	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1110	;
UPDATE Takse SET Iznos = 	380.00	WHERE Id = 	1111	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1112	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1113	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1114	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1115	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1116	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1117	;
UPDATE Takse SET Iznos = 	22.50	WHERE Id = 	1118	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1119	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1120	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1121	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1122	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1123	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1124	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1125	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1126	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1127	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1128	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1129	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1130	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1131	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1132	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1133	;
UPDATE Takse SET Iznos = 	305.00	WHERE Id = 	1134	;
UPDATE Takse SET Iznos = 	305.00	WHERE Id = 	1135	;
UPDATE Takse SET Iznos = 	265.00	WHERE Id = 	1136	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1137	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1138	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1139	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1140	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1141	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1142	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1143	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1144	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1145	;
UPDATE Takse SET Iznos = 	22.50	WHERE Id = 	1146	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1147	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1148	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1149	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1150	;
UPDATE Takse SET Iznos = 	133.59	WHERE Id = 	1151	;
UPDATE Takse SET Iznos = 	5.00	WHERE Id = 	1152	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1153	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1154	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1155	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1156	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1157	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1158	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1159	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1160	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1161	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	1163	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	1164	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1165	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1166	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1167	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1168	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1169	;
UPDATE Takse SET Iznos = 	176.00	WHERE Id = 	1170	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1171	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1172	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1173	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1174	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1175	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	1176	;
UPDATE Takse SET Iznos = 	985.14	WHERE Id = 	1177	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1178	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	1179	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1180	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1181	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1182	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1183	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1184	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	1185	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1186	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1187	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1188	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1189	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1190	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1191	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1192	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1193	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1194	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	1195	;
UPDATE Takse SET Iznos = 	2500.00	WHERE Id = 	1196	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	1197	;
UPDATE Takse SET Iznos = 	217.30	WHERE Id = 	1198	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1199	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1200	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1201	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1202	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1203	;
UPDATE Takse SET Iznos = 	3035.00	WHERE Id = 	1204	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1205	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1206	;
UPDATE Takse SET Iznos = 	1810.00	WHERE Id = 	1207	;
UPDATE Takse SET Iznos = 	1810.00	WHERE Id = 	1208	;
UPDATE Takse SET Iznos = 	41.00	WHERE Id = 	1209	;
UPDATE Takse SET Iznos = 	41.00	WHERE Id = 	1210	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	1211	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	1212	;
UPDATE Takse SET Iznos = 	41.00	WHERE Id = 	1213	;
UPDATE Takse SET Iznos = 	41.00	WHERE Id = 	1214	;
UPDATE Takse SET Iznos = 	995.31	WHERE Id = 	1215	;
UPDATE Takse SET Iznos = 	1606.33	WHERE Id = 	1216	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1217	;
UPDATE Takse SET Iznos = 	15.00	WHERE Id = 	1218	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1219	;
UPDATE Takse SET Iznos = 	22.50	WHERE Id = 	1220	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1221	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1222	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1223	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1224	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1225	;
UPDATE Takse SET Iznos = 	135.00	WHERE Id = 	1226	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1227	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1228	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1229	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1230	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	1231	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1232	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	1233	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1234	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1235	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1236	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1237	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1238	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1239	;
UPDATE Takse SET Iznos = 	72.00	WHERE Id = 	1240	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1241	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1242	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1243	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1244	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1245	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	1246	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	1247	;
UPDATE Takse SET Iznos = 	50.00	WHERE Id = 	1248	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1249	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1250	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1251	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1253	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	1254	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1255	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1256	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1257	;
UPDATE Takse SET Iznos = 	3000.00	WHERE Id = 	1258	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1259	;
UPDATE Takse SET Iznos = 	265.00	WHERE Id = 	1260	;
UPDATE Takse SET Iznos = 	265.00	WHERE Id = 	1261	;
UPDATE Takse SET Iznos = 	265.00	WHERE Id = 	1262	;
UPDATE Takse SET Iznos = 	550.00	WHERE Id = 	1263	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1264	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1265	;
UPDATE Takse SET Iznos = 	1800.00	WHERE Id = 	1266	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	1267	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1268	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1269	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1270	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1271	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1272	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1273	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1274	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1275	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1276	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1277	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1278	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1279	;
UPDATE Takse SET Iznos = 	856.44	WHERE Id = 	1280	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1281	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1282	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1283	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1284	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1285	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1286	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1287	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1288	;
UPDATE Takse SET Iznos = 	5.00	WHERE Id = 	1289	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1290	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1291	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1292	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1293	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1294	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1295	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1296	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1298	;
UPDATE Takse SET Iznos = 	75.00	WHERE Id = 	1299	;
UPDATE Takse SET Iznos = 	75.00	WHERE Id = 	1300	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1301	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1302	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	1303	;
UPDATE Takse SET Iznos = 	39.00	WHERE Id = 	1304	;
UPDATE Takse SET Iznos = 	54.40	WHERE Id = 	1305	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1306	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1307	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1308	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1309	;
UPDATE Takse SET Iznos = 	72.50	WHERE Id = 	1310	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1311	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1312	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1313	;
UPDATE Takse SET Iznos = 	1500.00	WHERE Id = 	1314	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1315	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1316	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1317	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1318	;
UPDATE Takse SET Iznos = 	1800.00	WHERE Id = 	1319	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1320	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1321	;
UPDATE Takse SET Iznos = 	30.00	WHERE Id = 	1322	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1323	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1324	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1325	;
UPDATE Takse SET Iznos = 	8.00	WHERE Id = 	1326	;
UPDATE Takse SET Iznos = 	9.00	WHERE Id = 	1327	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1328	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1329	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1330	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1331	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1332	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	1333	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1334	;
UPDATE Takse SET Iznos = 	50.00	WHERE Id = 	1335	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1336	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1337	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	1338	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	1339	;
UPDATE Takse SET Iznos = 	600.00	WHERE Id = 	1340	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1341	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1342	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	1343	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	1344	;
UPDATE Takse SET Iznos = 	1010.88	WHERE Id = 	1345	;
UPDATE Takse SET Iznos = 	6915.24	WHERE Id = 	1346	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1347	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1348	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1349	;
UPDATE Takse SET Iznos = 	50.00	WHERE Id = 	1350	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1351	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1352	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1353	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1354	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1355	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1356	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1357	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1358	;
UPDATE Takse SET Iznos = 	67.00	WHERE Id = 	1359	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	1360	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1361	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1362	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1363	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1364	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1365	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1366	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1367	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1368	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1369	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1370	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1371	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1372	;
UPDATE Takse SET Iznos = 	421.20	WHERE Id = 	1373	;
UPDATE Takse SET Iznos = 	842.40	WHERE Id = 	1374	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1375	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1376	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1377	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1378	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1379	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1380	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1381	;
UPDATE Takse SET Iznos = 	48.00	WHERE Id = 	1382	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1383	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1384	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	1385	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1386	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1387	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1388	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1389	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1390	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	1391	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1392	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1393	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1394	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1395	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1396	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1397	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1398	;
UPDATE Takse SET Iznos = 	260.00	WHERE Id = 	1399	;
UPDATE Takse SET Iznos = 	46.80	WHERE Id = 	1400	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	1401	;
UPDATE Takse SET Iznos = 	10.00	WHERE Id = 	1402	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	1403	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	1404	;
UPDATE Takse SET Iznos = 	842.40	WHERE Id = 	1405	;
UPDATE Takse SET Iznos = 	4025.40	WHERE Id = 	1406	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1407	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1408	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1409	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1410	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1411	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1412	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1413	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1414	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1415	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1416	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	1417	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	1418	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1419	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1420	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1421	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1422	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	1423	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1424	;
UPDATE Takse SET Iznos = 	135.00	WHERE Id = 	1425	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1426	;
UPDATE Takse SET Iznos = 	41.48	WHERE Id = 	1427	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1428	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1429	;
UPDATE Takse SET Iznos = 	71.26	WHERE Id = 	1430	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1431	;
UPDATE Takse SET Iznos = 	225.00	WHERE Id = 	1432	;
UPDATE Takse SET Iznos = 	2227.10	WHERE Id = 	1433	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1434	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1435	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1436	;
UPDATE Takse SET Iznos = 	989.82	WHERE Id = 	1437	;
UPDATE Takse SET Iznos = 	1260.09	WHERE Id = 	1438	;
UPDATE Takse SET Iznos = 	1484.73	WHERE Id = 	1439	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1440	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1441	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1442	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1443	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	1444	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1445	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1446	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1447	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1448	;
UPDATE Takse SET Iznos = 	42.50	WHERE Id = 	1449	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1450	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	1451	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1452	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1453	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1454	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1455	;
UPDATE Takse SET Iznos = 	50.00	WHERE Id = 	1456	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1457	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1458	;
UPDATE Takse SET Iznos = 	50.00	WHERE Id = 	1459	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1460	;
UPDATE Takse SET Iznos = 	1260.09	WHERE Id = 	1461	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1462	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1463	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1464	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	1465	;
UPDATE Takse SET Iznos = 	1193.40	WHERE Id = 	1466	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1467	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1468	;
UPDATE Takse SET Iznos = 	1484.73	WHERE Id = 	1469	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1470	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1471	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1472	;
UPDATE Takse SET Iznos = 	206.00	WHERE Id = 	1473	;
UPDATE Takse SET Iznos = 	206.00	WHERE Id = 	1474	;
UPDATE Takse SET Iznos = 	206.00	WHERE Id = 	1475	;
UPDATE Takse SET Iznos = 	30.00	WHERE Id = 	1476	;
UPDATE Takse SET Iznos = 	77.00	WHERE Id = 	1477	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1478	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	1479	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1480	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1481	;
UPDATE Takse SET Iznos = 	280.00	WHERE Id = 	1482	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	1483	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1484	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	1485	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1486	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1487	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	1488	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1489	;
UPDATE Takse SET Iznos = 	975.78	WHERE Id = 	1490	;
UPDATE Takse SET Iznos = 	125.00	WHERE Id = 	1491	;
UPDATE Takse SET Iznos = 	125.00	WHERE Id = 	1492	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1493	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1494	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1495	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1496	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1497	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1498	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1499	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1500	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1501	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1502	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1503	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1504	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1505	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1506	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1508	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1509	;
UPDATE Takse SET Iznos = 	60.00	WHERE Id = 	1510	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1511	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1512	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1513	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1514	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1515	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1516	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1517	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1518	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1519	;
UPDATE Takse SET Iznos = 	132.50	WHERE Id = 	1520	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1521	;
UPDATE Takse SET Iznos = 	280.00	WHERE Id = 	1522	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1523	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1524	;
UPDATE Takse SET Iznos = 	350.00	WHERE Id = 	1525	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	1526	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1527	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1528	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1529	;
UPDATE Takse SET Iznos = 	12.00	WHERE Id = 	1530	;
UPDATE Takse SET Iznos = 	20.00	WHERE Id = 	1531	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1532	;
UPDATE Takse SET Iznos = 	780.00	WHERE Id = 	1533	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1534	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1535	;
UPDATE Takse SET Iznos = 	404.19	WHERE Id = 	1536	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1537	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1538	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1539	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1540	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1541	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1542	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1543	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	1544	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1545	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1546	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1547	;
UPDATE Takse SET Iznos = 	50.00	WHERE Id = 	1548	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1549	;
UPDATE Takse SET Iznos = 	280.80	WHERE Id = 	1550	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1551	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1552	;
UPDATE Takse SET Iznos = 	280.80	WHERE Id = 	1553	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1554	;
UPDATE Takse SET Iznos = 	117.00	WHERE Id = 	1555	;
UPDATE Takse SET Iznos = 	1060.00	WHERE Id = 	1556	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1557	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1558	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1559	;
UPDATE Takse SET Iznos = 	120.00	WHERE Id = 	1560	;
UPDATE Takse SET Iznos = 	175.00	WHERE Id = 	1561	;
UPDATE Takse SET Iznos = 	175.00	WHERE Id = 	1562	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1563	;
UPDATE Takse SET Iznos = 	280.00	WHERE Id = 	1564	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1565	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1566	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1567	;
UPDATE Takse SET Iznos = 	60.00	WHERE Id = 	1568	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1569	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1570	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1571	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1572	;
UPDATE Takse SET Iznos = 	610.74	WHERE Id = 	1573	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1574	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1575	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1576	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1577	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1578	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1579	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1580	;
UPDATE Takse SET Iznos = 	22.50	WHERE Id = 	1581	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1582	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1584	;
UPDATE Takse SET Iznos = 	975.78	WHERE Id = 	1585	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1586	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1587	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1588	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	1589	;
UPDATE Takse SET Iznos = 	120.00	WHERE Id = 	1590	;
UPDATE Takse SET Iznos = 	21336.00	WHERE Id = 	1591	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1592	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1593	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1594	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1595	;
UPDATE Takse SET Iznos = 	50.00	WHERE Id = 	1596	;
UPDATE Takse SET Iznos = 	912.60	WHERE Id = 	1597	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1598	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1599	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	1600	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1601	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1602	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1603	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1604	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1605	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1606	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1607	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1608	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1609	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1610	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1611	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1612	;
UPDATE Takse SET Iznos = 	125.00	WHERE Id = 	1613	;
UPDATE Takse SET Iznos = 	550.00	WHERE Id = 	1614	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1615	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1616	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1617	;
UPDATE Takse SET Iznos = 	1825.20	WHERE Id = 	1618	;
UPDATE Takse SET Iznos = 	4001.40	WHERE Id = 	1619	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1620	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1621	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1622	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1623	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1624	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1625	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	1626	;
UPDATE Takse SET Iznos = 	125.00	WHERE Id = 	1627	;
UPDATE Takse SET Iznos = 	125.00	WHERE Id = 	1628	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1629	;
UPDATE Takse SET Iznos = 	75.00	WHERE Id = 	1630	;
UPDATE Takse SET Iznos = 	75.00	WHERE Id = 	1631	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1632	;
UPDATE Takse SET Iznos = 	100.00	WHERE Id = 	1633	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1634	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	1635	;
UPDATE Takse SET Iznos = 	1000.00	WHERE Id = 	1636	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1637	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1638	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1639	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1640	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1641	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1642	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1643	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1644	;
UPDATE Takse SET Iznos = 	20.00	WHERE Id = 	1645	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1646	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1647	;
UPDATE Takse SET Iznos = 	183.60	WHERE Id = 	1648	;
UPDATE Takse SET Iznos = 	85.10	WHERE Id = 	1649	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1650	;
UPDATE Takse SET Iznos = 	1800.00	WHERE Id = 	1651	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1652	;
UPDATE Takse SET Iznos = 	500.00	WHERE Id = 	1653	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1654	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1655	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1656	;
UPDATE Takse SET Iznos = 	900.00	WHERE Id = 	1657	;
UPDATE Takse SET Iznos = 	268.68	WHERE Id = 	1658	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	1659	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1660	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1661	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1662	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1663	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1664	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	1665	;
UPDATE Takse SET Iznos = 	360.00	WHERE Id = 	1666	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1667	;
UPDATE Takse SET Iznos = 	300.00	WHERE Id = 	1668	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	1669	;
UPDATE Takse SET Iznos = 	248.62	WHERE Id = 	1670	;
UPDATE Takse SET Iznos = 	107.32	WHERE Id = 	1671	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1672	;
UPDATE Takse SET Iznos = 	600.00	WHERE Id = 	1673	;
UPDATE Takse SET Iznos = 	45.00	WHERE Id = 	1674	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1675	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1676	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1677	;
UPDATE Takse SET Iznos = 	400.00	WHERE Id = 	1678	;
UPDATE Takse SET Iznos = 	626.58	WHERE Id = 	1679	;
UPDATE Takse SET Iznos = 	180.00	WHERE Id = 	1680	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1681	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1682	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1683	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1684	;
UPDATE Takse SET Iznos = 	200.00	WHERE Id = 	1685	;
UPDATE Takse SET Iznos = 	150.00	WHERE Id = 	1686	;
UPDATE Takse SET Iznos = 	250.00	WHERE Id = 	1687	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1688	;
UPDATE Takse SET Iznos = 	842.40	WHERE Id = 	1689	;
UPDATE Takse SET Iznos = 	90.00	WHERE Id = 	1690	;
UPDATE Takse SET Iznos = 	450.00	WHERE Id = 	1691	;






 delete from VrsteRadnji where id in (
	 select vr.id from VrsteRadnji vr where vr.id not in (select distinct VrstaRadnjeId from radnje)
	 and vr.name in (
		 select name
		 from VrsteRadnji
		 group by name
		 having count(1) > 1
		)
)
go






select *
from VrsteRadnji
where name in (
	select name
	from VrsteRadnji
	group by name
	having count(1) > 1
)

--Update Radnje Set VrstaRadnjeId = 7 Where VrstaRadnjeId = 55;
--Delete From VrsteRadnji Where Id = 55;
--Update Radnje Set VrstaRadnjeId = 190 Where VrstaRadnjeId = 255;
--Delete From VrsteRadnji Where Id = 255;
--Update Radnje Set VrstaRadnjeId = 79 Where VrstaRadnjeId = 188;
--Delete From VrsteRadnji Where Id = 188;
--Update Radnje Set VrstaRadnjeId = 40 Where VrstaRadnjeId = 175;
--Delete From VrsteRadnji Where Id = 175;







