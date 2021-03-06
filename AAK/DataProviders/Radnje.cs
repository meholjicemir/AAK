﻿using AAK.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;

namespace AAK.DataProviders
{
    public class Radnje
    {
        public static List<Radnja> Radnje_GetAll(int userId, string filter, int rowCount)
        {
            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure<int, string, int>("Radnje_GetAll", "userId", userId, "filter", filter ?? "", "rowCount", rowCount);
            return DBUtility.Utility.ParseDataTable<Radnja>(dt);
        }

        public static List<Radnja> Radnje_GetForCase(int caseId, int userId)
        {
            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure<int, int>("Radnje_GetForCase", "caseId", caseId, "userId", userId);

            List<Radnja> radnje = DBUtility.Utility.ParseDataTable<Radnja>(dt);

            foreach (Radnja radnja in radnje)
            {
                radnja.DocumentName = radnja.DocumentName.Replace("%20", " ");
                if (radnja.DocumentName.Contains('\\'))
                    radnja.DocumentName = radnja.DocumentName.Substring(radnja.DocumentName.LastIndexOf('\\') + 1);
            }

            return radnje;
        }

        public static int? Radnja_Insert(Radnja radnja, bool createGoogleEvent = true)
        {
            //radnja.DocumentLink = (radnja.DocumentLink ?? "").TrimStart('\\').TrimStart('/');

            //if (createGoogleEvent)
            //    radnja.GoogleEventId = GoogleCalendarIntegration.Utility.CreateEvent(radnja.UserId,
            //        radnja.VrstaRadnjeName + " (" + radnja.CaseFullName + ")", radnja.Biljeske,
            //        radnja.DatumRadnje.Value, radnja.DatumRadnje.Value.AddHours(1),
            //        ConfigurationManager.AppSettings["GoogleCalendarId"].ToString());

            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<int>("caseId", radnja.PredmetId);
            collection.AddParameter<DateTime?>("datumRadnje", radnja.DatumRadnje);
            collection.AddParameter<string>("troskovi", radnja.Troskovi);
            collection.AddParameter<string>("biljeske", radnja.Biljeske);
            collection.AddParameter<int>("vrstaRadnjeId", radnja.VrstaRadnjeId);
            collection.AddParameter<DateTime?>("datumPrijema", radnja.DatumPrijema);
            collection.AddParameter<decimal?>("vrijednostRadnje", radnja.VrijednostRadnje);
            collection.AddParameter<int?>("radnjuObavioId", radnja.RadnjuObavioId);
            collection.AddParameter<int?>("nacinObavljanjaId", radnja.NacinObavljanjaId);
            collection.AddParameter<string>("documentName", radnja.DocumentName);
            collection.AddParameter<string>("googleDriveDocId", radnja.GoogleDriveDocId);
            collection.AddParameter<string>("googleEventId", radnja.GoogleEventId);
            return DBUtility.Utility.ExecuteStoredProcedure<int>("Radnja_Insert", ref collection);
        }

        public static void Radnja_Update(Radnja radnja, bool updateGoogleEvent = true)
        {
            //radnja.DocumentLink = (radnja.DocumentLink ?? "").TrimStart('\\').TrimStart('/');

            //if (updateGoogleEvent && (radnja.GoogleEventId ?? "").Length > 0)
            //    GoogleCalendarIntegration.Utility.UpdateEvent(radnja.UserId, radnja.GoogleEventId,
            //        radnja.VrstaRadnjeName + " (" + radnja.CaseFullName + ")", radnja.Biljeske,
            //        radnja.DatumRadnje.Value.AddHours(8), radnja.DatumRadnje.Value.AddHours(10),
            //        ConfigurationManager.AppSettings["GoogleCalendarId"].ToString());

            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<int>("caseId", radnja.PredmetId);
            collection.AddParameter<DateTime?>("datumRadnje", radnja.DatumRadnje);
            collection.AddParameter<string>("troskovi", radnja.Troskovi);
            collection.AddParameter<string>("biljeske", radnja.Biljeske);
            collection.AddParameter<int>("vrstaRadnjeId", radnja.VrstaRadnjeId);
            collection.AddParameter<DateTime?>("datumPrijema", radnja.DatumPrijema);
            collection.AddParameter<decimal?>("vrijednostRadnje", radnja.VrijednostRadnje);
            collection.AddParameter<int?>("radnjuObavioId", radnja.RadnjuObavioId);
            collection.AddParameter<int?>("nacinObavljanjaId", radnja.NacinObavljanjaId);
            collection.AddParameter<string>("documentName", radnja.DocumentName);
            collection.AddParameter<string>("googleDriveDocId", radnja.GoogleDriveDocId);
            collection.AddParameter<int>("id", radnja.Id);
            DBUtility.Utility.ExecuteStoredProcedureVoid("Radnja_Update", ref collection);
        }

        public static void Radnja_Delete(Radnja radnja, bool deleteGoogleEvent = true)
        {
            //if (deleteGoogleEvent && (radnja.GoogleEventId ?? "").Length > 0)
            //    GoogleCalendarIntegration.Utility.DeleteEvent(radnja.UserId, radnja.GoogleEventId,
            //        ConfigurationManager.AppSettings["GoogleCalendarId"].ToString());

            DBUtility.Utility.ExecuteStoredProcedureVoid<int>("Radnja_Delete", "id", radnja.Id);
        }

        public static void Radnja_UpdateGoogleEventId(Radnja radnja)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<int, string>(
                "Radnja_UpdateGoogleEventId",
                "id", radnja.Id,
                "googleEventId", radnja.GoogleEventId);
        }
    }
}