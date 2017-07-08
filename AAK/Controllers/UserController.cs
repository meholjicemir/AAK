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
    public class UserController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Users_GetAll([FromUri]UserWithData data)
        {
            try
            {
                List<User> result = Users.Users_GetAll();
                return Request.CreateResponse<List<User>>(System.Net.HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Users_GetAll");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }

        [HttpPost]
        public HttpResponseMessage User_CheckCredentials(User user)
        {
            try
            {
                if (user.FirstName.Equals(string.Empty) && user.LastName.Equals(string.Empty))
                {
                    // Getting user for login
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
                else
                {
                    // Saving new user or updating existing one
                    if (user.Id > 0)
                    {
                        // Edit
                        Users.User_Update(user);
                        return Request.CreateResponse<int?>(System.Net.HttpStatusCode.OK, user.Id);
                    }
                    else
                    {
                        // Insert
                        int? insertedId = Users.User_Insert(user);
                        return Request.CreateResponse<int?>(System.Net.HttpStatusCode.OK, insertedId);
                    }
                }
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "User_CheckCredentials");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }

        [HttpDelete]
        public HttpResponseMessage User_Delete([FromUri] User user)
        {
            try
            {
                Users.User_Delete(user.Id);
                return Request.CreateResponse(System.Net.HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "User_Delete");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
