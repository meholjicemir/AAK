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
    public class CodeTableDeleteController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage CodeTable_DeleteRecord([FromUri] CodeTableData codeTableData)
        {
            try
            {
                if (Google.Validator.ValidateToken(codeTableData.Token, codeTableData.Email))
                {
                    CodeTables.CodeTable_DeleteRecord(codeTableData);
                    return Request.CreateResponse(System.Net.HttpStatusCode.OK);
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "CodeTable_DeleteRecord");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
