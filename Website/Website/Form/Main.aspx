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

        <div>
            <h1 class="extra_padding_top_max">Welkom bij FestiBase!</h1>
        </div>
        
        <div class="row extra_padding_top_max">
            <div class="col"></div>
            <div class="col">
                <div class="form-group">
                    <label class="text-left">Selecteer uw festival:</label>
                    <asp:DropDownList id="listFestivals" runat="server" CssClass="form-control" >
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col"></div>
        </div>
            
        <asp:Button ID="btnConfirm" runat="server" Text="Verder" class="btn btn-primary" />

    </section>

    <footer class="container-fluid extra_padding_top_med">
        <div class="row">
            <div class="col">
                <img src="../Resources/images/logo.png" width="250" height="200"/>
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
