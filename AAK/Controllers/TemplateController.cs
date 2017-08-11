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
    public class TemplateController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Templates_GetAll([FromUri]UserWithData data)
        {
            try
            {
                List<Template> templates = Templates.Templates_GetAll();
                return Request.CreateResponse<List<Template>>(System.Net.HttpStatusCode.OK, templates);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Sudovi_GetAll");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }

        [HttpPost]
        public HttpResponseMessage Template_Generate([FromBody]UserWithData data)
        {
            try
            {
                List<KeyValuePair<string, string>> templateFields = Templates.Case_GetTemplateFields((int)data.CaseId, data.UserId);
                string fileName = WordTemplateEngine.Utility.GenerateDocument(data.TemplateName, templateFields, (int)data.FilterNasBroj, data.UserId);
                return Request.CreateResponse<string>(System.Net.HttpStatusCode.OK, fileName);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Template_Generate");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
