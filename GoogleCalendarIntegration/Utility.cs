using Google.Apis.Auth.OAuth2;
using Google.Apis.Calendar.v3;
using Google.Apis.Calendar.v3.Data;
using Google.Apis.Services;
using Google.Apis.Util.Store;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace GoogleCalendarIntegration
{
    public class Utility
    {
        private static CalendarService Service = null;
        private static string[] Scopes = { CalendarService.Scope.Calendar };

        private static CalendarService GetService()
        {
            var credential = GoogleWebAuthorizationBroker.AuthorizeAsync(
                           new ClientSecrets
                           {
                               ClientId = ConfigurationManager.AppSettings["Google_ClientId"].ToString(),
                               ClientSecret = ConfigurationManager.AppSettings["Google_ClientSecret"].ToString(),
                           },
                           new[] { CalendarService.Scope.Calendar },
                           "user",
                           CancellationToken.None).Result;

            // Create the service.
            var service = new CalendarService(new BaseClientService.Initializer
            {
                HttpClientInitializer = credential,
                ApplicationName = "Calendar API Sample",
            });

            return service;
        }

        private static CalendarService GetService2(int userId)
        {
            UserCredential credential;

            string jsonPath = AppDomain.CurrentDomain.BaseDirectory + "client_secret.json";

            LoggerUtility.Logger.LogMessage("debug", "jsonPath: " + jsonPath);
            using (var stream = new FileStream(jsonPath, FileMode.Open, FileAccess.Read))
            {
                string credPath = AppDomain.CurrentDomain.BaseDirectory + "Temp\\_" + userId.ToString() + "_\\";
                credPath = Path.Combine(credPath, ".credentials/calendar-dotnet-quickstart.json");

                //string credPath = System.Environment.GetFolderPath(System.Environment.SpecialFolder.Personal);
                //credPath = Path.Combine(credPath, ".credentials/calendar-dotnet-quickstart.json");

                LoggerUtility.Logger.LogMessage("debug", "credPath: " + credPath);

                credential = GoogleWebAuthorizationBroker.AuthorizeAsync(
                    GoogleClientSecrets.Load(stream).Secrets,
                    Scopes,
                    "user",
                    CancellationToken.None,
                    new FileDataStore(credPath, false)
                    ).Result;

                LoggerUtility.Logger.LogMessage("debug", "Authorized.");
            }

            LoggerUtility.Logger.LogMessage("debug", "About to initialize service.");

            // Create Google Calendar API service.
            var service = new CalendarService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = "Djonko" //ConfigurationManager.AppSettings["ApplicationName"] == null ? null : ConfigurationManager.AppSettings["ApplicationName"].ToString()
            });

            LoggerUtility.Logger.LogMessage("debug", "Service initialized.");

            return service;
        }

        public static string CreateEvent(int userId, string summary, string description,
            DateTime start, DateTime end, string calendarId = "primary",
            string location = "", string timezone = "Europe/Sarajevo")
        {
            try
            {
                if (Service == null)
                    Service = GetService();

                Event newEvent = new Event()
                {
                    Summary = summary,
                    Location = location,
                    Description = description,
                    Start = new EventDateTime()
                    {
                        DateTime = start,
                        TimeZone = timezone
                    },
                    End = new EventDateTime()
                    {
                        DateTime = end,
                        TimeZone = timezone
                    },
                    Reminders = new Event.RemindersData()
                    {
                        UseDefault = false,
                        Overrides = new EventReminder[] {
                            new EventReminder() { Method = "email", Minutes = 24 * 60 },
                            new EventReminder() { Method = "sms", Minutes = 10 },
                        }
                    }
                };

                EventsResource.InsertRequest request = Service.Events.Insert(newEvent, calendarId);
                Event createdEvent = request.Execute();

                return createdEvent.Id;
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "GoogleCalendarIntegration.Utility.CreateEvent");
                if (ex.InnerException != null)
                {
                    LoggerUtility.Logger.LogException(ex.InnerException, "GoogleCalendarIntegration.Utility.CreateEvent.InnerException");
                    if (ex.InnerException.InnerException != null)
                        LoggerUtility.Logger.LogException(ex.InnerException.InnerException, "GoogleCalendarIntegration.Utility.CreateEvent.InnerException.InnerException");
                }

                return "";
            }
        }

        public static void UpdateEvent(int userId, string eventId, string summary, string description,
            DateTime start, DateTime end, string calendarId = "primary",
            string location = "", string timezone = "Europe/Sarajevo")
        {
            try
            {
                if (Service == null)
                    Service = GetService();

                Event newEvent = new Event()
                {
                    Summary = summary,
                    Location = location,
                    Description = description,
                    Start = new EventDateTime()
                    {
                        DateTime = start,
                        TimeZone = timezone
                    },
                    End = new EventDateTime()
                    {
                        DateTime = end,
                        TimeZone = timezone
                    },
                    Reminders = new Event.RemindersData()
                    {
                        UseDefault = false,
                        Overrides = new EventReminder[] {
                            new EventReminder() { Method = "email", Minutes = 24 * 60 },
                            new EventReminder() { Method = "sms", Minutes = 10 },
                        }
                    }
                };

                EventsResource.UpdateRequest request = Service.Events.Update(newEvent, calendarId, eventId);
                request.Execute();
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "GoogleCalendarIntegration.Utility.UpdateEvent");
            }
        }

        public static void DeleteEvent(int userId, string eventId, string calendarId = "primary")
        {
            try
            {
                if (Service == null)
                    Service = GetService();

                EventsResource.DeleteRequest request = Service.Events.Delete(calendarId, eventId);
                request.Execute();
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "GoogleCalendarIntegration.Utility.DeleteEvent");
            }
        }

    }
}
