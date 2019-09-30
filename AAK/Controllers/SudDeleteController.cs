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
    public class SudDeleteController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Sudovi_Delete([FromUri] Sud sud)
        {
            try
            {
                if (Google.Validator.ValidateToken(sud.Token, sud.Email))
                {
                    Sudovi.Sudovi_Delete(sud.Id);
                    return Request.CreateResponse(System.Net.HttpStatusCode.OK);
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Sudovi_Delete");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
