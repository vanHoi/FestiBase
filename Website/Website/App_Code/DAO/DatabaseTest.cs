using System;
using System.IO;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

public class DatabaseTest
{
    private SqlConnection conn;

    public DatabaseTest()
    {
        conn = new SqlConnection(File.ReadAllText(HttpContext.Current.Server.MapPath("~/App_Code/DAO/databaseConnection.txt")));

        try
        {
            conn.Open();
        }
        catch (Exception e)
        {
            Console.WriteLine(e.ToString());
        }
    }

    public string getFestivalbyNumber(int number)
    {
        try
        {
            string festival = "";
            SqlCommand command = new SqlCommand("SELECT * FROM FESTIVAL WHERE festival_number = " + number, conn);
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                festival = String.Format("Festival: {0} start op {1} en eindigt op {2}. Locatie {3}", reader["name"].ToString(),
                    reader["start_date"].ToString(), reader["end_date"].ToString(), reader["location"].ToString());
            }

            conn.Close();
            return festival;
        }
        catch (Exception e)
        {
            Console.WriteLine(e.ToString());
        }

        return null;
    }
}