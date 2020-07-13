using System;
using System.Web.UI;

namespace Connet
{
    public class Global : System.Web.HttpApplication
    {
        public static ConnetDataContext db = new ConnetDataContext();

        protected void Application_Start(object sender, EventArgs e)
        {
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery",
                new ScriptResourceDefinition
                {
                    Path = "~/Scripts/jquery-3.3.1.min.js",
                    DebugPath = "~/Scripts/jquery-3.3.1.min.js",
                    CdnPath = "http://code.jquery.com/jquery-3.3.1.min.js",
                    CdnDebugPath = "http://code.jquery.com/jquery-3.3.1.min.js"
                });
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Session.Clear();
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {
            Response.RedirectPermanent("~/Error.aspx?errmsg=Looks like something went wrong...");
        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}