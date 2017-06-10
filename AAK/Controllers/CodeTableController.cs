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
    public class CodeTableController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage CodeTable_GetData([FromUri]CodeTable codeTable)
        {
            try
            {
                List<CodeTableData> result = CodeTables.CodeTable_GetData(codeTable);
                return Request.CreateResponse<List<CodeTableData>>(System.Net.HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "CodeTable_GetData");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }

        [HttpPost]
        public HttpResponseMessage CodeTable_InsertRecord([FromBody]CodeTableData codeTableData)
        {
            try
            {
                int? insertedId = CodeTables.CodeTable_InsertRecord(codeTableData);
                return Request.CreateResponse<int?>(System.Net.HttpStatusCode.OK, insertedId);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "CodeTable_InsertRecord");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
