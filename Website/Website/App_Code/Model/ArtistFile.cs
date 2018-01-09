using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ArtistFile
/// </summary>
public class ArtistFile
{
    private int fileNumber;
    private int artistNumber;
    private int festivalCompanyNumber;
    private string file;
    private string description;

    public int FileNumber
    {
        get => fileNumber;
        set => fileNumber = value;
    }

    public int ArtistNumber
    {
        get => artistNumber;
        set => artistNumber = value;
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

    public ArtistFile(int fileNumber, int artistNumber, int festivalCompanyNumber, string file, string description)
    {
        this.fileNumber = fileNumber;
        this.artistNumber = artistNumber;
        this.festivalCompanyNumber = festivalCompanyNumber;
        this.file = file;
        this.description = description;
    }
}