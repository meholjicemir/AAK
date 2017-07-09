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
    public class CaseActivityController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage CaseActivities_GetAll([FromUri]UserWithData data)
        {
            try
            {
                List<CaseActivity> result = CaseActivities.CaseActivities_GetAll(data.UserId, data.Filter, data.RowCount);
                return Request.CreateResponse<List<CaseActivity>>(System.Net.HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "CaseActivities_GetAll");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }

        [HttpDelete]
        public HttpResponseMessage CaseActivity_Delete([FromUri] CaseActivity caseActivity)
        {
            try
            {
                CaseActivities.CaseActivity_Delete(caseActivity.Id);
                return Request.CreateResponse(System.Net.HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "CaseActivity_Delete");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
