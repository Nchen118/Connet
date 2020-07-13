using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Connet.CSFile;
using Helpers;

namespace Connet.Broadcaster
{
    public partial class AddProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    BackBtn.PostBackUrl = Request.UrlReferrer.ToString();
                }
                catch (NullReferenceException)
                {
                    BackBtn.PostBackUrl = "/";
                }

                if (!string.IsNullOrEmpty(UserInfo.Role) && UserInfo.Role.ToLower() == "seller")
                {

                }
                else
                {
                    Response.RedirectPermanent("/");
                }
            }

        }

        protected void AddBtn_Click(object sender, EventArgs e)
        {
            if (Prod_ImgValidation.IsValid && NameValidator.IsValid && DescValidator.IsValid && QtyEmptyValidator.IsValid && QtyValidator.IsValid && PriceEmptyValidator.IsValid && PriceValidator.IsValid)
            {
                Product p = new Product
                {
                    Id = Security.GenerateNewID('P'),
                    Name = Name.Text,
                    Description = LineBreaksConvert.LineBreaksTextToDB(Description.Text),
                    Quantity = int.Parse(Qty.Text),
                    Price = decimal.Parse(Price.Text),
                    Active = true,
                    Seller_Id = UserInfo.Id
                };

                Global.db.Products.InsertOnSubmit(p);
                Global.db.SubmitChanges();

                var path = MapPath("~/Broadcaster/Product_Image/");
                var img = new SimpleImage(Img_File.FileContent);
                img.SaveAs(path + p.Id + ".jpg");

                Response.RedirectPermanent("~/Broadcaster/ProductInfo.aspx?id=" + p.Id);
            }
        }

        protected void Prod_ImgValidation_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var pattern = new Regex(@".+\.(jpg|png|jpeg)$", RegexOptions.IgnoreCase);

            if (!Img_File.HasFile)
            {
                args.IsValid = false;
                Prod_ImgValidation.ErrorMessage = "No picture chosen";
            }
            else if (!pattern.IsMatch(Img_File.FileName))
            {
                args.IsValid = false;
                Prod_ImgValidation.ErrorMessage = "Only JPG and PNG are allowed for [Photo]";
            }
        }
    }
}