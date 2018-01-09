using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View_VisitorLogin : System.Web.UI.Page
{
    private VisitorModel visitorModel;

    protected void Page_Load(object sender, EventArgs e)
    {
        visitorModel = new VisitorModel();
    }

    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("MainForm.aspx");
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(tboxEmail.Text))
        {
            visitorModel.loginVisitor(tboxEmail.Text);
            Session["email"] = tboxEmail.Text;
            Response.Redirect("VisitorOverviewForm.aspx");
        }
    }
}