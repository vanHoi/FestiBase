using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Artist
/// </summary>
public class Artist
{
    private int artistNumber;
    private string name;
    private List<Genre> playsGenres;

    public Artist(int artistNumber, string name, List<Genre> playsGenres)
    {
        this.artistNumber = artistNumber;
        this.name = name;
        this.playsGenres = playsGenres;
    }
}