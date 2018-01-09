using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Podium
/// </summary>
public class Podium
{
    private int podiumNumber;
    private int festivalNumber;
    private int tentNumber;
    private string name;
    private int constructionWidth;
    private int constructionLength;
    private int constructionHeight;
    private int floorHeight;
    private int capacity;
    private int floorLoad;
    private int freeSpanWidth;
    private int freeSpanLength;
    private int freeSpanHeight;
    private string environment;
    private List<Genre> playsGenres;

    public int PodiumNumber
    {
        get => podiumNumber;
        set => podiumNumber = value;
    }

    public int FestivalNumber
    {
        get => festivalNumber;
        set => festivalNumber = value;
    }

    public int TentNumber
    {
        get => tentNumber;
        set => tentNumber = value;
    }

    public string Name
    {
        get => name;
        set => name = value;
    }

    public int ConstructionWidth
    {
        get => constructionWidth;
        set => constructionWidth = value;
    }

    public int ConstructionLength
    {
        get => constructionLength;
        set => constructionLength = value;
    }

    public int ConstructionHeight
    {
        get => constructionHeight;
        set => constructionHeight = value;
    }

    public int FloorHeight
    {
        get => floorHeight;
        set => floorHeight = value;
    }

    public int Capacity
    {
        get => capacity;
        set => capacity = value;
    }

    public int FloorLoad
    {
        get => floorLoad;
        set => floorLoad = value;
    }

    public int FreeSpanWidth
    {
        get => freeSpanWidth;
        set => freeSpanWidth = value;
    }

    public int FreeSpanLength
    {
        get => freeSpanLength;
        set => freeSpanLength = value;
    }

    public int FreeSpanHeight
    {
        get => freeSpanHeight;
        set => freeSpanHeight = value;
    }

    public string Environment
    {
        get => environment;
        set => environment = value;
    }

    public List<Genre> PlaysGenres
    {
        get => playsGenres;
        set => playsGenres = value;
    }

    public Podium(int podiumNumber, int festivalNumber, int tentNumber, string name, int constructionWidth, 
        int constructionLength, int constructionHeight, int floorHeight, int capacity, int floorLoad, int freeSpanWidth, 
        int freeSpanLength, int freeSpanHeight, string environment, List<Genre> playsGenres)
    {
        this.podiumNumber = podiumNumber;
        this.festivalNumber = festivalNumber;
        this.tentNumber = tentNumber;
        this.name = name;
        this.constructionWidth = constructionWidth;
        this.constructionLength = constructionLength;
        this.constructionHeight = constructionHeight;
        this.floorHeight = floorHeight;
        this.capacity = capacity;
        this.floorLoad = floorLoad;
        this.freeSpanWidth = freeSpanWidth;
        this.freeSpanLength = freeSpanLength;
        this.freeSpanHeight = freeSpanHeight;
        this.environment = environment;
        this.playsGenres = playsGenres;
    }
}