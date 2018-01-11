namespace Domain
{
    /// <summary>
    /// Summary description for Toilet
    /// </summary>
    public class Toilet
    {
        public Toilet() { }

        public Toilet(int toiletNumber, FestivalCompany festivalCompany, string name, string capacity)
        {
            this.ToiletNumber = toiletNumber;
            this.FestivalCompany = festivalCompany;
            this.Name = name;
            this.Capacity = capacity;
        }

        public int ToiletNumber { get; set; }

        public FestivalCompany FestivalCompany { get; set; }

        public string Name { get; set; }

        public string Capacity { get; set; }
    }
}