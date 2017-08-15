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
    public class NoteController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Notes_GetForCase([FromUri]Note note)
        {
            try
            {
                if (Google.Validator.ValidateToken(note.Token, note.Email))
                {
                    List<Note> result = Notes.Notes_GetForCase(note.CaseId);
                    return Request.CreateResponse<List<Note>>(System.Net.HttpStatusCode.OK, result);
                }
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Notes_GetForCase");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
