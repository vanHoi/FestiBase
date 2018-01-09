using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View_MainForm : System.Web.UI.Page
{
    private FestivalModel festivalModel;

    protected void Page_Load(object sender, EventArgs e)
    {
        festivalModel = new FestivalModel();

        foreach (Festival f in festivalModel.getAllFestivals())
        {
            listFestivals.Items.Add(new ListItem(f.Name, f.FestivalNumber.ToString()));
        }
    }

    protected void btnVisitor_Click(object sender, EventArgs e)
    {
        Response.Redirect("VisitorLoginForm.aspx");
    }
}