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
    public class AdvancedSearchController : ApiController
    {
        [HttpPost]
        public HttpResponseMessage AdvancedSearch([FromBody]AdvancedSearchParameters parameters)
        {
            try
            {
                if (Google.Validator.ValidateToken(parameters.Token, parameters.Email))
                {
                    List<Predmet> results = Predmeti.Predmeti_GeForAdvancedSearch(parameters);
                    return Request.CreateResponse<List<Predmet>>(System.Net.HttpStatusCode.OK, results);
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "AdvancedSearch");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
