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
        public static List<Predmet> Predmeti_GetAll(int userId, string filter, int? filterNasBroj, int rowCount, int? caseId)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<int>("userId", userId);
            collection.AddParameter<string>("filter", filter ?? "");
            collection.AddParameter<int?>("filterNasBroj", filterNasBroj);
            collection.AddParameter<int>("rowCount", rowCount);
            collection.AddParameter<int?>("caseId", caseId);

            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure("Predmeti_GetAll", ref collection);
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
            collection.AddParameter<bool>("pristupPredmetu", predmet.PristupPredmetu);
            collection.AddParameter<string>("brojPredmeta", predmet.BrojPredmeta);
            collection.AddParameter<int?>("sudId", predmet.SudId);
            collection.AddParameter<int>("sudijaId", predmet.SudijaId);
            collection.AddParameter<decimal?>("vrijednostSpora", predmet.VrijednostSpora);
            collection.AddParameter<int>("vrstaPredmetaId", predmet.VrstaPredmetaId);
            collection.AddParameter<DateTime?>("datumStanjaPredmeta", predmet.DatumStanjaPredmeta);
            //collection.AddParameter<int>("stanjePredmetaId", predmet.StanjePredmetaId);
            collection.AddParameter<string>("stanjePredmetaName", predmet.StanjePredmetaName);

            collection.AddParameter<int>("nacinOkoncanjaId", predmet.NacinOkoncanjaId);
            collection.AddParameter<string>("uspjeh", predmet.Uspjeh);
            collection.AddParameter<DateTime?>("datumArhiviranja", predmet.DatumArhiviranja);
            collection.AddParameter<string>("brojArhive", predmet.BrojArhive);
            collection.AddParameter<string>("brojArhiveRegistrator", predmet.BrojArhiveRegistrator);

            collection.AddParameter<string>("pravniOsnov", predmet.PravniOsnov);

            collection.AddParameter<int?>("userId", predmet.CreatedBy);

            int insertedId = DBUtility.Utility.ExecuteStoredProcedure<int>("Predmeti_Insert", ref collection);

            if (insertedId > 0)
            {
                foreach (LicePredmet lp in predmet.Parties)
                {
                    lp.PredmetId = insertedId;
                    LicePredmet_Insert(lp);
                }

                foreach (Note note in predmet.Notes)
                {
                    note.CaseId = insertedId;
                    Notes.Note_Insert(note);
                }

                foreach (Expense expense in predmet.Expenses)
                {
                    expense.CaseId = insertedId;
                    Expenses.Expense_Insert(expense);
                }

                foreach (Radnja radnja in predmet.Radnje)
                {
                    radnja.PredmetId = insertedId;
                    Radnje.Radnja_Insert(radnja);
                }

                foreach (Document document in predmet.Documents)
                {
                    document.CaseId = insertedId;
                    Documents.Document_Insert(document);
                }

                foreach (Connection connection in predmet.Connections)
                {
                    connection.CaseId = insertedId;
                    Connections.Connection_Insert(connection);
                }
            }

            return insertedId;
        }

        public static void Predmeti_Update(Predmet predmet)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<int>("kategorijaPredmetaId", predmet.KategorijaPredmetaId);
            collection.AddParameter<int>("ulogaId", predmet.UlogaId);
            collection.AddParameter<bool>("privremeniZastupnici", predmet.PrivremeniZastupnici);
            collection.AddParameter<bool>("pristupPredmetu", predmet.PristupPredmetu);
            collection.AddParameter<string>("brojPredmeta", predmet.BrojPredmeta);
            collection.AddParameter<int?>("sudId", predmet.SudId);
            collection.AddParameter<int>("sudijaId", predmet.SudijaId);
            collection.AddParameter<decimal?>("vrijednostSpora", predmet.VrijednostSpora);
            collection.AddParameter<int>("vrstaPredmetaId", predmet.VrstaPredmetaId);
            collection.AddParameter<DateTime?>("datumStanjaPredmeta", predmet.DatumStanjaPredmeta);
            //collection.AddParameter<int>("stanjePredmetaId", predmet.StanjePredmetaId);
            collection.AddParameter<string>("stanjePredmetaName", predmet.StanjePredmetaName);

            collection.AddParameter<int>("nacinOkoncanjaId", predmet.NacinOkoncanjaId);
            collection.AddParameter<string>("uspjeh", predmet.Uspjeh);
            collection.AddParameter<DateTime?>("datumArhiviranja", predmet.DatumArhiviranja);
            collection.AddParameter<string>("brojArhive", predmet.BrojArhive);
            collection.AddParameter<string>("brojArhiveRegistrator", predmet.BrojArhiveRegistrator);

            collection.AddParameter<string>("pravniOsnov", predmet.PravniOsnov);

            collection.AddParameter<int>("id", predmet.Id);
            collection.AddParameter<int?>("userId", predmet.ModifiedBy);

            DBUtility.Utility.ExecuteStoredProcedureVoid("Predmeti_Update", ref collection);

            #region Parties
            {
                List<LicePredmet> existingLicePredmeti = LicePredmet_GetForPredmet(predmet.Id);
                LicePredmet temp;

                foreach (LicePredmet lp in existingLicePredmeti)
                {
                    temp = (from LicePredmet tempLP in predmet.Parties
                                //where tempLP.LiceId == lp.LiceId && tempLP.PredmetId == lp.PredmetId && tempLP.UlogaId == lp.UlogaId
                            where tempLP.Id == lp.Id
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
            #endregion

            #region Notes
            {
                List<Note> existingNotes = Notes.Notes_GetForCase(predmet.Id);
                Note temp;

                foreach (Note note in existingNotes)
                {
                    temp = (from Note tempNote in predmet.Notes
                                //where tempNote.CaseId == note.CaseId && tempNote.NoteDate == note.NoteDate && tempNote.NoteText.Equals(note.NoteText) && tempNote.CreatedBy == note.CreatedBy
                            where tempNote.Id == note.Id
                            select tempNote).FirstOrDefault();

                    if (temp == null)
                        Notes.Note_Delete(note.Id);
                }

                foreach (Note note in predmet.Notes)
                {
                    note.CaseId = predmet.Id;

                    temp = (from Note tempNote in existingNotes
                            where tempNote.CaseId == note.CaseId && tempNote.NoteDate == note.NoteDate && tempNote.NoteText.Equals(note.NoteText) && tempNote.CreatedBy == note.CreatedBy
                            select tempNote).FirstOrDefault();

                    if (temp == null)
                        Notes.Note_Insert(note);
                }
            }
            #endregion

            #region Expenses
            {
                List<Expense> existingExpenses = Expenses.Expenses_GetForCase(predmet.Id);
                Expense temp;

                foreach (Expense expense in existingExpenses)
                {
                    temp = (from Expense tempExpense in predmet.Expenses
                                //where tempExpense.CaseId == expense.CaseId && tempExpense.ExpenseDate == expense.ExpenseDate && tempExpense.VrstaTroskaId == expense.VrstaTroskaId
                                //    && (tempExpense.PaidBy ?? "").ToLowerInvariant().Equals((expense.PaidBy ?? "").ToLowerInvariant())
                            where tempExpense.Id == expense.Id
                            select tempExpense).FirstOrDefault();

                    if (temp == null)
                        Expenses.Expense_Delete(expense.Id);
                }

                foreach (Expense expense in predmet.Expenses)
                {
                    expense.CaseId = predmet.Id;

                    temp = (from Expense tempExpense in existingExpenses
                            where tempExpense.CaseId == expense.CaseId && tempExpense.ExpenseDate == expense.ExpenseDate && tempExpense.VrstaTroskaId == expense.VrstaTroskaId
                                && tempExpense.PaidBy.ToLowerInvariant().Trim().Equals((expense.PaidBy ?? "").ToLowerInvariant().Trim())
                            select tempExpense).FirstOrDefault();

                    if (temp == null)
                        Expenses.Expense_Insert(expense);
                }
            }
            #endregion

            #region Radnje
            {
                List<Radnja> existingRadnje = Radnje.Radnje_GetForCase(predmet.Id, (int)predmet.ModifiedBy);
                Radnja temp;

                foreach (Radnja radnja in existingRadnje)
                {
                    temp = (from Radnja tempRadnja in predmet.Radnje
                            where tempRadnja.Id == radnja.Id
                            select tempRadnja).FirstOrDefault();

                    if (temp == null)
                        Radnje.Radnja_Delete(radnja);
                }

                foreach (Radnja radnja in predmet.Radnje)
                {
                    radnja.PredmetId = predmet.Id;
                    if (radnja.Id == -1)
                        Radnje.Radnja_Insert(radnja);
                    // They never update (app does not allow this)
                    //else
                    //    Radnje.Radnja_Update(radnja);
                }
            }
            #endregion

            #region Documents
            {
                List<Document> existingDocuments = Documents.Documents_GetForCase(predmet.Id, (int)predmet.ModifiedBy);
                Document temp;

                foreach (Document document in existingDocuments)
                {
                    temp = (from Document tempDocument in predmet.Documents
                            where tempDocument.Id == document.Id
                            select tempDocument).FirstOrDefault();

                    if (temp == null)
                        Documents.Document_Delete(document.Id);
                }

                foreach (Document document in predmet.Documents)
                {
                    document.CaseId = predmet.Id;
                    if (document.Id == -1)
                        Documents.Document_Insert(document);
                    else
                        Documents.Document_Update(document);
                }
            }
            #endregion

            #region Connections
            {
                List<Connection> existingConnections = Connections.Connections_GetForCase(predmet.Id);
                Connection temp;

                foreach (Connection document in existingConnections)
                {
                    temp = (from Connection tempConnection in predmet.Connections
                            where tempConnection.Id == document.Id
                            select tempConnection).FirstOrDefault();

                    if (temp == null)
                        Connections.Connection_Delete(document.Id);
                }

                foreach (Connection connection in predmet.Connections)
                {
                    connection.CaseId = predmet.Id;
                    if (connection.Id == -1)
                        Connections.Connection_Insert(connection);
                    else
                        Connections.Connection_Update(connection);
                }
            }
            #endregion
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
            collection.AddParameter<string>("broj", licePredmet.Broj);
            return DBUtility.Utility.ExecuteStoredProcedure<int>("LicePredmet_Insert", ref collection);
        }

        public static void LicePredmet_Delete(int id)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<int>("LicePredmet_Delete", "id", id);
        }

        public static List<Predmet> GetCasesForParty(int partyId)
        {
            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure<int>("GetCasesForParty", "partyId", partyId);
            return DBUtility.Utility.ParseDataTable<Predmet>(dt);
        }

        #endregion

        #region Advanced Search
        public static List<Predmet> Predmeti_GeForAdvancedSearch(AdvancedSearchParameters parameters)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<int>("userId", parameters.UserId);
            collection.AddParameter<int>("nasBroj", parameters.NasBroj ?? -1);
            collection.AddParameter<string>("kategorije", parameters.Kategorije ?? "");
            collection.AddParameter<string>("ulogeUPostupku", parameters.UlogeUPostupku ?? "");
            collection.AddParameter<string>("brojPredmeta", parameters.BrojPredmeta ?? "");
            collection.AddParameter<bool>("bezBrojaPredmeta", parameters.BezBrojaPredmeta);
            collection.AddParameter<string>("sudovi", parameters.Sudovi ?? "");
            collection.AddParameter<string>("sudije", parameters.Sudije ?? "");
            collection.AddParameter<decimal>("vrijednostSporaFrom", parameters.VrijednostSporaFrom);
            collection.AddParameter<decimal>("vrijednostSporaTo", parameters.VrijednostSporaTo);
            collection.AddParameter<string>("vrstePredmeta", parameters.VrstePredmeta ?? "");
            collection.AddParameter<DateTime?>("datumStanjaPredmeta", parameters.DatumStanjaPredmeta);
            collection.AddParameter<string>("stanjePredmeta", parameters.StanjePredmeta ?? "");
            collection.AddParameter<string>("labels", parameters.Labels ?? "");
            collection.AddParameter<DateTime?>("iniciranFrom", parameters.IniciranFrom);
            collection.AddParameter<DateTime?>("iniciranTo", parameters.IniciranTo);
            collection.AddParameter<DateTime?>("arhiviranFrom", parameters.ArhiviranFrom);
            collection.AddParameter<DateTime?>("arhiviranTo", parameters.ArhiviranTo);
            collection.AddParameter<int>("uspjehFrom", Convert.ToInt32((parameters.UspjehFrom ?? "0").Replace("%", "")));
            collection.AddParameter<int>("uspjehTo", Convert.ToInt32((parameters.UspjehTo ?? "100").Replace("%", "")));
            collection.AddParameter<bool?>("pristupPredmetu", parameters.PristupPredmetu);
            collection.AddParameter<string>("pravniOsnov", parameters.PravniOsnov);
            collection.AddParameter<int>("rowCount", parameters.RowCount);

            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure("Predmeti_GetForAdvancedSearch", ref collection);
            return DBUtility.Utility.ParseDataTable<Predmet>(dt);
        }
        #endregion
    }
}