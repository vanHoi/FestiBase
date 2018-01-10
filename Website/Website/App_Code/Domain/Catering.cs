using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Catering
/// </summary>
public class Catering
{
    private int cateringNumber;
    private FestivalCompany festivalCompany;
    private string name;
    private bool electricity;

    public Catering() { }

    public Catering(int cateringNumber, FestivalCompany festivalCompany, string name, bool electricity)
    {
        this.cateringNumber = cateringNumber;
        this.festivalCompany = festivalCompany;
        this.name = name;
        this.electricity = electricity;
    }

    public int CateringNumber
    {
        get => cateringNumber;
        set => cateringNumber = value;
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

    public bool Electricity
    {
        get => electricity;
        set => electricity = value;
    }
}