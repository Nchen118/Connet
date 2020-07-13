using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Connet.CSFile;

namespace Connet.Account
{
    public partial class SellerDetail : System.Web.UI.Page
    {
        private string id;

        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                id = Request.QueryString["id"];

                var s = Global.db.Sellers.SingleOrDefault(x => x.Id == id);

                if (s != null)
                {
                    SellerId.Text = s.Id;
                    SellerName.Text = s.Name;
                    SellerDateJoined.Text = s.DateJoined.ToString("dd MMMM yyyy");
                    SellerPic.ImageUrl = ResolveUrl("~/Broadcaster/Profile_pic/" + s.Id) == null ? 
                                         ResolveUrl("~/Broadcaster/Profile_pic/" + s.Id) : ResolveUrl("~/Images/empty_profile.jpeg");
                    SellerProduct.Text = Global.db.Products.Count(x => x.Seller_Id == s.Id).ToString();
                }
                else
                {
                    Response.RedirectPermanent("/");
                }
                
            }
        }

        protected void ProductDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            var p = Global.db.Products.Where(x => x.Seller_Id == id);

            e.Result = p;
        }
    }
}