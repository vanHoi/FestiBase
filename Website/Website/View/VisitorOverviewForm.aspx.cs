using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View_VisitorOverviewForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblVisitor.Text = "Welkom " + Session["email"].ToString();
    }
}