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
    public class LabelConnectionController : ApiController
    {
        [HttpPost]
        public HttpResponseMessage LabelConnections_Create([FromBody]LabelConnection input)
        {
            try
            {
                if (Google.Validator.ValidateToken(input.Token, input.Email))
                {
                    if ((input.ContentIds ?? "").Length > 0)
                    {
                        input.ContentIds = input.ContentIds.Trim().Trim(',').Trim();
                        List<string> contentIds = input.ContentIds.Split(',').ToList<string>();

                        List<LabelConnection> updatedConnections = new List<LabelConnection>();
                        foreach (string contentId in contentIds)
                        {
                            input.ContentId = Convert.ToInt32(contentId);
                            LabelConnections.LabelConnection_Create(input);
                            updatedConnections.Add(new LabelConnection(input.LabelId, input.ContentType, input.ContentId));
                        }
                        return Request.CreateResponse<List<LabelConnection>>(System.Net.HttpStatusCode.OK, updatedConnections);
                    }
                    else
                        throw new Exception("No content ids sent.");
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "LabelConnections_Create");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }

        [HttpDelete]
        public HttpResponseMessage LabelConnection_Delete([FromUri] LabelConnection labelConnection)
        {
            try
            {
                if (Google.Validator.ValidateToken(labelConnection.Token, labelConnection.Email))
                {
                    LabelConnections.LabelConnection_Delete(labelConnection);
                    return Request.CreateResponse(System.Net.HttpStatusCode.OK);
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "LabelConnection_Delete");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
