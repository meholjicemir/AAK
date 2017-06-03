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
        public static List<Predmet> Predmeti_GetAll(int userId)
        {
            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure<int>("Predmeti_GetAll", "userId", userId);
            return DBUtility.Utility.ParseDataTable<Predmet>(dt);
        }
    }
}