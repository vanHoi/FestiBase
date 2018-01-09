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
    private int festivalCompanyNumber;
    private string ticketType;
    private string visitorNumber;
    private DateTime scanDate;

    public BoughtTicket(int ticketNumber, int festivalCompanyNumber, string ticketType, string visitorNumber, DateTime scanDate)
    {
        this.ticketNumber = ticketNumber;
        this.festivalCompanyNumber = festivalCompanyNumber;
        this.ticketType = ticketType;
        this.visitorNumber = visitorNumber;
        this.scanDate = scanDate;
    }

    public int TicketNumber
    {
        get => ticketNumber;
        set => ticketNumber = value;
    }

    public int FestivalCompanyNumber
    {
        get => festivalCompanyNumber;
        set => festivalCompanyNumber = value;
    }

    public string TicketType
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
}