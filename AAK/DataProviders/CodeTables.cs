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
            List<CodeTableData> result = DBUtility.Utility.ParseDataTable<CodeTableData>(dt);

            int ordinalNo = 1;
            foreach (CodeTableData record in result)
                record.OrdinalNo = ordinalNo++;

            return result;
        }

        public static int? CodeTable_InsertRecord(CodeTableData codeTableData)
        {
            return DBUtility.Utility.ExecuteStoredProcedure<string, string, int>("CodeTable_InsertRecord", "tableName", codeTableData.TableName, "name", codeTableData.Name);
        }

        public static void CodeTable_UpdateRecord(CodeTableData codeTableData)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<string, string, int>("CodeTable_UpdateRecord", "tableName", codeTableData.TableName, "name", codeTableData.Name, "id", codeTableData.Id);
        }

        public static void CodeTable_DeleteRecord(CodeTableData codeTableData)
        {
            DBUtility.Utility.ExecuteStoredProcedureVoid<string, int>("CodeTable_DeleteRecord", "tableName", codeTableData.TableName, "id", codeTableData.Id);
        }
    }
}