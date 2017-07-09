﻿using AAK.DataProviders;
using AAK.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace AAK.Controllers
{
    public class ExpenseController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Expenses_GetForCase([FromUri]Expense expense)
        {
            try
            {
                List<Expense> result = Expenses.Expenses_GetForCase(expense.CaseId);
                return Request.CreateResponse<List<Expense>>(System.Net.HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                LoggerUtility.Logger.LogException(ex, "Expenses_GetForCase");
                return Request.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
            }
        }
    }
}
