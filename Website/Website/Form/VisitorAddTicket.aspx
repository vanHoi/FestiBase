<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VisitorAddTicket.aspx.cs" Inherits="Form.FormAddTicket" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Nieuw Ticket Toevoegen</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="theme-color" content="#160e2f">
    <link rel="icon" type="image/png" href="~/Resources/favicon.png">
    <link href="~/Resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="~/Resources/css/bootstrap_overrides.css" rel="stylesheet" type="text/css" />
    <link href="~/Resources/css/style.css" rel="stylesheet" type="text/css" />
    <link href="~/Resources/css/style_visitor.css" rel="stylesheet" type="text/css" />
</head>
<body>
<form id="formAddTicket" runat="server">
    
    <section class="container-fluid">

        <div class="row extra-padding-top-xs">
            <div class="col-9"></div>
            <div class="col-3 text-right">
                <asp:Button ID="btnCancel" runat="server" OnClick="btnCancelClick" Text="Annuleren" CssClass="btn btn-primary btn-primary-small" />
            </div>
        </div>
        <div class="row extra-padding-top-xs">
            <div class="col-12 text-center">
                <h1 class="no-padding">Ticket Toevoegen</h1>
                <h3 class="extra-padding-top-xs">
                    Nieuw festivalticket gekocht?
                    <br />
                    Voeg hem hieronder toe aan uw FestiBase account!
                </h3>
                
                <h3 class="extra-padding-top-xs text-danger">
                    <asp:Label ID="labelError" runat="server"></asp:Label>
                </h3>
                
                <div class="row">
                    <div class="col-3"></div>
                    <div class="col-6">
                        <div class="form-group text-left">
                            <label>Ticketnummer:</label>
                            <asp:TextBox ID="tboxTicketNumber" runat="server" CssClass="form-control" ></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-3"></div>
                </div>

                <asp:Button ID="btnAdd" runat="server" OnClick="btnAddClick" Text="Toevoegen" CssClass="btn btn-primary" />

            </div>
        </div>

    </section>
    
</form>
</body>
</html>