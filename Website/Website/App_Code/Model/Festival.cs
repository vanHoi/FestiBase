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