using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.Models
{
    public class Lice
    {
        public int Id { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string ZakonskiZastupnik { get; set; }
        public string Biljeske { get; set; }
        public string PravnoLice { get; set; }
        public string Adresa { get; set; }
        public string PostaskiBroj { get; set; }
        public string Grad { get; set; }
        public string Drzava { get; set; }
        public string Telefon { get; set; }
        public string Fax { get; set; }
        public string Email { get; set; }
        public string JMBG_IDBroj { get; set; }
        public bool? IsMinor { get; set; }

        public int? CreatedBy { get; set; }
        public string CreatedByName { get; set; }
        public DateTime? Created { get; set; }

        public int? ModifiedBy { get; set; }
        public string ModifiedByName { get; set; }
        public DateTime? Modified { get; set; }

        public string Naziv { get; set; }

        public Lice()
        {
            this.Id = -1;
            this.Ime = string.Empty;
            this.Prezime = string.Empty;
            this.ZakonskiZastupnik = string.Empty;
            this.Biljeske = string.Empty;
            this.PravnoLice = string.Empty;
            this.Adresa = string.Empty;
            this.PostaskiBroj = string.Empty;
            this.Grad = string.Empty;
            this.Drzava = string.Empty;
            this.Telefon = string.Empty;
            this.Fax = string.Empty;
            this.Email = string.Empty;
            this.JMBG_IDBroj = string.Empty;
            this.IsMinor = null;

            this.CreatedBy = null;
            this.CreatedByName = string.Empty;
            this.Created = null;

            this.ModifiedBy = null;
            this.ModifiedByName = string.Empty;
            this.Modified = null;

            this.Naziv = string.Empty;
        }
    }
}