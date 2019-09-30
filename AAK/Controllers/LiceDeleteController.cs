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
    public class LiceDeleteController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Lica_Delete([FromUri] Lice lice)
        {
            try
            {
                if (Google.Validator.ValidateToken(lice.Token, lice.ValidationEmail))
                {
                    Lica.Lica_Delete(lice.Id);
                    return Request.CreateResponse(System.Net.HttpStatusCode.OK);
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Lica_Delete");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
