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