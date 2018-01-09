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
    private int festivalCompanyNumber;
    private string file;
    private string description;

    public int FileNumber
    {
        get => fileNumber;
        set => fileNumber = value;
    }

    public int FestivalCompanyNumber
    {
        get => festivalCompanyNumber;
        set => festivalCompanyNumber = value;
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

    public FestivalCompanyFile(int fileNumber, int festivalCompanyNumber, string file, string description)
    {
        this.fileNumber = fileNumber;
        this.festivalCompanyNumber = festivalCompanyNumber;
        this.file = file;
        this.description = description;
    }
}