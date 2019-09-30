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
    public class CaseActivityDeleteController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage CaseActivity_Delete([FromUri] CaseActivity caseActivity)
        {
            try
            {
                if (Google.Validator.ValidateToken(caseActivity.Token, caseActivity.Email))
                {
                    CaseActivities.CaseActivity_Delete(caseActivity.Id);
                    return Request.CreateResponse(System.Net.HttpStatusCode.OK);
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "CaseActivity_Delete");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
