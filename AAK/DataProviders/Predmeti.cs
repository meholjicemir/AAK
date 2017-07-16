﻿using AAK.Models;
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
                                && tempExpense.PaidBy.ToLowerInvariant().Equals(expense.PaidBy.ToLowerInvariant())
                            select tempExpense).FirstOrDefault();

                    if (temp == null)
                        Expenses.Expense_Insert(expense);
                }
            }
            #endregion

            #region Radnje
            {
                List<Radnja> existingRadnje = Radnje.Radnje_GetForCase(predmet.Id);
                Radnja temp;

                foreach (Radnja radnja in existingRadnje)
                {
                    temp = (from Radnja tempRadnja in predmet.Radnje
                            where tempRadnja.Id == radnja.Id
                            select tempRadnja).FirstOrDefault();

                    if (temp == null)
                        Radnje.Radnja_Delete(radnja.Id);
                }

                foreach (Radnja radnja in predmet.Radnje)
                {
                    radnja.PredmetId = predmet.Id;
                    if (radnja.Id == -1)
                        Radnje.Radnja_Insert(radnja);
                    else
                        Radnje.Radnja_Update(radnja);
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
            return DBUtility.Utility.ExecuteStoredProcedure<int>("LicePredmet_Insert", ref collection);
        }

        public static void LicePredmet_Delete(int id)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<int>("LicePredmet_Delete", "id", id);
        }

        #endregion
    }
}