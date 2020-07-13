using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Connet.CSFile;

namespace Connet.AdminAccess
{
    public partial class OrderList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(UserInfo.Role) || UserInfo.Role.ToLower() != "admin")
            {
                Response.Redirect("~/AdminAccess/AdminPage.aspx");
            }
        }

        protected void OrderListDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            if (string.IsNullOrEmpty(Filter.Text))
            {
                e.Result = Global.db.Order_Details;
            }
            else
            {
                e.Result = Global.db.Order_Details.Where(x => x.Order.Buyer.Name.Contains(Filter.Text));
            }

        }
    }
}