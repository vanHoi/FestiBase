<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Main.aspx.cs" Inherits="Form.FormMain" %>

<!doctype html>
<html lang="nl">
<head runat="server">
    <title>Welkom bij FestiBase!</title>
    <link href="~/Resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="~/Resources/css/style.css" rel="stylesheet" type="text/css" />
    <link href="~/Resources/css/style_main.css" rel="stylesheet" type="text/css" />
</head>
<body>

<div class="container text-center">
    <form id="form1" runat="server">
        <div>
            <h1>Welkom bij FestiBase!</h1>
        </div>
        
        <br/><br/><br/>

        <p>Selecteer uw festival:</p>

        <asp:DropDownList ID="listFestivals" runat="server" Width="200px">
        </asp:DropDownList>
        <p>
            
        <asp:Button ID="btnConfirm" runat="server" Text="Verder" class="btn btn-primary" />
    </form>
    </div>
<div class="container-fluid text-right">
    <div class="text-right">
        <asp:Button ID="btnVisitor" runat="server" Text="Inloggen als bezoeker" OnClick="btnVisitor_Click" class="btn btn-primary" />
    </div>
</div>

</body>
</html>
