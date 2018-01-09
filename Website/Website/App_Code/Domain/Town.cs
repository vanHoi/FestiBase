using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Town
/// </summary>
public class Town
{
    private int townNumber;
    private int countryNumber;
    private string name;

    public Town(int townNumber, int countryNumber, string name)
    {
        this.townNumber = townNumber;
        this.countryNumber = countryNumber;
        this.name = name;
    }

    public int TownNumber
    {
        get => townNumber;
        set => townNumber = value;
    }

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
}