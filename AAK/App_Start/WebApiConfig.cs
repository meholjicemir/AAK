using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace AAK
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            // Web API configuration and services

            // Web API routes
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            var json = GlobalConfiguration.Configuration.Formatters.JsonFormatter;
            //var converters = json.SerializerSettings.Converters;
            //converters.Add(new IsoDateTimeConverter() { DateTimeFormat = "dd.MM.yyyy HH:mm:ss" });

            //GlobalConfiguration.Configuration.Formatters.Insert(0, json);
        }
    }
}
