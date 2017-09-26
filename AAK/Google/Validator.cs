﻿using AAK.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Script.Serialization;

namespace AAK.Google
{
    public static class Validator
    {
        public static Dictionary<string, User> UserSessions = new Dictionary<string, User>();

        public static bool ValidateToken(string token, string email)
        {
            //TEMP
            return true;

            User user = new User();
            user.Token = token;
            user.Email = email;
            return ValidateToken(ref user);
        }

        public static bool ValidateToken(ref User user)
        {
            //TEMP
            //GoogleDriveIntegration.Utility.DownloadFile("0B9A-gSuvyVSOazNzclhmSmR0MkE", "ocr issue 1.jpg", 1);
            GoogleDriveIntegration.Utility.UploadFile(@"C:\Users\emir\Desktop\ocr issue 1.jpg", "ocr issue 1.jpg");
            return true;

            try
            {
                if (UserSessions.ContainsKey(user.Token) && UserSessions[user.Token].Email.Equals(user.Email))
                {
                    user = UserSessions[user.Token];
                    return true;
                }

                System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
                using (var client = new HttpClient())
                {
                    var values = new Dictionary<string, string>
                    {
                       { "id_token", user.Token }
                    };

                    HttpContent content = new FormUrlEncodedContent(values);
                    string requestBody = content.ReadAsStringAsync().Result;

                    HttpResponseMessage response = client.PostAsync(ConfigurationManager.AppSettings["Google_TokenValidationURL"].ToString(), content).Result;
                    string resultContent = response.Content.ReadAsStringAsync().Result;

                    dynamic item = new JavaScriptSerializer().Deserialize<object>(resultContent);
                    bool errorDescriptionExists = item.ContainsKey("error_description");
                    if (errorDescriptionExists)
                    {
                        LoggerUtility.Logger.LogMessage("Login failed", item["error_description"]);
                        return false;
                    }

                    string emailVerified = item["email"];

                    if (user.Email.Equals(emailVerified) && item["aud"].ToString().Contains(ConfigurationManager.AppSettings["Google_ClientId"].ToString()))
                    {
                        user.PictureLink = item["picture"];

                        for (int i = UserSessions.Count - 1; i >= 0; i--)
                        {
                            string key = UserSessions.Keys.ElementAt(i);
                            if (UserSessions[key].Email.Equals(user.Email))
                                UserSessions.Remove(key);
                        }

                        UserSessions.Add(user.Token, user);
                        return true;
                    }
                    return false;
                }
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex);
                return false;
            }
        }
    }
}