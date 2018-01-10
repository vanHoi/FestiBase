using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PodiumSchedule
/// </summary>
public class PodiumSchedule
{
    private int podiumScheduleNumber;
    private Podium podium;
    private DateTime startDate;
    private DateTime startTime;
    private DateTime endDate;
    private DateTime endTime;
    private int breakTime;

    public PodiumSchedule() { }

    public PodiumSchedule(int podiumScheduleNumber, Podium podium, DateTime startDate, DateTime startTime, 
        DateTime endDate, DateTime endTime, int breakTime)
    {
        this.podiumScheduleNumber = podiumScheduleNumber;
        this.podium = podium;
        this.startDate = startDate;
        this.startTime = startTime;
        this.endDate = endDate;
        this.endTime = endTime;
        this.breakTime = breakTime;
    }

    public int PodiumScheduleNumber
    {
        get => podiumScheduleNumber;
        set => podiumScheduleNumber = value;
    }

    public Podium Podium
    {
        get => podium;
        set => podium = value;
    }

    public DateTime StartDate
    {
        get => startDate;
        set => startDate = value;
    }

    public DateTime StartTime
    {
        get => startTime;
        set => startTime = value;
    }

    public DateTime EndDate
    {
        get => endDate;
        set => endDate = value;
    }

    public DateTime EndTime
    {
        get => endTime;
        set => endTime = value;
    }

    public int BreakTime
    {
        get => breakTime;
        set => breakTime = value;
    }

}