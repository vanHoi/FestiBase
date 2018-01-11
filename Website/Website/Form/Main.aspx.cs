using System;
using System.Web.UI.WebControls;
using Domain;
using Model;

namespace Form
{
    public partial class FormMain : System.Web.UI.Page
    {
        private FestivalModel _festivalModel;

        protected void Page_Load(object sender, EventArgs e)
        {
            _festivalModel = new FestivalModel();
            listFestivals.Items.Clear();

            foreach (Festival f in _festivalModel.GetAllFestivals())
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