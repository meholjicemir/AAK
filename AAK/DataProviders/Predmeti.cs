using AAK.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace AAK.DataProviders
{
    public static class Predmeti
    {
        public static List<Predmet> Predmeti_GetAll(int userId, string filter, int rowCount)
        {
            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure<int, string, int>("Predmeti_GetAll", "userId", userId, "filter", filter ?? "", "rowCount", rowCount);
            return DBUtility.Utility.ParseDataTable<Predmet>(dt);
        }

        public static int GetNextNasBroj()
        {
            return DBUtility.Utility.ExecuteStoredProcedure<int>("GetNextNasBroj");
        }

        public static int? Predmeti_Insert(Predmet predmet)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<int>("kategorijaPredmetaId", predmet.KategorijaPredmetaId);
            collection.AddParameter<int>("ulogaId", predmet.UlogaId);
            collection.AddParameter<bool>("privremeniZastupnici", predmet.PrivremeniZastupnici);
            collection.AddParameter<string>("brojPredmeta", predmet.BrojPredmeta);
            collection.AddParameter<int?>("sudId", predmet.SudId);
            collection.AddParameter<int>("sudijaId", predmet.SudijaId);
            collection.AddParameter<decimal?>("vrijednostSpora", predmet.VrijednostSpora);
            collection.AddParameter<int>("vrstaPredmetaId", predmet.VrstaPredmetaId);
            collection.AddParameter<DateTime>("datumStanjaPredmeta", predmet.DatumStanjaPredmeta);
            collection.AddParameter<int>("stanjePredmetaId", predmet.StanjePredmetaId);
            collection.AddParameter<int?>("userId", predmet.CreatedBy);
            return DBUtility.Utility.ExecuteStoredProcedure<int>("Predmeti_Insert", ref collection);
        }

        public static void Predmeti_Update(Predmet predmet)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<int>("kategorijaPredmetaId", predmet.KategorijaPredmetaId);
            collection.AddParameter<int>("ulogaId", predmet.UlogaId);
            collection.AddParameter<bool>("privremeniZastupnici", predmet.PrivremeniZastupnici);
            collection.AddParameter<string>("brojPredmeta", predmet.BrojPredmeta);
            collection.AddParameter<int?>("sudId", predmet.SudId);
            collection.AddParameter<int>("sudijaId", predmet.SudijaId);
            collection.AddParameter<decimal?>("vrijednostSpora", predmet.VrijednostSpora);
            collection.AddParameter<int>("vrstaPredmetaId", predmet.VrstaPredmetaId);
            collection.AddParameter<DateTime>("datumStanjaPredmeta", predmet.DatumStanjaPredmeta);
            collection.AddParameter<int>("stanjePredmetaId", predmet.StanjePredmetaId);
            collection.AddParameter<int>("id", predmet.Id);
            collection.AddParameter<int?>("userId", predmet.ModifiedBy);
            DBUtility.Utility.ExecuteStoredProcedureVoid("Predmeti_Update", ref collection);
        }

        public static void Predmeti_Delete(int id)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<int>("Predmeti_Delete", "id", id);
        }
    }
}