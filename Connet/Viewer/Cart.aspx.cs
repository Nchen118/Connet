using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Connet.CSFile;

namespace Connet.Viewer
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(UserInfo.Role) || UserInfo.Role.ToLower() != "buyer")
            {
                Response.Redirect("~/Error.aspx?errmsg=Sorry...only buyer allow to owe a cart");
            }
            else
            {
                decimal total = 0;
                var checkDelProduct = Global.db.Carts.Where(x => !x.Product.Active && x.Buyer_Id.ToLower() == UserInfo.Id);

                if (checkDelProduct != null)
                {
                    Global.db.Carts.DeleteAllOnSubmit(checkDelProduct);
                    Global.db.SubmitChanges();
                }

                var c = Global.db.Carts.Where(x => x.Buyer_Id == UserInfo.Id);

                foreach (var o in c) { total += o.Product.Price * o.Quantity; }

                totalPrice.Text = "RM " + total.ToString("F");
            }
        }

        protected void checkout_Click(object sender, EventArgs e)
        {
            var c = Global.db.Carts.FirstOrDefault(x => x.Buyer_Id == UserInfo.Id);

            if (c != null) { Response.Redirect("~/Viewer/Payment.aspx"); }
            else { Response.Redirect(Request.RawUrl); }
        }

        protected void DeleteBtn_Click(object sender, EventArgs e)
        {
            Button btn = (Button) sender;
            if (!string.IsNullOrEmpty(btn.CommandName))
            {
                var c = Global.db.Carts.SingleOrDefault(x => x.Buyer_Id == UserInfo.Id && x.Id.ToString() == btn.CommandName);
                if (c != null)
                {
                    Global.db.Carts.DeleteOnSubmit(c);
                    Global.db.SubmitChanges();
                    Response.Redirect("~/Viewer/Cart.aspx");
                }
            }
        }

        protected void CartLinqDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            var removeItem = Global.db.Carts.Where(x => x.Buyer_Id == UserInfo.Id && x.Product.Active == false);

            if (removeItem.Any())
            {
                Global.db.Carts.DeleteAllOnSubmit(removeItem);
                Global.db.SubmitChanges();
            }

            e.Result = Global.db.Carts.Where(x => x.Buyer_Id == UserInfo.Id);
        }

        // Product Quantity Increment
        protected void MinQty_OnClick(object sender, EventArgs e)
        {
            Button btn = (Button) sender;

            var c = Global.db.Carts.SingleOrDefault(x => x.Id.ToString() == btn.CommandName);

            if (c != null && c.Quantity > 1)
            {
                c.Quantity = c.Quantity - 1;
                Global.db.SubmitChanges();
                Response.RedirectPermanent(Request.RawUrl);
            }
        }

        protected void AddQty_OnClick(object sender, EventArgs e)
        {
            Button btn = (Button)sender;

            var c = Global.db.Carts.SingleOrDefault(x => x.Id.ToString() == btn.CommandName);

            if (c != null && c.Quantity < c.Product.Quantity)
            {
                c.Quantity = c.Quantity + 1;
                Global.db.SubmitChanges();
                Response.RedirectPermanent(Request.RawUrl);
            }
        }
    }
}