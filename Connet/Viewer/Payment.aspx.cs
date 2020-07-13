using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Connet.CSFile;

namespace Connet.Viewer
{
    public partial class Payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try { BackBtn.PostBackUrl = Request.UrlReferrer.ToString(); }
                catch (NullReferenceException) { BackBtn.PostBackUrl = "/"; }

                if (string.IsNullOrEmpty(UserInfo.Role) || UserInfo.Role.ToLower() != "buyer")
                {
                    Response.RedirectPermanent("/");
                }
            }
        }

        protected void cvCardNum_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string temp = Security.ParseOutHTML(txtCardNum.Text);
            string tm = temp.Replace(" ", string.Empty);
            bool verified = ValidateCardNumber(tm);
            if (string.IsNullOrEmpty(args.Value))
            {
                cvCardNum.ErrorMessage = "The credit card number is empty";
                args.IsValid = false;
            }
            else if (!verified)
            {
                cvCardNum.ErrorMessage = "The credit card number is invalid";
                args.IsValid = false;
            }
        }
        protected void cvCreditCardEpx_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string exp = Security.ParseOutHTML(txtExpDate.Text);
            if (string.IsNullOrEmpty(exp))
            {
                cvExpDate.ErrorMessage = "The expire data cannot be empty";
                args.IsValid = false;
            }

        }

        protected void cvCreditCardCvv_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string cvv = Security.ParseOutHTML(txtCvv.Text);
            if (string.IsNullOrEmpty(cvv))
            {
                cvCvv.ErrorMessage = "CVV/CVC cannot be empty";
                args.IsValid = false;
            }
            else if (Convert.ToInt32(cvv) < 0)
            {
                cvCvv.ErrorMessage = "Invalid CVV/CVC";
                args.IsValid = false;
            }
        }


        private static bool ValidateCardNumber(string cardNumber)
        {
            try
            {
                // Array to contain individual numbers
                var CheckNumbers = new ArrayList();
                // So, get length of card
                var CardLength = cardNumber.Length;

                // Double the value of alternate digits, starting with the second digit
                // from the right, i.e. back to front.
                // Loop through starting at the end
                for (var i = CardLength - 2; i >= 0; i = i - 2)
                    // Now read the contents at each index, this
                    // can then be stored as an array of integers

                    // Double the number returned
                    CheckNumbers.Add(int.Parse(cardNumber[i].ToString()) * 2);

                var CheckSum = 0; // Will hold the total sum of all checksum digits

                // Second stage, add separate digits of all products
                for (var iCount = 0; iCount <= CheckNumbers.Count - 1; iCount++)
                {
                    var _count = 0; // will hold the sum of the digits

                    // determine if current number has more than one digit
                    if ((int)CheckNumbers[iCount] > 9)
                    {
                        var _numLength = ((int)CheckNumbers[iCount]).ToString().Length;
                        // add count to each digit
                        for (var x = 0; x < _numLength; x++)
                            _count = _count + int.Parse(
                                         ((int)CheckNumbers[iCount]).ToString()[x].ToString());
                    }
                    else
                    {
                        // single digit, just add it by itself
                        _count = (int)CheckNumbers[iCount];
                    }

                    CheckSum = CheckSum + _count; // add sum to the total sum
                }

                // Stage 3, add the unaffected digits
                // Add all the digits that we didn't double still starting from the
                // right but this time we'll start from the rightmost number with 
                // alternating digits
                var OriginalSum = 0;
                for (var y = CardLength - 1; y >= 0; y = y - 2)
                    OriginalSum = OriginalSum + int.Parse(cardNumber[y].ToString());

                // Perform the final calculation, if the sum Mod 10 results in 0 then
                // it's valid, otherwise its false.
                return (OriginalSum + CheckSum) % 10 == 0;
            }
            catch
            {
                return false;
            }
        }

        protected void Confirm_Click(object sender, EventArgs e)
        {
            Address a = null;

            for (int i = 0; i < AddressListView.Items.Count; i++)
            {
                var chk = (RadioButton)AddressListView.Items[i].FindControl("AddressRb");
                if (chk.Checked)
                {
                    var ad = Global.db.Addresses.SingleOrDefault(x => x.Id.ToString() == AddressListView.DataKeys[i].Value.ToString());
                    if (ad != null)
                    {
                        a = ad;
                    }
                }
            }

            if (a == null)
            {
                ShippingValidator.IsValid = false;
                ShippingValidator.ErrorMessage = "Please choose an address to process payment.";
            }
            else
            {
                if (ShippingValidator.IsValid && cvCardNum.IsValid && cvExpDate.IsValid && cvCvv.IsValid)
                {
                    var c = Global.db.Carts.Where(x => x.Buyer_Id == UserInfo.Id);

                    if (c.Any())
                    {
                        foreach (var item in c)
                        {
                            var p = Global.db.Products.SingleOrDefault(x => x.Id == item.Product_Id);

                            p.Quantity = p.Quantity - item.Quantity;    // Deduct product stock

                            Order o = new Order
                            {
                                Id = Security.GenerateNewID('O'),
                                Order_date = DateTime.Now,
                                Order_Status = "Pending",
                                Quantity = item.Quantity,
                                TotalPrice = item.Product.Price * item.Quantity,
                                Buyer_Id = UserInfo.Id,
                                Address_Id = a.Id
                            };

                            Global.db.Orders.InsertOnSubmit(o);

                            Order_Detail od = new Order_Detail
                            {
                                Product_Id = item.Product_Id,
                                Order_Id = o.Id
                            };

                            Global.db.Order_Details.InsertOnSubmit(od);

                            Global.db.SubmitChanges();
                        }

                        Global.db.Carts.DeleteAllOnSubmit(c);
                        Global.db.SubmitChanges();

                        PaymentPanel.Visible = false;
                        MessagePanel.Visible = true;
                        Message.Text = "Congratz...You have successfully purchase your goody";
                    }

                }
            }
        }

        protected void AddressDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            e.Result = Global.db.Addresses.Where(x => x.User_Id == UserInfo.Id && x.Active);
        }

        protected void CartDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            e.Result = Global.db.Carts.Where(x => x.Buyer_Id == UserInfo.Id);
        }
    }
}