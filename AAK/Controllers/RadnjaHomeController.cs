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
    public class RadnjaHomeController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Radnje_GetAll([FromUri]UserWithData data)
        {
            try
            {
                List<Radnja> result = Radnje.Radnje_GetAll(data.UserId, data.Filter, data.RowCount);
                return Request.CreateResponse<List<Radnja>>(System.Net.HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Radnje_GetAll");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
