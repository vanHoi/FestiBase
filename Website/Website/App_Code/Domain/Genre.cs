namespace Domain
{
    /// <summary>
    /// Summary description for Genre
    /// </summary>
    public class Genre
    {
        public Genre() { }

        public Genre(int genreNumber, string name)
        {
            this.GenreNumber = genreNumber;
            this.Name = name;
        }

        public int GenreNumber { get; set; }

        public string Name { get; set; }
    }
}