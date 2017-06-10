using AAK.DataProviders;
using AAK.Models;
using AAK.Models.Helper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace AAK.Controllers
{
    public class PredmetController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Predmeti_GetAll([FromUri]UserWithData data)
        {
            try
            {
                List<Predmet> result = Predmeti.Predmeti_GetAll(data.UserId, data.Filter, data.RowCount);
                return Request.CreateResponse<List<Predmet>>(System.Net.HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Predmeti_GetAll");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
