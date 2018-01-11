<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VisitorOverview.aspx.cs" Inherits="Form.FormVisitorOverview" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>
                <asp:Label ID="lblVisitor" runat="server" Text="Welkom "></asp:Label>
            </h1>
            <p>Hier ziet u een overzicht van uw festivals.</p>

        </div>
        <asp:Button ID="btnAddTicket" runat="server" Text="Ticket toevoegen" OnClick="btnAddTicket_Click"/>
        <asp:Table ID="tblTickets" runat="server" CellPadding="5" CellSpacing="0" GridLines="Both">
            <asp:TableRow runat="server">
                <asp:TableCell runat="server"><b>Festival</b></asp:TableCell>
                <asp:TableCell runat="server"><b>Ticket soort</b></asp:TableCell>
                <asp:TableCell runat="server"><b>Datum</b></asp:TableCell>
                <asp:TableCell runat="server"><b>Programma</b></asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:Button ID="btnLogout" runat="server" Height="30px" OnClick="btnLogoutClick" Text="Uitloggen" Width="108px" />
        <p>
            <asp:Button ID="btnGenre" runat="server" Height="30px" Text="Mijn genres" Width="107px" />
        </p>
    </form>
</body>
</html>
