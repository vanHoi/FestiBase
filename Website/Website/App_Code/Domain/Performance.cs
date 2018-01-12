using System;

namespace Domain
{
    /// <summary>
    /// Summary description for Performance
    /// </summary>
    public class Performance
    {
        public Performance() { }

        public Performance(int performanceNumber, Artist artist, PodiumSchedule podiumSchedule, Festival festival, DateTime startTime, int playTime, int minPrepTime)
        {
            this.PerformanceNumber = performanceNumber;
            this.Artist = artist;
            this.PodiumSchedule = podiumSchedule;
            this.Festival = festival;
            this.StartTime = startTime;
            this.PlayTime = playTime;
            this.MinPrepTime = minPrepTime;
        }

        public int PerformanceNumber { get; set; }

        public Artist Artist { get; set; }

        public PodiumSchedule PodiumSchedule { get; set; }

        public Festival Festival { get; set; }

        public DateTime StartTime { get; set; }

        public int PlayTime { get; set; }

        public int MinPrepTime { get; set; }
    }
}