using AAK.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace AAK.Controllers
{
    public class UserController : ApiController
    {
        [HttpPost]
        public HttpResponseMessage User_CheckCredentials(User user)
        {
            try
            {
                DataTable dt = DBUtility.Utility.ExecuteStoredProcedure<string>("User_GetByEmail", "email", user.Email);
                if (dt.Rows.Count > 0)
                {
                    user = DBUtility.Utility.ParseDataRow<User>(dt.Rows[0]);
                    if (user.Id > 0)
                    {
                        user.AccessToken = Guid.NewGuid().ToString();
                        return Request.CreateResponse<User>(System.Net.HttpStatusCode.OK, user);
                    }
                }
                return Request.CreateResponse<User>(System.Net.HttpStatusCode.OK, new User());
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "User_CheckCredentials");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
