﻿using AAK.DataProviders;
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
                if (Google.Validator.ValidateToken(data.Token, data.Email))
                {
                    List<CaseActivity> result = CaseActivities.CaseActivities_GetAll(data.UserId, data.Filter, data.RowCount);
                    return Request.CreateResponse<List<CaseActivity>>(System.Net.HttpStatusCode.OK, result);
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "CaseActivities_GetAll");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }

        [HttpPost]
        public HttpResponseMessage CaseActivity_Create([FromBody]CaseActivity caseActivity)
        {
            try
            {
                if (Google.Validator.ValidateToken(caseActivity.Token, caseActivity.Email))
                {
                    int? insertedId = CaseActivities.CaseActivity_Create(caseActivity);
                    return Request.CreateResponse<int?>(System.Net.HttpStatusCode.OK, insertedId);
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "CaseActivity_Create");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }

        [HttpDelete]
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
