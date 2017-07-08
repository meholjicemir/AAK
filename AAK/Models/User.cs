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

        public string AccessToken { get; set; }

        public string UserGroupCodes { get; set; }
        public string UserGroupNames { get; set; }

        public User()
        {
            this.Id = -1;
            this.Email = string.Empty;
            this.FirstName = string.Empty;
            this.LastName = string.Empty;
            this.Phone = string.Empty;

            this.AccessToken = string.Empty;

            this.UserGroupCodes = string.Empty;
            this.UserGroupNames = string.Empty;
        }
    }
}