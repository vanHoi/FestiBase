using Domain;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_AddTicket : System.Web.UI.Page
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
                labelError.Text = " Deze ticket is al gebruikt ";

            }
        }
    }

    protected void btnCancelClick(object sender, EventArgs e)
    {
        Response.Redirect("VisitorOverview.aspx");
    }
}