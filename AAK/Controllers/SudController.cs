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
                List<Sud> result = Sudovi.Sudovi_GetAll();
                return Request.CreateResponse<List<Sud>>(System.Net.HttpStatusCode.OK, result);
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
                Sudovi.Sudovi_Delete(sud.Id);
                return Request.CreateResponse(System.Net.HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Sudovi_Delete");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
