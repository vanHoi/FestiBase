using System;

namespace Domain
{
    /// <summary>
    /// Summary description for PodiumSchedule
    /// </summary>
    public class PodiumSchedule
    {
        public PodiumSchedule() { }

        public PodiumSchedule(int podiumScheduleNumber, Podium podium, DateTime startDate, DateTime startTime, 
            DateTime endDate, DateTime endTime, int breakTime)
        {
            this.PodiumScheduleNumber = podiumScheduleNumber;
            this.Podium = podium;
            this.StartDate = startDate;
            this.StartTime = startTime;
            this.EndDate = endDate;
            this.EndTime = endTime;
            this.BreakTime = breakTime;
        }

        public int PodiumScheduleNumber { get; set; }

        public Podium Podium { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime StartTime { get; set; }

        public DateTime EndDate { get; set; }

        public DateTime EndTime { get; set; }

        public int BreakTime { get; set; }
    }
}