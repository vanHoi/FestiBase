using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Toilet
/// </summary>
public class Toilet
{
    private int toiletNumber;
    private int festivalCompanyNumber;
    private string name;
    private string capacity;

    public Toilet(int toiletNumber, int festivalCompanyNumber, string name, string capacity)
    {
        this.toiletNumber = toiletNumber;
        this.festivalCompanyNumber = festivalCompanyNumber;
        this.name = name;
        this.capacity = capacity;
    }
}