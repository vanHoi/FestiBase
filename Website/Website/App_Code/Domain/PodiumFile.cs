using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PodiumFile
/// </summary>
public class PodiumFile
{
    private int fileNumber;
    private Podium podium;
    private FestivalCompany festivalCompany;
    private string file;
    private string description;

    public PodiumFile() { }

    public PodiumFile(int fileNumber, Podium podium, FestivalCompany festivalCompany, string file, string description)
    {
        this.fileNumber = fileNumber;
        this.podium = podium;
        this.festivalCompany = festivalCompany;
        this.file = file;
        this.description = description;
    }

    public int FileNumber
    {
        get => fileNumber;
        set => fileNumber = value;
    }

    public Podium Podium
    {
        get => podium;
        set => podium = value;
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