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
        private readonly GenreDao _genreDao;

        public VisitorModel()
        {
            _visitorDao = new VisitorDAO();
            _boughtTicketDao = new BoughtTicketDAO();
            _genreDao = new GenreDao();
        }

        public Visitor LoginVisitor(string email)
        {
            return _visitorDao.LoginVisitor(email);
        }

        public List<BoughtTicket> GetAllBoughtTicketsOfVisitor(int visitorNumber)
        {
            return _boughtTicketDao.GetAllBoughtTicketsOfVisitor(visitorNumber);
        }

        public List<Genre> GetGenresOfVisitor(int visitorNumber)
        {
            return _genreDao.GetGenresOfVisitor(visitorNumber);
        }

        public void deleteLikedGenre(int visitorNumber, int genreNumber)
        {
            _genreDao.deleteLikedGenre(genreNumber, visitorNumber);
        }

        public void addLikedGenre(int visitorNumber, int genreNumber)
        {
            _genreDao.addLikedGenre(genreNumber, visitorNumber);
        }
    }
}