using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Connet
{
    public partial class Index : System.Web.UI.Page
    {
        private static string sortType;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RecentLink_Click(object sender, EventArgs e)
        {
            sortType = "recent";
            Response.Redirect("/");
        }

        protected void MostViewLink_Click(object sender, EventArgs e)
        {
            sortType = "mostview";
            Response.Redirect("/");
        }

        protected void StreamDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            if (string.IsNullOrEmpty(sortType) || sortType == "recent")
            {
                e.Result = Global.db.Streams.Where(x => x.Active).OrderByDescending(x => x.CreatedDate);
            }
            else if (sortType == "mostview")
            {
                e.Result = Global.db.Streams.Where(x => x.Active).OrderByDescending(x => x.TotalView);
            }
        }
    }
}