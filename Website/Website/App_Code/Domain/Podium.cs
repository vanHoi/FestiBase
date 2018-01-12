using System.Collections.Generic;

namespace Domain
{
    /// <summary>
    /// Summary description for Podium
    /// </summary>
    public class Podium
    {
        public Podium() { }

        public Podium(int podiumNumber, Festival festival, Tent tent, string name, int constructionWidth, int constructionLength, int constructionHeight, int floorHeight, int capacity, int floorLoad, int freeSpanWidth, int freeSpanLength, int freeSpanHeight, string environment)
        {
            this.PodiumNumber = podiumNumber;
            this.Festival = festival;
            this.Tent = tent;
            this.Name = name;
            this.ConstructionWidth = constructionWidth;
            this.ConstructionLength = constructionLength;
            this.ConstructionHeight = constructionHeight;
            this.FloorHeight = floorHeight;
            this.Capacity = capacity;
            this.FloorLoad = floorLoad;
            this.FreeSpanWidth = freeSpanWidth;
            this.FreeSpanLength = freeSpanLength;
            this.FreeSpanHeight = freeSpanHeight;
            this.Environment = environment;
        }

        public Podium(int podiumNumber, Festival festival, Tent tent, string name, int constructionWidth, int constructionLength, 
            int constructionHeight, int floorHeight, int capacity, int floorLoad, int freeSpanWidth, int freeSpanLength, 
            int freeSpanHeight, string environment, List<Genre> playsGenres)
        {
            this.PodiumNumber = podiumNumber;
            this.Festival = festival;
            this.Tent = tent;
            this.Name = name;
            this.ConstructionWidth = constructionWidth;
            this.ConstructionLength = constructionLength;
            this.ConstructionHeight = constructionHeight;
            this.FloorHeight = floorHeight;
            this.Capacity = capacity;
            this.FloorLoad = floorLoad;
            this.FreeSpanWidth = freeSpanWidth;
            this.FreeSpanLength = freeSpanLength;
            this.FreeSpanHeight = freeSpanHeight;
            this.Environment = environment;
            this.PlaysGenres = playsGenres;
        }

        public int PodiumNumber { get; set; }

        public Festival Festival { get; set; }

        public Tent Tent { get; set; }

        public string Name { get; set; }

        public int ConstructionWidth { get; set; }

        public int ConstructionLength { get; set; }

        public int ConstructionHeight { get; set; }

        public int FloorHeight { get; set; }

        public int Capacity { get; set; }

        public int FloorLoad { get; set; }

        public int FreeSpanWidth { get; set; }

        public int FreeSpanLength { get; set; }

        public int FreeSpanHeight { get; set; }

        public string Environment { get; set; }

        public List<Genre> PlaysGenres { get; set; }
    }
}