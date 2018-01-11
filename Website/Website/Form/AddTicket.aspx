<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddTicket.aspx.cs" Inherits="Form_AddTicket" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>



            <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Annuleren" />



        </div>
        <p>
            &nbsp;</p>
        <p>
            <asp:TextBox ID="tboxTicketNumber" runat="server" Width="301px"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="btnAdd" runat="server" OnClick="btnAdd_Click" Text="Toevoegen" />
        </p>
    </form>
</body>
</html>
