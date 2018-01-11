﻿using System;
using System.Web.UI.WebControls;
using Domain;
using Model;

namespace Form
{
    public partial class Form_VisitorOverview : System.Web.UI.Page
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
                lblVisitor.Text = "Welkom " + visitor.FirstName;
            }

            if (visitor != null)
                foreach (BoughtTicket b in _visitorModel.getAllBoughtTicketsOfVisitor(visitor.VisitorNumber))
                {
                    TableRow row = new TableRow();

                    TableCell cell = new TableCell {Text = b.getFestival().Name};

                    TableCell cell2 = new TableCell {Text = b.TicketType.Type};

                    TableCell cell3 = new TableCell();
                    if (b.getFestival().StartDate.Date == b.getFestival().EndDate.Date)
                    {
                        cell3.Text = b.getFestival().StartDate.ToString("dd/MM/yyyy");
                    }
                    else
                    {
                        cell3.Text = b.getFestival().StartDate.ToString("dd/MM/yyyy") + " t/m " +
                                     b.getFestival().EndDate.ToString("dd/MM/yyyy");
                    }


                    TableCell cell4 = new TableCell();
                    Button btnProgram = new Button
                    {
                        Text = b.getFestival().EndDate < DateTime.Now ? "Beheer bezochte optredens" : "Bekijk programma"
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
            Session.Remove("visitorNumber");
            Response.Redirect("VisitorLogin.aspx");
        }

        protected void btnAddTicket_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddTicket.aspx");
        }
    }
}