using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Test : Page
{
    DatabaseTest databaseTest;

	protected void Page_Load(object sender, EventArgs e)
    {
        databaseTest = new DatabaseTest();
    }

    public string getFestival(int number){
        return databaseTest.getFestivalbyNumber(number);
    }
}
