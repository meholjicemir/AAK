using AAK.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace AAK.DataProviders
{
    public class CaseActivities
    {
        public static List<CaseActivity> CaseActivities_GetAll(int userId, string filter, int rowCount)
        {
            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure<int, string, int>("CaseActivities_GetAll", "userId", userId, "filter", filter ?? "", "rowCount", rowCount);
            return DBUtility.Utility.ParseDataTable<CaseActivity>(dt);
        }

        public static void CaseActivity_Delete(long id)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<long>("CaseActivity_Delete", "id", id);
        }
    }
}