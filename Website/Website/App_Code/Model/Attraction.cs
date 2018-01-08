using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Attraction
/// </summary>
public class Attraction
{
    private int attractionNumber;
    private int festivalCompanyNumber;
    private string name;
    private string attractionType;

    public Attraction(int attractionNumber, int festivalCompanyNumber, string name, string attractionType)
    {
        this.attractionNumber = attractionNumber;
        this.festivalCompanyNumber = festivalCompanyNumber;
        this.name = name;
        this.attractionType = attractionType;
    }
}