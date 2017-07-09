using AAK.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace AAK.DataProviders
{
    public class Expenses
    {
        public static List<Expense> Expenses_GetForCase(int caseId)
        {
            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure<int>("Expenses_GetForCase", "caseId", caseId);
            return DBUtility.Utility.ParseDataTable<Expense>(dt);
        }

        public static int? Expense_Insert(Expense expense)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<int>("caseId", expense.CaseId);
            collection.AddParameter<decimal>("amount", expense.Amount);
            collection.AddParameter<DateTime?>("expenseDate", expense.ExpenseDate);
            collection.AddParameter<string>("paidBy", expense.PaidBy);
            collection.AddParameter<int?>("vrstaTroskaId", expense.VrstaTroskaId);
            return DBUtility.Utility.ExecuteStoredProcedure<int>("Expense_Insert", ref collection);
        }

        public static void Expense_Delete(int id)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<int>("Expense_Delete", "id", id);
        }
    }
}