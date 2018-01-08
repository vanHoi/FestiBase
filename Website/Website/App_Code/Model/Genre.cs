using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Genre
/// </summary>
public class Genre
{
    private int genreNumber;
    private string name;

    public Genre(int genreNumber, string name)
    {
        this.genreNumber = genreNumber;
        this.name = name;
    }
}