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
    private Festival festival;
    private CompanyBranch companyBranch;
    private string contactPerson;
    private string description;
    private string telephoneNumber;

    public FestivalCompany()
    {
        festival = new Festival();
        companyBranch = new CompanyBranch();
    }

    public FestivalCompany(int festivalCompanyNumber, Festival festival, CompanyBranch companyBranch, string contactPerson, string description, string telephoneNumber)
    {
        this.festivalCompanyNumber = festivalCompanyNumber;
        this.festival = festival;
        this.companyBranch = companyBranch;
        this.contactPerson = contactPerson;
        this.description = description;
        this.telephoneNumber = telephoneNumber;
    }

    public int FestivalCompanyNumber
    {
        get => festivalCompanyNumber;
        set => festivalCompanyNumber = value;
    }

    public Festival Festival
    {
        get => festival;
        set => festival = value;
    }

    public CompanyBranch CompanyBranch
    {
        get => companyBranch;
        set => companyBranch = value;
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

    public void addFestival(int festivalNumber, string name, DateTime startDate, DateTime endDate)
    {
        festival.FestivalNumber = festivalNumber;
        festival.Name = name;
        festival.StartDate = startDate;
        festival.EndDate = endDate;
    }
}