using Newtonsoft.Json;

using System;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DotNetWebDeveloperEnlightenment
{
    public partial class Default : System.Web.UI.Page, ICallbackEventHandler
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string cbReference = Page.ClientScript.GetCallbackEventReference(this, "arg", "ReceiveServerData", "context");

            string callbackScript = "function CallServer(arg, context)" + "{ " + cbReference + ";}";

            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "CallServer", callbackScript, addScriptTags: true);



            if(!this.Page.IsPostBack)
            {
                uxLongTextbox.Text = new string('x', 42 * 1024);
            }

        }

        // Postback approach
        protected void uxPostback_Click(object sender, EventArgs e)
        {
            SwitchLeader(uxAutobotLeader, uxDecepticonLeader);
        }

        // UpdatePanel approach
        protected void uxUpdatePanel_Click(object sender, EventArgs e)
        {
            SwitchLeader(uxAutobotViceLeader, uxDecepticonViceLeader);            
        }


        // Shared code between postback approach and UpdatePanel approach
        static void SwitchLeader(TextBox uxAutobotLeader, TextBox uxDecepticonLeader)
        {
            string temp = uxAutobotLeader.Text;
            uxAutobotLeader.Text = uxDecepticonLeader.Text;
            uxDecepticonLeader.Text = temp;
        }



        // Callback aproach..
        ToSwitch _toSwitch;
        void ICallbackEventHandler.RaiseCallbackEvent(string eventArgument)
        {
            _toSwitch = JsonConvert.DeserializeObject<ToSwitch>(eventArgument);            
        }

        string ICallbackEventHandler.GetCallbackResult()
        {
            return JsonConvert.SerializeObject(new ToSwitch { Autobot = _toSwitch.Decepticon, Decepticon = _toSwitch.Autobot });
        }
        //..Callback approach



        // Unlike ASP.NET Web API, we can't pass whole object(a.k.a. DTO) to WebMethod. So just have to pass it as string and let DeserializeObject make it strongly-typed
        [WebMethod]
        public static ToSwitch SwitchLeaders(string jsonString)
        {
            var toSwitch = JsonConvert.DeserializeObject<ToSwitch>(jsonString);           
            
            return new ToSwitch { Autobot = toSwitch.Decepticon, Decepticon = toSwitch.Autobot };

        }


        // Shared class between Callback and WebMethod approach
        public class ToSwitch
        {
            public string Autobot { get; set; }
            public string Decepticon { get; set; }
        }
    }
}