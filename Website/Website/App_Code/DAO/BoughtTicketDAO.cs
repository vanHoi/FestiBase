using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using Domain;

namespace DAO
{
    /// <summary>
    /// Summary description for BoughtTicketDAO
    /// </summary>
    public class BoughtTicketDAO
    {
        private readonly SqlConnection _conn;

        public BoughtTicketDAO()
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

        public List<BoughtTicket> GetAllBoughtTicketsOfVisitor(int visitorNumber)
        {
            try
            {
                List<BoughtTicket> boughtTickets = new List<BoughtTicket>();
                SqlCommand command = new SqlCommand("SELECT f.festival_number, f.name, f.start_date, f.end_date, b.ticket_type FROM FESTIVAL f " +
                                                    "INNER JOIN FESTIVAL_COMPANY fc ON fc.festival_number = f.festival_number " +
                                                    "INNER JOIN TICKET_TYPE t ON t.festival_company_number = fc.festival_company_number " +
                                                    "INNER JOIN BOUGHT_TICKET b ON b.festival_company_number = t.festival_company_number AND b.ticket_type = t.ticket_type " +
                                                    "INNER JOIN VISITOR v ON v.visitor_number = b.visitor_number " +
                                                    "WHERE v.visitor_number = @visitorNumber " +
                                                    " ORDER BY f.start_date DESC", _conn);

                command.Parameters.AddWithValue("visitorNumber", visitorNumber);

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    BoughtTicket boughtTicket = new BoughtTicket();
                    boughtTicket.AddFestival(Convert.ToInt32(reader["festival_number"]), Convert.ToString(reader["name"]),
                        Convert.ToDateTime(reader["start_date"]), Convert.ToDateTime(reader["end_date"]));
                    boughtTicket.TicketType.Type = Convert.ToString(reader["ticket_type"]);

                    boughtTickets.Add(boughtTicket);
                }

                _conn.Close();
                return boughtTickets;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }

            return null;
        }
    }
}