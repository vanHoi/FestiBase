using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Company
/// </summary>
public class Company
{
    private int cocNumber;
    private string name;

    public Company() { }

    public Company(int cocNumber, string name)
    {
        this.cocNumber = cocNumber;
        this.name = name;
    }

    public int CocNumber
    {
        get => cocNumber;
        set => cocNumber = value;
    }

    public string Name
    {
        get => name;
        set => name = value;
    }

}