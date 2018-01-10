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
    private int podiumNumber;
    private int festivalCompanyNumber;
    private string file;
    private string description;

    public PodiumFile(int fileNumber, int podiumNumber, int festivalCompanyNumber, string file, string description)
    {
        this.fileNumber = fileNumber;
        this.podiumNumber = podiumNumber;
        this.festivalCompanyNumber = festivalCompanyNumber;
        this.file = file;
        this.description = description;
    }

    public int FileNumber
    {
        get => fileNumber;
        set => fileNumber = value;
    }

    public int PodiumNumber
    {
        get => podiumNumber;
        set => podiumNumber = value;
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

}