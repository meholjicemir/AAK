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
            collection.AddParameter<DateTime?>("datumStanjaPredmeta", predmet.DatumStanjaPredmeta);
            collection.AddParameter<int>("stanjePredmetaId", predmet.StanjePredmetaId);

            collection.AddParameter<int>("nacinOkoncanjaId", predmet.NacinOkoncanjaId);
            collection.AddParameter<string>("uspjeh", predmet.Uspjeh);
            collection.AddParameter<DateTime?>("datumArhiviranja", predmet.DatumArhiviranja);
            collection.AddParameter<string>("brojArhive", predmet.BrojArhive);
            collection.AddParameter<string>("brojArhiveRegistrator", predmet.BrojArhiveRegistrator);

            collection.AddParameter<int?>("userId", predmet.CreatedBy);
            int insertedId = DBUtility.Utility.ExecuteStoredProcedure<int>("Predmeti_Insert", ref collection);

            if (insertedId > 0)
                foreach (LicePredmet lp in predmet.Parties)
                {
                    lp.PredmetId = insertedId;
                    LicePredmet_Insert(lp);
                }

            return insertedId;
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
            collection.AddParameter<DateTime?>("datumStanjaPredmeta", predmet.DatumStanjaPredmeta);
            collection.AddParameter<int>("stanjePredmetaId", predmet.StanjePredmetaId);

            collection.AddParameter<int>("nacinOkoncanjaId", predmet.NacinOkoncanjaId);
            collection.AddParameter<string>("uspjeh", predmet.Uspjeh);
            collection.AddParameter<DateTime?>("datumArhiviranja", predmet.DatumArhiviranja);
            collection.AddParameter<string>("brojArhive", predmet.BrojArhive);
            collection.AddParameter<string>("brojArhiveRegistrator", predmet.BrojArhiveRegistrator);

            collection.AddParameter<int>("id", predmet.Id);
            collection.AddParameter<int?>("userId", predmet.ModifiedBy);
            DBUtility.Utility.ExecuteStoredProcedureVoid("Predmeti_Update", ref collection);

            List<LicePredmet> existingLicePredmeti = LicePredmet_GetForPredmet(predmet.Id);

            LicePredmet temp;

            foreach (LicePredmet lp in existingLicePredmeti)
            {
                temp = (from LicePredmet tempLP in predmet.Parties
                        where tempLP.LiceId == lp.LiceId && tempLP.PredmetId == lp.PredmetId && tempLP.UlogaId == lp.UlogaId
                        select tempLP).FirstOrDefault();

                if (temp == null)
                    LicePredmet_Delete(lp.Id);
            }

            foreach (LicePredmet lp in predmet.Parties)
            {
                lp.PredmetId = predmet.Id;

                temp = (from LicePredmet tempLP in existingLicePredmeti
                        where tempLP.LiceId == lp.LiceId && tempLP.PredmetId == lp.PredmetId && tempLP.UlogaId == lp.UlogaId
                        select tempLP).FirstOrDefault();

                if (temp == null)
                    LicePredmet_Insert(lp);
            }
        }

        public static void Predmeti_Delete(int id)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<int>("Predmeti_Delete", "id", id);
        }

        #region LicePredmet

        public static List<LicePredmet> LicePredmet_GetForPredmet(int predmetId)
        {
            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure<int>("LicePredmet_GetForPredmet", "predmetId", predmetId);
            return DBUtility.Utility.ParseDataTable<LicePredmet>(dt);
        }

        public static int? LicePredmet_Insert(LicePredmet licePredmet)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<int>("predmetId", licePredmet.PredmetId);
            collection.AddParameter<int>("liceId", licePredmet.LiceId);
            collection.AddParameter<int>("ulogaId", licePredmet.UlogaId);
            collection.AddParameter<bool>("isNasaStranka", licePredmet.IsNasaStranka);
            collection.AddParameter<bool>("isProtivnaStranka", licePredmet.IsProtivnaStranka);
            return DBUtility.Utility.ExecuteStoredProcedure<int>("LicePredmet_Insert", ref collection);
        }

        public static void LicePredmet_Delete(int id)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<int>("LicePredmet_Delete", "id", id);
        }

        #endregion
    }
}