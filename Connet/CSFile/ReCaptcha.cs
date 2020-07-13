using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;

namespace Connet.CSFile
{
    public class ReCaptcha
    {
        public static bool Validate(string reCaptchaResponse)
        {
            var client = new System.Net.WebClient();

            var googleReply = client.DownloadString(string.Format("https://www.google.com/recaptcha/api/siteverify?secret=6LcfRpgUAAAAAOwjKFD-GMSn18UGp2ILUqR1EEcb&response={0}", reCaptchaResponse));

            var captchaResponse = JsonConvert.DeserializeObject<ReCaptcha>(googleReply);

            return captchaResponse.Success.ToLower() == "true";
        }

        [JsonProperty("success")]
        private string Success
        {
            get { return m_Success; }
            set { m_Success = value; }
        }

        private string m_Success;

        [JsonProperty("error-codes")]
        private List<string> ErrorCodes
        {
            get { return m_ErrorCodes; }
            set { m_ErrorCodes = value; }
        }

        private List<string> m_ErrorCodes;
    }
}