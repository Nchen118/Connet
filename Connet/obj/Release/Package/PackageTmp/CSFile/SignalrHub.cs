using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;

namespace Connet.CSFile
{
    public class SignalrHub : Hub
    {
        public void Hello()
        {
            Clients.All.hello();
        }
    }
}