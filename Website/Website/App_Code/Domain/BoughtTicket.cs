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
            Visitor = new Visitor();
        }

        public BoughtTicket(int ticketNumber, TicketType ticketType, 
            string visitorNumber, DateTime scanDate)
        {
            this.TicketNumber = ticketNumber;
            this.TicketType = ticketType;
            this.VisitorNumber = visitorNumber;
            this.ScanDate = scanDate;
        }

        public int TicketNumber { get; set; }

        public TicketType TicketType { get; set; }

        public string VisitorNumber { get; set; }

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