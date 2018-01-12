<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VisitorLogin.aspx.cs" Inherits="Form.FormVisitorLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inloggen als Bezoeker</title>
    <link rel="icon" type="image/png" href="~/Resources/favicon.png">
    <link href="~/Resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="~/Resources/css/bootstrap_overrides.css" rel="stylesheet" type="text/css" />
    <link href="~/Resources/css/style.css" rel="stylesheet" type="text/css" />
    <link href="~/Resources/css/style_visitor.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="formLoginBezoeker" runat="server">
        
        <section class="container text-center">

            <h1>Welkom bezoeker!</h1>

            <h3 class="extra-padding-top-sm">Geef uw emailadres op om door te gaan:</h3>
            
            <div class="row extra-padding-top-sm">
                <div class="col-3"></div>
                <div class="col-6">
                    <div class="form-group text-left">
                        <label>E-mailadres:</label>
                        <asp:TextBox ID="tboxEmail" runat="server" TextMode="Email" CssClass="form-control" ></asp:TextBox>
                    </div>
                </div>
                <div class="col-3"></div>
            </div>
            
            <asp:Button ID="btnLogin" runat="server" OnClick="btnLoginClick" Text="Inloggen" CssClass="btn btn-primary" />
            
        </section>
            
        <footer class="container-fluid extra-padding-top-med">
            <div class="row">
                <div class="col">
                    <img src="../Resources/images/logo.png" width="250" height="200"/>
                </div>
                <div class="col"></div>
                <div class="col text-right align-self-end">
                    <asp:Button ID="btnReturn" runat="server" Text="Terug" OnClick="btnReturnClick" class="btn btn-primary" />
                </div>
            </div>
        </footer>

    </form>
</body>
</html>
