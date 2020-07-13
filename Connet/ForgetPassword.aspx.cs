using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Lifetime;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Connet.CSFile;

namespace Connet.Viewer
{
    public partial class ForgetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(UserInfo.Id))
                {
                    Response.RedirectPermanent("/");
                }
                else
                {
                    string id = Request.QueryString["id"];

                    if (!string.IsNullOrEmpty(id))
                    {
                        var u = Global.db.Users.SingleOrDefault(x => x.Id == id);

                        if (u != null)
                        {
                            EmailRecoveryPanel.Visible = false;
                            ResetPasswordPanel.Visible = true;
                            Email.Text = u.Email;
                        }
                        else
                        {
                            Response.RedirectPermanent("/");
                        }

                    }
                }
            }
        }

        protected void EmailValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var validate = Validation.emailValidate(args.Value.Trim());
            var checkEmail = Global.db.Users.SingleOrDefault(x => args.Value == x.Email);
            if (!string.IsNullOrEmpty(validate))
            {
                EmailValidator.ErrorMessage = "*" + validate;
                args.IsValid = false;
            }
            else if (checkEmail == null)
            {
                EmailValidator.ErrorMessage = "*Email does not exist";
                args.IsValid = false;
            }
        }

        protected void Continue_Click(object sender, EventArgs e)
        {
            if (EmailValidator.IsValid)
            {
                var u = Global.db.Users.SingleOrDefault(x => x.Email == EmailRecovery.Text);

                if (u != null)
                {
                    CSFile.Email.Send(u.Name, u.Email, u.Id, "forgetpassword");
                    EmailRecoveryPanel.Visible = false;
                    MessagePanel.Visible = true;
                    Message.Text = "Email has successfully sent, please check your email.";
                }

            }
        }

        protected void NewPasswordValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var validate = Validation.passwordValidate(args.Value);
            if (!string.IsNullOrEmpty(validate))
            {
                NewPasswordValidator.ErrorMessage = "*" + validate;
                args.IsValid = false;
            }
        }

        protected void ConfirmNewPasswordValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (string.IsNullOrEmpty(args.Value))
            {
                args.IsValid = false;
                ConfirmNewPasswordValidator.ErrorMessage = "*Confirm password is empty";
            }
            else if (args.Value != NewPassword.Text)
            {
                args.IsValid = false;
                ConfirmNewPasswordValidator.ErrorMessage = "*Password not match";
            }
        }

        protected void Confirm_Click(object sender, EventArgs e)
        {
            if (NewPasswordValidator.IsValid && ConfirmNewPasswordValidator.IsValid)
            {
                try
                {
                    var user = Global.db.Users.SingleOrDefault(x => x.Email == Email.Text);

                    if (user != null)
                    {
                        if (user.role.ToLower() == "buyer")
                        {
                            var buyer = Global.db.Buyers.SingleOrDefault(x => x.Email == Email.Text);

                            if (buyer != null)
                            {
                                buyer.Password = Security.GetHash(NewPassword.Text);
                            }

                        }
                        else if (user.role.ToLower() == "seller")
                        {
                            var seller = Global.db.Sellers.SingleOrDefault(x => x.Email == Email.Text);

                            if (seller != null)
                            {
                                seller.Password = Security.GetHash(NewPassword.Text);
                            }
                        }

                        Global.db.SubmitChanges();

                        ResetPasswordPanel.Visible = false;
                        MessagePanel.Visible = true;
                        Message.Text = "Password reset successful! Login now.";
                    }
                }
                catch (Exception)
                {
                    ResetPasswordPanel.Visible = false;
                    MessagePanel.Visible = true;
                    Message.Text = "Hmm...Something went wrong. Please contact Admin for help.";
                }
            }
        }
    }
}