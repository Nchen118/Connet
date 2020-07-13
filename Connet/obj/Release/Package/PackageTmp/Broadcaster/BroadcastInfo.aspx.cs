using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Lifetime;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Connet.CSFile;

namespace Connet.Broadcaster
{
    public partial class BroadcastInfo : System.Web.UI.Page
    {
        // Variables
        private static List<Product> SelectedList;

        // ===========
        //  Page Load
        // ===========
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user logged in and seller authorize
                if (string.IsNullOrEmpty(UserInfo.Role) || UserInfo.Role.ToLower() != "seller")
                {
                    Response.RedirectPermanent("/");
                }
                else
                {
                    title.Text = Session["title"] != null ? Session["title"].ToString() : "";

                    SelectedList = Session["SelectedList"] != null
                        ? (List<Product>) Session["SelectedList"] : new List<Product>();

                    Session.Remove("SelectedList");

                    Session.Remove("title");
                    try { BackBtn.PostBackUrl = Request.UrlReferrer.ToString(); }
                    catch (NullReferenceException) { BackBtn.PostBackUrl = "/"; }
                }
            }
        }

        // ==============
        //  Button Event
        // ==============
        protected void broadcastBtn_Click(object sender, EventArgs e)
        {
            if (SelectedList.Count < 1 || SelectedList.Count >= 10)
            {
                ProductList.IsValid = false;
                ProductList.ErrorMessage = "At least 1 product and not more than 10 products for each broadcast session needed.";
            }

            if (IsValid)
            {
                Stream s = new Stream
                {
                    Id = Security.GenerateNewID('R'),
                    Name = title.Text,
                    CreatedDate = DateTime.Now,
                    Seller_Id = UserInfo.Id,
                    Active = true
                };

                Global.db.Streams.InsertOnSubmit(s);

                List<Stream_Product> sp = new List<Stream_Product>();

                foreach (var o in SelectedList) { sp.Add(new Stream_Product{ RoomID = s.Id, ProductID = o.Id }); }

                Global.db.Stream_Products.InsertAllOnSubmit(sp);
                Global.db.SubmitChanges();

                Session["room"] = s.Id;
                Response.Redirect("~/Broadcaster/Broadcast.aspx");
            }
        }

        protected void done_Click(object sender, EventArgs e)
        {
            // Get checked checkbox store into List
            SelectedList.Clear();
            for (int i = 0; i < lvProduct.Items.Count; i++)
            {
                var chk = (HtmlInputCheckBox)lvProduct.Items[i].FindControl("chkProduct");
                if (chk.Checked)
                {
                    var p = Global.db.Products.SingleOrDefault(x => x.Id == lvProduct.DataKeys[i].Value.ToString() && x.Active);
                    if (p != null)
                    {
                        SelectedList.Add(p);
                    }
                }
            }

            // Store into session for redirect purpose
            Session["SelectedList"] = SelectedList;
            Session["title"] = title.Text;

            Response.RedirectPermanent("~/Broadcaster/BroadcastInfo.aspx");            
        }

        // ================
        //  LinqDataSource
        // ================
        protected void ProductLinqDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            e.Result = Global.db.Products.Where(x => x.Seller_Id == UserInfo.Id && x.Active);   // Get all seller product
        }

        protected void SelectedLinqDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            // Determine selected product records and display to user
            if (SelectedList != null && SelectedList.Any()) { e.Result = SelectedList; }
            else { e.Cancel = true; }
        }
    }
}