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
    private int organisationNumber;
    private string name;
    private DateTime startDate;
    private DateTime endDate;
    private string location;
    private double tokenPrice;

    public int FestivalNumber
    {
        get => festivalNumber;
        set => festivalNumber = value;
    }

    public int OrganisationNumber
    {
        get => organisationNumber;
        set => organisationNumber = value;
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

    public Festival(int festivalNumber, int organisationNumber, string name, DateTime startDate, DateTime endDate, string location, double tokenPrice)
    {
        this.festivalNumber = festivalNumber;
        this.organisationNumber = organisationNumber;
        this.name = name;
        this.startDate = startDate;
        this.endDate = endDate;
        this.location = location;
        this.tokenPrice = tokenPrice;
    }
}