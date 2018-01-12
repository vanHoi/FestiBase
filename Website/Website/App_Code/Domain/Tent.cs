namespace Domain
{
    /// <summary>
    /// Summary description for Tent
    /// </summary>
    public class Tent
    {
        public Tent() { }

        public Tent(int tentNumber, Festival festival, string name, int width, int length, int sideHeight, int ridgeHeight, 
            int constructionWidth, int constructionLength, string tentType, string color, string floorType, string capacity)
        {
            this.TentNumber = tentNumber;
            this.Festival = festival;
            this.Name = name;
            this.Width = width;
            this.Length = length;
            this.SideHeight = sideHeight;
            this.RidgeHeight = ridgeHeight;
            this.ConstructionWidth = constructionWidth;
            this.ConstructionLength = constructionLength;
            this.TentType = tentType;
            this.Color = color;
            this.FloorType = floorType;
            this.Capacity = capacity;
        }

        public int TentNumber { get; set; }

        public Festival Festival { get; set; }

        public string Name { get; set; }

        public int Width { get; set; }

        public int Length { get; set; }

        public int SideHeight { get; set; }

        public int RidgeHeight { get; set; }

        public int ConstructionWidth { get; set; }

        public int ConstructionLength { get; set; }

        public string TentType { get; set; }

        public string Color { get; set; }

        public string FloorType { get; set; }

        public string Capacity { get; set; }
    }
}