using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.Models
{
    public class Connection
    {
        public int Id { get; set; }
        public int CaseId { get; set; }

        public int ConnectionCaseId { get; set; }
        public string ConnectionCaseName { get; set; }

        public string Note { get; set; }

        public int UserId { get; set; }

        public Connection()
        {
            this.Id = -1;
            this.CaseId = -1;

            this.ConnectionCaseId = -1;
            this.ConnectionCaseName = string.Empty;

            this.Note = string.Empty;

            this.UserId = -1;
        }
    }
}