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
        private GenreModel _genreModel;

        protected void Page_Load(object sender, EventArgs e)
        {
            _visitorModel = new VisitorModel();
            _genreModel = new GenreModel();

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
                    HtmlGenericControl li = new HtmlGenericControl("li") { InnerText = g.Name };

                    Button update = new Button { CommandArgument = Convert.ToString(g.GenreNumber) };

                    if (g.VisitorNumber != 0)
                    {
                        update.Text = "Unlike";
                        update.Click += BtnUpdateGenreUnlike;
                    }
                    else
                    {
                        update.Text = "Like";
                        update.Click += BtnUpdateGenreLike;
                    }
                    update.OnClientClick = "return Confirm();";
                    li.Controls.Add(update);

                    genres_list.Controls.Add(li);
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