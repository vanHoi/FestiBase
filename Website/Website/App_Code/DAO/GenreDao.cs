using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using Domain;

namespace DAO
{
    /// <summary>
    /// Summary description for GenreDAO
    /// </summary>
    public class GenreDAO
    {
        private readonly SqlConnection _conn;
        public GenreDAO()
        {
            _conn = new SqlConnection(File.ReadAllText(HttpContext.Current.Server.MapPath("~/App_Code/DAO/databaseConnection.txt")));

            try
            {
                this.Open();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }
        }

        public void Open()
        {
            try
            {
                if (_conn != null && _conn.State == ConnectionState.Closed)
                {
                    _conn.Open();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }
        
        }

        internal List<Genre> GetGenresOfVisitor(int visitorNumber)
        {
            List<Genre> genres = new List<Genre>();
            try
            {
                this.Open();
                SqlCommand command = new SqlCommand("EXEC sp_get_genres_of_visitor @visitor_number", _conn);
                command.Parameters.AddWithValue("visitor_number", visitorNumber);

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Genre genre = new Genre(Convert.ToInt32(reader["genre_number"]), Convert.ToString(reader["genre"]));
                    genres.Add(genre);
                }

                _conn.Close();
            }
            catch(Exception e)
            {
                Console.WriteLine(e.ToString());
            }
            return genres;
        }

        public List<Genre> GetAllGenres()
        {
            List<Genre> genres = new List<Genre>();
            try
            {
                this.Open();
                SqlCommand command = new SqlCommand("EXEC sp_get_all_genres", _conn);
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Genre genre = new Genre(Convert.ToInt32(reader["genre_number"]),
                        Convert.ToString(reader["genre"]));
                    genres.Add(genre);
                }

                _conn.Close();
            }
            catch(Exception e)
            {
                Console.WriteLine(e.ToString());
            }
            return genres;
        }

        public void DeleteLikedGenre(int genreNumber, int visitorNumber)
        {
            try
            {
                this.Open();
                SqlCommand command = new SqlCommand("EXEC sp_delete_genre_preference_visitor @visitor_number, @genre_number", _conn);
                command.Parameters.AddWithValue("visitor_number", visitorNumber);
                command.Parameters.AddWithValue("genre_number", genreNumber);
                command.ExecuteNonQuery();
                _conn.Close();
            }
            catch(Exception e)
            {
                Console.WriteLine(e.ToString());
            }
        }

        public void AddLikedGenre(int genreNumber, int visitorNumber)
        {
            try
            {
                this.Open();
                SqlCommand command = new SqlCommand("EXEC sp_add_genre_preference_visitor @visitor_number, @genre_number", _conn);
                command.Parameters.AddWithValue("visitor_number", visitorNumber);
                command.Parameters.AddWithValue("genre_number", genreNumber);
                command.ExecuteNonQuery();
                _conn.Close();
            }
            catch(Exception e)
            {
                Console.WriteLine(e.ToString());
            }
        }

        public void Close()
        {
        }
    }
}