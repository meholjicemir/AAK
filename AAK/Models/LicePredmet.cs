using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.Models
{
    public class LicePredmet
    {
        public int Id { get; set; }
        public int PredmetId { get; set; }
        public int LiceId { get; set; }
        public int UlogaId { get; set; }
        public bool IsNasaStranka { get; set; }
        public bool IsProtivnaStranka { get; set; }
        public string Broj { get; set; }

        public string Lice { get; set; }
        public string Uloga { get; set; }
        public string GlavnaStranka { get; set; }

        public LicePredmet()
        {
            this.Id = -1;
            this.PredmetId = -1;
            this.LiceId = -1;
            this.UlogaId = -1;
            this.IsNasaStranka = false;
            this.IsProtivnaStranka = false;
            this.Broj = string.Empty;

            this.Lice = string.Empty;
            this.Uloga = string.Empty;
            this.GlavnaStranka = string.Empty;
        }
    }
}