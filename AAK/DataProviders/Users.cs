using AAK.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace AAK.DataProviders
{
    public static class Users
    {
        public static List<User> Users_GetAll()
        {
            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure("Users_GetAll");
            return DBUtility.Utility.ParseDataTable<User>(dt);
        }

        public static int? User_Insert(User user)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<string>("email", user.Email);
            collection.AddParameter<string>("phone", user.Phone);
            collection.AddParameter<string>("firstName", user.FirstName);
            collection.AddParameter<string>("lastName", user.LastName);
            collection.AddParameter<string>("userGroupCodes", user.UserGroupCodes);
            collection.AddParameter<string>("googleDriveLocalFolderPath", user.GoogleDriveLocalFolderPath);
            return DBUtility.Utility.ExecuteStoredProcedure<int>("User_Insert", ref collection);
        }

        public static void User_Update(User user)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<string>("email", user.Email);
            collection.AddParameter<string>("phone", user.Phone);
            collection.AddParameter<string>("firstName", user.FirstName);
            collection.AddParameter<string>("lastName", user.LastName);
            collection.AddParameter<string>("userGroupCodes", user.UserGroupCodes);
            collection.AddParameter<string>("googleDriveLocalFolderPath", user.GoogleDriveLocalFolderPath);
            collection.AddParameter<int>("id", user.Id);
            DBUtility.Utility.ExecuteStoredProcedureVoid("User_Update", ref collection);
        }

        public static void User_Delete(int id)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<int>("User_Delete", "id", id);
        }
    }
}