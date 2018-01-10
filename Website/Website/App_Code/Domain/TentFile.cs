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
    private Tent tent;
    private FestivalCompany festivalCompany;
    private string file;
    private string description;

    public TentFile() { }

    public TentFile(int fileNumber, Tent tent, FestivalCompany festivalCompany, string file, string description)
    {
        this.fileNumber = fileNumber;
        this.tent = tent;
        this.festivalCompany = festivalCompany;
        this.file = file;
        this.description = description;
    }

    public int FileNumber
    {
        get => fileNumber;
        set => fileNumber = value;
    }

    public Tent Tent
    {
        get => tent;
        set => tent = value;
    }

    public FestivalCompany FestivalCompany
    {
        get => festivalCompany;
        set => festivalCompany = value;
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