using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for LockerRented
/// </summary>
public class LockerRented
{
    private int lockerNumber;
    private DateTime startDate;
    private DateTime endDate;
    private int visitorNumber;

    public int LockerNumber
    {
        get => lockerNumber;
        set => lockerNumber = value;
    }

    public DateTime StartDate
    {
        get => startDate;
        set => startDate = value;
    }

    public DateTime EndDate
    {
        get => endDate;
        set => endDate = value;
    }

    public int VisitorNumber
    {
        get => visitorNumber;
        set => visitorNumber = value;
    }

    public LockerRented(int lockerNumber, DateTime startDate, DateTime endDate, int visitorNumber)
    {
        this.lockerNumber = lockerNumber;
        this.startDate = startDate;
        this.endDate = endDate;
        this.visitorNumber = visitorNumber;
    }
}