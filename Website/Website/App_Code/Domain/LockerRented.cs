using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for LockerRented
/// </summary>
public class LockerRented
{
    private Locker locker;
    private DateTime startDate;
    private DateTime endDate;
    private Visitor visitor;

    public LockerRented() { }

    public LockerRented(Locker locker, DateTime startDate, DateTime endDate, Visitor visitor)
    {
        this.locker = locker;
        this.startDate = startDate;
        this.endDate = endDate;
        this.visitor = visitor;
    }

    public Locker Locker
    {
        get => locker;
        set => locker = value;
    }

    public Visitor Visitor
    {
        get => visitor;
        set => visitor = value;
    }

    public DateTime StartDate
    {
        get => startDate;
        set => startDate = value;
    }

    public DateTime EndDate
    {
        get => endDate;
        set => endDate = value;
    }
}