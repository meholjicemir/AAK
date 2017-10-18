using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GetGoogleDocIds
{
    class Program
    {
        static void Main(string[] args)
        {
            //GoogleDriveIntegration.Utility.DownloadFile("0B5XGHYent1qWMWUwRndMX2N4dHc", "zalba.docx", 1);

            Handle('D');
            Handle('R');
        }

        private static void Handle(char entity)
        {
            string rootFolderId = ConfigurationManager.AppSettings["GoogleDriveRootFolderId"].ToString();

            DataTable dt;
            if (entity == 'D')
                dt = DBUtility.Utility.ExecuteStoredProcedure("GetDocsForMapping");
            else if (entity == 'R')
                dt = DBUtility.Utility.ExecuteStoredProcedure("GetRadnjeForMapping");
            else
                return;

            List<Doc> docs = DBUtility.Utility.ParseDataTable<Doc>(dt);

            #region Variables used in the loop
            string fileName;
            List<string> fileFolderNames;
            List<string> fileFolderIds;
            List<Google.Apis.Drive.v3.Data.File> folders;
            bool updated = false;
            #endregion

            foreach (Doc doc in docs)
            {
                fileName = doc.UNC;
                if (fileName.Contains('\\'))
                    fileName = fileName.Substring(fileName.LastIndexOf('\\') + 1);

                List<Google.Apis.Drive.v3.Data.File> files = new List<Google.Apis.Drive.v3.Data.File>();
                GoogleDriveIntegration.Utility.GetFiles(ref files, fileName);

                if (files.Count == 0)
                    UpdateGoogleDocDriveId(doc.Id, "none", entity);
                else if (files.Count == 1)
                    UpdateGoogleDocDriveId(doc.Id, files[0].Id, entity);
                else
                {
                    updated = false;
                    fileFolderNames = doc.UNC.Replace(fileName, "").Split('\\').ToList<string>();
                    fileFolderIds = new List<string>();

                    string tempFolderId = rootFolderId;
                    foreach (string fileFolderName in fileFolderNames)
                    {
                        if (fileFolderName.Trim() != "")
                        {
                            folders = new List<Google.Apis.Drive.v3.Data.File>();
                            GoogleDriveIntegration.Utility.GetFolders(ref folders, tempFolderId, fileFolderName.Trim());

                            if (folders.Count == 1)
                            {
                                fileFolderIds.Add(folders[0].Id);
                                tempFolderId = folders[0].Id;
                            }
                        }
                    }

                    foreach (Google.Apis.Drive.v3.Data.File file in files)
                    {
                        if (fileFolderIds.Count > 0
                            && (file.Parents == null ? true : file.Parents.Contains(fileFolderIds.Last<string>())))
                        {
                            UpdateGoogleDocDriveId(doc.Id, file.Id, entity);
                            updated = true;
                            break;
                        }
                    }

                    if (!updated)
                    {
                        if (entity == 'D')
                            LoggerUtility.Logger.LogMessage("doc_not_found_in_google_drive", doc.Id.ToString() + " - " + doc.UNC);
                        else if (entity == 'R')
                            LoggerUtility.Logger.LogMessage("radnja_doc_not_found_in_google_drive", doc.Id.ToString() + " - " + doc.UNC);
                    }
                }
            }
        }

        private static void UpdateGoogleDocDriveId(int docId, string fileId, char entity)
        {
            if (entity == 'D')
                DBUtility.Utility.ExecuteStoredProcedureVoid<int, string>(
                            "Dokument_UpdateGoogleDocDriveId",
                            "id", docId,
                            "googleDriveDocId", fileId);
            else if (entity == 'R')
            {
                DBUtility.Utility.ExecuteStoredProcedureVoid<int, string>(
                        "Radnja_UpdateGoogleDocDriveId",
                        "id", docId,
                        "googleDriveDocId", fileId);

                LoggerUtility.Logger.LogMessage("QUERY_update_google_drive_doc_id_radnje",
                    "UPDATE Radnje SET google_drive_doc_id = '" + fileId + "' WHERE id = " + docId.ToString() + ";");
            }
        }
    }
}
