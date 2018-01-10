using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_VisitorOverview : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["visitor"] == null)
        {
            Response.Redirect("VisitorLogin.aspx");
        }
        else
        {
            Visitor visitor = (Visitor) Session["visitor"];
            if (String.IsNullOrEmpty(visitor.FirstName))
            {
                lblVisitor.Text = "Welkom!";
            }
            else
            {
                lblVisitor.Text = "Welkom " + visitor.FirstName;
            }
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Remove("visitorNumber");
        Response.Redirect("VisitorLogin.aspx");
    }
}