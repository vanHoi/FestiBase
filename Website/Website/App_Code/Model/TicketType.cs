using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for TicketType
/// </summary>
public class TicketType
{
    private int festivalCompanyNumber;
    private string ticketType;
    private double ticketPrice;
    private DateTime dateValidFrom;
    private DateTime dateValidTo;

    public TicketType(int festivalCompanyNumber, string ticketType, double ticketPrice, DateTime dateValidFrom, DateTime dateValidTo)
    {
        this.festivalCompanyNumber = festivalCompanyNumber;
        this.ticketType = ticketType;
        this.ticketPrice = ticketPrice;
        this.dateValidFrom = dateValidFrom;
        this.dateValidTo = dateValidTo;
    }
}