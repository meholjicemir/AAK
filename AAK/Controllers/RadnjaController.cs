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
    public class RadnjaController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Radnje_GetForCase([FromUri]Radnja radnja)
        {
            try
            {
                List<Radnja> result = Radnje.Radnje_GetForCase(radnja.PredmetId);
                return Request.CreateResponse<List<Radnja>>(System.Net.HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Radnje_GetForCase");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
