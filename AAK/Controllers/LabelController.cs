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
    public class LabelController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Labels_GetAll([FromUri]UserWithData data)
        {
            try
            {
                if (Google.Validator.ValidateToken(data.Token, data.Email))
                {
                    List<Label> result = Labels.Labels_GetAll();
                    return Request.CreateResponse<List<Label>>(System.Net.HttpStatusCode.OK, result);
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Labels_GetAll");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }

        [HttpPost]
        public HttpResponseMessage Label_InsertUpdate([FromBody]Label label)
        {
            try
            {
                if (Google.Validator.ValidateToken(label.Token, label.Email))
                {
                    if (label.Id > 0)
                    {
                        // Edit
                        Labels.Label_Update(label);
                        return Request.CreateResponse<int?>(System.Net.HttpStatusCode.OK, label.Id);
                    }
                    else
                    {
                        // Insert
                        int? insertedId = Labels.Label_Insert(label);
                        return Request.CreateResponse<int?>(System.Net.HttpStatusCode.OK, insertedId);
                    }
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Label_InsertUpdate");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }

        [HttpDelete]
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
