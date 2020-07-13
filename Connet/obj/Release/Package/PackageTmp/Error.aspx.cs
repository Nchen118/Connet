using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Connet
{
    public partial class Error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string errmsg = Request.QueryString["errmsg"];
            string trace = Request.QueryString["trace"];

            ErrorMsg.Text = errmsg;
            ErrorTrace.Text = trace;
        }

        protected void ReturnBackBtn_Click(object sender, EventArgs e)
        {
            Response.RedirectPermanent("/");
        }
    }
}