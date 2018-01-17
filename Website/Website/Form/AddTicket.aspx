<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddTicket.aspx.cs" Inherits="Form.FormAddTicket" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<form id="form1" runat="server">
    <div>



        <asp:Button ID="btnCancel" runat="server" OnClick="btnCancelClick" Text="Annuleren" />

        <h1> Ticket Toevoegen</h1>

        <h2> Nieuwe festivalticket gekocht?</h2>
        <h2> Voeg hem hieronder toe aan uw FestiBase account!</h2>

    </div>
    <p>
        <asp:Label ID="labelError" runat="server"></asp:Label>
    </p>
    <p>
        <asp:TextBox ID="tboxTicketNumber" runat="server" Width="301px"></asp:TextBox>
    </p>
    <p>
        <asp:Button ID="btnAdd" runat="server" OnClick="btnAddClick" Text="Toevoegen" />
    </p>
</form>
</body>
</html>