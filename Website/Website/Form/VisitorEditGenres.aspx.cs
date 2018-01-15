using System;
using Domain;
using Model;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

public partial class Form_VisitorEditGenres : System.Web.UI.Page
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
            List<Genre> genres = _genreModel.getAllGenres();
            List<Genre> visitorGenres = _visitorModel.GetGenresOfVisitor(visitor.VisitorNumber);
            foreach (Genre g in genres)
            {
                HtmlGenericControl li = new HtmlGenericControl("li");
                li.InnerText = g.Name;

                bool like = false;
                Button update = new Button();
                update.CommandArgument = Convert.ToString(g.GenreNumber);
                foreach (Genre vg in visitorGenres)
                {
                    if(g.GenreNumber == vg.GenreNumber)
                    {
                        like = true;
                    }
                }
                if (like)
                {
                    update.Text = "You like dis!";
                    update.Click += new EventHandler(btnUpdateGenreUnlike);
                }
                else
                {
                    update.Text = "Do you like dis?";
                    update.Click += new EventHandler(btnUpdateGenreLike);
                }
                update.OnClientClick = "return Confirm();";
                
                li.Controls.Add(update);


                genres_list.Controls.Add(li);
            }
        }

    }

    protected void btnUpdateGenreLike(object sender, EventArgs e)
    {
        Button button = (Button)sender;
        int id = Convert.ToInt32(button.CommandArgument);
        Visitor visitor = (Visitor)Session["visitor"];
        _visitorModel.addLikedGenre(visitor.VisitorNumber, id);
        this.refresh();
    }

    protected void btnUpdateGenreUnlike(object sender, EventArgs e)
    {
        Button button = (Button)sender;
        int id = Convert.ToInt32(button.CommandArgument);
        Visitor visitor = (Visitor)Session["visitor"];
        _visitorModel.deleteLikedGenre(visitor.VisitorNumber, id);
        this.refresh();
    }

    protected void refresh()
    {
        Response.Redirect("VisitorEditGenres.aspx");
    }

    protected void btnReturn(object sender, EventArgs e)
    {
        Response.Redirect("VisitorOverview.aspx");
    }
}