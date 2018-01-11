namespace Domain
{
    /// <summary>
    /// Summary description for FestivalCompanyFile
    /// </summary>
    public class FestivalCompanyFile
    {
        public FestivalCompanyFile() { }

        public FestivalCompanyFile(int fileNumber, FestivalCompany festivalCompany, string file, string description)
        {
            this.FileNumber = fileNumber;
            this.FestivalCompany = festivalCompany;
            this.File = file;
            this.Description = description;
        }

        public FestivalCompany FestivalCompany { get; set; }

        public int FileNumber { get; set; }

        public string File { get; set; }

        public string Description { get; set; }
    }
}