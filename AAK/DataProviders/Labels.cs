using AAK.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace AAK.DataProviders
{
    public class Labels
    {
        public static List<Label> Labels_GetAll()
        {
            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure("Labels_GetAll");
            return DBUtility.Utility.ParseDataTable<Label>(dt);
        }

        public static int? Label_Insert(Label label)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<string>("name", label.Name);
            collection.AddParameter<string>("backgroundColor", label.BackgroundColor);
            collection.AddParameter<string>("fontColor", label.FontColor);
            return DBUtility.Utility.ExecuteStoredProcedure<int>("Label_Insert", ref collection);
        }

        public static void Label_Update(Label label)
        {
            DBUtility.ParameterCollection collection = new DBUtility.ParameterCollection();
            collection.AddParameter<string>("name", label.Name);
            collection.AddParameter<string>("backgroundColor", label.BackgroundColor);
            collection.AddParameter<string>("fontColor", label.FontColor);
            collection.AddParameter<int>("id", label.Id);
            DBUtility.Utility.ExecuteStoredProcedureVoid("Label_Update", ref collection);
        }

        public static void Label_Delete(int id)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<int>("Label_Delete", "id", id);
        }
    }
}