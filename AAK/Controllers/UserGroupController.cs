using AAK.DataProviders;
using AAK.Models;
using AAK.Models.Helper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace AAK.Controllers
{
    public class UserGroupController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage UserGroups_GetAll([FromUri]UserWithData data)
        {
            try
            {
                List<UserGroup> result = UserGroups.UserGroups_GetAll();
                return Request.CreateResponse<List<UserGroup>>(System.Net.HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "UserGroups_GetAll");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
