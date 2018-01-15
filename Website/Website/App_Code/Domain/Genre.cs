namespace Domain
{
    /// <summary>
    /// Summary description for Genre
    /// </summary>
    public class Genre
    {
        public Genre() { }

        public Genre(int genreNumber, string name, int visitorNumber = 0)
        {
            this.GenreNumber = genreNumber;
            this.Name = name;
            this.VisitorNumber = visitorNumber;
        }

        public int GenreNumber { get; set; }

        public string Name { get; set; }

        public int VisitorNumber { get; set; }
    }
}