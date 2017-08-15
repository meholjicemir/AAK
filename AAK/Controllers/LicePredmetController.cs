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
    public class LicePredmetController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage LicePredmet_GetForPredmet([FromUri]Predmet predmet)
        {
            try
            {
                if (Google.Validator.ValidateToken(predmet.Token, predmet.Email))
                {
                    List<LicePredmet> result = Predmeti.LicePredmet_GetForPredmet(predmet.Id);
                    return Request.CreateResponse<List<LicePredmet>>(System.Net.HttpStatusCode.OK, result);
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "LicePredmet_GetForPredmet");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
