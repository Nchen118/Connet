using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Connet.CSFile;

namespace Connet.Viewer
{
    public partial class MyOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(UserInfo.Role) || UserInfo.Role.ToLower() != "buyer")
            {
                Response.RedirectPermanent("/");
            }
        }

        protected void MyOrderDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            e.Result = Global.db.Order_Details.Where(x => x.Order.Buyer_Id == UserInfo.Id).OrderByDescending(x => x.Order.Order_date);
        }
    }
}