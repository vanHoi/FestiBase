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
    private FestivalCompany festivalCompany;
    private string name;
    private string capacity;

    public Toilet() { }

    public Toilet(int toiletNumber, FestivalCompany festivalCompany, string name, string capacity)
    {
        this.toiletNumber = toiletNumber;
        this.festivalCompany = festivalCompany;
        this.name = name;
        this.capacity = capacity;
    }

    public int ToiletNumber
    {
        get => toiletNumber;
        set => toiletNumber = value;
    }

    public FestivalCompany FestivalCompany
    {
        get => festivalCompany;
        set => festivalCompany = value;
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
}