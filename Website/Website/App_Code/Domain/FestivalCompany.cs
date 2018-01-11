using System;

namespace Domain
{
    /// <summary>
    /// Summary description for FestivalCompany
    /// </summary>
    public class FestivalCompany
    {
        public FestivalCompany()
        {
            Festival = new Festival();
            CompanyBranch = new CompanyBranch();
        }

        public FestivalCompany(int festivalCompanyNumber, Festival festival, CompanyBranch companyBranch, string contactPerson, string description, string telephoneNumber)
        {
            this.FestivalCompanyNumber = festivalCompanyNumber;
            this.Festival = festival;
            this.CompanyBranch = companyBranch;
            this.ContactPerson = contactPerson;
            this.Description = description;
            this.TelephoneNumber = telephoneNumber;
        }

        public int FestivalCompanyNumber { get; set; }

        public Festival Festival { get; set; }

        public CompanyBranch CompanyBranch { get; set; }

        public string ContactPerson { get; set; }

        public string Description { get; set; }

        public string TelephoneNumber { get; set; }

        public void AddFestival(int festivalNumber, string name, DateTime startDate, DateTime endDate)
        {
            Festival.FestivalNumber = festivalNumber;
            Festival.Name = name;
            Festival.StartDate = startDate;
            Festival.EndDate = endDate;
        }
    }
}