using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Drive.v3;
using Google.Apis.Drive.v3.Data;
using Google.Apis.Services;
using Google.Apis.Util.Store;
using System.IO;
using System.Threading;
using System.Configuration;

namespace GoogleDriveIntegration
{
    public static class Utility
    {
        private static DriveService Service = null;
        private static string[] Scopes = { DriveService.Scope.Drive };

        private static DriveService GetService()
        {
            UserCredential credential;

            string jsonPath = AppDomain.CurrentDomain.BaseDirectory + "client_secret.json";
            using (var stream = new FileStream(jsonPath, FileMode.Open, FileAccess.Read))
            {
                credential = GoogleWebAuthorizationBroker.AuthorizeAsync(
                    GoogleClientSecrets.Load(stream).Secrets,
                    Scopes,
                    "user",
                    CancellationToken.None
                    ).Result;
            }

            // Create Drive API service.
            var service = new DriveService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = ConfigurationManager.AppSettings["ApplicationName"] == null ? null : ConfigurationManager.AppSettings["ApplicationName"].ToString()
            });

            return service;
        }

        public static void GetFiles(ref List<Google.Apis.Drive.v3.Data.File> files, string name = null, string pageToken = null)
        {
            try
            {
                if (Service == null)
                    Service = GetService();

                // Define parameters of request.
                FilesResource.ListRequest listRequest = Service.Files.List();
                listRequest.PageSize = 1000;

                if (name != null)
                    listRequest.Q = "name='" + name + "'";

                listRequest.Fields = "nextPageToken, files(id, name, mimeType, parents)";
                listRequest.PageToken = pageToken;

                // List files.
                FileList fl = listRequest.Execute();
                files.AddRange(fl.Files);
                if (fl.NextPageToken != null)
                    GetFiles(ref files, name, fl.NextPageToken);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "GoogleDriveIntegration.Utility.GetFolders");
            }
        }

        public static void GetFolders(ref List<Google.Apis.Drive.v3.Data.File> folders, string rootFolderId = null, string name = null, string pageToken = null)
        {
            try
            {
                if (Service == null)
                    Service = GetService();

                // Define parameters of request.
                FilesResource.ListRequest listRequest = Service.Files.List();
                listRequest.PageSize = 1000;

                listRequest.Q = "mimeType='application/vnd.google-apps.folder'";
                if (rootFolderId != null)
                    listRequest.Q += " and '" + rootFolderId + "' in parents";
                if (name != null)
                    listRequest.Q += " and name='" + name + "'";

                listRequest.Fields = "nextPageToken, files(id, name)";
                listRequest.PageToken = pageToken;

                // List files.
                FileList fl = listRequest.Execute();
                folders.AddRange(fl.Files);

                if (fl.NextPageToken != null)
                    GetFolders(ref folders, rootFolderId, name, fl.NextPageToken);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "GoogleDriveIntegration.Utility.GetFolders");
            }
        }

        public static string UploadFile(string filePath, string fileName, string parentFolderId = null)
        {
            try
            {
                if (Service == null)
                    Service = GetService();

                // TEMP
                //IList<Google.Apis.Drive.v3.Data.File> files = new List<Google.Apis.Drive.v3.Data.File>();
                //GetFolders(ref files);

                var fileMetadata = new Google.Apis.Drive.v3.Data.File()
                {
                    Name = fileName,
                    Parents = parentFolderId == null ? null : new List<string> { parentFolderId }
                };

                FilesResource.CreateMediaUpload request;
                using (var stream = new System.IO.FileStream(filePath, System.IO.FileMode.Open))
                {
                    request = Service.Files.Create(fileMetadata, stream, "image/jpeg");
                    request.Fields = "id";
                    request.Upload();
                }
                var file = request.ResponseBody;
                return file.Id;
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "GoogleDriveIntegration.Utility.UploadFile");
                return "";
            }
        }

        /// <summary>
        /// Downloads a file from Google drive and saves it to Temp\userId folder.
        /// </summary>
        /// <param name="fileId"></param>
        /// <param name="fileName"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public static bool DownloadFile(string fileId, string fileName, int userId)
        {
            try
            {
                if (Service == null)
                    Service = GetService();

                var request = Service.Files.Get(fileId);
                var stream = new System.IO.MemoryStream();

                request.Download(stream);

                if (stream != null)
                {
                    string folderPath = AppDomain.CurrentDomain.BaseDirectory + "Temp\\" + userId.ToString() + "\\";
                    if (Directory.Exists(folderPath))
                        Directory.Delete(folderPath, true);
                    Directory.CreateDirectory(folderPath);

                    string filePath = folderPath + fileName;
                    if (System.IO.File.Exists(filePath))
                        System.IO.File.Delete(filePath);

                    System.IO.File.WriteAllBytes(filePath, stream.ToArray());
                    return true;
                }
                return false;
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "GoogleDriveIntegration.Utility.DownloadFile");
                return false;
            }
        }
    }
}
