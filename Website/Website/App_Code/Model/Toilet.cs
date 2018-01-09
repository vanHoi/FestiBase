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

    public int ToiletNumber
    {
        get => toiletNumber;
        set => toiletNumber = value;
    }

    public int FestivalCompanyNumber
    {
        get => festivalCompanyNumber;
        set => festivalCompanyNumber = value;
    }

    public string Name
    {
        get => name;
        set => name = value;
    }

    public string Capacity
    {
        get => capacity;
        set => capacity = value;
    }

    public Toilet(int toiletNumber, int festivalCompanyNumber, string name, string capacity)
    {
        this.toiletNumber = toiletNumber;
        this.festivalCompanyNumber = festivalCompanyNumber;
        this.name = name;
        this.capacity = capacity;
    }
}