using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Connet.CSFile;

namespace Connet.Account
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(UserInfo.Role))
            {
                UserInfo.Id = null;
                UserInfo.Name = null;
                UserInfo.Role = null;

                if (!string.IsNullOrEmpty(Response.Cookies["Auth"].Values.ToString()))
                {
                    Response.Cookies["Auth"].Expires = DateTime.Now.AddDays(-1);
                }


                try
                {
                    Response.Redirect(Request.UrlReferrer.ToString());
                }
                catch (NullReferenceException)
                {
                    Response.Redirect("/");
                }
            }
            else
            {
                Response.Redirect("/");
            }
        }
    }
}