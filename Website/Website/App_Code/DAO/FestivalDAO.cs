using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for FestivalDAO
/// </summary>
public class FestivalDAO
{
    private SqlConnection conn;

    public FestivalDAO()
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

    public Festival getFestivalbyNumber(int number)
    {
        try
        {
            Festival festival = null;
            SqlCommand command = new SqlCommand("SELECT * FROM FESTIVAL WHERE festival_number = " + number, conn);
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                festival = new Festival(Convert.ToInt32(reader["festival_number"]),
                    Convert.ToInt32(reader["organisation_number"]),
                    Convert.ToString(reader["name"]),
                    Convert.ToDateTime(reader["start_date"]),
                    Convert.ToDateTime(reader["end_date"]),
                    Convert.ToString(reader["location"]),
                    Convert.ToDouble(reader["token_price"]));
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

    public List<Festival> getAllFestivals()
    {
        try
        {
            List<Festival> festivals = new List<Festival>();

            SqlCommand command = new SqlCommand("SELECT * FROM FESTIVAL", conn);
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                Festival festival = new Festival(Convert.ToInt32(reader["festival_number"]),
                    Convert.ToInt32(reader["organisation_number"]),
                    Convert.ToString(reader["name"]),
                    Convert.ToDateTime(reader["start_date"]),
                    Convert.ToDateTime(reader["end_date"]),
                    Convert.ToString(reader["location"]),
                    Convert.ToDouble(reader["token_price"]));
                festivals.Add(festival);
            }

            conn.Close();
            return festivals;
        }
        catch (Exception e)
        {
            Console.WriteLine(e.ToString());
        }

        return null;
    }
}