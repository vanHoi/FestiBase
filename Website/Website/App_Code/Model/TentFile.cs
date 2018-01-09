using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for TentFile
/// </summary>
public class TentFile
{
    private int fileNumber;
    private int tentNumber;
    private int festivalCompanyNumber;
    private string file;
    private string description;

    public int FileNumber
    {
        get => fileNumber;
        set => fileNumber = value;
    }

    public int TentNumber
    {
        get => tentNumber;
        set => tentNumber = value;
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

    public TentFile(int fileNumber, int tentNumber, int festivalCompanyNumber, string file, string description)
    {
        this.fileNumber = fileNumber;
        this.tentNumber = tentNumber;
        this.festivalCompanyNumber = festivalCompanyNumber;
        this.file = file;
        this.description = description;
    }
}