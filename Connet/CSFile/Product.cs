using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Connet.CSFile
{
    public class Product
    {
        public string id { get; set; }
        public string Name { get; set; }

        public Product(string id, string Name)
        {
            this.id = id;
            this.Name = Name;
        }
    }
}