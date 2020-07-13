using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Connet
{
    public partial class SearchProduct : System.Web.UI.Page
    {
        // Global variable
        private static string search;
        protected void Page_Load(object sender, EventArgs e)
        {
            search = Request.QueryString["search"];
        }

        protected void SearchDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            if (string.IsNullOrEmpty(search)) { e.Cancel = true; }  // If search textbox is empty
            else {
                e.Result = Global.db.Products.Where(
                x => (x.Name.Contains(search) || x.Seller.Name.Contains(search))    // Search by item name or seller name
                     && x.Active);  // Check if item was deleted
            }
        }
    }
}