<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VisitorOverviewForm.aspx.cs" Inherits="View_VisitorOverviewForm" %>

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
        <asp:Button ID="btnAddTicket" runat="server" Text="Ticket toevoegen" />
        <asp:Table ID="Table1" runat="server">
        </asp:Table>
    </form>
</body>
</html>
