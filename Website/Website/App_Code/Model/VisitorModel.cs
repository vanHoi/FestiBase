using System.Collections.Generic;
using DAO;
using Domain;

namespace Model
{
    /// <summary>
    /// Summary description for VisitorModel
    /// </summary>
    public class VisitorModel
    {
        private readonly VisitorDAO _visitorDao;
        private readonly BoughtTicketDAO _boughtTicketDao;

        public VisitorModel()
        {
            _visitorDao = new VisitorDAO();
            _boughtTicketDao = new BoughtTicketDAO();
        }

        public Visitor LoginVisitor(string email)
        {
            return _visitorDao.LoginVisitor(email);
        }

        public List<BoughtTicket> GetAllBoughtTicketsOfVisitor(int visitorNumber)
        {
            return _boughtTicketDao.GetAllBoughtTicketsOfVisitor(visitorNumber);
        }
    }
}