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

    public Company(int cocNumber, string name)
    {
        this.cocNumber = cocNumber;
        this.name = name;
    }
}