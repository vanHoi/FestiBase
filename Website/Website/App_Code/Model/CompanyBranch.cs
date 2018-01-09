using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CompanyBranch
/// </summary>
public class CompanyBranch
{
    private int branchNumber;
    private int cocNumber;
    private int townNumber;
    private string street;
    private string houseNumber;

    public CompanyBranch(int branchNumber, int cocNumber, int townNumber, string street, string houseNumber)
    {
        this.branchNumber = branchNumber;
        this.cocNumber = cocNumber;
        this.townNumber = townNumber;
        this.street = street;
        this.houseNumber = houseNumber;
    }

    public int BranchNumber
    {
        get => branchNumber;
        set => branchNumber = value;
    }

    public int CocNumber
    {
        get => cocNumber;
        set => cocNumber = value;
    }

    public int TownNumber
    {
        get => townNumber;
        set => townNumber = value;
    }

    public string Street
    {
        get => street;
        set => street = value;
    }

    public string HouseNumber
    {
        get => houseNumber;
        set => houseNumber = value;
    }
}