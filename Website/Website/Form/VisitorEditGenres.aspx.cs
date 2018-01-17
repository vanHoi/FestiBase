using System;
using System.Collections.Generic;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Domain;
using Model;

namespace Form
{
    public partial class FormVisitorEditGenres : System.Web.UI.Page
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

            if ( visitor != null )
            {
                List<Genre> visitorGenres = _visitorModel.GetGenresOfVisitor(visitor.VisitorNumber);

                foreach (Genre g in visitorGenres)
                {
                    HtmlGenericControl divRow = new HtmlGenericControl();
                    divRow.Attributes["class"] = "row table";
                    divRow.TagName = "div";

                    HtmlGenericControl divCell = new HtmlGenericControl();
                    divCell.Attributes["class"] = "col table-center-vertical";
                    divCell.TagName = "div";
                    divCell.InnerHtml = g.Name;

                    HtmlGenericControl divCell2 = new HtmlGenericControl();
                    divCell2.Attributes["class"] = "col table-center-vertical";
                    divCell2.TagName = "div";

                    Button btnGenre = new Button
                    {
                        CommandArgument = Convert.ToString(g.GenreNumber),
                        Text = g.VisitorNumber != 0 ? "Unlike" : "Like",
                        CssClass = "btn btn-primary btn-primary-small btn-primary-table"
                    };

                    if (g.VisitorNumber != 0)
                    {
                        btnGenre.Click += BtnUpdateGenreUnlike;
                    }
                    else
                    {
                        btnGenre.Click += BtnUpdateGenreLike;
                    }

                    divCell2.Controls.Add(btnGenre);

                    divRow.Controls.Add(divCell);
                    divRow.Controls.Add(divCell2);

                    pnlGenres.Controls.Add(divRow);
                }

            }

        }

        protected void BtnUpdateGenreLike(object sender, EventArgs e)
        {
            Button button = (Button)sender;
            int id = Convert.ToInt32(button.CommandArgument);
            Visitor visitor = (Visitor)Session["visitor"];
            _visitorModel.AddLikedGenre(visitor.VisitorNumber, id);
            this.Refresh();
        }

        protected void BtnUpdateGenreUnlike(object sender, EventArgs e)
        {
            Button button = (Button)sender;
            int id = Convert.ToInt32(button.CommandArgument);
            Visitor visitor = (Visitor)Session["visitor"];
            _visitorModel.DeleteLikedGenre(visitor.VisitorNumber, id);
            this.Refresh();
        }

        protected void Refresh()
        {
            Response.Redirect("VisitorEditGenres.aspx");
        }

        protected void BtnReturn(object sender, EventArgs e)
        {
            Response.Redirect("VisitorOverview.aspx");
        }
    }
}