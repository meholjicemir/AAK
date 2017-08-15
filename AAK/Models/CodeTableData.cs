using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.Models
{
    public class CodeTableData
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string TableName { get; set; }
        public int OrdinalNo { get; set; }

        public string Token { get; set; }
        public string Email { get; set; }
    }
}