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
    public class LiceController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Lica_GetAll([FromUri]UserWithData data)
        {
            try
            {
                List<Lice> result = Lica.Lica_GetAll(data.UserId, data.Filter, data.RowCount);
                return Request.CreateResponse<List<Lice>>(System.Net.HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Lica_GetAll");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
