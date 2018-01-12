using System;

namespace Domain
{
    /// <summary>
    /// Summary description for LockerRented
    /// </summary>
    public class LockerRented
    {
        public LockerRented() { }

        public LockerRented(Locker locker, DateTime startDate, DateTime endDate, Visitor visitor)
        {
            this.Locker = locker;
            this.StartDate = startDate;
            this.EndDate = endDate;
            this.Visitor = visitor;
        }

        public Locker Locker { get; set; }

        public Visitor Visitor { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime EndDate { get; set; }
    }
}