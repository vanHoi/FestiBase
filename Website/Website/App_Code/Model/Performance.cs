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

    public int PerformanceNumber
    {
        get => performanceNumber;
        set => performanceNumber = value;
    }

    public int ArtistNumber
    {
        get => artistNumber;
        set => artistNumber = value;
    }

    public int PodiumScheduleNumber
    {
        get => podiumScheduleNumber;
        set => podiumScheduleNumber = value;
    }

    public int FestivalNumber
    {
        get => festivalNumber;
        set => festivalNumber = value;
    }

    public DateTime StartTime
    {
        get => startTime;
        set => startTime = value;
    }

    public int PlayTime
    {
        get => playTime;
        set => playTime = value;
    }

    public int MinPrepTime
    {
        get => minPrepTime;
        set => minPrepTime = value;
    }

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