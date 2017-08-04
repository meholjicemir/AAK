using AAK.Models;
using System;
using System.Collections.Generic;
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
            return DBUtility.Utility.ParseDataTable<Radnja>(dt);
        }

        public static int? Radnja_Insert(Radnja radnja)
        {
            radnja.DocumentLink = (radnja.DocumentLink ?? "").TrimStart('\\').TrimStart('/');

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
            collection.AddParameter<string>("documentLink", radnja.DocumentLink);
            return DBUtility.Utility.ExecuteStoredProcedure<int>("Radnja_Insert", ref collection);
        }

        public static void Radnja_Update(Radnja radnja)
        {
            radnja.DocumentLink = (radnja.DocumentLink ?? "").TrimStart('\\').TrimStart('/');

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
            collection.AddParameter<string>("documentLink", radnja.DocumentLink);
            collection.AddParameter<int>("id", radnja.Id);
            DBUtility.Utility.ExecuteStoredProcedureVoid("Radnja_Update", ref collection);
        }

        public static void Radnja_Delete(int id)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<int>("Radnja_Delete", "id", id);
        }
    }
}