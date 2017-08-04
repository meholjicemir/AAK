using AAK.DataProviders;
using AAK.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace AAK.Controllers
{
    public class ConnectionController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Connections_GetForCase([FromUri]Connection document)
        {
            try
            {
                List<Connection> result = Connections.Connections_GetForCase(document.CaseId);
                return Request.CreateResponse<List<Connection>>(System.Net.HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Connections_GetForCase");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
