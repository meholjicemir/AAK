using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.Models
{
    public class Label
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string BackgroundColor { get; set; }
        public string FontColor { get; set; }

        public string Token { get; set; }
        public string Email { get; set; }

        public Label()
        {
            this.Id = -1;
            this.Name = string.Empty;
            this.BackgroundColor = string.Empty;
            this.FontColor = string.Empty;
        }
    }
}