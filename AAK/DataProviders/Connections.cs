using AAK.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace AAK.DataProviders
{
    public class Connections
    {
        public static List<Connection> Connections_GetForCase(int caseId)
        {
            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure<int>("Connections_GetForCase", "caseId", caseId);
            return DBUtility.Utility.ParseDataTable<Connection>(dt);
        }

        public static int? Connection_Insert(Connection connection)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<int>("caseId", connection.CaseId);
            collection.AddParameter<string>("note", connection.Note);
            collection.AddParameter<int>("connectionCaseId", connection.ConnectionCaseId);
            return DBUtility.Utility.ExecuteStoredProcedure<int>("Connection_Insert", ref collection);
        }

        public static void Connection_Update(Connection connection)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<int>("caseId", connection.CaseId);
            collection.AddParameter<string>("note", connection.Note);
            collection.AddParameter<int>("connectionCaseId", connection.ConnectionCaseId);
            collection.AddParameter<int>("id", connection.Id);
            DBUtility.Utility.ExecuteStoredProcedureVoid("Connection_Update", ref collection);
        }

        public static void Connection_Delete(int id)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<int>("Connection_Delete", "id", id);
        }
    }
}