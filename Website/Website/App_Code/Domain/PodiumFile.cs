namespace Domain
{
    /// <summary>
    /// Summary description for PodiumFile
    /// </summary>
    public class PodiumFile
    {
        public PodiumFile() { }

        public PodiumFile(int fileNumber, Podium podium, FestivalCompany festivalCompany, string file, string description)
        {
            this.FileNumber = fileNumber;
            this.Podium = podium;
            this.FestivalCompany = festivalCompany;
            this.File = file;
            this.Description = description;
        }

        public int FileNumber { get; set; }

        public Podium Podium { get; set; }

        public FestivalCompany FestivalCompany { get; set; }

        public string File { get; set; }

        public string Description { get; set; }
    }
}