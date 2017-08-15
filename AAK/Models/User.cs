using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAK.Models
{
    public class User
    {
        public int Id { get; set; }
        public string Email { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Phone { get; set; }

        public string UserGroupCodes { get; set; }
        public string UserGroupNames { get; set; }

        public string GoogleDriveLocalFolderPath { get; set; }

        public string PictureLink { get; set; }

        public string Token { get; set; }
        public string ValidationEmail { get; set; }

        public User()
        {
            this.Id = -1;
            this.Email = string.Empty;
            this.FirstName = string.Empty;
            this.LastName = string.Empty;
            this.Phone = string.Empty;

            this.UserGroupCodes = string.Empty;
            this.UserGroupNames = string.Empty;

            this.GoogleDriveLocalFolderPath = string.Empty;

            this.Token = string.Empty;
            this.PictureLink = string.Empty;
        }
    }
}