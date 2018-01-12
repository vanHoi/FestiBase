<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Main.aspx.cs" Inherits="Form.FormMain" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Welkom bij FestiBase!</h1>
        </div>
        <p>Selecteer een festival:</p>

        <asp:DropDownList ID="listFestivals" runat="server" Width="200px">
        </asp:DropDownList>
        <p>
            <asp:Button ID="btnConfirm" runat="server" Height="35px" Text="Verder" Width="180px" />
        </p>
        <p>
            <asp:Button ID="btnVisitor" runat="server" Height="35px" Text="Inloggen als bezoeker" Width="180px" OnClick="btnVisitorClick" />
        </p>
    </form>
</body>
</html>
