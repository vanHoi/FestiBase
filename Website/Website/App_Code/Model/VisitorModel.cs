using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for VisitorModel
/// </summary>
public class VisitorModel
{
    private VisitorDAO visitorDao;

    public VisitorModel()
    {
        visitorDao = new VisitorDAO();
    }

    public Visitor LoginVisitor(string email)
    {
        return visitorDao.LoginVisitor(email);
    }
}