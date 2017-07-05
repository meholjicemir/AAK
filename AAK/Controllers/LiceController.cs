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

        [HttpPost]
        public HttpResponseMessage Lice_InsertUpdate([FromBody]Lice lice)
        {
            try
            {
                if (lice.Id > 0)
                {
                    // Edit
                    Lica.Lica_Update(lice);
                    return Request.CreateResponse<int?>(System.Net.HttpStatusCode.OK, lice.Id);
                }
                else
                {
                    // Insert
                    int? insertedId = Lica.Lica_Insert(lice);
                    return Request.CreateResponse<int?>(System.Net.HttpStatusCode.OK, insertedId);
                }
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Lice_InsertUpdate");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }

        [HttpDelete]
        public HttpResponseMessage Lica_Delete([FromUri] Lice lice)
        {
            try
            {
                Lica.Lica_Delete(lice.Id);
                return Request.CreateResponse(System.Net.HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Lica_Delete");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}