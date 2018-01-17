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
        private readonly GenreDAO _genreDao;

        public VisitorModel()
        {
            _visitorDao = new VisitorDAO();
            _boughtTicketDao = new BoughtTicketDAO();
            _genreDao = new GenreDAO();
        }

        public Visitor LoginVisitor(string email)
        {
            return _visitorDao.LoginVisitor(email);
        }

        public List<BoughtTicket> GetAllBoughtTicketsOfVisitor(int visitorNumber)
        {
            return _boughtTicketDao.GetAllBoughtTicketsOfVisitor(visitorNumber);
        }

        public bool addVisitorToTicket(int visitorNumber, int ticketNumber)
        {
            return _boughtTicketDao.AddVisitorToTicket(visitorNumber, ticketNumber);
        }

        public List<Genre> GetGenresOfVisitor(int visitorNumber)
        {
            return _genreDao.GetGenresOfVisitor(visitorNumber);
        }

        public void DeleteLikedGenre(int visitorNumber, int genreNumber)
        {
            _genreDao.DeleteLikedGenre(genreNumber, visitorNumber);
        }

        public void AddLikedGenre(int visitorNumber, int genreNumber)
        {
            _genreDao.AddLikedGenre(genreNumber, visitorNumber);
        }
    }
}