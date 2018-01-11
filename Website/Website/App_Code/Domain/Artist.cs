using System.Collections.Generic;

namespace Domain
{
    /// <summary>
    /// Summary description for Artist
    /// </summary>
    public class Artist
    {
        public Artist() { }

        public Artist(int artistNumber, string name)
        {
            this.ArtistNumber = artistNumber;
            this.Name = name;
        }

        public Artist(int artistNumber, string name, List<Genre> playsGenres)
        {
            this.ArtistNumber = artistNumber;
            this.Name = name;
            this.PlaysGenres = playsGenres;
        }

        public int ArtistNumber { get; set; }

        public string Name { get; set; }

        public List<Genre> PlaysGenres { get; set; }
    }
}