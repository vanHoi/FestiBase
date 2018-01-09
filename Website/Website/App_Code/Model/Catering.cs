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
    private int festivalCompanyNumber;
    private string name;
    private bool electricity;

    public int CateringNumber
    {
        get => cateringNumber;
        set => cateringNumber = value;
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

    public bool Electricity
    {
        get => electricity;
        set => electricity = value;
    }

    public Catering(int cateringNumber, int festivalCompanyNumber, string name, bool electricity)
    {
        this.cateringNumber = cateringNumber;
        this.festivalCompanyNumber = festivalCompanyNumber;
        this.name = name;
        this.electricity = electricity;
    }
}