namespace Domain
{
    /// <summary>
    /// Summary description for Catering
    /// </summary>
    public class Catering
    {
        public Catering() { }

        public Catering(int cateringNumber, FestivalCompany festivalCompany, string name, bool electricity)
        {
            this.CateringNumber = cateringNumber;
            this.FestivalCompany = festivalCompany;
            this.Name = name;
            this.Electricity = electricity;
        }

        public int CateringNumber { get; set; }

        public FestivalCompany FestivalCompany { get; set; }

        public string Name { get; set; }

        public bool Electricity { get; set; }
    }
}