using AAK.DataProviders;
using AAK.Models.Helper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace AAK.Controllers
{
    public class NasBrojController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage GetNextNasBroj()
        {
            try
            {
                int result = Predmeti.GetNextNasBroj();
                return Request.CreateResponse<int>(System.Net.HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "GetNextNasBroj");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }


    }
}
