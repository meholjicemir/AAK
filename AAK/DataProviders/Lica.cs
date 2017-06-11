using AAK.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace AAK.DataProviders
{
    public class Lica
    {
        public static List<Lice> Lica_GetAll(int userId, string filter, int rowCount)
        {
            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure<int, string, int>("Lica_GetAll", "userId", userId, "filter", filter ?? "", "rowCount", rowCount);
            return DBUtility.Utility.ParseDataTable<Lice>(dt);
        }
    }
}