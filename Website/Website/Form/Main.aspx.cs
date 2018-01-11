using System;
using System.Web.UI.WebControls;
using Domain;
using Model;

namespace Form
{
    public partial class Form_Main : System.Web.UI.Page
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
            Response.Redirect("VisitorLogin.aspx");
        }
    }
}