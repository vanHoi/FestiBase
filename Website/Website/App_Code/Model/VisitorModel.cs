using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for VisitorModel
/// </summary>
public class VisitorModel
{
    private VisitorDAO visitorDAO;
    private BoughtTicketDAO boughtTicketDAO;

    public VisitorModel()
    {
        visitorDAO = new VisitorDAO();
        boughtTicketDAO = new BoughtTicketDAO();
    }

    public Visitor LoginVisitor(string email)
    {
        return visitorDAO.LoginVisitor(email);
    }

    public List<BoughtTicket> getAllBoughtTicketsOfVisitor(int visitorNumber)
    {
        return boughtTicketDAO.getAllBoughtTicketsOfVisitor(visitorNumber);
    }
}