using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for FestivalCompanyFile
/// </summary>
public class FestivalCompanyFile
{
    private int fileNumber;
    private FestivalCompany festivalCompany;
    private string file;
    private string description;

    public FestivalCompanyFile() { }

    public FestivalCompanyFile(int fileNumber, FestivalCompany festivalCompany, string file, string description)
    {
        this.fileNumber = fileNumber;
        this.festivalCompany = festivalCompany;
        this.file = file;
        this.description = description;
    }

    public FestivalCompany FestivalCompany
    {
        get => festivalCompany;
        set => festivalCompany = value;
    }

    public int FileNumber
    {
        get => fileNumber;
        set => fileNumber = value;
    }

    public string File
    {
        get => file;
        set => file = value;
    }

    public string Description
    {
        get => description;
        set => description = value;
    }
}