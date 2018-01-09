using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Tent
/// </summary>
public class Tent
{
    private int tentNumber;
    private int festivalNumber;
    private string name;
    private int width;
    private int length;
    private int sideHeight;
    private int ridgeHeight;
    private int constructionWidth;
    private int constructionLength;
    private string tentType;
    private string color;
    private string floorType;
    private string capacity;

    public int TentNumber
    {
        get => tentNumber;
        set => tentNumber = value;
    }

    public int FestivalNumber
    {
        get => festivalNumber;
        set => festivalNumber = value;
    }

    public string Name
    {
        get => name;
        set => name = value;
    }

    public int Width
    {
        get => width;
        set => width = value;
    }

    public int Length
    {
        get => length;
        set => length = value;
    }

    public int SideHeight
    {
        get => sideHeight;
        set => sideHeight = value;
    }

    public int RidgeHeight
    {
        get => ridgeHeight;
        set => ridgeHeight = value;
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

    public string TentType
    {
        get => tentType;
        set => tentType = value;
    }

    public string Color
    {
        get => color;
        set => color = value;
    }

    public string FloorType
    {
        get => floorType;
        set => floorType = value;
    }

    public string Capacity
    {
        get => capacity;
        set => capacity = value;
    }

    public Tent(int tentNumber, int festivalNumber, string name, int width, int length, int sideHeight, int ridgeHeight, int constructionWidth, int constructionLength, string tentType, string color, string floorType, string capacity)
    {
        this.tentNumber = tentNumber;
        this.festivalNumber = festivalNumber;
        this.name = name;
        this.width = width;
        this.length = length;
        this.sideHeight = sideHeight;
        this.ridgeHeight = ridgeHeight;
        this.constructionWidth = constructionWidth;
        this.constructionLength = constructionLength;
        this.tentType = tentType;
        this.color = color;
        this.floorType = floorType;
        this.capacity = capacity;
    }
}