using System;
using System.Web.UI.WebControls;
using Domain;
using Model;

namespace Form
{
    public partial class FormVisitorOverview : System.Web.UI.Page
    {
        private VisitorModel _visitorModel;

        protected void Page_Load(object sender, EventArgs e)
        {
            _visitorModel = new VisitorModel();

            if (Session["visitor"] == null)
            {
                Response.Redirect("VisitorLogin.aspx");
            }

            Visitor visitor = (Visitor) Session["visitor"];
            if (String.IsNullOrEmpty(visitor?.FirstName))
            {
                lblVisitor.Text = "Welkom!";
            }
            else
            {
                lblVisitor.Text = "Welkom " + visitor.FirstName + "!";
            }

            if (visitor != null)
                foreach (BoughtTicket b in _visitorModel.GetAllBoughtTicketsOfVisitor(visitor.VisitorNumber))
                {
                    TableRow row = new TableRow();

                    TableCell cell = new TableCell {Text = b.GetFestival().Name};

                    TableCell cell2 = new TableCell {Text = b.TicketType.Type};

                    TableCell cell3 = new TableCell();
                    if (b.GetFestival().StartDate.Date == b.GetFestival().EndDate.Date)
                    {
                        cell3.Text = b.GetFestival().StartDate.ToString("dd/MM/yyyy");
                    }
                    else
                    {
                        cell3.Text = b.GetFestival().StartDate.ToString("dd/MM/yyyy") + " t/m " +
                                     b.GetFestival().EndDate.ToString("dd/MM/yyyy");
                    }


                    TableCell cell4 = new TableCell();
                    Button btnProgram = new Button
                    {
                        Text = b.GetFestival().EndDate < DateTime.Now ? "Beheer bezochte optredens" : "Bekijk programma"
                    };


                    btnProgram.Click += btnProgram_Click;
                    cell4.Controls.Add(btnProgram);

                    row.Cells.Add(cell);
                    row.Cells.Add(cell2);
                    row.Cells.Add(cell3);
                    row.Cells.Add(cell4);

                    tblTickets.Rows.Add(row);
                }
        }

        protected void btnProgram_Click(object sender, EventArgs e)
        {

        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("visitor");
            Response.Redirect("VisitorLogin.aspx");
        }
    }
}