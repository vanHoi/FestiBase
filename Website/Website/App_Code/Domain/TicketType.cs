using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for TicketType
/// </summary>
public class TicketType
{
    private FestivalCompany festivalCompany;
    private string type;
    private double ticketPrice;
    private DateTime dateValidFrom;
    private DateTime dateValidTo;

    public TicketType()
    {
        festivalCompany = new FestivalCompany();
    }

    public TicketType(FestivalCompany festivalCompany, string type, double ticketPrice, DateTime dateValidFrom,
        DateTime dateValidTo)
    {
        this.festivalCompany = festivalCompany;
        this.type = type;
        this.ticketPrice = ticketPrice;
        this.dateValidFrom = dateValidFrom;
        this.dateValidTo = dateValidTo;
    }

    public FestivalCompany FestivalCompany
    {
        get => festivalCompany;
        set => festivalCompany = value;
    }

    public string Type
    {
        get => type;
        set => type = value;
    }

    public double TicketPrice
    {
        get => ticketPrice;
        set => ticketPrice = value;
    }

    public DateTime DateValidFrom
    {
        get => dateValidFrom;
        set => dateValidFrom = value;
    }

    public DateTime DateValidTo
    {
        get => dateValidTo;
        set => dateValidTo = value;
    }

    public void addFestival(int festivalNumber, string name, DateTime startDate, DateTime endDate)
    {
        festivalCompany.addFestival(festivalNumber, name, startDate, endDate);
    }

    public Festival getFestival()
    {
        return festivalCompany.Festival;
    }
}