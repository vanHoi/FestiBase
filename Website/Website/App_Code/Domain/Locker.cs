using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Locker
/// </summary>
public class Locker
{
    private int lockerNumber;
    private FestivalCompany festivalCompany;

    public Locker() { }

    public Locker(int lockerNumber, FestivalCompany festivalCompany)
    {
        this.lockerNumber = lockerNumber;
        this.festivalCompany = festivalCompany;
    }

    public int LockerNumber
    {
        get => lockerNumber;
        set => lockerNumber = value;
    }

    public FestivalCompany FestivalCompany
    {
        get => festivalCompany;
        set => festivalCompany = value;
    }
}