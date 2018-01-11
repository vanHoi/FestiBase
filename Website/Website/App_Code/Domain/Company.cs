namespace Domain
{
    /// <summary>
    /// Summary description for Company
    /// </summary>
    public class Company
    {
        public Company() { }

        public Company(int cocNumber, string name)
        {
            this.CocNumber = cocNumber;
            this.Name = name;
        }

        public int CocNumber { get; set; }

        public string Name { get; set; }
    }
}