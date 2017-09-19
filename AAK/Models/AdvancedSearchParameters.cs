using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.Models
{
    public class AdvancedSearchParameters
    {
        public int UserId { get; set; }
        public int? NasBroj { get; set; }
        public string Kategorije { get; set; }
        public string UlogeUPostupku { get; set; }
        public string BrojPredmeta { get; set; }
        public string Sudovi { get; set; }
        public string Sudije { get; set; }
        public decimal VrijednostSporaFrom { get; set; }
        public decimal VrijednostSporaTo { get; set; }
        public string VrstePredmeta { get; set; }
        public DateTime? DatumStanjaPredmeta { get; set; }
        public string StanjePredmeta { get; set; }

        public int RowCount { get; set; }

        public string Token { get; set; }
        public string Email { get; set; }
    }

}