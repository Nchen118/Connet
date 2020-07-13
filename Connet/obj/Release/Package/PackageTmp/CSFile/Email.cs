using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Web;

namespace Connet.CSFile
{
    public class Email
    {
        public static void Send(string username, string email, string id, string condition = "Verify")
        {
            // Account Verification
            if (condition.ToLower() == "verify")
            {
                string body = PopulateBody (
                    username,
                    "Click here",
                    "https://localhost:44318/Account/Verification.aspx?email=" + email + "&code=" + Security.GetHash(id),
                    "<p>Thank you for signing up connet, please click the button to verify your account.</p>" +
                              "<p>Ignore to this email if you didn't attempt to register using this email</p>"
                );
                SendHtmlFormattedEmail(email, "Account Verify", body);
            }
            // Forget Password
            else if (condition.ToLower() == "forgetpassword")
            {
                string body = PopulateBody (
                    username,
                    "Click here",
                    "https://localhost:44318/ForgetPassword.aspx?id=" + id,
                    "<p>Please click the button to change your password.</p>" +
                              "<p>Ignore to this email if you didn't attempt to change password.</p>"
                );
                SendHtmlFormattedEmail(email, "Forget Password", body);
            }
        }

        private static string PopulateBody(string userName, string title, string url, string description)
        {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(HttpContext.Current.Server.MapPath("~/SendEmail.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{UserName}", userName);
            body = body.Replace("{Title}", title);
            body = body.Replace("{Url}", url);
            body = body.Replace("{Description}", description);
            body = body.Replace("{Year}", DateTime.Now.Year.ToString());
            return body;
        }

        private static void SendHtmlFormattedEmail(string recepientEmail, string subject, string body)
        {
            try
            {
                MailMessage mailMessage = new MailMessage();
                mailMessage.To.Add(recepientEmail);
                mailMessage.From = new MailAddress("connetcompany@gmail.com");
                mailMessage.Subject = subject;
                mailMessage.Body = body;
                mailMessage.IsBodyHtml = true;
                SmtpClient smtpClient = new SmtpClient();

                smtpClient.Host = "smtp.gmail.com";

                smtpClient.Port = 587;
                smtpClient.Credentials = new System.Net.NetworkCredential
                ("connetcompany@gmail.com", "connet123");
                smtpClient.EnableSsl = true;
                smtpClient.Send(mailMessage);
            }
            catch (Exception)
            {
                HttpContext.Current.Response.Redirect("~/Error.aspx?errmsg=Unable to send email"); 
            }

}
    }
}