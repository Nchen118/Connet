using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Connet.CSFile
{
    public class LineBreaksConvert
    {
        public static string LineBreaksTextToDB(string input)
        {
            return System.Text.RegularExpressions.Regex.Replace(input, "([^\\r])[\\n]", "$1\\r\\n").Replace("\\r\\n", "<br />");
        }

        public static string LineBreaksDBToText(string input)
        {
            return input.Replace("<br />", System.Environment.NewLine);
        }
    }
}