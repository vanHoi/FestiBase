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
    private int festivalCompanyNumber;

    public Locker(int lockerNumber, int festivalCompanyNumber)
    {
        this.lockerNumber = lockerNumber;
        this.festivalCompanyNumber = festivalCompanyNumber;
    }
}