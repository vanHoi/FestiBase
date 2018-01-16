<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VisitorOverview.aspx.cs" Inherits="Form.FormVisitorOverview" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Bezoeker Hoofdscherm</title>
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
  <form id="formBezoekerHoofdscherm" runat="server">

        <section class="container-fluid">

            <div class="row extra-padding-top-xs">
                <div class="col-9"></div>
                <div class="col-3 text-right">
                    <asp:Button ID="btnLogout" runat="server" OnClick="btnLogoutClick" Text="Uitloggen" CssClass="btn btn-primary btn-primary-small" />
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row extra-padding-top-xs">
                <div class="col-3"></div>
                <div class="col-6 text-center">
                    <h1 class="no-padding">
                        <asp:Label ID="lblVisitor" runat="server" Text="Welkom "></asp:Label></h1>
                </div>
                <div class="col-3 text-right">
                    <asp:Button ID="btnGenre" runat="server" Text="Mijn genres" OnClick="btnGenreEdit" CssClass="btn btn-primary btn-primary-small" />
                </div>
            </div>

        </section>

        <section class="container text-center">

            <h3 class="extra-padding-top-sm">Hier ziet u een overzicht van uw festivals.</h3>

            <div class="extra-padding-top-sm">
                <asp:Button ID="btnAddTicket" runat="server" Text="Ticket Toevoegen" CssClass="btn btn-primary btn-primary-big" />
            </div>

            <div class="extra-padding-top-sm table-wrapper">
                <asp:Panel ID="pnlTickets" runat="server">
                    <div class="row table">
                        <div class="col table-center-vertical">
                            <span class="table_title">Festival</span>
                        </div>
                        <div class="col table-center-vertical">
                            <span class="table_title">Ticket Soort</span>
                        </div>
                        <div class="col table-center-vertical">
                            <span class="table_title">Datum</span>
                        </div>
                        <div class="col table-center-vertical">
                            <span class="table_title">Programma</span>
                        </div>
                    </div>
                </asp:Panel>
            </div>

            <footer class="container-fluid"></footer>

        </section>
    </form>
</body>
</html>
