namespace Domain
{
    /// <summary>
    /// Summary description for Attraction
    /// </summary>
    public class Attraction
    {
        public Attraction() { }

        public Attraction(int attractionNumber, FestivalCompany festivalCompany, string name, string attractionType)
        {
            this.AttractionNumber = attractionNumber;
            this.FestivalCompany = festivalCompany;
            this.Name = name;
            this.AttractionType = attractionType;
        }

        public int AttractionNumber { get; set; }

        public FestivalCompany FestivalCompany { get; set; }

        public string Name { get; set; }

        public string AttractionType { get; set; }
    }
}