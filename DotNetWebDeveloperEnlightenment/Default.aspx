<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DotNetWebDeveloperEnlightenment.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

        <script src="Scripts/jquery-1.10.2.min.js"></script>

    <script>
            



        $(function () {

            $('#uxCallback').click(function () {

                var js = JSON.stringify({ Autobot: $('#uxAutobotLeader').val(), Decepticon: $('#uxDecepticonLeader').val()});
                CallServer(js, null);

                return false;
            });



            // WebMethod way...

            $('#uxWebMethod').click(function () {

                //// we can do it the raw way like the following. jsonString should match the name of the parameter in the page's WebMethod
                //var js = JSON.stringify({ jsonString: JSON.stringify({ Autobot: $('#uxAutobotLeader').val(), Decepticon: $('#uxDecepticonLeader').val() }) });

                //$.ajax({
                //    type: 'POST',
                //    url: '/Default.aspx/SwitchLeaders',
                //    data: js,
                //    contentType: 'application/json; charset=utf-8',
                //    dataType: 'json',
                //    success: function (response) {


                //            $('#uxAutobotLeader').val(response.d.Autobot);
                //            $('#uxDecepticonLeader').val(response.d.Decepticon);
                //    }
                //});




                // or alternatively, we can do it with idiomatic ASP.NET way:
                // Just enable the EnablePageMethods of the ScriptManager instance before we can use PageMethods
                // http://decoding.wordpress.com/2008/11/14/aspnet-how-to-call-a-server-side-method-from-client-side-javascript/

                var js = JSON.stringify({ Autobot: $('#uxAutobotLeader').val(), Decepticon: $('#uxDecepticonLeader').val() });
                                
                PageMethods.SwitchLeaders(js, function (response) {
                    console.log(response);
                    $('#uxAutobotLeader').val(response.Autobot);
                    $('#uxDecepticonLeader').val(response.Decepticon);
                });
                
                
                return false;
            });


            // ...WebMethod way


            // WebAPI way...

            $('#uxWebApi').click(function () {

                var js = JSON.stringify({ Autobot: $('#uxAutobotLeader').val(), Decepticon: $('#uxDecepticonLeader').val() });


                $.ajax({
                    type: 'POST',
                    url: '/api/Switcher',
                    data: js,
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function (response) {


                        $('#uxAutobotLeader').val(response.Autobot);
                        $('#uxDecepticonLeader').val(response.Decepticon);
                    }
                });


                return false;
            });

            // ...WebAPI way

        }); // document ready

        
        // ASP.NET callbacks pollutes the global namespace

        function ReceiveServerData(rValue) {            
            var js = $.parseJSON(rValue);

            $('#uxAutobotLeader').val(js.Autobot);
            $('#uxDecepticonLeader').val(js.Decepticon);


        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <div></div>
        <div></div>
        <div></div>
        <div></div>
    
        Autobot Leader:
        <asp:TextBox ID="uxAutobotLeader" runat="server" ClientIDMode="Static">Optimus Prime</asp:TextBox>
        <div></div>
        <div></div>
        Decepticon Leader:
        <asp:TextBox ID="uxDecepticonLeader" runat="server" ClientIDMode="Static">Megatron</asp:TextBox>
        <div></div>
        <div></div>
        <div></div>
        <asp:Button ID="uxPostback" runat="server" OnClick="uxPostback_Click" Text="Switch using Postback" Width="211px" />
        <div></div>
        <div></div>
        <asp:Button ID="uxCallback" runat="server" Text="Switch using Callback" Width="212px" ClientIDMode="Static"/>
        
        <div></div>
        <div></div>
        <asp:Button ID="uxWebMethod" runat="server" Text="Switch using WebMethod" Width="213px" />
        <div></div>
        <div></div>
        <asp:Button ID="uxWebApi" runat="server" Text="Switch using ASP.NET Web API" Width="213px" />
        <div></div>

        <hr />
    
        <div></div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                Autobot Vice Leader:
                <asp:TextBox ID="uxAutobotViceLeader" runat="server">Bumble Bee</asp:TextBox>
        <div></div>
        <div></div>
                Decepticon Vice Leader:
                <asp:TextBox ID="uxDecepticonViceLeader" runat="server">Starscream</asp:TextBox>
                <div></div>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
                </asp:ScriptManager>
                <div></div>
        <div></div>
        
                <asp:Button ID="uxUpdatePanel" runat="server" OnClick="uxUpdatePanel_Click" Text="Switch using UpdatePanel" />
                <div></div>
                <div></div>
                <div></div>
            </ContentTemplate>
        </asp:UpdatePanel>
    
    </div>
        <p>
            &nbsp;</p>
        <p>
            <asp:TextBox ID="uxLongTextbox" runat="server"></asp:TextBox>
        </p>
    </form>
</body>
</html>
