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

    public ArtistFile(int fileNumber, int artistNumber, int festivalCompanyNumber, string file, string description)
    {
        this.fileNumber = fileNumber;
        this.artistNumber = artistNumber;
        this.festivalCompanyNumber = festivalCompanyNumber;
        this.file = file;
        this.description = description;
    }
}