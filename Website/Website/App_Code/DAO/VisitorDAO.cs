using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for VisitorDAO
/// </summary>
public class VisitorDAO
{
    private SqlConnection conn;

    public VisitorDAO()
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

    public void LoginVisitor(string email)
    {
        try
        {
            SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM Visitor WHERE email = @email", conn);
            command.Parameters.AddWithValue("email", email);
            if (Convert.ToInt32(command.ExecuteScalar()) == 0)
            {
                AddVisitor(email);
            }

            conn.Close();
        }
        catch (Exception e)
        {
            Console.WriteLine(e.ToString());
        }
    }

    public void AddVisitor(string email)
    {
        try
        {
            SqlCommand command = new SqlCommand("EXEC sp_add_or_update_visitor NULL, NULL, @email, NULL, " +
                                                "NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1", conn);
            command.Parameters.AddWithValue("email", email);
            command.ExecuteNonQuery();
            conn.Close();
        }
        catch (Exception e)
        {
            Console.WriteLine(e.ToString());
        }
    }
}