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



    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(tboxTicketNumber.Text))
        {

            Visitor visitor = (Visitor)Session["visitor"];

            _visitorModel.addVisitorToTicket( visitor.VisitorNumber, Convert.ToInt32(tboxTicketNumber.Text));
        }
    }



    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("VisitorOverview.aspx");
    }
}