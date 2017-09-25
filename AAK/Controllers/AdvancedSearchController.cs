using AAK.DataProviders;
using AAK.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace AAK.Controllers
{
    public class AdvancedSearchController : ApiController
    {
        [HttpPost]
        public HttpResponseMessage AdvancedSearch([FromBody]AdvancedSearchParameters parameters)
        {
            try
            {
                if (Google.Validator.ValidateToken(parameters.Token, parameters.Email))
                {
                    List<Predmet> results = Predmeti.Predmeti_GeForAdvancedSearch(parameters);

                    if (parameters.ExportToExcel)
                    {
                        string exportedPath = this.ExportToExcel(results, parameters.UserFullName, parameters.UserId);
                        return Request.CreateResponse<string>(System.Net.HttpStatusCode.OK, exportedPath);
                    }
                    else
                        return Request.CreateResponse<List<Predmet>>(System.Net.HttpStatusCode.OK, results);
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "AdvancedSearch");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }

        #region Private methods
        private string ExportToExcel(List<Predmet> data, string userFullName, int userId)
        {
            try
            {
                if (data.Count() == 0)
                    return null;

                DataTable dt = ToDataTable<Predmet>(data);

                string neatName = "Napredna pretraga od korisnika " + userFullName;
                string strFileName = neatName + ".xlsx";

                // Fix the file name, replace any illegal character with an underscore (_).
                for (int i = 0; i < strFileName.Length; i++)
                    if (Path.GetInvalidFileNameChars().Contains(Convert.ToChar(strFileName.Substring(i, 1))))
                        strFileName = strFileName.Replace(strFileName.Substring(i, 1), "_");

                Dictionary<string, string> columnNameTranslations = new Dictionary<string, string>();
                columnNameTranslations.Add("NasBroj", "Naš broj");
                columnNameTranslations.Add("BrojPredmeta", "Broj predmeta");
                columnNameTranslations.Add("VrijednostSpora", "Vrijednost spora");
                columnNameTranslations.Add("PravniOsnov", "Pravni osnov");
                columnNameTranslations.Add("DatumStanjaPredmeta", "Datum stanja predmeta");
                columnNameTranslations.Add("DatumArhiviranja", "Datum arhiviranja");
                columnNameTranslations.Add("BrojArhive", "Broj arhive");
                columnNameTranslations.Add("BrojArhiveRegistrator", "Broj arhive registrator");
                columnNameTranslations.Add("StrankaNasa", "Naša stranka");
                columnNameTranslations.Add("StrankaProtivna", "Protivna stranka");
                columnNameTranslations.Add("SudName", "Sud");
                columnNameTranslations.Add("KategorijaPredmetaName", "Kategorija predmeta");
                columnNameTranslations.Add("SudijaName", "Sudija");
                columnNameTranslations.Add("VrstaPredmetaName", "Vrsta predmeta");
                columnNameTranslations.Add("UlogaName", "Uloga");
                columnNameTranslations.Add("NacinOkoncanjaName", "Način okončanja");
                columnNameTranslations.Add("StanjePredmetaName", "Stanje predmeta");
                columnNameTranslations.Add("PrivremeniZastupnici", "Privremeni zastupnici");
                columnNameTranslations.Add("ModifiedByName", "Izmijenjeno od");
                columnNameTranslations.Add("Modified", "Izmijenjeno");

                ExporterUtility.Excel.DataTable_To_Excel(strFileName, dt, neatName, userId, ref columnNameTranslations, neatName,
                    ConfigurationManager.AppSettings["ColumnsToExcludeWhenExportingInAdvancedSearch"].ToString());

                return strFileName;
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "ExportToExcel");
                return null;
            }
        }

        private static DataTable ToDataTable<T>(List<T> items)
        {

            IEnumerable<T> data = items.AsEnumerable<T>();
            DataTable table = new DataTable();
            using (var reader = FastMember.ObjectReader.Create(data))
            {
                table.Load(reader);
            }

            return table;
        }
        #endregion
    }
}
