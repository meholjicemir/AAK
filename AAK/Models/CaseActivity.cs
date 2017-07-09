using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.Models
{
    public class CaseActivity
    {
        public long Id { get; set; }
        public int CaseId { get; set; }
        public string Note { get; set; }
        public DateTime? ActivityDate { get; set; }

        public int? CreatedBy { get; set; }
        public string CreatedByName { get; set; }
        public DateTime? Created { get; set; }

        public string CaseFullName { get; set; }
        public string BrojPredmeta { get; set; }
        public string KategorijaPredmeta { get; set; }

        public CaseActivity()
        {
            this.Id = -1;
            this.CaseId = -1;
            this.Note = string.Empty;
            this.ActivityDate = null;

            this.CreatedBy = null;
            this.CreatedByName = string.Empty;
            this.Created = null;

            this.CaseFullName = string.Empty;
            this.BrojPredmeta = string.Empty;
            this.KategorijaPredmeta = string.Empty;
        }
    }
}