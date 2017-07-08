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
        public DateTime? Iniciran { get; set; }
        public decimal? VrijednostSpora { get; set; }
        public string Uspjeh { get; set; } // Uspjeh u postupku
        public string PravniOsnov { get; set; }
        public DateTime? DatumStanjaPredmeta { get; set; }
        public DateTime? DatumArhiviranja { get; set; }

        public string BrojArhive { get; set; }
        public string BrojArhiveRegistrator { get; set; }
        public string BrojArhiveTotal { get; set; }

        public int? SkontroDan { get; set; }
        public DateTime? SkontroDatum { get; set; }
        public string SkontroBiljeska { get; set; }

        public string StrankaNasa { get; set; }
        public string StrankaProtivna { get; set; }
        public string StrankePostupak { get; set; }


        public int? SudId { get; set; }
        public string SudName { get; set; }

        public int KategorijaPredmetaId { get; set; }
        public string KategorijaPredmetaName { get; set; }

        public int SudijaId { get; set; }
        public string SudijaName { get; set; }

        public int VrstaPredmetaId { get; set; }
        public string VrstaPredmetaName { get; set; }

        // Uloga u postupku
        public int UlogaId { get; set; }
        public string UlogaName { get; set; }

        public int NacinOkoncanjaId { get; set; }
        public string NacinOkoncanjaName { get; set; }

        public int StanjePredmetaId { get; set; }
        public string StanjePredmetaName { get; set; }

        public bool PrivremeniZastupnici { get; set; }

        public int? CreatedBy { get; set; }
        public string CreatedByName { get; set; }
        public DateTime? Created { get; set; }

        public int? ModifiedBy { get; set; }
        public string ModifiedByName { get; set; }
        public DateTime? Modified { get; set; }

        public List<LicePredmet> Parties { get; set; }

        public Predmet()
        {
            this.Id = -1;
            this.NasBroj = -1;
            this.BrojPredmeta = string.Empty;
            this.Iniciran = null;
            this.VrijednostSpora = null;
            this.Uspjeh = string.Empty;
            this.PravniOsnov = string.Empty;
            this.DatumStanjaPredmeta = null;
            this.DatumArhiviranja = null;

            this.BrojArhive = string.Empty;
            this.BrojArhiveRegistrator = string.Empty;
            this.BrojArhiveTotal = string.Empty;

            this.SkontroDan = null;
            this.SkontroDatum = null;
            this.SkontroBiljeska = string.Empty;

            this.StrankaNasa = string.Empty;
            this.StrankaProtivna = string.Empty;
            this.StrankePostupak = string.Empty;

            this.SudId = null;
            this.SudName = string.Empty;

            this.KategorijaPredmetaId = -1;
            this.KategorijaPredmetaName = string.Empty;

            this.SudijaId = -1;
            this.SudijaName = string.Empty;

            this.VrstaPredmetaId = -1;
            this.VrstaPredmetaName = string.Empty;

            this.UlogaId = -1;
            this.UlogaName = string.Empty;

            this.NacinOkoncanjaId = -1;
            this.NacinOkoncanjaName = string.Empty;

            this.StanjePredmetaId = -1;
            this.StanjePredmetaName = string.Empty;

            this.PrivremeniZastupnici = false;


            this.CreatedBy = null;
            this.CreatedByName = string.Empty;
            this.Created = null;

            this.ModifiedBy = null;
            this.ModifiedByName = string.Empty;
            this.Modified = null;

            this.Parties = new List<LicePredmet>();
        }
    }
}