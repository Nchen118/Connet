using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web.UI.WebControls;
using Connet.CSFile;

namespace Connet.Account
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    ViewState["RefUrl"] = Request.UrlReferrer.ToString(); //Error
                }
                catch (NullReferenceException) { }
            }

            if (!string.IsNullOrEmpty(UserInfo.Role))
            {
                try
                {
                    Response.Redirect(ViewState["RefUrl"].ToString());
                }
                catch (NullReferenceException)
                {
                    Response.Redirect("/");
                }
            }
        }

        protected void SignUpEmailValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var validate = Validation.emailValidate(args.Value.Trim());
            var duplicate = Global.db.Users.SingleOrDefault(x => args.Value == x.Email);
            if (!string.IsNullOrEmpty(validate))
            {
                EmailValidator.ErrorMessage = "*" + validate;
                args.IsValid = false;
            }
            else if (duplicate != null)
            {
                EmailValidator.ErrorMessage = "*Email already used try others";
                args.IsValid = false;
            }
        }

        protected void SignUpUsernameValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var validate = Validation.usernameValidate(args.Value.Trim());
            var duplicate = Global.db.Users.SingleOrDefault(x => args.Value == x.Name);
            if (!string.IsNullOrEmpty(validate))
            {
                UsernameValidator.ErrorMessage = "*" + validate;
                args.IsValid = false;
            }
            else if (duplicate != null)
            {
                UsernameValidator.ErrorMessage = "*Username already used try others";
                args.IsValid = false;
            }
        }

        protected void SignUpPasswordValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var validate = Validation.passwordValidate(args.Value);
            if (!string.IsNullOrEmpty(validate))
            {
                PasswordValidator.ErrorMessage = "*" + validate;
                args.IsValid = false;
            }
        }

        protected void SignUpConfirmPasswordValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!Password.Text.Equals(args.Value))
            {
                ConfirmPasswordValidator.ErrorMessage = "*Confirm password incorrect";
                args.IsValid = false;
            }
        }

        protected void SignUpPhoneNumberValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var validate = Validation.phoneNumber(args.Value);
            var duplicate = Global.db.Users.SingleOrDefault(x => args.Value == x.PhoneNumber);
            if (!string.IsNullOrEmpty(validate))
            {
                PhoneNumberValidator.ErrorMessage = "*" + validate;
                args.IsValid = false;
            }
            else if (duplicate != null)
            {
                UsernameValidator.ErrorMessage = "*Username already used try others";
                args.IsValid = false;
            }
        }

        protected void Signup_Click(object sender, EventArgs e)
        {
            if (EmailValidator.IsValid && UsernameValidator.IsValid && PasswordValidator.IsValid && ConfirmPasswordValidator.IsValid && PhoneNumberValidator.IsValid && RegisType.IsValid)
            {
                if (ReCaptcha.Validate(recaptcha_token.Value))
                {
                    if (buyerR.Checked)
                    {
                        Buyer b = new Buyer
                        {
                            Id = Security.GenerateNewID('B'),
                            Name = Security.ParseOutHTML(Username.Text.Trim()),
                            Email = Security.ParseOutHTML(Email.Text.Trim().ToLower()),
                            Password = Security.GetHash(Password.Text),
                            PhoneNumber = PhoneNumber.Text,
                            DateJoined = DateTime.Now
                        };
                        Global.db.Buyers.InsertOnSubmit(b);
                        CSFile.Email.Send(b.Name, b.Email, b.Id);
                    }
                    else if (sellerR.Checked)
                    {
                        Seller s = new Seller
                        {
                            Id = Security.GenerateNewID('S'),
                            Name = Security.ParseOutHTML(Username.Text.Trim()),
                            Email = Security.ParseOutHTML(Email.Text.Trim().ToLower()),
                            Password = Security.GetHash(Password.Text),
                            PhoneNumber = PhoneNumber.Text,
                            DateJoined = DateTime.Now
                        };
                        Global.db.Sellers.InsertOnSubmit(s);
                        CSFile.Email.Send(s.Name, s.Email, s.Id);
                    }
                    Global.db.SubmitChanges();
                    Response.Redirect("~/Account/Verification.aspx?email=" + Email.Text);
                }
                else
                {
                    RecaptchaError.IsValid = false;
                }
            }
        }

        protected void Cancel_Click(object sender, EventArgs e)
        {
            try
            {
                Response.Redirect(ViewState["RefUrl"].ToString());
            }
            catch (NullReferenceException)
            {
                Response.Redirect("/");
            }
        }

        protected void RegisTypeValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!buyerR.Checked && !sellerR.Checked)
            {
                args.IsValid = false;
            }
        }
    }
}