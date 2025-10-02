using System;
using System.Web;
using System.Web.Routing;

namespace UserCRUDApp
{
    public partial class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RegisterRoutes(RouteTable.Routes);
        }

        void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute("Default", "", "~/Register.aspx");
        }

        void Session_Start(object sender, EventArgs e)
        {
            // Code that runs when a new session is started
        }
    }
}
