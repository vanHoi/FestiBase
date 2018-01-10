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
    private Company company;
    private int townNumber;
    private string street;
    private string houseNumber;

    public CompanyBranch() { }

    public CompanyBranch(int branchNumber, Company company, int townNumber, string street, string houseNumber)
    {
        this.branchNumber = branchNumber;
        this.company = company;
        this.townNumber = townNumber;
        this.street = street;
        this.houseNumber = houseNumber;
    }

    public int BranchNumber
    {
        get => branchNumber;
        set => branchNumber = value;
    }

    public Company Company
    {
        get => company;
        set => company = value;
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