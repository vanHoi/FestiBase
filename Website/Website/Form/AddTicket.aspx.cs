using System;
using Domain;
using Model;

namespace Form
{
    public partial class FormAddTicket : System.Web.UI.Page
    {
        private VisitorModel _visitorModel;

        protected void Page_Load(object sender, EventArgs e)
        {
            _visitorModel = new VisitorModel();

            if (Session["visitor"] == null)
            {
                Response.Redirect("VisitorLogin.aspx");
            }

        }

        protected void btnAddClick(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(tboxTicketNumber.Text))
            {

                Visitor visitor = (Visitor)Session["visitor"];

                if (_visitorModel.addVisitorToTicket(visitor.VisitorNumber, Convert.ToInt32(tboxTicketNumber.Text)))
                {
                    Session["ticketAdded"] = true;
                    Response.Redirect("VisitorOverview.aspx");
                }

                else
                {
                    labelError.Text = " Dit ticket is al gebruikt ";
                }
            }
        }

        protected void btnCancelClick(object sender, EventArgs e)
        {
            Response.Redirect("VisitorOverview.aspx");
        }
    }
}