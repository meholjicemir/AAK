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
        public HttpResponseMessage CodeTable_InsertUpdateRecord([FromBody]CodeTableData codeTableData)
        {
            try
            {
                if (codeTableData.Id > 0)
                {
                    // Edit
                    CodeTables.CodeTable_UpdateRecord(codeTableData);
                    return Request.CreateResponse<int?>(System.Net.HttpStatusCode.OK, codeTableData.Id);
                }
                else
                {
                    // Insert
                    int? insertedId = CodeTables.CodeTable_InsertRecord(codeTableData);
                    return Request.CreateResponse<int?>(System.Net.HttpStatusCode.OK, insertedId);
                }
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "CodeTable_InsertUpdateRecord");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }

        [HttpDelete]
        public HttpResponseMessage CodeTable_DeleteRecord([FromUri] CodeTableData codeTableData)
        {
            try
            {
                CodeTables.CodeTable_DeleteRecord(codeTableData);
                return Request.CreateResponse(System.Net.HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "CodeTable_DeleteRecord");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
