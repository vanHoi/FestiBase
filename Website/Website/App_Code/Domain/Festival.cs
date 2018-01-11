using System;

namespace Domain
{
    /// <summary>
    /// Summary description for Festival
    /// </summary>
    public class Festival
    {
        public Festival()
        {
            Organisation = new Organisation();
        }

        public Festival(int festivalNumber, Organisation organisation, string name, DateTime startDate, 
            DateTime endDate, string location, double tokenPrice)
        {
            this.FestivalNumber = festivalNumber;
            this.Organisation = organisation;
            this.Name = name;
            this.StartDate = startDate;
            this.EndDate = endDate;
            this.Location = location;
            this.TokenPrice = tokenPrice;
        }

        public int FestivalNumber { get; set; }

        public Organisation Organisation { get; set; }

        public string Name { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime EndDate { get; set; }

        public string Location { get; set; }

        public double TokenPrice { get; set; }
    }
}