using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(DotNetWebDeveloperEnlightenment.Startup))]
namespace DotNetWebDeveloperEnlightenment
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
