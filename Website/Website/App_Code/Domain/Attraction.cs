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
    private FestivalCompany festivalCompany;
    private string name;
    private string attractionType;

    public Attraction() { }

    public Attraction(int attractionNumber, FestivalCompany festivalCompany, string name, string attractionType)
    {
        this.attractionNumber = attractionNumber;
        this.festivalCompany = festivalCompany;
        this.name = name;
        this.attractionType = attractionType;
    }

    public int AttractionNumber
    {
        get => attractionNumber;
        set => attractionNumber = value;
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

    public string AttractionType
    {
        get => attractionType;
        set => attractionType = value;
    }

}