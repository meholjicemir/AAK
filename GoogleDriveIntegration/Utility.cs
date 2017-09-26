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

namespace GoogleDriveIntegration
{
    public static class Utility
    {
        private static DriveService Service = null;
        private static string[] Scopes = { DriveService.Scope.Drive };
        private static string ApplicationName = "Drive API .NET Quickstart";

        private static DriveService GetService()
        {
            UserCredential credential;

            string jsonPath = AppDomain.CurrentDomain.BaseDirectory + "bin/client_secret.json";
            using (var stream = new FileStream(jsonPath, FileMode.Open, FileAccess.Read))
            {
                string credPath = System.Environment.GetFolderPath(System.Environment.SpecialFolder.Personal);
                credPath = Path.Combine(credPath, ".credentials/drive-dotnet-quickstart.json");

                credential = GoogleWebAuthorizationBroker.AuthorizeAsync(
                    GoogleClientSecrets.Load(stream).Secrets,
                    Scopes,
                    "user",
                    CancellationToken.None,
                    new FileDataStore(credPath, true)).Result;
                //Console.WriteLine("Credential file saved to: " + credPath);
            }

            // Create Drive API service.
            var service = new DriveService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = ApplicationName,
            });



            return service;
        }

        private static void GetFolders(ref IList<Google.Apis.Drive.v3.Data.File> files)
        {
            try
            {
                if (Service == null)
                    Service = GetService();

                // Define parameters of request.
                FilesResource.ListRequest listRequest = Service.Files.List();
                //listRequest.PageSize = 10;
                listRequest.Fields = "nextPageToken, files(id, name, mimeType)";

                // List files.
                files = listRequest.Execute().Files;

                // Exclude everything that's not a folder.
                for (int i = files.Count - 1; i >= 0; i--)
                    if (!files[i].MimeType.Equals("application/vnd.google-apps.folder"))
                        files.RemoveAt(i);
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
                IList<Google.Apis.Drive.v3.Data.File> files = new List<Google.Apis.Drive.v3.Data.File>();
                GetFolders(ref files);

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
