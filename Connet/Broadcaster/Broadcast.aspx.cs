using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Connet.CSFile;

namespace Connet.Broadcaster
{
    public partial class Broadcast : System.Web.UI.Page
    {
        private static string room;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                room = Session["room"].ToString();
                Session.Remove("room");
            }
            catch (Exception)
            {
                Response.RedirectPermanent("/");
            }

            var s = Global.db.Streams.SingleOrDefault(x => x.Id == room);

            if (s == null || UserInfo.Role.ToLower() != "seller")
            {
                Response.RedirectPermanent("/");
            }
            else
            {
                roomid.Value = room;
                sellerField.Value = UserInfo.Name;
            }


        }

        protected void ProductListDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            var sp = Global.db.Stream_Products.Where(x => x.RoomID == room);
            e.Result = sp;
        }
    }
}