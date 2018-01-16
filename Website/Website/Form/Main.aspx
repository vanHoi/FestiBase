<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Main.aspx.cs" Inherits="Form.FormMain" %>

<!doctype html>
<html lang="nl">
<head runat="server">
    <title>Welkom bij FestiBase!</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="theme-color" content="#160e2f">
    <link rel="icon" type="image/png" href="~/Resources/favicon.png">
    <link href="~/Resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="~/Resources/css/bootstrap_overrides.css" rel="stylesheet" type="text/css" />
    <link href="~/Resources/css/style.css" rel="stylesheet" type="text/css" />
    <link href="~/Resources/css/style_main.css" rel="stylesheet" type="text/css" />
</head>
<body>

    <form id="formStartpagina" runat="server">

        <section class="container text-center">

            <h1 class="extra-padding-top-xl">Welkom bij FestiBase!</h1>

        </section>
        
        <div class="clearfix"></div>

        <footer>
            <div class="container text-center">

                <div class="row">
                    <div class="col-3"></div>
                    <div class="col-6">
                        <div class="form-group text-left">
                            <label>Selecteer uw festival:</label>
                            <asp:DropDownList ID="listFestivals" runat="server" CssClass="form-control" Height="80px">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-3"></div>
                </div>

                <asp:Button ID="btnConfirm" runat="server" Text="Verder" class="btn btn-primary" />
            </div>
            
            <div class="clearfix"></div>

            <div class="container-fluid">
                <div class="row">
                    <div class="col">
                        <img src="../Resources/images/logo.png" class="festibase-logo" />
                    </div>
                    <div class="col"></div>
                    <div class="col text-right align-self-end">
                        <asp:Button ID="btnVisitor" runat="server" Text="Inloggen als Bezoeker" OnClick="btnVisitorClick" class="btn btn-primary" />
                    </div>
                </div>
            </div>
        </footer>

    </form>

</body>
</html>
