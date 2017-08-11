using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.Models.Helper
{
    public class UserWithData
    {
        public int UserId { get; set; }
        public string Filter { get; set; }
        public int? FilterNasBroj { get; set; }
        public int RowCount { get; set; }
        public int? CaseId { get; set; }
        public int? PartyId { get; set; }
        public string TemplateName { get; set; }
    }
}