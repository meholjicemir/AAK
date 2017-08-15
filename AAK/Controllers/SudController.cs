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
    public class SudController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Sudovi_GetAll([FromUri]UserWithData data)
        {
            try
            {
                if (Google.Validator.ValidateToken(data.Token, data.Email))
                {
                    List<Sud> result = Sudovi.Sudovi_GetAll();
                    return Request.CreateResponse<List<Sud>>(System.Net.HttpStatusCode.OK, result);
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Sudovi_GetAll");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }

        [HttpPost]
        public HttpResponseMessage Sudovi_InsertUpdate([FromBody]Sud sud)
        {
            try
            {
                if (Google.Validator.ValidateToken(sud.Token, sud.Email))
                {
                    if (sud.Id > 0)
                    {
                        // Edit
                        Sudovi.Sudovi_Update(sud);
                        return Request.CreateResponse<int?>(System.Net.HttpStatusCode.OK, sud.Id);
                    }
                    else
                    {
                        // Insert
                        int? insertedId = Sudovi.Sudovi_Insert(sud);
                        return Request.CreateResponse<int?>(System.Net.HttpStatusCode.OK, insertedId);
                    }
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Sudovi_InsertUpdate");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }

        [HttpDelete]
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
