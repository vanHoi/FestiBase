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
    private int podiumNumber;
    private DateTime startDate;
    private DateTime startTime;
    private DateTime endDate;
    private DateTime endTime;
    private int breakTime;
    public PodiumSchedule(int podiumScheduleNumber, int podiumNumber, DateTime startDate, DateTime startTime, 
        DateTime endDate, DateTime endTime, int breakTime)
    {
        this.podiumScheduleNumber = podiumScheduleNumber;
        this.podiumNumber = podiumNumber;
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

    public int PodiumNumber
    {
        get => podiumNumber;
        set => podiumNumber = value;
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