using Google.Apis.Auth.OAuth2;
using Google.Apis.Calendar.v3;
using Google.Apis.Calendar.v3.Data;
using Google.Apis.Services;
using Google.Apis.Util.Store;
using System;
using System.Collections.Generic;
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
        private static string ApplicationName = "Google Calendar Integration - Emir";

        private static CalendarService GetService()
        {
            UserCredential credential;

            string jsonPath = AppDomain.CurrentDomain.BaseDirectory + "bin/client_secret.json";
            using (var stream = new FileStream(jsonPath, FileMode.Open, FileAccess.Read))
            {
                string credPath = System.Environment.GetFolderPath(System.Environment.SpecialFolder.Personal);
                credPath = Path.Combine(credPath, ".credentials/calendar-dotnet-quickstart.json");

                credential = GoogleWebAuthorizationBroker.AuthorizeAsync(
                    GoogleClientSecrets.Load(stream).Secrets,
                    Scopes,
                    "user",
                    CancellationToken.None,
                    new FileDataStore(credPath, true)).Result;
            }

            // Create Google Calendar API service.
            var service = new CalendarService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = ApplicationName,
            });

            return service;
        }

        public static string CreateEvent(string summary, string description,
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
                return "";
            }
        }

        public static void UpdateEvent(string eventId, string summary, string description,
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

        public static void DeleteEvent(string eventId, string calendarId = "primary")
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
