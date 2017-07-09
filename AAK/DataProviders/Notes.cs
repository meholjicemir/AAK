using AAK.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace AAK.DataProviders
{
    public class Notes
    {
        public static List<Note> Notes_GetForCase(int caseId)
        {
            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure<int>("Notes_GetForCase", "caseId", caseId);
            return DBUtility.Utility.ParseDataTable<Note>(dt);
        }

        public static int? Note_Insert(Note note)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<int>("caseId", note.CaseId);
            collection.AddParameter<DateTime?>("noteDate", note.NoteDate);
            collection.AddParameter<string>("noteText", note.NoteText);
            collection.AddParameter<int?>("userId", note.CreatedBy);
            return DBUtility.Utility.ExecuteStoredProcedure<int>("Note_Insert", ref collection);
        }

        public static void Note_Delete(int id)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<int>("Note_Delete", "id", id);
        }
    }
}