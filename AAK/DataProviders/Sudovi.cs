using AAK.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace AAK.DataProviders
{
    public class Sudovi
    {
        public static List<Sud> Sudovi_GetAll()
        {
            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure("Sudovi_GetAll");
            return DBUtility.Utility.ParseDataTable<Sud>(dt);
        }

        public static int? Sudovi_Insert(Sud sud)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<string>("naziv", sud.Naziv);
            collection.AddParameter<string>("adresa", sud.Adresa);
            collection.AddParameter<string>("postanskiBroj", sud.PostanskiBroj);
            collection.AddParameter<string>("grad", sud.Grad);
            collection.AddParameter<string>("telefon", sud.Telefon);
            collection.AddParameter<string>("fax", sud.Fax);
            collection.AddParameter<string>("racunTakse", sud.RacunTakse);
            collection.AddParameter<string>("racunVjestacenja", sud.RacunVjestacenja);
            collection.AddParameter<int?>("userId", sud.CreatedBy);
            return DBUtility.Utility.ExecuteStoredProcedure<int>("Sudovi_Insert", ref collection);
        }

        public static void Sudovi_Update(Sud sud)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<string>("naziv", sud.Naziv);
            collection.AddParameter<string>("adresa", sud.Adresa);
            collection.AddParameter<string>("postanskiBroj", sud.PostanskiBroj);
            collection.AddParameter<string>("grad", sud.Grad);
            collection.AddParameter<string>("telefon", sud.Telefon);
            collection.AddParameter<string>("fax", sud.Fax);
            collection.AddParameter<string>("racunTakse", sud.RacunTakse);
            collection.AddParameter<string>("racunVjestacenja", sud.RacunVjestacenja);
            collection.AddParameter<int?>("userId", sud.ModifiedBy);
            collection.AddParameter<int>("id", sud.Id);
            DBUtility.Utility.ExecuteStoredProcedureVoid("Sudovi_Update", ref collection);
        }

        public static void Sudovi_Delete(int id)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<int>("Sudovi_Delete", "id", id);
        }
    }
}