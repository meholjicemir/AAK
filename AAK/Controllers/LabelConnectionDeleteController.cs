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
    public class LabelConnectionDeleteController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage LabelConnection_Delete([FromUri] LabelConnection labelConnection)
        {
            try
            {
                if (Google.Validator.ValidateToken(labelConnection.Token, labelConnection.Email))
                {
                    LabelConnections.LabelConnection_Delete(labelConnection);
                    return Request.CreateResponse(System.Net.HttpStatusCode.OK);
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "LabelConnection_Delete");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
