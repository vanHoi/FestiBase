using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Test : System.Web.UI.Page
{
    DatabaseTest databaseTest;
    string festivalDetails;

    protected void Page_Load(object sender, EventArgs e)
    {
        databaseTest = new DatabaseTest();
        festivalDetails = "";
    }

    public string getFestivalFromDatabase(int number)
    {
        return databaseTest.getFestivalbyNumber(number);
    }

    public string getFestivalDetails()
    {
        return festivalDetails;
    }

    protected void btnFestival_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrWhiteSpace(tbFestivalNumber.Text))
        {
            festivalDetails = getFestivalFromDatabase(Convert.ToInt32(tbFestivalNumber.Text));
        }
    }
}