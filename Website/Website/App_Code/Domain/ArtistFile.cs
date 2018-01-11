namespace Domain
{
    /// <summary>
    /// Summary description for ArtistFile
    /// </summary>
    public class ArtistFile
    {
        public ArtistFile() { }

        public ArtistFile(int fileNumber, Artist artist, FestivalCompany festivalCompany, string file, string description)
        {
            this.FileNumber = fileNumber;
            this.Artist = artist;
            this.FestivalCompany = festivalCompany;
            this.File = file;
            this.Description = description;
        }

        public int FileNumber { get; set; }

        public Artist Artist { get; set; }

        public FestivalCompany FestivalCompany { get; set; }

        public string File { get; set; }

        public string Description { get; set; }
    }
}