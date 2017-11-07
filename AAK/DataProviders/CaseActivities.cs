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

        public static int CaseActivity_Create(CaseActivity caseActivity)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<int>("caseId", caseActivity.CaseId);
            collection.AddParameter<string>("note", caseActivity.Note);
            collection.AddParameter<DateTime?>("activityDate", caseActivity.ActivityDate);
            collection.AddParameter<int>("activityDaysOffset", caseActivity.ActivityDaysOffset);
            collection.AddParameter<int?>("userId", caseActivity.CreatedBy);
            collection.AddParameter<bool>("forAllUsers", caseActivity.ForAllUsers);
            return DBUtility.Utility.ExecuteStoredProcedure<int>("CaseActivity_Create", ref collection);
        }

        public static void CaseActivity_Delete(long id)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<long>("CaseActivity_Delete", "id", id);
        }
    }
}