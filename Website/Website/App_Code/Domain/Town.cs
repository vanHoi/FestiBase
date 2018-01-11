namespace Domain
{
    /// <summary>
    /// Summary description for Town
    /// </summary>
    public class Town
    {
        public Town() { }

        public Town(int townNumber, Country country, string name)
        {
            this.TownNumber = townNumber;
            this.Country = country;
            this.Name = name;
        }

        public int TownNumber { get; set; }

        public Country Country { get; set; }

        public string Name { get; set; }
    }
}