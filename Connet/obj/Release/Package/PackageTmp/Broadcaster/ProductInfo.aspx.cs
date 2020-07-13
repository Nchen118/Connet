using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Runtime.Remoting.Lifetime;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Connet.CSFile;

namespace Connet.Broadcaster
{
    public partial class ProductInfo : System.Web.UI.Page
    {
        private static Product p;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string prod_Id = Request.QueryString["id"];

                try
                {
                    BackBtn.PostBackUrl = Request.UrlReferrer.ToString();
                }
                catch (NullReferenceException)
                {
                    BackBtn.PostBackUrl = "/";
                }

                p = Global.db.Products.SingleOrDefault(x => x.Id == prod_Id);

                if (p != null && p.Active)
                {
                    Name.Text = p.Name;
                    Price.Text = "RM " + p.Price.ToString("F");
                    Qty.Text = p.Quantity.ToString();
                    Seller.NavigateUrl = ResolveUrl("~/Broadcaster/SellerDetail.aspx?id=" + p.Seller_Id);
                    Seller.Text = p.Seller.Name;
                    Desc.Text = p.Description;
                    Prod_Img.ImageUrl = ResolveUrl("~/Broadcaster/Product_Image/" + p.Id + ".jpg");
                    QtyOrder.Attributes["max"] = p.Quantity.ToString();

                    if (p.Seller.Id == UserInfo.Id)
                    {
                        AddCartPanel.Visible = false;
                        EditProductBtn.Visible = true;
                        QtyOrder.Visible = false;
                    }
                }
                else
                {
                    Response.RedirectPermanent("/");
                }
            }
        }

        protected void AddCart_Click(object sender, EventArgs e)
        {
            try
            {
                int qtyOrder = int.Parse(QtyOrder.Text);

                if (qtyOrder < 1)
                {
                    QtyValidator.IsValid = false;
                    QtyValidator.ErrorMessage = "Quantity cannot be 0";
                }
                else if (qtyOrder > p.Quantity)
                {
                    QtyValidator.IsValid = false;
                    QtyValidator.ErrorMessage = "Quantity is exceeded maximum stock";
                }
            }
            catch (ArgumentNullException)
            {
                QtyValidator.IsValid = false;
                QtyValidator.ErrorMessage = "Quantity cannot be empty.";
            }
            catch (Exception)
            {
                QtyValidator.IsValid = false;
                QtyValidator.ErrorMessage = "Quantity is not a number.";
            }

            if (QtyValidator.IsValid)
            {
                if (!string.IsNullOrEmpty(UserInfo.Role) && UserInfo.Role.ToLower() == "buyer")
                {
                    var cart = Global.db.Carts.SingleOrDefault(x => x.Buyer_Id == UserInfo.Id && x.Product_Id == p.Id);
                    if (p != null && cart == null)
                    {
                        Cart c = new Cart
                        {
                            Buyer_Id = UserInfo.Id,
                            Product_Id = p.Id,
                            Quantity = int.Parse(QtyOrder.Text),
                        };

                        Global.db.Carts.InsertOnSubmit(c);
                        Global.db.SubmitChanges();
                        Response.Redirect("~/Viewer/Cart.aspx");
                    }
                    else if (cart != null)
                    {
                        DisplayProduct.Visible = false;
                        Message.Text = "Product is already exist in your cart, please update in your cart";
                        MessagePanel.Visible = true;
                    }
                }
                else
                {
                    Response.Redirect("~/Error.aspx?errmsg=Please login buyer account to get your cart or register one. :(");
                }
            }
        }

        protected void EditProduct_Click(object sender, EventArgs e)
        {
            DisplayProduct.Visible = false;

            ProdName.Text = p.Name;
            ProdImg.ImageUrl = ResolveUrl("~/Broadcaster/Product_Image/" + p.Id + ".jpg");
            PriceChange.Text = p.Price.ToString("F");
            StockChange.Text = p.Quantity.ToString();
            ProdDesc.Text = LineBreaksConvert.LineBreaksDBToText(p.Description);
            SellerLink.Text = p.Seller.Name;
            SellerLink.NavigateUrl = "~/broadcaster/sellerdetail.aspx?id=" + p.Seller_Id;

            EditProductPanel.Visible = true;
        }

        protected void DeleteProd_Click(object sender, EventArgs e)
        {
            if (p != null)
            {
                var delProd = Global.db.Products.SingleOrDefault(x => x.Id == p.Id);

                if (delProd != null)
                {
                    delProd.Active = false;
                    Global.db.SubmitChanges();

                    EditProductPanel.Visible = false;
                    MessagePanel.Visible = true;
                    Message.Text = "You have successfully removed " + delProd.Name;
                }
            }
        }

        protected void UpdateProd_Click(object sender, EventArgs e)
        {
            if (ProdDescRequired.IsValid && PriceChangeValidator.IsValid && StockChangeValidator.IsValid)
            {
                p.Price = decimal.Parse(PriceChange.Text);
                p.Quantity = int.Parse(StockChange.Text);
                p.Description = LineBreaksConvert.LineBreaksTextToDB(ProdDesc.Text);

                Global.db.SubmitChanges();

                Response.RedirectPermanent("/Broadcaster/ProductInfo.aspx?Id=" + p.Id);
            }
        }

        protected void PriceChangeValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (string.IsNullOrEmpty(args.Value))
            {
                args.IsValid = false;
                PriceChangeValidator.ErrorMessage = "*Price cannot be empty";
            }
            else
            {
                try
                {
                    decimal price = decimal.Parse(args.Value);

                    if (price < 0)
                    {
                        args.IsValid = false;
                        PriceChangeValidator.ErrorMessage = "*Price must be a positive value";
                    }
                    else if (price > 999999)
                    {
                        args.IsValid = false;
                        PriceChangeValidator.ErrorMessage = "*Price only allow not more than 6 digits";
                    }
                }
                catch (Exception)
                {
                    args.IsValid = false;
                    PriceChangeValidator.ErrorMessage = "*Invalid format.";
                }
            }
        }

        protected void StockChangeValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (string.IsNullOrEmpty(args.Value))
            {
                args.IsValid = false;
                StockChangeValidator.ErrorMessage = "*Stock quantity cannot be empty";
            }
        }
    }
}