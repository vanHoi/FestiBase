<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MainForm.aspx.cs" Inherits="View_MainForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1><asp:Label ID="Label1" runat="server" Text="Welkom bij FestiBase!"></asp:Label></h1>
        </div>
        <p>
            <asp:Label ID="Label2" runat="server" Text="Selecteer een festival:"></asp:Label>
        </p>
        <asp:DropDownList ID="listFestivals" runat="server" Width="200px">
        </asp:DropDownList>
        <p>
            <asp:Button ID="btnConfirm" runat="server" Height="46px" Text="Verder" Width="149px" />
        </p>
    </form>
</body>
</html>
