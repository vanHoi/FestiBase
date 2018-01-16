<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VisitorEditGenres.aspx.cs" Inherits="Form.FormVisitorEditGenres" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Genres Beheren</h1>
            <p>
                We leren u graag beter kennen om zo de artiesten beter te kunnen afstellen op uw wensen.
                <br />
                Geef daarom hier uw favoriete genres op!
            </p>
        </div>
        <div>
            <ul runat="server" id="genres_list">
            </ul>
        </div>
        <asp:Button ID="return" runat="server" OnClick="BtnReturn" Text="Terug" />
    </form>
</body>
</html>
