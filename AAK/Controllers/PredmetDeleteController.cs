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
    public class PredmetDeleteController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Predmeti_Delete([FromUri]Predmet predmet)
        {
            try
            {
                if (Google.Validator.ValidateToken(predmet.Token, predmet.Email))
                {
                    Predmeti.Predmeti_Delete(predmet.Id);
                    return Request.CreateResponse(System.Net.HttpStatusCode.OK);
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Predmeti_Delete");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
