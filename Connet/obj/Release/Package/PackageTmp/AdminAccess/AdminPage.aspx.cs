using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Connet.CSFile;

namespace Connet.AdminAccess
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    BackBtn.PostBackUrl = Request.UrlReferrer.ToString();
                }
                catch (NullReferenceException)
                {
                    BackBtn.PostBackUrl = "/";
                }

                if (!string.IsNullOrEmpty(UserInfo.Role) && UserInfo.Role.ToLower() == "admin")
                {
                    AuthPanel.Visible = false;
                    AdminName.Text = UserInfo.Name;
                    MenuPanel.Visible = true;
                }
            }
        }

        protected void UsernameValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var admin = Global.db.Admins.SingleOrDefault(x => x.Name == args.Value);

            if (string.IsNullOrEmpty(args.Value))
            {
                args.IsValid = false;
                UsernameValidator.ErrorMessage = "*Username is empty";
            }
            else if (admin == null)
            {
                args.IsValid = false;
                UsernameValidator.ErrorMessage = "*Username invalid";
            }
        }

        protected void PasswordValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (string.IsNullOrEmpty(args.Value))
            {
                args.IsValid = false;
                PasswordValidator.ErrorMessage = "*Password is empty";
            }
        }

        protected void Login_Click(object sender, EventArgs e)
        {
            if (UsernameValidator.IsValid && PasswordValidator.IsValid)
            {
                var admin = Global.db.Admins.SingleOrDefault(x => x.Name == Username.Text && x.Password == Security.GetHash(Password.Text));

                if (admin == null)
                {
                    PasswordValidator.IsValid = false;
                    PasswordValidator.ErrorMessage = "*Password incorrect.";
                }
                else
                {
                    UserInfo.Id = admin.Id;
                    UserInfo.Name = admin.Name;
                    UserInfo.Role = "admin";

                    AuthPanel.Visible = false;
                    AdminName.Text = admin.Name;
                    MenuPanel.Visible = true;
                }
            }
        }
    }
}