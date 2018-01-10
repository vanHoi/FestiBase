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
    private Country country;
    private string name;

    public Town() { }

    public Town(int townNumber, Country country, string name)
    {
        this.townNumber = townNumber;
        this.country = country;
        this.name = name;
    }

    public int TownNumber
    {
        get => townNumber;
        set => townNumber = value;
    }

    public Country Country
    {
        get => country;
        set => country = value;
    }

    public string Name
    {
        get => name;
        set => name = value;
    }
}