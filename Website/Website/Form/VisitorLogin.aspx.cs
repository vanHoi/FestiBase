using System;
using System.Net.Mail;
using Model;

namespace Form
{
    public partial class FormVisitorLogin : System.Web.UI.Page
    {
        private VisitorModel _visitorModel;

        protected void Page_Load(object sender, EventArgs e)
        {
            _visitorModel = new VisitorModel();
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Main.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(tboxEmail.Text) && IsValidEmail(tboxEmail.Text))
            {
                Session["visitor"] = _visitorModel.LoginVisitor(tboxEmail.Text);
                Response.Redirect("VisitorOverview.aspx");
            }
        }

        private bool IsValidEmail(string email)
        {
            MailAddress mailAddress = new MailAddress(email);
            return mailAddress.Address == email;
        }
    }
}