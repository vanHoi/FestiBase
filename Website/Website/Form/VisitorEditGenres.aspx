<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VisitorEditGenres.aspx.cs" Inherits="Form.FormVisitorEditGenres" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mijn Genres Beheren</title>
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
    <form id="formGenresBeheren" runat="server">
        
        <section class="container-fluid">

            <div class="row extra-padding-top-xs">
                <div class="col-9"></div>
                <div class="col-3 text-right">
                    <asp:Button ID="return" runat="server" OnClick="BtnReturn" Text="Terug" CssClass="btn btn-primary btn-primary-small" />
                </div>
            </div>
            <div class="row extra-padding-top-xs">
                <div class="col-12 text-center">
                    <h1 class="no-padding">Genres Beheren</h1>
                    <h3 class="extra-padding-top-xs">
                        We leren u graag beter kennen om zo de artiesten beter te kunnen afstellen op uw wensen.
                        <br />
                        Geef daarom hier uw favoriete genres op!
                    </h3>
                </div>
            </div>

        </section>

        <section class="container text-center">
            
            <div class="row">
                <div class="col-3"></div>
                <div class="col-6">
                    <div class="extra-padding-top-sm table-wrapper">
                        <asp:Panel ID="pnlGenres" runat="server">
                            <div class="row table">
                                <div class="col table-center-vertical">
                                    <span class="table_title">Naam</span>
                                </div>
                                <div class="col table-center-vertical">
                                    <span class="table_title">Like</span>
                                </div>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
                <div class="col-3"></div>
            </div>

        </section>
        
        <footer class="container-fluid"></footer>
        
    </form>
</body>
</html>
