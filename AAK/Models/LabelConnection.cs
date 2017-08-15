using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.Models
{
    public class LabelConnection
    {
        public int Id { get; set; }
        public int LabelId { get; set; }
        public string ContentType { get; set; }
        public int ContentId { get; set; }

        public string ContentIds { get; set; }

        public string Token { get; set; }
        public string Email { get; set; }

        public LabelConnection()
        {
            this.Id = -1;
            this.LabelId = -1;
            this.ContentType = string.Empty;
            this.ContentId = -1;

            this.ContentIds = string.Empty;
        }

        public LabelConnection(int labelId, string contentType, int contentId)
        {
            this.LabelId = labelId;
            this.ContentType = contentType;
            this.ContentId = contentId;
        }
    }
}