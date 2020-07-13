using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using Newtonsoft.Json;

namespace Connet.CSFile
{
    public class Security
    {
        public static string GetHash(string strPass)
        {
            var binPass = Encoding.Default.GetBytes(strPass);

            var sha = SHA256.Create();
            var binHash = sha.ComputeHash(binPass);
            var strHash = Convert.ToBase64String(binHash);

            return strHash;
        }

        public static string ParseOutHTML(string htmlContent)
        {
            var parsedContent = string.Empty;
            var tagPattern = new Regex(@"(?<=^|>)[^><]+?(?=<|$)", RegexOptions.IgnoreCase);
            var tagsRemoved = tagPattern.Matches(htmlContent);
            foreach (Match match in tagsRemoved)
                parsedContent += match.Value.Trim() + " ";
            return parsedContent;
        }

        public static string Token(int characters, bool numeric = false)
        {
            string chars;
            if (numeric)
                chars = "0123456789";
            else
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var stringChars = new char[characters];
            var random = new Random();

            for (int i = 0; i < stringChars.Length; i++)
            {
                stringChars[i] = chars[random.Next(chars.Length)];
            }

            return new string(stringChars);
        }

        public static string GenerateNewID(char type)
        {
            return (type.ToString().ToUpper() + Guid.NewGuid().ToString("N")).Trim();
        }

        private static string encryptKey = "/hE=ru5%X5w+SKb=ii72";

        public static string Encrypt(string strData)
        {
            string encryptValue;
            if (!string.IsNullOrEmpty(encryptKey))
            {
                if (encryptKey.Length < 16)
                {
                    char c = "XXXXXXXXXXXXXXXX"[16];
                    encryptKey = encryptKey + encryptKey.Substring(0, 16 - encryptKey.Length);
                }
                else
                {
                    encryptKey = encryptKey.Substring(0, 16);
                }

                // create encryption keys
                byte[] byteKey = Encoding.UTF8.GetBytes(encryptKey.Substring(0, 8));
                byte[] byteVector = Encoding.UTF8.GetBytes(encryptKey.Substring(encryptKey.Length - 8, 8));

                // convert data to byte array
                byte[] byteData = Encoding.UTF8.GetBytes(strData);

                // encrypt 
                DESCryptoServiceProvider objDES = new DESCryptoServiceProvider();
                MemoryStream objMemoryStream = new MemoryStream();
                CryptoStream objCryptoStream = new CryptoStream(objMemoryStream, objDES.CreateEncryptor(byteKey, byteVector), CryptoStreamMode.Write);
                objCryptoStream.Write(byteData, 0, byteData.Length);
                objCryptoStream.FlushFinalBlock();

                // convert to string and Base64 encode
                encryptValue = Convert.ToBase64String(objMemoryStream.ToArray());
            }
            else
            {
                encryptValue = strData;
            }
            return encryptValue;
        }


        public static string Decrypt(string strData)
        {
            string decryptValue = "";
            if (!string.IsNullOrEmpty(encryptKey))
            {
                // convert key to 16 characters for simplicity
                if (encryptKey.Length < 16)
                {
                    encryptKey = encryptKey + encryptKey.Substring(0, 16 - encryptKey.Length);

                }
                else
                {
                    encryptKey = encryptKey.Substring(0, 16);
                }

                // create encryption keys
                byte[] byteKey = Encoding.UTF8.GetBytes(encryptKey.Substring(0, 8));
                byte[] byteVector = Encoding.UTF8.GetBytes(encryptKey.Substring(encryptKey.Length - 8, 8));

                // convert data to byte array and Base64 decode
                byte[] byteData = new byte[strData.Length + 1];
                try
                {
                    byteData = Convert.FromBase64String(strData);
                }
                catch
                {
                    decryptValue = strData;
                }


                if (string.IsNullOrEmpty(decryptValue))
                {
                    // decrypt
                    DESCryptoServiceProvider objDES = new DESCryptoServiceProvider();
                    MemoryStream objMemoryStream = new MemoryStream();
                    CryptoStream objCryptoStream = new CryptoStream(objMemoryStream, objDES.CreateDecryptor(byteKey, byteVector), CryptoStreamMode.Write);
                    objCryptoStream.Write(byteData, 0, byteData.Length);
                    objCryptoStream.FlushFinalBlock();

                    // convert to string
                    System.Text.Encoding objEncoding = System.Text.Encoding.UTF8;
                    decryptValue = objEncoding.GetString(objMemoryStream.ToArray());

                }
            }
            else
            {
                decryptValue = strData;
            }

            return decryptValue;
        }
    }
}