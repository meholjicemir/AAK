using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.Models
{
    public class Template
    {
        public string Name { get; set; }
        public string FullPath { get; set; }

        public Template()
        {
            this.Name = string.Empty;
            this.FullPath = string.Empty;
        }
    }
}