<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Test.aspx.cs" Inherits="Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <p><%= getFestivalDetails() %></p>

        </div>
            Voer festival nummer in en druk daarna op ok: <asp:TextBox ID="tbFestivalNumber" runat="server"></asp:TextBox>


        <p>
        <asp:Button ID="btnFestival" runat="server" Height="35px" OnClick="btnFestival_Click" Text="Ok" Width="121px" />
        </p>
    </form>
</body>
</html>
