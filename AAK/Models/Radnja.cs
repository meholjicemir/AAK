using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.Models
{
    public class Radnja
    {
        public int Id { get; set; }
        public int PredmetId { get; set; }
        public DateTime? DatumRadnje { get; set; }
        public string Troskovi { get; set; }
        public string Biljeske { get; set; }

        public int VrstaRadnjeId { get; set; }
        public string VrstaRadnjeName { get; set; }

        public DateTime? DatumPrijema { get; set; }
        public decimal? VrijednostRadnje { get; set; }

        public int? RadnjuObavioId { get; set; }
        public string RadnjuObavioName { get; set; }

        public int? NacinObavljanjaId { get; set; }
        public string NacinObavljanjaName { get; set; }

        public string CaseFullName { get; set; }
        public int? CaseNasBroj { get; set; }

        public string GoogleDriveDocId { get; set; }
        public string DocumentName { get; set; }

        public string GoogleEventId { get; set; }
        public bool CreateCalendarEvent { get; set; }

        public int UserId { get; set; }

        public string Token { get; set; }
        public string Email { get; set; }

        public Radnja()
        {
            this.Id = -1;
            this.PredmetId = -1;
            this.DatumRadnje = null;
            this.Troskovi = string.Empty;
            this.Biljeske = string.Empty;

            this.VrstaRadnjeId = -1;
            this.VrstaRadnjeName = string.Empty;

            this.DatumPrijema = null;
            this.VrijednostRadnje = null;

            this.RadnjuObavioId = null;
            this.RadnjuObavioName = string.Empty;

            this.NacinObavljanjaId = null;
            this.NacinObavljanjaName = string.Empty;

            this.CaseFullName = string.Empty;
            this.CaseNasBroj = null;

            this.GoogleDriveDocId = string.Empty;
            this.DocumentName = string.Empty;

            this.GoogleEventId = string.Empty;
            this.CreateCalendarEvent = false;

            this.UserId = -1;
        }
    }
}