using AAK.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace AAK.DataProviders
{
    public class UserGroups
    {
        public static List<UserGroup> UserGroups_GetAll()
        {
            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure("UserGroups_GetAll");
            return DBUtility.Utility.ParseDataTable<UserGroup>(dt);
        }
    }
}