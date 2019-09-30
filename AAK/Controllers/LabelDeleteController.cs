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
    public class LabelDeleteController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Label_Delete([FromUri] Label label)
        {
            try
            {
                if (Google.Validator.ValidateToken(label.Token, label.Email))
                {
                    Labels.Label_Delete(label.Id);
                    return Request.CreateResponse(System.Net.HttpStatusCode.OK);
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Label_Delete");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
