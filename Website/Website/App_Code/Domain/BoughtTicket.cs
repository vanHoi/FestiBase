using System;

namespace Domain
{
    /// <summary>
    /// Summary description for BoughtTicket
    /// </summary>
    public class BoughtTicket
    {
        public BoughtTicket()
        {
            TicketType = new TicketType();
        }

        public BoughtTicket(int ticketNumber, TicketType ticketType, Visitor visitor, DateTime scanDate)
        {
            TicketNumber = ticketNumber;
            TicketType = ticketType;
            Visitor = visitor;
            ScanDate = scanDate;
        }

        public int TicketNumber { get; set; }

        public TicketType TicketType { get; set; }

        public Visitor Visitor { get; set; }

        public DateTime ScanDate { get; set; }

        public void AddFestival(int festivalNumber, string name, DateTime startDate, DateTime endDate)
        {
            TicketType.AddFestival(festivalNumber, name, startDate, endDate);
        }

        public Festival GetFestival()
        {
            return TicketType.GetFestival();
        }
    }
}