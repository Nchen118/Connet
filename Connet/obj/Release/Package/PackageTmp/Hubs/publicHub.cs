using System;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using Connet.CSFile;
using Helpers;
using Microsoft.AspNet.SignalR;

namespace Connet.Hubs
{
    public class publicHub : Hub
    {
        public void SendToAll(string roomid, string name, string message)
        {
            Clients.All.sendMessage(roomid, name, message);
        }

        public void Send(string name, string message)
        {
            // Call the broadcastMessage method to update clients.
            Clients.All.broadcastMessage(name, message);
        }

        public void ViewSend(string roomid, string views)
        {
            var stream = Global.db.Streams.SingleOrDefault(x => x.Id == roomid);

            if (stream != null)
            {
                stream.TotalView = (stream.TotalView < int.Parse(views) ? int.Parse(views) : stream.TotalView);
            }
            
            Clients.All.viewReceive(roomid, views);
        }

        public void ImageBit(string imageBitmap, string roomid)
        {
            var stream = Global.db.Streams.SingleOrDefault(x => x.Id == roomid);

            if (stream != null)
            {
                stream.Screenshot = imageBitmap;
                Global.db.SubmitChanges();
            }
        }

        public void BroadcastEnd(string roomid)
        {
            var stream = Global.db.Streams.SingleOrDefault(x => x.Id == roomid);

            if (stream != null)
            {
                stream.Active = false;
                Global.db.SubmitChanges();
            }
        }
        
        public override Task OnDisconnected(bool stopCalled)
        {
            if (stopCalled)
            {
                // We know that Stop() was called on the client,
                // and the connection shut down gracefully.

            }
            else
            {
                // This server hasn't heard from the client in the last ~35 seconds.
                // If SignalR is behind a load balancer with scaleout configured, 
                // the client may still be connected to another SignalR server.

            }

            return base.OnDisconnected(stopCalled);
        }
    }
}