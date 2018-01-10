using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Festival
/// </summary>
public class Festival
{
    private int festivalNumber;
    private Organisation organisation;
    private string name;
    private DateTime startDate;
    private DateTime endDate;
    private string location;
    private double tokenPrice;

    public Festival()
    {
        organisation = new Organisation();
    }

    public Festival(int festivalNumber, Organisation organisation, string name, DateTime startDate, 
        DateTime endDate, string location, double tokenPrice)
    {
        this.festivalNumber = festivalNumber;
        this.organisation = organisation;
        this.name = name;
        this.startDate = startDate;
        this.endDate = endDate;
        this.location = location;
        this.tokenPrice = tokenPrice;
    }

    public int FestivalNumber
    {
        get => festivalNumber;
        set => festivalNumber = value;
    }

    public Organisation Organisation
    {
        get => organisation;
        set => organisation = value;
    }

    public string Name
    {
        get => name;
        set => name = value;
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

    public string Location
    {
        get => location;
        set => location = value;
    }

    public double TokenPrice
    {
        get => tokenPrice;
        set => tokenPrice = value;
    }
}