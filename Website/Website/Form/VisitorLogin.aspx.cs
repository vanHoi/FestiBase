using System;
using Model;

namespace Form
{
    public partial class Form_VisitorLogin : System.Web.UI.Page
    {
        private VisitorModel visitorModel;

        protected void Page_Load(object sender, EventArgs e)
        {
            visitorModel = new VisitorModel();
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Main.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(tboxEmail.Text))
            {
                Session["visitor"] = visitorModel.LoginVisitor(tboxEmail.Text);
                Response.Redirect("VisitorOverview.aspx");
            }
        }
    }
}