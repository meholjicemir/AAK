using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.Models
{
    public class Document
    {
        public int Id { get; set; }
        public int CaseId { get; set; }
        public string Note { get; set; }

        public int? TipDokumentaId { get; set; }
        public string TipDokumentaName { get; set; }

        public int? PredatoUzDokumentId { get; set; }
        public string PredatoUzDokumentName { get; set; }

        public string DocumentLink { get; set; }
        public string AbsoluteDocumentLink { get; set; }

        public int UserId { get; set; }

        public string Token { get; set; }
        public string Email { get; set; }

        public Document()
        {
            this.Id = -1;
            this.CaseId = -1;
            this.Note = string.Empty;

            this.TipDokumentaId = null;
            this.TipDokumentaName = string.Empty;

            this.PredatoUzDokumentId = null;
            this.PredatoUzDokumentName = string.Empty;

            this.DocumentLink = string.Empty;
            this.AbsoluteDocumentLink = string.Empty;

            this.UserId = -1;
        }
    }
}