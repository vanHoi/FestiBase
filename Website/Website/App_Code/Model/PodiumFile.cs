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
}