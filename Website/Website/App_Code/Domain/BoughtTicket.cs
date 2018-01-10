using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for BoughtTicket
/// </summary>
public class BoughtTicket
{
    private int ticketNumber;
    private TicketType ticketType;
    private string visitorNumber;
    private DateTime scanDate;

    public BoughtTicket()
    {
        ticketType = new TicketType();
    }

    public BoughtTicket(int ticketNumber, TicketType ticketType, 
        string visitorNumber, DateTime scanDate)
    {
        this.ticketNumber = ticketNumber;
        this.ticketType = ticketType;
        this.visitorNumber = visitorNumber;
        this.scanDate = scanDate;
    }

    public int TicketNumber
    {
        get => ticketNumber;
        set => ticketNumber = value;
    }

    public TicketType TicketType
    {
        get => ticketType;
        set => ticketType = value;
    }

    public string VisitorNumber
    {
        get => visitorNumber;
        set => visitorNumber = value;
    }

    public DateTime ScanDate
    {
        get => scanDate;
        set => scanDate = value;
    }

    public void addFestival(int festivalNumber, string name, DateTime startDate, DateTime endDate)
    {
        ticketType.addFestival(festivalNumber, name, startDate, endDate);
    }

    public Festival getFestival()
    {
        return ticketType.getFestival();
    }
}