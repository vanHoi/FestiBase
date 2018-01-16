namespace Domain
{
    /// <summary>
    /// Summary description for Locker
    /// </summary>
    public class Locker
    {
        public Locker() { }

        public Locker(int lockerNumber, FestivalCompany festivalCompany)
        {
            this.LockerNumber = lockerNumber;
            this.FestivalCompany = festivalCompany;
        }

        public int LockerNumber { get; set; }

        public FestivalCompany FestivalCompany { get; set; }
    }
}