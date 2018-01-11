using System;

namespace Domain
{
    /// <summary>
    /// Summary description for TicketType
    /// </summary>
    public class TicketType
    {
        public TicketType()
        {
            FestivalCompany = new FestivalCompany();
        }

        public TicketType(FestivalCompany festivalCompany, string type, double ticketPrice, DateTime dateValidFrom,
            DateTime dateValidTo)
        {
            this.FestivalCompany = festivalCompany;
            this.Type = type;
            this.TicketPrice = ticketPrice;
            this.DateValidFrom = dateValidFrom;
            this.DateValidTo = dateValidTo;
        }

        public FestivalCompany FestivalCompany { get; set; }

        public string Type { get; set; }

        public double TicketPrice { get; set; }

        public DateTime DateValidFrom { get; set; }

        public DateTime DateValidTo { get; set; }

        public void addFestival(int festivalNumber, string name, DateTime startDate, DateTime endDate)
        {
            FestivalCompany.addFestival(festivalNumber, name, startDate, endDate);
        }

        public Festival getFestival()
        {
            return FestivalCompany.Festival;
        }
    }
}