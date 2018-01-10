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
    private Artist artist;
    private PodiumSchedule podiumSchedule;
    private Festival festival;
    private DateTime startTime;
    private int playTime;
    private int minPrepTime;

    public Performance() { }

    public Performance(int performanceNumber, Artist artist, PodiumSchedule podiumSchedule, Festival festival, DateTime startTime, int playTime, int minPrepTime)
    {
        this.performanceNumber = performanceNumber;
        this.artist = artist;
        this.podiumSchedule = podiumSchedule;
        this.festival = festival;
        this.startTime = startTime;
        this.playTime = playTime;
        this.minPrepTime = minPrepTime;
    }

    public int PerformanceNumber
    {
        get => performanceNumber;
        set => performanceNumber = value;
    }

    public Artist Artist
    {
        get => artist;
        set => artist = value;
    }

    public PodiumSchedule PodiumSchedule
    {
        get => podiumSchedule;
        set => podiumSchedule = value;
    }

    public Festival Festival
    {
        get => festival;
        set => festival = value;
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
}