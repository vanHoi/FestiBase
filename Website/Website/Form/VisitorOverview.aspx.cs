using System;
using System.Web.UI.HtmlControls;
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

            Visitor visitor = (Visitor)Session["visitor"];
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
                    HtmlGenericControl divRow = new HtmlGenericControl();
                    divRow.Attributes["class"] = "row tabel";
                    divRow.TagName = "div";

                    HtmlGenericControl divCell = new HtmlGenericControl();
                    divCell.Attributes["class"] = "col tabel-center-verticaal";
                    divCell.TagName = "div";
                    divCell.InnerHtml = b.GetFestival().Name;

                    HtmlGenericControl divCell2 = new HtmlGenericControl();
                    divCell2.Attributes["class"] = "col tabel-center-verticaal";
                    divCell2.TagName = "div";
                    divCell2.InnerHtml = b.TicketType.Type;

                    HtmlGenericControl divCell3 = new HtmlGenericControl(); ;
                    divCell3.Attributes["class"] = "col tabel-center-verticaal";
                    divCell3.TagName = "div";

                    if (b.GetFestival().StartDate.Date == b.GetFestival().EndDate.Date)
                    {
                        divCell3.InnerHtml = b.GetFestival().StartDate.ToString("dd/MM/yyyy");
                    }
                    else
                    {
                        divCell3.InnerHtml = b.GetFestival().StartDate.ToString("dd/MM/yyyy") + " t/m " +
                                                b.GetFestival().EndDate.ToString("dd/MM/yyyy");
                    }

                    HtmlGenericControl divCell4 = new HtmlGenericControl();
                    divCell4.Attributes["class"] = "col tabel-center-verticaal";
                    divCell4.TagName = "div";

                    Button btnProgram = new Button
                    {
                        Text = b.GetFestival().EndDate < DateTime.Now ? "Beheer Bezochte Optredens" : "Bekijk Programma",
                        CssClass = "btn btn-primary btn-primary-small btn-primary-tabel"
                    };


                    btnProgram.Click += btnProgramClick;
                    divCell4.Controls.Add(btnProgram);

                    divRow.Controls.Add(divCell);
                    divRow.Controls.Add(divCell2);
                    divRow.Controls.Add(divCell3);
                    divRow.Controls.Add(divCell4);

                    pnlTickets.Controls.Add(divRow);
                }
        }

        protected void btnProgramClick(object sender, EventArgs e)
        {

        }

        protected void btnLogoutClick(object sender, EventArgs e)
        {
            Session.Remove("visitor");
            Response.Redirect("VisitorLogin.aspx");
        }
    }
}