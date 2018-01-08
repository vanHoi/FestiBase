using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Performance
/// </summary>
public class Performance
{
    private int performanceNumber;
    private int artistNumber;
    private int podiumScheduleNumber;
    private int festivalNumber;
    private DateTime startTime;
    private int playTime;
    private int minPrepTime;

    public Performance(int performanceNumber, int artistNumber, int podiumScheduleNumber, int festivalNumber, 
        DateTime startTime, int playTime, int minPrepTime)
    {
        this.performanceNumber = performanceNumber;
        this.artistNumber = artistNumber;
        this.podiumScheduleNumber = podiumScheduleNumber;
        this.festivalNumber = festivalNumber;
        this.startTime = startTime;
        this.playTime = playTime;
        this.minPrepTime = minPrepTime;
    }
}