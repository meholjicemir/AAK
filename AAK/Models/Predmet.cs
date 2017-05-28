using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.Models
{
    public class Predmet
    {
        public int Id { get; set; }
        public int NasBroj { get; set;}
        public string BrojPredmeta { get; set; }
        public string Sudija { get; set; }
        public DateTime Iniciran { get; set; }
        public decimal VrijednostSpora { get; set; }
        public string Kategorija { get; set; }
        public string Uloga { get; set; } // Uloga u postupku
        public string VrstaPredmeta { get; set; }
        public string Uspjeh { get; set; } // Uspjeh u postupku
        public string PravniOsnov { get; set; }


        public string SudId { get; set; }
        public string SudName { get; set; }
    }
}