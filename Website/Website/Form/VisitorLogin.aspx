<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VisitorLogin.aspx.cs" Inherits="Form.FormVisitorLogin" %>

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
        <asp:TextBox ID="tboxEmail" runat="server" Width="220px" TextMode="Email"></asp:TextBox>
        <p>
            <asp:Button ID="btnLogin" runat="server" OnClick="btnLoginClick" Text="Inloggen" />
        </p>
        <asp:Button ID="btnReturn" runat="server" OnClick="btnReturnClick" Text="Terug" />
    </form>
</body>
</html>
