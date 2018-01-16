namespace Domain
{
    /// <summary>
    /// Summary description for TentFile
    /// </summary>
    public class TentFile
    {
        public TentFile() { }

        public TentFile(int fileNumber, Tent tent, FestivalCompany festivalCompany, string file, string description)
        {
            this.FileNumber = fileNumber;
            this.Tent = tent;
            this.FestivalCompany = festivalCompany;
            this.File = file;
            this.Description = description;
        }

        public int FileNumber { get; set; }

        public Tent Tent { get; set; }

        public FestivalCompany FestivalCompany { get; set; }

        public string File { get; set; }

        public string Description { get; set; }
    }
}