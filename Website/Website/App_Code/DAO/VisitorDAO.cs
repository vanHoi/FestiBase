using System;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using Domain;

namespace DAO
{
    /// <summary>
    /// Summary description for VisitorDAO
    /// </summary>
    public class VisitorDAO
    {
        private readonly SqlConnection _conn;

        public VisitorDAO()
        {
            _conn = new SqlConnection(File.ReadAllText(HttpContext.Current.Server.MapPath("~/App_Code/DAO/databaseConnection.txt")));

            try
            {
                _conn.Open();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }
        }

        public Visitor LoginVisitor(string email)
        {
            Visitor visitor = new Visitor();

            try
            {
                if (CheckIfVisitorExists(email))
                {
                    AddVisitor(email);
                }

                SqlCommand command = new SqlCommand("SELECT * FROM Visitor WHERE email = @email", _conn);
                command.Parameters.AddWithValue("email", email);

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    visitor.VisitorNumber = Convert.ToInt32(reader["visitor_number"]);

                    if (reader["email"] != DBNull.Value)
                    {
                        visitor.Email = Convert.ToString(reader["email"]);
                    }

                    if (reader["town_number"] != DBNull.Value)
                    {
                        visitor.Town = new Town
                        {
                            TownNumber = Convert.ToInt32(reader["town_number"])
                        };
                    }

                    if (reader["first_name"] != DBNull.Value)
                    {
                        visitor.FirstName = Convert.ToString(reader["first_name"]);
                    }

                    if (reader["surname"] != DBNull.Value)
                    {
                        visitor.Surname = Convert.ToString(reader["surname"]);
                    }

                    if (reader["telephone_number"] != DBNull.Value)
                    {
                        visitor.TelephoneNumber = Convert.ToString(reader["telephone_number"]);
                    }

                    if (reader["birthdate"] != DBNull.Value)
                    {
                        visitor.Birthdate = Convert.ToDateTime(reader["birthdate"]);
                    }

                    if (reader["twitter_username"] != DBNull.Value)
                    {
                        visitor.TwitterUsername = Convert.ToString(reader["twitter_username"]);
                    }

                    if (reader["facebook_username"] != DBNull.Value)
                    {
                        visitor.FacebookUsername = Convert.ToString(reader["facebook_username"]);
                    }

                    if (reader["street"] != DBNull.Value)
                    {
                        visitor.Street = Convert.ToString(reader["street"]);
                    }

                    if (reader["house_number"] != DBNull.Value)
                    {
                        visitor.HouseNumber = Convert.ToInt32(reader["house_number"]);
                    }   
                }

                _conn.Close();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }

            return visitor;
        }

        private bool CheckIfVisitorExists(string email)
        {
            try
            {
                SqlCommand command = new SqlCommand("SELECT visitor_number FROM Visitor WHERE email = @email", _conn);
                command.Parameters.AddWithValue("email", email);

                return Convert.ToInt32(command.ExecuteScalar()) == 0;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }

            return false;
        }

        private void AddVisitor(string email)
        {
            try
            {
                SqlCommand command = new SqlCommand("EXEC sp_add_or_update_visitor NULL, @email, NULL, NULL, " +
                                                    "NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1", _conn);
                command.Parameters.AddWithValue("email", email);
                command.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }
        }
    }
}