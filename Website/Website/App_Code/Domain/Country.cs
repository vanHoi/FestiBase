namespace Domain
{
    /// <summary>
    /// Summary description for Country
    /// </summary>
    public class Country
    {
        public Country() { }

        public Country(int countryNumber, string name)
        {
            this.CountryNumber = countryNumber;
            this.Name = name;
        }

        public int CountryNumber { get; set; }

        public string Name { get; set; }
    }
}