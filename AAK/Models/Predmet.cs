using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.Models
{
    public class Predmet
    {
        public int Id { get; set; }
        public int NasBroj { get; set; }
        public string BrojPredmeta { get; set; }
        public string Sudija { get; set; }
        public DateTime? Iniciran { get; set; }
        public decimal VrijednostSpora { get; set; }
        public string Kategorija { get; set; }
        public string Uloga { get; set; } // Uloga u postupku
        public string VrstaPredmeta { get; set; }
        public string Uspjeh { get; set; } // Uspjeh u postupku
        public string PravniOsnov { get; set; }
        public DateTime DatumStanjaPredmeta { get; set; }
        public string StanjePredmeta { get; set; }
        public DateTime? DatumArhiviranja { get; set; }
        public string NacinOkoncanja { get; set; }
        public string BrojArhive { get; set; }
        public string BrojArhiveRegistrator { get; set; }
        public int? SkontroDan { get; set; }
        public DateTime? SkontroDatum { get; set; }
        public string SkontroBiljeska { get; set; }

        public string StrankaNasa { get; set; }
        public string StrankaProtivna { get; set; }
        public string StrankePostupak { get; set; }


        public int? SudId { get; set; }
        public string SudName { get; set; }

        public Predmet()
        {
            this.Id = -1;
            this.NasBroj = -1;
            this.BrojPredmeta = string.Empty;
            this.Sudija = string.Empty;
            this.Iniciran = null;
            this.VrijednostSpora = 0.0M;
            this.Kategorija = string.Empty;
            this.Uloga = string.Empty;
            this.VrstaPredmeta = string.Empty;
            this.Uspjeh = string.Empty;
            this.PravniOsnov = string.Empty;
            this.DatumStanjaPredmeta = new DateTime(1970, 1, 1);
            this.StanjePredmeta = string.Empty;
            this.DatumArhiviranja = null;
            this.NacinOkoncanja = string.Empty;
            this.BrojArhive = string.Empty;
            this.BrojArhiveRegistrator = string.Empty;
            this.SkontroDan = null;
            this.SkontroDatum = null;
            this.SkontroBiljeska = string.Empty;

            this.StrankaNasa = string.Empty;
            this.StrankaProtivna = string.Empty;
            this.StrankePostupak = string.Empty;

            this.SudId = null;
            this.SudName = string.Empty;
        }
    }
}