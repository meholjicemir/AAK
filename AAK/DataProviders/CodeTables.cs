using AAK.Models;
using AAK.Models.Helper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace AAK.DataProviders
{
    public static class CodeTables
    {
        public static List<CodeTableData> CodeTable_GetData(CodeTable codeTable)
        {
            DataTable dt = DBUtility.Utility.ExecuteStoredProcedure<string, string>("CodeTable_GetData", "tableName", codeTable.Name, "columnName", codeTable.ColumnName);
            return DBUtility.Utility.ParseDataTable<CodeTableData>(dt);
        }

        public static int? CodeTable_InsertRecord(CodeTableData codeTableData)
        {
            return DBUtility.Utility.ExecuteStoredProcedure<string, string, int>("CodeTable_InsertRecord", "tableName", codeTableData.TableName, "name", codeTableData.Name);
        }
    }
}