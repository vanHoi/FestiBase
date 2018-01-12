namespace Domain
{
    /// <summary>
    /// Summary description for CompanyBranch
    /// </summary>
    public class CompanyBranch
    {
        public CompanyBranch() { }

        public CompanyBranch(int branchNumber, Company company, int townNumber, string street, string houseNumber)
        {
            this.BranchNumber = branchNumber;
            this.Company = company;
            this.TownNumber = townNumber;
            this.Street = street;
            this.HouseNumber = houseNumber;
        }

        public int BranchNumber { get; set; }

        public Company Company { get; set; }

        public int TownNumber { get; set; }

        public string Street { get; set; }

        public string HouseNumber { get; set; }
    }
}