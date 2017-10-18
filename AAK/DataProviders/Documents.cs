using AAK.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace AAK.DataProviders
{
    public class Documents
    {
        public static List<Document> Documents_GetForCase(int caseId, int userId)
        {
            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure<int, int>("Documents_GetForCase", "caseId", caseId, "userId", userId);
            List<Document> documents = DBUtility.Utility.ParseDataTable<Document>(dt);

            foreach (Document document in documents)
            {
                document.DocumentName = document.DocumentName.Replace("%20", " ");
                if (document.DocumentName.Contains('\\'))
                    document.DocumentName = document.DocumentName.Substring(document.DocumentName.LastIndexOf('\\') + 1);
            }

            return documents;
        }

        public static int? Document_Insert(Document document)
        {
            //document.DocumentLink = (document.DocumentLink ?? "").TrimStart('\\').TrimStart('/');

            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<int>("caseId", document.CaseId);
            collection.AddParameter<string>("note", document.Note);
            collection.AddParameter<int?>("tipDokumentaId", document.TipDokumentaId);
            collection.AddParameter<string>("predatoUzDokumentName", document.PredatoUzDokumentName);
            collection.AddParameter<string>("googleDriveDocId", document.GoogleDriveDocId);
            return DBUtility.Utility.ExecuteStoredProcedure<int>("Document_Insert", ref collection);
        }

        public static void Document_Update(Document document)
        {
            //document.DocumentLink = (document.DocumentLink ?? "").TrimStart('\\').TrimStart('/');

            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<int>("caseId", document.CaseId);
            collection.AddParameter<string>("note", document.Note);
            collection.AddParameter<int?>("tipDokumentaId", document.TipDokumentaId);
            collection.AddParameter<string>("predatoUzDokumentName", document.PredatoUzDokumentName);
            collection.AddParameter<string>("googleDriveDocId", document.GoogleDriveDocId);
            collection.AddParameter<int>("id", document.Id);
            DBUtility.Utility.ExecuteStoredProcedureVoid("Document_Update", ref collection);
        }

        public static void Document_Delete(int id)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<int>("Document_Delete", "id", id);
        }
    }
}