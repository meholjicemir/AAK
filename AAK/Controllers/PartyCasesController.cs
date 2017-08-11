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
    public class PartyCasesController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage GetCasesForParty([FromUri]UserWithData data)
        {
            try
            {
                List<Predmet> result = Predmeti.GetCasesForParty((int)data.PartyId);
                return Request.CreateResponse<List<Predmet>>(System.Net.HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "GetCasesForParty");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
