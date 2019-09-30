using AAK.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Web.Script.Serialization;

namespace AAK.Google
{
    public static class Validator
    {
        public static Dictionary<string, User> UserSessions = new Dictionary<string, User>();

        public static bool ValidateToken(string token, string email)
        {
            //TEMP
            //return true;

            User user = new User();
            user.Token = token;
            user.Email = email;
            return ValidateToken(ref user);
        }

        public static bool ValidateToken(ref User user)
        {
            //TEMP
            //if (user.Email.ToLowerInvariant().Equals("meholjic.emir@gmail.com") || user.Email.ToLowerInvariant().Equals("mersad18@gmail.com") || user.Email.ToLowerInvariant().Equals("jasminadonko@gmail.com"))
            //    return true;

            try
            {
                LoggerUtility.Logger.LogMessage("ValidateToken", (user.Email ?? "") + " - " + (user.Token ?? ""));

                if (UserSessions.ContainsKey(user.Token) && UserSessions[user.Token].Email.Equals(user.Email))
                {
                    user = UserSessions[user.Token];
                    return true;
                }

                LoggerUtility.Logger.LogMessage("ValidateToken.Debug", "1");

                //System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
                using (var client = new HttpClient())
                {
                    LoggerUtility.Logger.LogMessage("ValidateToken.Debug", "2");
                    var values = new Dictionary<string, string>
                    {
                       { "id_token", user.Token }
                    };

                    HttpContent content = new FormUrlEncodedContent(values);
                    string requestBody = content.ReadAsStringAsync().Result;

                    LoggerUtility.Logger.LogMessage("ValidateToken.Debug", "3");
                    LoggerUtility.Logger.LogMessage("ValidateToken.Debug", requestBody);

                    client.Timeout = TimeSpan.FromMinutes(10);

                    Uri uri = new Uri(ConfigurationManager.AppSettings["Google_TokenValidationURL"].ToString(), UriKind.Absolute);
                    LoggerUtility.Logger.LogMessage("ValidateToken.Debug", uri.AbsoluteUri);

                    HttpResponseMessage response = client.PostAsync(uri, content).Result;
                    LoggerUtility.Logger.LogMessage("ValidateToken.Debug", "4");
                    string resultContent = response.Content.ReadAsStringAsync().Result;
                    LoggerUtility.Logger.LogMessage("ValidateToken.Debug", "5");
                    LoggerUtility.Logger.LogMessage("ValidateToken.Debug", resultContent);

                    dynamic item = new JavaScriptSerializer().Deserialize<object>(resultContent);
                    bool errorDescriptionExists = item.ContainsKey("error_description");
                    if (errorDescriptionExists)
                    {
                        LoggerUtility.Logger.LogMessage("Login failed", item["error_description"]);
                        return false;
                    }

                    string emailVerified = item["email"];
                    LoggerUtility.Logger.LogMessage("ValidateToken.Debug", "6");
                    LoggerUtility.Logger.LogMessage("ValidateToken.Debug", emailVerified);

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
                LoggerUtility.Logger.LogException(ex, "ValidateToken");
                if (ex.InnerException != null)
                {
                    //LoggerUtility.Logger.LogException(ex.InnerException, "ValidateToken.InnerException");
                    Exception ex2 = ex.InnerException;
                    string idCode = "ValidateToken.InnerException";
                    while (ex2 != null)
                    {
                        LoggerUtility.Logger.LogException(ex2, idCode);
                        ex2 = ex2.InnerException;
                        idCode += ".InnerException";
                    }
                }

                return false;
            }
        }
    }
}