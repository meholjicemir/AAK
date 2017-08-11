using AAK.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;

namespace AAK.DataProviders
{
    public class Templates
    {
        public static List<Template> Templates_GetAll()
        {
            try
            {
                List<string> filePaths = Directory.GetFiles(HttpRuntime.AppDomainAppPath + "Templates", "*.docx", SearchOption.TopDirectoryOnly).ToList<string>();
                List<Template> templates = new List<Template>();
                foreach (string filePath in filePaths)
                {
                    Template template = new Template();
                    template.Name = filePath.Substring(filePath.Replace('/', '\\').LastIndexOf('\\') + 1);
                    template.FullPath = filePath;
                    templates.Add(template);
                }
                return templates;
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Templates_GetAll");
                return new List<Template>();
            }
        }

        public static List<KeyValuePair<string, string>> Case_GetTemplateFields(int caseId, int userId)
        {
            try
            {
                DataTable dt = DBUtility.Utility.ExecuteStoredProcedure<int, int>("Case_GetTemplateFields", "caseId", caseId, "userId", userId);

                List<KeyValuePair<string, string>> templateFields = new List<KeyValuePair<string, string>>();

                foreach (DataColumn dc in dt.Columns)
                    templateFields.Add(new KeyValuePair<string, string>(dc.ColumnName, dt.Rows[0][dc].ToString()));

                return templateFields;
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Case_GetTemplateFields");
                return new List<KeyValuePair<string, string>>();
            }
        }

    }
}