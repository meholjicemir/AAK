using AAK.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace AAK.DataProviders
{
    public class Lica
    {
        public static List<Lice> Lica_GetAll(int userId, string filter, int rowCount, int? partyId = null)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<int>("userId", userId);
            collection.AddParameter<string>("filter", filter ?? "");
            collection.AddParameter<int>("rowCount", rowCount);
            collection.AddParameter<int?>("partyId", partyId);

            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure("Lica_GetAll", ref collection);
            return DBUtility.Utility.ParseDataTable<Lice>(dt);
        }

        public static int? Lica_Insert(Lice lice)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<string>("prezime", lice.Prezime);
            collection.AddParameter<string>("ime", lice.Ime);
            collection.AddParameter<string>("zakonskiZastupnik", lice.ZakonskiZastupnik);
            collection.AddParameter<string>("pravnoLice", lice.PravnoLice);
            collection.AddParameter<string>("adresa", lice.Adresa);
            collection.AddParameter<string>("postanskiBroj", lice.PostanskiBroj);
            collection.AddParameter<string>("grad", lice.Grad);
            collection.AddParameter<int?>("drzavaId", lice.DrzavaId);
            collection.AddParameter<string>("telefon", lice.Telefon);
            collection.AddParameter<string>("fax", lice.Fax);
            collection.AddParameter<string>("email", lice.Email);
            collection.AddParameter<string>("JMBG_IDBroj", lice.JMBG_IDBroj);
            collection.AddParameter<string>("biljeske", lice.Biljeske);
            collection.AddParameter<bool?>("isMinor", lice.IsMinor);
            collection.AddParameter<int?>("userId", lice.CreatedBy);
            return DBUtility.Utility.ExecuteStoredProcedure<int>("Lica_Insert", ref collection);
        }

        public static void Lica_Update(Lice lice)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<string>("prezime", lice.Prezime);
            collection.AddParameter<string>("ime", lice.Ime);
            collection.AddParameter<string>("zakonskiZastupnik", lice.ZakonskiZastupnik);
            collection.AddParameter<string>("pravnoLice", lice.PravnoLice);
            collection.AddParameter<string>("adresa", lice.Adresa);
            collection.AddParameter<string>("postanskiBroj", lice.PostanskiBroj);
            collection.AddParameter<string>("grad", lice.Grad);
            collection.AddParameter<int?>("drzavaId", lice.DrzavaId);
            collection.AddParameter<string>("telefon", lice.Telefon);
            collection.AddParameter<string>("fax", lice.Fax);
            collection.AddParameter<string>("email", lice.Email);
            collection.AddParameter<string>("JMBG_IDBroj", lice.JMBG_IDBroj);
            collection.AddParameter<string>("biljeske", lice.Biljeske);
            collection.AddParameter<bool?>("isMinor", lice.IsMinor);
            collection.AddParameter<int?>("userId", lice.ModifiedBy);
            collection.AddParameter<int>("id", lice.Id);
            DBUtility.Utility.ExecuteStoredProcedureVoid("Lica_Update", ref collection);
        }

        public static void Lica_Delete(int id)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<int>("Lica_Delete", "id", id);
        }
    }
}
