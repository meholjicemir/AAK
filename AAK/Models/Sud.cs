using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.Models
{
    public class Sud
    {
        public int Id { get; set; }
        public string Naziv { get; set; }
        public string Adresa { get; set; }
        public string PostanskiBroj { get; set; }
        public string Grad { get; set; }
        public string Telefon { get; set; }
        public string Fax { get; set; }
        public string RacunTakse { get; set; }
        public string RacunVjestacenja { get; set; }

        public int? CreatedBy { get; set; }
        public string CreatedByName { get; set; }
        public DateTime? Created { get; set; }

        public int? ModifiedBy { get; set; }
        public string ModifiedByName { get; set; }
        public DateTime? Modified { get; set; }

        public string Token { get; set; }
        public string Email { get; set; }

        public Sud()
        {
            this.Id = -1;
            this.Naziv = string.Empty;
            this.Adresa = string.Empty;
            this.PostanskiBroj = string.Empty;
            this.Grad = string.Empty;
            this.Telefon = string.Empty;
            this.Fax = string.Empty;
            this.RacunTakse = string.Empty;
            this.RacunVjestacenja = string.Empty;

            this.CreatedBy = null;
            this.CreatedByName = string.Empty;
            this.Created = null;

            this.ModifiedBy = null;
            this.ModifiedByName = string.Empty;
            this.Modified = null;
        }
    }
}