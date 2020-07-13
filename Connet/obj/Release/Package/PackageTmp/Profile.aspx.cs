using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Connet.CSFile;

namespace Connet
{
    public partial class Profile : System.Web.UI.Page
    {
        // ------------------------------- Page Load Event -------------------------------
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(UserInfo.Role)) // Check if user is not logged in
                {
                    // Buyer
                    if (UserInfo.Role.ToLower() == "buyer")
                    {
                        BuyerPanel.Visible = true;      // Enable Buyer Panel
                        SellerPanel.Visible = false;    // Disable Seller Panel

                        var b = Global.db.Buyers.SingleOrDefault(x => UserInfo.Id == x.Id);

                        if (b != null)  // Buyer found
                        {
                            // Display buyer info
                            ProfileID.Text = b.Id.Trim();
                            Name.Text = b.Name.Trim();
                            Current_Name.Text = b.Name.Trim();
                            Email.Text = b.Email.Trim();
                            Phone.Text = b.PhoneNumber.Trim();

                            switch (b.Gender)   // Check gender
                            {
                                case 'm': Male.Checked = true;
                                    GenderTxt.Text = "Male";
                                    break;
                                case 'f': Female.Checked = true;
                                    GenderTxt.Text = "Female";
                                    break;
                                default:
                                    GenderTxt.Text = "Not specific";
                                    break;
                            }
                        }
                        else
                        {
                            // Redirect to error page if buyer not found
                            Response.Redirect("~/Error.aspx?errmsg=Sorry seems like your account occur error. Please contact admin.");
                        }
                    }
                    // Seller
                    else if (UserInfo.Role.ToLower() == "seller")
                    {
                        var s = Global.db.Sellers.SingleOrDefault(x => x.Id == UserInfo.Id);

                        if (s != null)  // Seller found
                        {
                            // Display seller info
                            Seller_Name.Text = s.Name;
                            SellerID.Text = s.Id;
                            SellerDateJoined.Text = s.DateJoined.ToString("dd MMMM yyyy");
                            SellerName.Text = s.Name;
                            SellerEmail.Text = s.Email;
                            SellerPhone.Text = s.PhoneNumber;
                            
                            SellerPanel.Visible = true; // Enable Seller Panel
                            BuyerPanel.Visible = false; // Display Buyer Panel
                        }
                        else
                        {
                            // Redirect to error page is seller not found
                            Response.Redirect("~/Error.aspx?errmsg=Sorry seems like your account occur error. Please contact admin.");
                        }

                    }
                }
                else
                {
                    Response.Redirect("/");
                }
            }
        }

        // ------------------------------- Buyer Side -------------------------------

        // ===========
        //  Validator
        // ===========

        /* Profile info */
        protected void NameValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string error = Validation.usernameValidate(args.ToString());
            if (!string.IsNullOrEmpty(error))
            {
                args.IsValid = false;
                NameValidator.ErrorMessage = error;
            }
        }

        protected void EmailValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string error = Validation.emailValidate(args.Value);
            if (!string.IsNullOrEmpty(error))
            {
                args.IsValid = false;
                EmailValidator.ErrorMessage = error;
            }
        }

        protected void PhoneValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string error = Validation.phoneNumber(args.Value);
            if (!string.IsNullOrEmpty(error))
            {
                args.IsValid = false;
                PhoneValidator.ErrorMessage = error;
            }
        }

        /* Address Info */
        protected void AddressValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (string.IsNullOrEmpty(args.Value))
            {
                args.IsValid = false;
                AddressValidator.ErrorMessage = "Address line is empty";
            }
            else if (args.Value.Length >= 100)
            {
                args.IsValid = false;
                AddressValidator.ErrorMessage = "Address line has exceeded maximum 100 characters";
            }
        }

        protected void CityValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (string.IsNullOrEmpty(args.Value))
            {
                args.IsValid = false;
                CityValidator.ErrorMessage = "City is empty";
            }
            else if (args.Value.Length >= 50)
            {
                args.IsValid = false;
                CityValidator.ErrorMessage = "City has exceeded maximum 50 characters";
            }
        }

        protected void ZipCodeValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var reg = Regex.Match(args.Value, @"^\d");

            if (string.IsNullOrEmpty(args.Value))
            {
                args.IsValid = false;
                ZipcodeValidator.ErrorMessage = "Zip code is empty";
            }
            else if (!reg.Success)
            {
                args.IsValid = false;
                ZipcodeValidator.ErrorMessage = "Zip code must be a number";
            }
            else if (args.Value.Length != 5)
            {
                args.IsValid = false;
                ZipcodeValidator.ErrorMessage = "Zip code format incorrect";
            }
        }

        protected void StateValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (string.IsNullOrEmpty(args.Value))
            {
                args.IsValid = false;
                StateValidator.ErrorMessage = "State is empty";
            }
            else if (args.Value.Length >= 50)
            {
                args.IsValid = false;
                StateValidator.ErrorMessage = "State has exceeded maximum 50 characters";
            }
        }

        // ==============
        //  Button Event
        // ==============
        protected void EditBtn_Click(object sender, EventArgs e)
        {
            Name.ReadOnly = false;
            Email.ReadOnly = false;
            Phone.ReadOnly = false;
            Gender.Visible = false;
            PickGender.Visible = true;
            Save.Visible = true;
            Edit.Visible = false;
        }
        protected void edit_p_OnClick(object sender, EventArgs e)
        {
            Edit_Address.Visible = false;
            Edit_Profile.Visible = true;
        }

        protected void edit_a_OnClick(object sender, EventArgs e)
        {
            Edit_Address.Visible = true;
            Edit_Profile.Visible = false;
        }

        protected void CancelBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx");
        }

        protected void SaveBtn_Click(object sender, EventArgs e)
        {
            if (NameValidator.IsValid && EmailValidator.IsValid && PhoneValidator.IsValid)
            {
                var b = Global.db.Buyers.SingleOrDefault(x => x.Id == UserInfo.Id);

                if (b != null)
                {
                    if (b.Name.ToLower() != Name.Text.ToLower()) { b.Name = Name.Text; }
                    if (b.Email.ToLower() != Email.Text.ToLower()) { b.Email = Email.Text; }
                    if (b.PhoneNumber != Phone.Text) { b.PhoneNumber = Phone.Text; }
                    if (Male.Checked) b.Gender = 'm'; else if (Female.Checked) b.Gender = 'f';
                    
                    Global.db.SubmitChanges();

                    Response.Redirect("Profile.aspx");
                }
            }
        }

        protected void AddressDelBtn_Click(object sender, EventArgs e)
        {
            Button btn = (Button) sender;

            var a = Global.db.Addresses.SingleOrDefault(x => x.Id.ToString() == btn.CommandName);

            if (a != null)
            {
                a.Active = false;
                Global.db.SubmitChanges();
            }

            Response.Redirect(Request.RawUrl);
        }

        protected void AddAddress_Click(object sender, EventArgs e)
        {
            if (AddressValidator.IsValid && CityValidator.IsValid && ZipcodeValidator.IsValid && StateValidator.IsValid)
            {
                Address a = new Address
                {
                    AddressLine = Address.Text,
                    City = City.Text,
                    State = State.Text,
                    Zipcode = Zipcode.Text,
                    User_Id = UserInfo.Id,
                    Active = true
                };

                Global.db.Addresses.InsertOnSubmit(a);
                Global.db.SubmitChanges();
                Response.Redirect(Request.RawUrl);
            }
        }

        // ------------------------------- Seller Side -------------------------------


        /* ------------------------- Linq Data Selecting ------------------------- */
        protected void ProfileDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            e.Result = Global.db.Products.Where(x => x.Seller_Id == UserInfo.Id && x.Active);
        }

        protected void AddressDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            var a = Global.db.Addresses.Where(x => x.User_Id == UserInfo.Id && x.Active);

            if (a.Count() >= 3)
            {
                NewAddressPanel.Visible = false;
            }

            e.Result = a;
        }
    }
}