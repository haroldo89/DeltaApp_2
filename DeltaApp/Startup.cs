using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(DeltaApp.Startup))]
namespace DeltaApp
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
