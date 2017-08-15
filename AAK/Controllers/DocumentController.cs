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
    public class DocumentController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Documents_GetForCase([FromUri]Document document)
        {
            try
            {
                if (Google.Validator.ValidateToken(document.Token, document.Email))
                {
                    List<Document> result = Documents.Documents_GetForCase(document.CaseId, document.UserId);
                    return Request.CreateResponse<List<Document>>(System.Net.HttpStatusCode.OK, result);
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Documents_GetForCase");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
