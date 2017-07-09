using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.Models
{
    public class Expense
    {
        public int Id { get; set; }
        public int CaseId { get; set; }
        public decimal Amount { get; set; }
        public DateTime? ExpenseDate { get; set; }
        public string PaidBy { get; set; }

        public int? VrstaTroskaId { get; set; }
        public string VrstaTroskaName { get; set; }

        public Expense()
        {
            this.Id = -1;
            this.CaseId = -1;
            this.Amount = 0.0M;
            this.ExpenseDate = null;

            this.VrstaTroskaId = null;
            this.VrstaTroskaName = string.Empty;
        }
    }
}