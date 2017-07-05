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
    public class PredmetController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Predmeti_GetAll([FromUri]UserWithData data)
        {
            try
            {
                List<Predmet> result = Predmeti.Predmeti_GetAll(data.UserId, data.Filter, data.RowCount);
                return Request.CreateResponse<List<Predmet>>(System.Net.HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Predmeti_GetAll");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }

        [HttpPost]
        public HttpResponseMessage Predmet_InsertUpdate([FromBody]Predmet predmet)
        {
            try
            {
                if (predmet.Id > 0)
                {
                    // Edit
                    Predmeti.Predmeti_Update(predmet);
                    return Request.CreateResponse<int?>(System.Net.HttpStatusCode.OK, predmet.Id);
                }
                else
                {
                    // Insert
                    int? insertedId = Predmeti.Predmeti_Insert(predmet);
                    return Request.CreateResponse<int?>(System.Net.HttpStatusCode.OK, insertedId);
                }
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Predmet_InsertUpdate");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }

        [HttpDelete]
        public HttpResponseMessage Predmeti_Delete([FromUri] Predmet predmet)
        {
            try
            {
                Predmeti.Predmeti_Delete(predmet.Id);
                return Request.CreateResponse(System.Net.HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Predmeti_Delete");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
