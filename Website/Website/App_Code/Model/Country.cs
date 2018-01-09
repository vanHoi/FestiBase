using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Country
/// </summary>
public class Country
{
    private int countryNumber;
    private string name;

    public int CountryNumber
    {
        get => countryNumber;
        set => countryNumber = value;
    }

    public string Name
    {
        get => name;
        set => name = value;
    }

    public Country(int countryNumber, string name)
    {
        this.countryNumber = countryNumber;
        this.name = name;
    }
}