using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Connet.CSFile;

namespace Connet.Account
{
    public partial class Verification : System.Web.UI.Page
    {
        private string email;
        private string code;

        protected void Page_Load(object sender, EventArgs e)
        {
            email = Request.QueryString["email"];
            code = Request.QueryString["code"];

            if (string.IsNullOrEmpty(email))
            {
                Response.RedirectPermanent("/");
            }
            else
            {
                var user = Global.db.Users.SingleOrDefault(x => x.Email == email);
                if (string.IsNullOrEmpty(code))
                {
                    if (user != null && !user.Verified)
                    {
                        VerifyPage.Visible = true;
                        SuccessPage.Visible = false;
                    }
                    else
                    {
                        Response.RedirectPermanent("/");
                    }
                }
                else
                {
                    if (user != null && Security.GetHash(user.Id) == code)
                    {
                        VerifyPage.Visible = false;

                        if (user.role.ToLower() == "buyer")
                        {
                            Global.db.Buyers.SingleOrDefault(x => x.Email == email).Verified = true;
                        }
                        else if (user.role.ToLower() == "seller")
                        {
                            Global.db.Sellers.SingleOrDefault(x => x.Email == email).Verified = true;
                        }
                        Global.db.SubmitChanges();

                        SuccessPage.Visible = true;
                    }
                    else
                    {
                        Response.Redirect("~/Error.aspx?errmsg=Sorry, unable to verify your account. Please try again later.");
                    }
                }
            }
        }

        protected void resendBtn_Click(object sender, EventArgs e)
        {
            var user = Global.db.Users.SingleOrDefault(x => x.Email == email);
            if (user != null) { Email.Send(user.Name, user.Email, user.Id); }
        }
    }
}