using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for FestivalCompany
/// </summary>
public class FestivalCompany
{
    private int festivalCompanyNumber;
    private int festivalNumber;
    private int branchNumber;
    private string contactPerson;
    private string description;
    private string telephoneNumber;

    public int FestivalCompanyNumber
    {
        get => festivalCompanyNumber;
        set => festivalCompanyNumber = value;
    }

    public int FestivalNumber
    {
        get => festivalNumber;
        set => festivalNumber = value;
    }

    public int BranchNumber
    {
        get => branchNumber;
        set => branchNumber = value;
    }

    public string ContactPerson
    {
        get => contactPerson;
        set => contactPerson = value;
    }

    public string Description
    {
        get => description;
        set => description = value;
    }

    public string TelephoneNumber
    {
        get => telephoneNumber;
        set => telephoneNumber = value;
    }

    public FestivalCompany(int festivalCompanyNumber, int festivalNumber, int branchNumber, string contactPerson, string description, string telephoneNumber)
    {
        this.festivalCompanyNumber = festivalCompanyNumber;
        this.festivalNumber = festivalNumber;
        this.branchNumber = branchNumber;
        this.contactPerson = contactPerson;
        this.description = description;
        this.telephoneNumber = telephoneNumber;
    }
}