using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Connet.CSFile;

namespace Connet.Broadcaster
{
    public partial class ProductOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(UserInfo.Role) || UserInfo.Role.ToLower() != "seller")
            {
                Response.Redirect("/");
            }
        }

        protected void OrderDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            e.Result = Global.db.Order_Details.OrderByDescending(x => x.Order.Order_date);
        }
    }
}