using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Connet.CSFile;

namespace Connet.LayoutPages
{
    public partial class Layout : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (!string.IsNullOrEmpty(UserInfo.Role))
                {
                    AuthLink.Text = UserInfo.Name;
                    login_content.Visible = false;
                    switch (UserInfo.Role.ToLower())
                    {
                        case "buyer":
                            Buyer.Visible = true;
                            Cart_Wrap.Visible = true;
                            break;
                        case "seller":
                            Seller.Visible = true;
                            break;
                        case "admin":
                            Response.Redirect("~/Account/Logout.aspx");
                            break;
                    }
                }
                else
                {
                    if (!string.IsNullOrEmpty(Response.Cookies["Auth"].Values.ToString()))
                    {
                        var u = Global.db.Users.SingleOrDefault(x =>
                            x.Name.ToLower() == Security.Decrypt(Response.Cookies["Auth"]["Name"].ToString()).ToLower() && x.Password ==
                            Security.Decrypt(Response.Cookies["Auth"]["Password"].ToString()));

                        if (u != null)
                        {
                            UserInfo.Id = u.Id;
                            UserInfo.Name = u.Name;
                            UserInfo.Role = u.role;
                        }
                        else
                        {
                            Response.Cookies["Auth"].Expires = DateTime.Now.AddDays(-1);
                        }

                        Response.RedirectPermanent("/");
                    }
                    else
                    {
                        AuthLink.Text = "Sign up / Login";
                        AuthLink.Attributes["data-toggle"] = "modal";
                        AuthLink.Attributes["data-target"] = "#loginModal";
                        login_content.Visible = true;
                    }

                }
            }
        }

        protected void UsernameValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (string.IsNullOrEmpty(args.Value))
            {
                UsernameValid.ErrorMessage = "Username is empty";
                args.IsValid = false;
            }
        }

        protected void PasswordValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (string.IsNullOrEmpty(args.Value))
            {
                PasswordValid.ErrorMessage = "Password is empty";
                args.IsValid = false;
            }
        }

        protected void hidden_search_btn_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/SearchProduct.aspx?search=" + SearchBox.Text);
        }

        // User Login
        protected void Login_Click(object sender, EventArgs e)
        {
            if (UsernameValid.IsValid && PasswordValid.IsValid)
            {
                var user = Global.db.Users.SingleOrDefault(x => (Username.Text.ToLower() == x.Name.ToLower() || Username.Text.ToLower() == x.Email.ToLower() || Username.Text.ToLower() == x.PhoneNumber)
                                                                && Security.GetHash(Password.Text) == x.Password);
                if (user == null)
                {
                    UsernameValid.ErrorMessage = "Username or password invalid";
                    UsernameValid.IsValid = false;
                }
                else
                {
                    if (user.Verified)
                    {
                        UserInfo.Id = user.Id;
                        UserInfo.Name = user.Name;
                        UserInfo.Role = user.role;

                        if (rmbMe.Checked)
                        {
                            if (!string.IsNullOrEmpty(Response.Cookies["Auth"].Values.ToString()))
                            {
                                Response.Cookies["Auth"].Expires = DateTime.Now.AddDays(-1);
                            }
                            Response.Cookies["Auth"]["Name"] = Security.Encrypt(UserInfo.Name);
                            Response.Cookies["Auth"]["Password"] = Security.Encrypt(user.Password);
                            Response.Cookies["Auth"].Expires = DateTime.Now.AddDays(30);
                        }

                        try
                        {
                            if (Request.UrlReferrer.ToString().Contains("Error.aspx") || Request.UrlReferrer.ToString().Contains("ForgetPassword.aspx"))
                            {
                                Response.RedirectPermanent("/");
                            }
                            else
                            {
                                Response.RedirectPermanent(Request.UrlReferrer.ToString());
                            }

                        }
                        catch (NullReferenceException)
                        {
                            Response.RedirectPermanent("/");
                        }
                    }
                    else
                    {
                        Response.RedirectPermanent("~/Account/Verification.aspx?email=" + user.Email);
                    }
                }
            }
        }
    }
}