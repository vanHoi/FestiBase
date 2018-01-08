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

    public TentFile(int fileNumber, int tentNumber, int festivalCompanyNumber, string file, string description)
    {
        this.fileNumber = fileNumber;
        this.tentNumber = tentNumber;
        this.festivalCompanyNumber = festivalCompanyNumber;
        this.file = file;
        this.description = description;
    }
}