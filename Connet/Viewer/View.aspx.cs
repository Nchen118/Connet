using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Connet.CSFile;

namespace Connet.Viewer
{
    public partial class View : System.Web.UI.Page
    {
        private static string room;

        protected void Page_Load(object sender, EventArgs e)
        {
            room = Request.QueryString["roomid"];

            if (!string.IsNullOrEmpty(room))
            {
                roomID.Value = room;
            }

            if (!string.IsNullOrEmpty(UserInfo.Name))
            {
                userField.Value = UserInfo.Name; 
            }
        }

        protected void ViewDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            var p = Global.db.Stream_Products.Where(x => x.RoomID == room);

            e.Result = p;
        }
    }
}