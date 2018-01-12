<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Main.aspx.cs" Inherits="Form.FormMain" %>

<!doctype html>
<html lang="nl">
<head runat="server">
    <title>Welkom bij FestiBase!</title>
    <link rel="icon" type="image/png" href="~/Resources/favicon.png">
    <link href="~/Resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="~/Resources/css/style.css" rel="stylesheet" type="text/css" />
    <link href="~/Resources/css/style_main.css" rel="stylesheet" type="text/css" />
</head>
<body class="d-flex flex-column">

    <form id="formStartpagina" runat="server" class="flex-grow">

        <section class="container text-center">

            <h1 class="extra-padding-top-xl">Welkom bij FestiBase!</h1>
        
            <div class="row extra-padding-top-med">
                <div class="col-3"></div>
                <div class="col-6">
                    <div class="form-group text-left">
                        <label>Selecteer uw festival:</label>
                        <asp:DropDownList id="listFestivals" runat="server" CssClass="form-control listbox" Height="80px" >
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-3"></div>
            </div>
            
            <asp:Button ID="btnConfirm" runat="server" Text="Verder" class="btn btn-primary" />

        </section>

        <footer class="container-fluid">
            <div class="row">
                <div class="col">
                    <img src="../Resources/images/logo.png" class="festibase-logo"/>
                </div>
                <div class="col"></div>
                <div class="col text-right align-self-end">
                    <asp:Button ID="btnVisitor" runat="server" Text="Inloggen als bezoeker" OnClick="btnVisitorClick" class="btn btn-primary" />
                </div>
            </div>
        </footer>
    </form>

</body>
</html>
