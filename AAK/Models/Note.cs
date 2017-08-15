using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.Models
{
    public class Note
    {
        public int Id { get; set; }
        public int CaseId { get; set; }
        public DateTime? NoteDate { get; set; }
        public string NoteText { get; set; }
        public int? CreatedBy { get; set; }
        public string CreatedByName { get; set; }

        public string Token { get; set; }
        public string Email { get; set; }

        public Note()
        {
            this.Id = -1;
            this.CaseId = -1;
            this.NoteDate = null;
            this.NoteText = string.Empty;
            this.CreatedBy = null;
            this.CreatedByName = string.Empty;
        }
    }
}