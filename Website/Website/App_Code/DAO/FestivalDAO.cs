﻿ using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using Domain;

namespace DAO
{
    /// <summary>
    /// Summary description for FestivalDAO
    /// </summary>
    public class FestivalDAO
    {
        private readonly SqlConnection _conn;

        public FestivalDAO()
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

        public Festival GetFestivalbyNumber(int number)
        {
            try
            {
                Festival festival = null;
                SqlCommand command = new SqlCommand("SELECT * FROM FESTIVAL WHERE festival_number = " + number, _conn);
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    festival = new Festival(Convert.ToInt32(reader["festival_number"]),
                        new Organisation(),
                        Convert.ToString(reader["name"]),
                        Convert.ToDateTime(reader["start_date"]),
                        Convert.ToDateTime(reader["end_date"]),
                        Convert.ToString(reader["location"]),
                        Convert.ToDouble(reader["token_price"]))
                    {
                        Organisation = {OrganisationNumber = Convert.ToInt32(reader["organisation_number"])}
                    };

                }

                _conn.Close();
                return festival;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }

            return null;
        }

        public List<Festival> GetAllFestivals()
        {
            List<Festival> festivals = new List<Festival>();
            try
            {

                SqlCommand command = new SqlCommand("SELECT * FROM FESTIVAL", _conn);
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Festival festival = new Festival(Convert.ToInt32(reader["festival_number"]),
                        new Organisation(),
                        Convert.ToString(reader["name"]),
                        Convert.ToDateTime(reader["start_date"]),
                        Convert.ToDateTime(reader["end_date"]),
                        Convert.ToString(reader["location"]),
                        Convert.ToDouble(reader["token_price"]))
                    {
                        Organisation = {OrganisationNumber = Convert.ToInt32(reader["organisation_number"])}
                    };

                    festivals.Add(festival);
                }

                _conn.Close();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }
            return festivals;

        }
    }
}