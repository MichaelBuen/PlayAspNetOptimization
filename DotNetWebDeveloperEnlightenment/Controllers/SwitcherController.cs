using System.Web.Http;

namespace DotNetWebDeveloperEnlightenment.Controllers
{
    public class SwitcherController : ApiController
    {                
        public ToSwitch Post(ToSwitch toSwitch)
        {
            return new ToSwitch { Autobot = toSwitch.Decepticon, Decepticon = toSwitch.Autobot };

        }

        public class ToSwitch
        {
            public string Autobot { get; set; }
            public string Decepticon { get; set; }
        }

    }
}