<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VisitorLogin.aspx.cs" Inherits="Form.Form_VisitorLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Welkom bezoeker!</h1>
            <p>Geef uw emailadres op om door te gaan:</p>
        </div>
        <asp:TextBox ID="tboxEmail" runat="server" Width="220px"></asp:TextBox>
        <p>
            <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Inloggen" />
        </p>
        <asp:Button ID="btnReturn" runat="server" OnClick="btnReturn_Click" Text="Terug" />
    </form>
</body>
</html>
