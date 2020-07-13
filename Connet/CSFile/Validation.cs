using System;
using System.Linq;
using System.Net.Mail;
using System.Text.RegularExpressions;

namespace Connet.CSFile
{
    public class Validation
    {
        public static string usernameValidate(string username)
        {
            var fullname = Security.ParseOutHTML(username);
            var match = Regex.Match(fullname, @"^[\w\d._]+");
            if (string.IsNullOrEmpty(fullname))
                return "Username cannot be empty";
			else {
                if (username.Length > 50)
                    return "Username cannot more than 50 characters";
                else if (username.Any(Char.IsWhiteSpace))
					return "Username cannot contain whitespace";
                else if (!match.Success)
					return "Invalid username, try other username";
				else return null;
			}
        }

        public static string emailValidate(string mail)
        {
            var email = mail;
            if (string.IsNullOrEmpty(email))
                return "Email is empty";
			else {
                if (mail.Length > 50)
                    return "Email cannot more than 50 characters";
                else if (!EmailValidate(email))
					return "Invalid email format";
				else return null;
			}
        }

        private static bool EmailValidate(string emailAdd)
        {
            try
            {
                var m = new MailAddress(emailAdd);
                return true;
            }
            catch (FormatException)
            {
                return false;
            }
        }

        public static string passwordValidate(string pwd)
        {
            var password = Security.ParseOutHTML(pwd);
            var match = Regex.Match(password, @"^.*(?=.{8,50})(?=.*[\d])(?=.*[\w]).*$");
            if (string.IsNullOrEmpty(pwd))
                return "Password is empty";
			else {
				if (password.Length < 8)
					return "Password must more than 8";
				else if (password.Length > 50)
					return "Password must less than 50";
				else if (!match.Success)
					return "Password must contain at least one alphabet and one number";
				else return null;
			}
        }

        public static string phoneNumber(string num)
        {
            var phoneNumber = num;
            Match match1 = Regex.Match(phoneNumber, @"01\d{8,9}"), match2 = Regex.Match(num, @"^01\d-\d{7,8}$");
            if (string.IsNullOrEmpty(phoneNumber))
                return "Phone Number cannot be empty";
			else {
				if (match1.Success || match2.Success)
					return null;
				else return "Invalid Phone Number";
			}
        }
    }
}