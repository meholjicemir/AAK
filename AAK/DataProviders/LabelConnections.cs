using AAK.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.DataProviders
{
    public class LabelConnections
    {
        public static int? LabelConnection_Create(LabelConnection labelConnection)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<int>("labelId", labelConnection.LabelId);
            collection.AddParameter<string>("contentType", labelConnection.ContentType);
            collection.AddParameter<int>("contentId", labelConnection.ContentId);
            return DBUtility.Utility.ExecuteStoredProcedure<int>("LabelConnection_Create", ref collection);
        }

        public static void LabelConnection_Delete(LabelConnection labelConnection)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<int, int, string>("LabelConnection_Delete", "labelId", labelConnection.LabelId, "contentId", labelConnection.ContentId, "contentType", labelConnection.ContentType);
        }
    }
}