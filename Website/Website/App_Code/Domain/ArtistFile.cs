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
    private Artist artist;
    private FestivalCompany festivalCompany;
    private string file;
    private string description;

    public ArtistFile() { }

    public ArtistFile(int fileNumber, Artist artist, FestivalCompany festivalCompany, string file, string description)
    {
        this.fileNumber = fileNumber;
        this.artist = artist;
        this.festivalCompany = festivalCompany;
        this.file = file;
        this.description = description;
    }

    public int FileNumber
    {
        get => fileNumber;
        set => fileNumber = value;
    }

    public Artist Artist
    {
        get => artist;
        set => artist = value;
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